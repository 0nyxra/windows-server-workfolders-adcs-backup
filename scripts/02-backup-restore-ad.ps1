# TP3 - Sauvegarde et restauration authoritative d'Active Directory
# Serveur : DC-contosoCM

# --- Sauvegarde du System State ---
wbadmin start backup -backupTarget:B: -systemState -vssFull -quiet
wbadmin get versions

# --- Restauration (en DSRM : msconfig > Boot > Safe boot > Active Directory repair) ---
# Adapter -version et -backupTarget selon la sortie de "wbadmin get versions"
wbadmin start systemstaterecovery -version:05/10/2026-21:54 -backupTarget:B: -quiet

# --- NE PAS redémarrer : marquer l'OU comme authoritative ---
# ntdsutil
#   activate instance ntds
#   authoritative restore
#   restore subtree "OU=Ventes,DC=contosoCM,DC=com"
#   quit
#   quit

# Puis : décocher Safe boot dans msconfig et redémarrer normalement.
# Vérification :
Get-ADUser -Identity TestUserBackup
