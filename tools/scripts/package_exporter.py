import argparse
import os
import typing
import sys
import tqdm
import concurrent.futures
import subprocess
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import pickle


class Package:
    def __init__(self):
        self.name = ''
        self.mtime = 0
        self.crc = 0


class PackageManifest:
    def __init__(self):
        self.packages: typing.Dict[str, Package] = {}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('input_directory')
    parser.add_argument('output_directory')
    parser.add_argument('--mod', required=False)
    parser.add_argument('--umodel_path', required=False, default='umodel')
    parser.add_argument('--dry', action='store_true', required=False, default=False)
    parser.add_argument('--clean', required=False, action='store_true')
    args = parser.parse_args()

    # Load package manifest.
    manifest = PackageManifest()
    manifest_path = os.path.join(args.output_directory, '.manifest')

    if args.clean:
        print('Clean export mode; manifest file will not be loaded.')
    else:
        try:
            with open(manifest_path, 'rb') as f:
                manifest = pickle.load(f)
                print('Manifest file loaded.')
        except FileNotFoundError:
            print('Manifest file not found.')

    suffixes = ['.usx', '.utx']
    directories = [
        'Animations',
        'Sounds',
        'StaticMeshes',
        'Textures'
    ]

    # Get a recursive list of all the *.props.txt files in the.
    roots = [args.input_directory]
    if args.mod:
        roots.append(os.path.join(args.input_directory, args.mod))

    files = []
    for root in roots:
        for directory in directories:
            files += list(p.resolve() for p in Path(os.path.join(root, directory)).glob("**/*") if p.suffix in suffixes)

    # Only evaluate packages that have changed since the last time we did this, or are new.
    files_to_evaluate = []
    for file in files:
        basename = os.path.basename(file)
        if basename in manifest.packages and manifest.packages[basename].mtime == os.path.getmtime(file):
            # File hasn't been modified since we last evaluated it, skip.
            continue
        files_to_evaluate.append(file)

    up_to_date_package_count = len(files) - len(files_to_evaluate)

    print(f'{up_to_date_package_count} package(s) up-to-date.')
    print(f'{len(files_to_evaluate)} package(s) marked for export.')

    if args.dry:
        print('Skipping export; in dry mode.')
    else:
        def export_package(umodel_path: str, output_directory: str, package_path: str):
            args = [umodel_path, '-export', f'-out="{output_directory}"', package_path]
            return subprocess.run(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        if len(files_to_evaluate) > 0:
            with tqdm.tqdm(total=len(files_to_evaluate)) as pbar:
                with ThreadPoolExecutor(max_workers=8) as executor:
                    # TODO: update the package manifest mtimes etc.
                    jobs = {executor.submit(export_package, args.umodel_path, args.output_directory, str(file)): file for file in files_to_evaluate}
                    for _ in concurrent.futures.as_completed(jobs):
                        pbar.update(1)

    # Write the new manifest file.
    for file in files_to_evaluate:
        name = os.path.basename(file)
        package = Package()
        package.name = name
        package.mtime = os.path.getmtime(file)
        manifest.packages[name] = package

    if len(files_to_evaluate) > 0:
        with open(manifest_path, 'wb') as f:
            pickle.dump(manifest, f)
            print('Manifest file updated.')


if __name__ == '__main__':
    main()
