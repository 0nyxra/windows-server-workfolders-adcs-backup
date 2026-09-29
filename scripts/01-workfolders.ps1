# TP3 - Work Folders : commandes utilisées
# Domaine : contosoCM.com | Serveur : WFCM-Server

# --- Sur DC-contosoCM : URL de découverte pour l'utilisateur ---
# (Set-SyncServerSetting -DiscoveryUrl n'existe pas dans cette version)
Set-ADUser -Identity "MobileUser1" -Replace @{"msDS-SyncServerURL"="https://WFCM-Server.contosoCM.com"}

# --- Sur WFCM-Server : liaison du certificat WFCert à HTTP.sys ---
# 1. Récupérer l'empreinte (thumbprint) du certificat
Get-ChildItem Cert:\LocalMachine\My | Format-List Subject, Thumbprint

# 2. Lier le certificat au port 443 pour Work Folders
#    appid = GUID du service Work Folders
netsh http add sslcert ipport=0.0.0.0:443 certhash=A63FF4847D9ED4AE957F176559DCC64DA043F077 appid='{CE66697B-3AA0-49D1-BDBD-A25C8359E103}'

# 3. Vérifications
Get-SyncShare
Get-SyncServerSetting   # SSLCertificateEnabled doit être True
netsh http show sslcert ipport=0.0.0.0:443
