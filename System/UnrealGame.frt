[Public]
;Object=(Class=Class,MetaClass=Engine.Mutator,Name=UnrealGame.MutBigHead,Description="La taille de votre tête dépend de vos performances.")
;Object=(Class=Class,MetaClass=Engine.Mutator,Name=UnrealGame.MutLowGrav,Description="Faible gravité.")
;Object=(Class=Class,MetaClass=Engine.Mutator,Name=UnrealGame.MutDelayedSpawn,Description="Réapparaition retardée pour les meilleures armes et les bonus.")

[ACTION_DisableObjective]
ActionString="Désactiver l'objectif."

[ACTION_DisableThisScript]
ActionString="Déscativer ce script"

[ACTION_SetObjectiveActiveStatus]
ActionString="Modifier l'état actif de l'objectif"

[Action_ChangeObjectiveTeam]
ActionString="Changer l'objectif de jeu de l'équipe"

[BombTargetMessage]
TargetMessage="Passe en approche"

[CTFGame]
CTFHints=("Vous pouvez utiliser %BASEPATH 0% pour voir le chemin menant à la base rouge ou %BASEPATH 1% pour voir celui menant à la base bleue.","Le tir du téléporteur expédie la balise du téléporteur. Appuyer de nouveau sur %FIRE% rappelle la balise alors que %A:TFIRE% vous téléporte instantanément à l'emplacement de la balise (si cette action est possible).","Si vous employez le téléporteur alors que vous tenez le drapeau, vous lâcherez celui-ci.","Appuyer sur %SWITCHWEAPON 10% après avoir lancé le téléporteur permet de voir ce que transmet sa caméra interne.","Appuyer sur %FIRE% alors que vous maintenez enfoncé %ALTFIRE% après la téléportation vous fera reprendre en main l'arme précédente.")
Description="Votre équipe doit marquer des points en prenant le drapeau de l'adversaire dans sa base et en le ramenant à son propre drapeau. Si le porteur est tué, le drapeau tombe sur le sol et n'importe qui peut le ramasser. Si votre drapeau a été pris, vous devez le ramener (en le touchant lorsqu'il est tombé au sol) avant que votre équipe puisse ramener le drapeau adverse."

[CTFHUDMessage]
YouHaveFlagString="Vous avez le drapeau, rentrez !"
EnemyHasFlagString="L'ennemi a votre drapeau, reprenez-le !"

[CTFMessage]
ReturnBlue="a rapporté le drapeau bleu !"
ReturnRed="a rapporté le drapeau rouge !"
ReturnedBlue="Le drapeau bleu est revenu !"
ReturnedRed="Le drapeau rouge est revenu !"
CaptureBlue="a le drapeau bleu !"
CaptureRed="a le drapeau rouge !"
DroppedBlue="a lâché le drapeau bleu !"
DroppedRed="a lâché le drapeau rouge !"
HasBlue="a pris le drapeau bleu !"
HasRed="a pris le drapeau rouge !"

[CinematicHud]
FontArrayNames[0]="ROFonts.ROBtsrmVr38"
FontArrayNames[1]="ROFonts.ROBtsrmVr28"
FontArrayNames[2]="ROFonts.ROBtsrmVr24"
FontArrayNames[3]="ROFonts.ROBtsrmVr20"
FontArrayNames[4]="ROFonts.ROBtsrmVr18"
FontArrayNames[5]="ROFonts.ROBtsrmVr14"
FontArrayNames[6]="ROFonts.ROBtsrmVr12"
FontArrayNames[7]="ROFonts.ROBtsrmVr9"
FontArrayNames[8]="ROFonts.ROBtsrmVr7"

[ClassicAnnouncer]
AnnouncerName="UT2003"

[ConvoyGibbed]
DeathString="%k a poussé %o par-dessus bord."

[CustomBotConfig]
FavoriteWeapon="Arme préférée :"
NoPreference="Pas de préf. d'arme"

[DMMutator]
DMMutPropsDisplayText[0]="Mégavitesse"
DMMutPropsDisplayText[1]="Contrôle aérien"
DMMutDescText[0]="Augmente beaucoup la vitesse de jeu."
DMMutDescText[1]="Indique le degré de contrôle aérien des joueurs."

[DMStatsScreen]
StatsString="STATS PERSO. DE"
AwardsString="RECOMPENSES"
FirstBloodString="Premier sang !"
FlakMonkey="Fort en Flak !"
Combowhore="Génie du combo !"
Headhunter="Chasseur de têtes !"
RoadRampage="Hécatombe routière !"
DaredevilString="Casse-cou :"
FlagTouches="Drapeau touché"
FlagReturns="Drapeau ramené"
GoalsScored="Buts marqués :"
HatTrick="Chapeau !"
KillString[0]="Double Frag"
KillString[1]="Multi Frag"
KillString[2]="Mega frag !"
KillString[3]="Ultra frag !"
KillString[4]="MONSTER FRAG !"
KillString[5]="GRAVE !"
KillString[6]="NOM DE DIEU !"
AdrenalineCombos="COMBOS ADRENALINE"
ComboNames[0]="Vitesse"
ComboNames[1]="Berserk"
ComboNames[2]="Défense"
ComboNames[3]="Invisible"
ComboNames[4]="Autre"
KillsByWeapon="STATS DES ARMES"
CombatResults="RESULTATS DE COMBAT"
Kills="Frags"
Deaths="Morts"
Suicides="Suicides"
NextStatsString="F8 pour joueur suivant"
WeaponString="Arme "
DeathsBy="Tué(e) par"
deathsholding="Morts avec"
EfficiencyString="Efficacité"
WaitingForStats="Attente des stats du serveur. F3 pour retour à l'ATH normal."
KillsByVehicle="STATS VEHICULE"
VehicleString="Véhicule"

[DeathMatch]
DMPropsDisplayText[0]="Délai lancement Net"
DMPropsDisplayText[1]="Joueurs Net min."
DMPropsDisplayText[2]="Délai relance"
DMPropsDisplayText[3]="Partie tournoi"
DMPropsDisplayText[4]="Les joueurs doivent être prêts"
DMPropsDisplayText[5]="Forcer réapparition"
DMPropsDisplayText[6]="Réglage auto comp. bots"
DMPropsDisplayText[7]="Autoriser provocations"
DMPropsDisplayText[8]="Temps protection réapp."
DMPropsDisplayText[9]="Autoriser téléporteur"
DMPropsDisplayText[10]="Utiliser skins équipe"
DMPropsDisplayText[11]="Util. val. carte par déf."
DMPropsDisplayText[12]="Rejet entrée tardive"
DMPropsDisplayText[13]="Activer surbrillance joueur"
DMPropDescText[0]="Délai avant lancement pour permettre la jonction des autres joueurs."
DMPropDescText[1]="Nombre de joueurs devant rejoindre pour permettre le lancement de la partie sur le net."
DMPropDescText[2]="Durée d'attente du serveur en fin de partie avant de charger la carte suivante."
DMPropDescText[3]="Partie tournoi"
DMPropDescText[4]="Si activé, les joueurs doivent cliquer Prêt pour pouvoir lancer la partie."
DMPropDescText[5]="Les joueurs réapparaissent immédiatement après leur mort."
DMPropDescText[6]="La compétence des bots s'ajuste automatiquement en fonction de leurs résultats contre vous."
DMPropDescText[7]="Permet aux joueurs d'employer les provoc. enregistrées."
DMPropDescText[8]="Définit la durée d'invulnérabilité après réapparition (sauf si les joueurs tirent)."
DMPropDescText[9]="Si activé, les joueurs débutent avec un téléporteur."
DMPropDescText[10]="Si coché, les joueurs auront des skins rouges ou bleus vifs."
DMPropDescText[11]="Emploi du nombre de bots par défaut de la carte."
DMPropDescText[12]="Indique le nombre maximal de vies perdues par un joueur avant d'interdire l'entrée à de nouveaux joueurs."
DMPropDescText[13]="A distance, les joueurs sont entourés d'un halo de la couleur de leur équipe."
YouDestroyed="Vous avez détruit un"
DMHints=("Chaque arme possède deux modes de tir : un mode normal actionné par %FIRE% et un mode secondaire déclenché par %ALTFIRE%.","Appuyez de nouveau sur Saut au sommet d'un bond pour obtenir un boost supplémentaire.","Appuyer rapidement deux fois de suite sur une touche de mouvement amènera votre personnage à esquiver dans cette direction.","Il est également possible d'esquiver à partir des murs pendant un saut.","Il est possible de changer d'arme en appuyant sur la touche numérique correspondante ou en faisant défiler les armes à l'aide de %NEXTWEAPON% et %PREVWEAPON%.","Le combo shock est une puissante explosion générée en tirant sur une boule shock (tir secondaire du fusil shock) à l'aide d'un faisceau shock (tir primaire du fusil shock).","Lors du chargement de roquettes à l'aide du tir secondaire du lance-roquettes, appuyer sur la commande de tir primaire avant de libérer les roquettes les expédiera selon uns spirale serrée.","Vous pouvez afficher/masquer à tout moment en appuyant sur %SHOWSCORES%.","Outre les bonus d'adrénaline, vous recevrez de l'adrénaline en tuant des ennemis et grâce à d'autres exploits. Lorsque l'adrénaline sera au niveau 100, vous pourrez entamer un combo d'adrénaline grâce à la combinaison correcte de touches de mouvement.","%SHOWSTATS% affiche vos stats personnelles.","Vous pourrez abattre les missiles de rédepteur ennemis grâce à un tir bien placé.","Pour expédier des messages textuels à d'autres joueurs, appuyez sur %TALK% et tapez votre message.","Vous pourrez envoyer des provocations ou d'autres messages oraux à l'aide du menu Voix en appuyant sur %SPEECHMENUTOGGLE%.","En position accroupie (en maintenant enfoncé %DUCK%, vous ne pourrez pas tomber d'une corniche.")
Description="Chacun pour soi. Tuer ou être tué. Le joueur ayant le plus de frags gagne."

[DestroyableObjective]
ObjectiveName="Détruisez l'objectif"
ObjectiveDescription="Détruisez l'objectif pour le désactiver"
Objective_Info_Attacker="Détruisez l'objectif"
Objective_Info_Defender="Protégez l'objectif"

[FemaleAnnouncer]
AnnouncerName="Femme"

[FirstBloodMessage]
FirstBloodString="a versé le premier sang !"

[GameObjective]
DestructionMessage="Objectif désactivé"
LocationPrefix="Près"
ObjectiveStringSuffix=" Base équipe"
ObjectiveDescription="Désactivez l'objectif."
Objective_Info_Attacker="Désactivez l'objectif."
Objective_Info_Defender="Défendez l'objectif"
UseDescription="UTILISER"

[HoldObjective]
ObjectiveName="Tenez objectif"
ObjectiveDescription="Touchez et tenez l'objectif pour le désactiver."
Objective_Info_Attacker="Tenez objectif"

[KeyPickup]
PickupMessage="Vous avez une clé."

[KillingSpreeMessage]
EndSpreeNote="a vu sa tuerie interrompue par"
EndSelfSpree="faisait fort jusqu'à ce qu'il se tue !"
EndFemaleSpree="faisait fort jusqu'à ce qu'elle se tue !"
SpreeNote[0]="a une folie meurtrière !"
SpreeNote[1]="est en pleine frénésie !"
SpreeNote[2]="domine !"
SpreeNote[3]="est imbattable !"
SpreeNote[4]="se bat comme un dieu !"
SpreeNote[5]="est méchamment grave !"
SelfSpreeNote[0]="Folie meurtrière !"
SelfSpreeNote[1]="Frénésie !"
SelfSpreeNote[2]="Domination !"
SelfSpreeNote[3]="Imbattable !"
SelfSpreeNote[4]="DIEU!"
SelfSpreeNote[5]="MECHAMMENT GRAVE !"

[LastSecondMessage]
LastSecondRed="Sauvetage à la dernière seconde par Rouge !"
LastSecondBlue="Sauvetage à la dernière seconde par Bleu !"

[MaleAnnouncer]
AnnouncerName="Homme"

[MessageTrigger]
Message="Mes Messages"

[MutBerserk]
FriendlyName="Super Berserk"
Description="Armes incroyablement rapides et puissantes."

[MutBigHead]
FriendlyName="Grosse tête"
Description="La taille de la tête dépend de vos prouesses."

[MutGameSpeed]
FriendlyName="Vitesse de jeu"
Description="Modifier la vitesse de jeu"

[MutLowGrav]
FriendlyName="FaibleGrav."
Description="Faible gravité"

[MutMovementModifier]
FriendlyName="Contrôle aérien"
Description="Modifier le déplacement des joueurs dans les airs."

[ProximityObjective]
ObjectiveName="Proximité objectif"
ObjectiveDescription="Touchez l'objectif pour le désactiver"
Objective_Info_Attacker="Touchez l'objectif"

[SexyFemaleAnnouncer]
AnnouncerName="Sexy"

[SquadAI]
SupportString="en soutien"
DefendString="défense"
AttackString="attaque"
HoldString="occup."
FreelanceString="Sweeper"

[StartupMessage]
Stage[0]="En attente des autres joueurs."
Stage[1]="En attente des signaux Prêt. Vous êtes PRET."
Stage[2]="Le match va commencer... 3"
Stage[3]="Le match va commencer... 2"
Stage[4]="Le match va commencer... 1"
Stage[5]="Le match a commencé !"
Stage[6]="Le match a commencé !"
Stage[7]="TEMPS DEPASSE !"
NotReady="Vous n'êtes pas PRET. App. sur Tir !"
SinglePlayer="TIR pour commencer !"

[TeamGame]
NearString="Près de"
BareHanded="A mains nues"
TGPropsDisplayText[0]="Bots équilibrent équipes"
TGPropsDisplayText[1]="Equilibrage des équipes"
TGPropsDisplayText[2]="Echelle tir allié"
TGPropsDisplayText[3]="Discussion privée entre équipes"
TGPropsDisplayText[4]="Taille équipe maximum"
TGPropDescText[0]="Des bots rejoindront ou changeront d'équipe pour assurer l'équilibre."
TGPropDescText[1]="A leur entrée, les joueurs doivent rejoindre la plus petite équipe."
TGPropDescText[2]="Indiquer la quantité de dégâts que peuvent s'infliger les joueurs d'une même équipe."
TGPropDescText[3]="Indiquer si les joueurs d'équipes adverses peuvent rejoindre la même salle de discussion privée."
TGPropDescText[4]="Nombre maximum de joueurs dans chaque équipe."
TGHints=("Si vous ratez un message d'un joueur, vous pouvez utiliser %INGAMECHAT% pour afficher une case contenant tous les messages de discussion reçus.","Vous pouvez vous relier à vos équipiers possédant aussi un link gun à l'aide du faisceau de tir secondaire du link gun. Une fois la liaison effectuée, le link gun de l'équipier recevra un boost de puissance conséquent.","Vous pouvez lancer votre arme à un équipier en appuyant sur %THROWWEAPON%.","Les équipiers ayant en main un link gun sont surmontés d'une balise verte au lieu de la balise jaune standard.","Appuyez sur %VOICETALK% pour discuter oralement avec votre équipe.",Appuyez sur %TEAMTALK% et saisissez votre message.","La fonction des messages préenregistrés permettant d'envoyer des messages vocaux peut être activée dans le menu des paramètres audio.")
EndGameComments[0]="lllllllamas"
EndGameComments[1]="slt"
EndGameComments[2]="bj"
EndGameComments[3]="bj"
EndGameComments[4]="bj tous"
EndGameComments[5]="Equipes"
EndGameComments[6]="omg"
EndGameComments[7]="bon sang !"
EndGameComments[8]="mon équipe est nulle"
EndGameComments[9]="bj"
EndGameTaunts[0]="quoi"
EndGameTaunts[1]="REFUSE !"
EndGameTaunts[2]="bj tous"
EndGameTaunts[3]="bj"
EndGameTaunts[4]="bj"
EndGameTaunts[5]="PAN !"
EndGameTaunts[6]="dommage"
EndGameTaunts[7]="Banzaï !"
EndGameTaunts[8]="QUOI !"
EndGameTaunts[9]="pas mal !"
EndGameVictoryRemarks[0]="Bande de débiles !"
EndGameVictoryRemarks[1]="Tas de n00bs."
EndGameVictoryRemarks[2]="On a gagné"
EndGameVictoryRemarks[3]="Un peu d'entraînement ne vous ferait pas de mal"
EndGameVictoryRemarks[4]="Voilà pour vous…"
EndGameVictoryRemarks[5]="C'était pathétique"
EndGameVictoryRemarks[6]="Trop facile !"
EndGameVictoryRemarks[7]="pwned !"
EndGameVictoryRemarks[8]="gros nul"
EndGameVictoryRemarks[9]="Même pas au niveau de l'IA"
EndGameLossRemarks[0]="avait un cheart de visée"
EndGameLossRemarks[1]="Prends un screenshot, ça ne se reproduira pas."
EndGameLossRemarks[2]="carte pourrie"
EndGameLossRemarks[3]="ce serveur est nul"
EndGameLossRemarks[4]="Campeurs."
EndGameLossRemarks[5]="N'importe quoi !"
EndGameLossRemarks[6]="Quelqu'un m'appelle ?"
EndGameLossRemarks[7]="mon équipe est nulle"
EndGameLossRemarks[8]="tripwire, réparez-moi ça par pitié !"
EndGameLossRemarks[9]="Vwvwvwvwvwvwvwvwvwvwvwvzxcjjj"
EndGameResponses[0]=":)"
EndGameResponses[1]=";)"
EndGameResponses[2]="haha"
EndGameResponses[3]="MDR"
EndGameResponses[4]="lol"
EndGameResponses[5]="ROFL"
EndGameResponses[6]="rofl"
EndGameResponses[7]="werd"
EndGameResponses[8]="ahaha"
EndGameResponses[9]="omg"
Description="Deux équipes se disputent le champ de bataille. L'équipe ayant le plus de frags gagne."

[TeamVoiceReplicationInfo]
PublicChannelNames=("Public","Local","Equipe")

[TimerMessage]
CountDownTrailer="..."

[TriggeredObjective]
ObjectiveName="Déclenchez l'objectif"
ObjectiveDescription="Déclenchez l'objectif pour le désactiver"
Objective_Info_Attacker="Déclenchez l'objectif"
Objective_Info_Defender="Défendez le déclencheur de l'objectif"

[UTClassicAnnouncer]
AnnouncerName="UT classique"

[UnrealMPGameInfo]
MPGIPropsDisplayText[0]="Joueurs minimum"
MPGIPropsDisplayText[1]="Délai en fin de partie"
MPGIPropsDisplayText[2]="Mode bots"
MPGIPropsDisplayText[3]="Autoriser discussion privée"
MPGIPropDescText[0]="Des bots seront ajoutés si nécessaire afin que le match compte au moins ce nombre de participants."
MPGIPropDescText[1]="Durée d'attente en fin de match avant le passage à la carte suivante."
MPGIPropDescText[2]="Indiquer le mode de détermination du nombre de bots du match."
MPGIPropDescText[3]="Indique si les clients peuvent créer et rejoindre des salles de discussion privées sur ce serveur"
BotModeText="0; Indiquer nombre; 1; Val. par déf. carte; 2; Util. liste bots"
SPBotText="Nombre de bots"
MPBotText="Joueurs minimum"
SPBotDesc="Indiquer le nombre de bots devant rejoindre votre match."
MPBotDesc="Des bots seront ajoutés si nécessaire afin que le match compte au moins ce nombre de participants."
BotOptions[0]="Indiquer nombre"
BotOptions[1]="Util. val. carte par déf."
BotOptions[2]="Utiliser liste bots"
BotOptions[3]="Joueurs contre Bots"

[UseObjective]
ObjectiveDescription="Atteignez l'objectif et utilisez le pour le désactiver"
Objective_Info_Attacker="Utilisez l'objectif"

