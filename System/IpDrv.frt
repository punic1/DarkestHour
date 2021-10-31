[Public]
Object=(Name=IpDrv.UpdateServerCommandlet,Class=Class,MetaClass=Core.Commandlet)
Object=(Name=IpDrv.MasterServerCommandlet,Class=Class,MetaClass=Core.Commandlet)
Object=(Name=IpDrv.CompressCommandlet,Class=Class,MetaClass=Core.Commandlet)
Object=(Name=IpDrv.DecompressCommandlet,Class=Class,MetaClass=Core.Commandlet)
Object=(Name=IpDrv.TcpNetDriver,Class=Class,MetaClass=Engine.NetDriver)
Object=(Name=IpDrv.UdpBeacon,Class=Class,MetaClass=Engine.Actor)
Preferences=(Caption="Réseau",Parent="Options avancées")
Preferences=(Caption="Jeu en réseau TCP/IP",Parent="Réseau",Class=IpDrv.TcpNetDriver)
Preferences=(Caption="Balise serveur",Parent="Réseau",Class=IpDrv.UdpBeacon,Immediate=True)

[TcpNetDriver]
ClassCaption=Jeu en réseau TCP/IP

[UdpBeacon]
ClassCaption=Balise serveur LAN

[CompressCommandlet]
HelpCmd=compression
HelpOneLiner=Compresser un package Unreal pour le téléchargement automatique. Un fichier .uz sera créé.
HelpUsage=compression Fichier1 [Fichier2 [Fichier3 ...]]
HelpParm[0]=Fichiers
HelpDesc[0]=Noms de fichiers à compresser.

[DecompressCommandlet]
HelpCmd=décompresser
HelpOneLiner=Décompresser un fichier compressé avec ucc.
HelpUsage=Décompresser un fichier compressé
HelpParm[0]=Fichier compressé
HelpDesc[0]=Le fichier .uz à décompresser

[MasterServerUplink]
MSUPropText[0]="Annoncer serveur"
MSUPropText[1]="Traitement stats"
MSUPropDesc[0]="Si activé, votre serveur sera affiché sur le navigateur de serveurs Internet"
MSUPropDesc[1]="Publie les stats des joueurs de votre serveur sur le site web de Red Orchestra."

