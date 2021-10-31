[Public]
Object=(Name=UTV2004.UTVCommandlet,Class=Class,MetaClass=Core.Commandlet)

[UTVCommandlet]
HelpCmd=utv
HelpOneLiner=Lance un serveur UTV2004
HelpUsage=utv [serveraddress=<addr>] [serverport=<port>] [listenport=<port>] [primarypassword=<pass>] [vippassword=<pass>] [normalpassword=<pass>] [joinpassword=<pass>] [delay=<seconds>] [maxclients=<num>] [seeall=<1/0>]
HelpParm[0]=serveraddress
HelpDesc[0]=L'adresse IP à laquelle le proxy devrait se connecter
HelpParm[1]=serverport
HelpDesc[1]=Le port de serveur auquel le proxy devrait se connecter
HelpParm[2]=listenport
HelpDesc[2]=Le port sur lequel le proxy devrait attendre des clients
HelpParm[3]=primarypassword
HelpDesc[3]=Le mot de passe nécessaire pour devenir client principal
HelpParm[4]=vippassword
HelpDesc[4]=Le mot de passe permettant à un client de passer outre le nombre max de clients
HelpParm[5]=normalpassword
HelpDesc[5]=Le mot de passe nécessaire au client pour rejoindre le proxy
HelpParm[6]=joinpassword
HelpDesc[6]=Le mot de passe utilisé par le proxy pour se connecter au jeu
HelpParm[7]=delay
HelpDesc[7]=Le nombre de secondes à attendre avant le transfert en provenance du serveur
HelpParm[8]=maxclients
HelpDesc[8]=Le nombre maximum de clients autorisés sur ce proxy
HelpParm[9]=seeall
HelpDesc[9]=Détermine si le proxy utilisera la fonction seeall
