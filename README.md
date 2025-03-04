# Gestionnaire de Système Linux - Script Bash

## Description

Ce projet est un script Bash interactif permettant d'effectuer diverses tâches d'administration système sous Linux. Il offre un menu simple pour automatiser la gestion des utilisateurs, la surveillance du système, la configuration réseau et bien plus encore.

## Prérequis

Ce script est conçu pour les systèmes basés sur **Debian/Ubuntu** ou tout autre système utilisant `apt` comme gestionnaire de paquets. Il ne fonctionnera pas sur des distributions utilisant `yum`, `dnf` (Fedora, CentOS) ou `pacman` (Arch Linux).

## Fonctionnalités

### 🔧 Mise à jour automatique du système
- Mise à jour des paquets (`auto_update`)

### 👤 Gestion des utilisateurs
- Lister les utilisateurs (`lister_utilisateurs`)
- Créer un utilisateur (`creer_utilisateur`)
- Supprimer un utilisateur (`supprimer_utilisateur`)

### 🌐 Outils réseau
- Effectuer un `nslookup` sur un domaine (`nslookup_domaine`)
- Afficher la configuration réseau (`afficher_config_reseau`)
- Pinger un hôte (`ping_host`)

### 📊 Surveillance du système
- Installation et affichage de `btop` (`installer_btop`, `afficher_btop`)
- Surveillance de l'espace disque (`surveillance_disque`)
- Lister les processus en cours (`lister_pids`)
- Supprimer les processus utilisateur (`supprimer_processus`)
- Afficher les statistiques de la RAM (`afficher_stats_ram`)
- Afficher les statistiques du CPU (`afficher_stats_cpu`)

### 🛠 Divers
- Effacer l'écran (`clear_screen`)
- Quitter proprement le script (`quitter`)

---

### Le code

#### auto_update
```bash
auto_update() {
    echo "  "
    echo "Mise à jour de la liste de paquets..." 
    sudo apt-get update 
    echo "  "
    echo "Mise à niveau des paquets installés..." 
    sudo apt-get upgrade -y 
    echo "  "
    echo "Script exécuté le $(date)" 
    read -p "Voulez-vous redémarrer le système maintenant ? (o/n) " response
    if [[ "$response" =~ ^[Oo]$ ]]; then
        echo "Redémarrage du système..." 
        sudo reboot
    else
        echo "Redémarrage annulé par l'utilisateur." 
        echo "   "
    fi
}
```

#### lister_utilisateurs
```bash
lister_utilisateurs() {
    echo "  "
    echo "Liste des utilisateurs :"
    cut -d: -f1 /etc/passwd
    echo "  "
}
```

#### creer_utilisateur
```bash
creer_utilisateur() {
    echo "  "
    read -p "Entrez le nom du nouvel utilisateur : " username
    sudo adduser "$username"
    echo "Utilisateur $username créé avec succès."
    echo "  "
}
```

#### supprimer_utilisateur
```bash
supprimer_utilisateur() {
    echo "  "
    read -p "Entrez le nom de l'utilisateur à supprimer : " username
    sudo deluser "$username"
    echo "Utilisateur $username supprimé."
    echo "  "
}
```

#### nslookup_domaine
```bash
nslookup_domaine() {
    echo "  "
    read -p "Entrez le domaine à analyser : " domaine
    nslookup "$domaine"
    echo "  "
}
```

#### installer_btop
```bash
installer_btop() {
    echo "  "
    echo "Installation de btop..."
    sudo apt-get install -y btop
    echo "  "
    echo "Lancement de btop..."
    btop
}
```

#### afficher_config_reseau
```bash
afficher_config_reseau() {
    echo "  "
    echo "Configuration réseau actuelle :"
    ip a
    echo "  "
}
```

#### surveillance_disque
```bash
surveillance_disque() {
    echo "  "
    echo "Utilisation du disque :"
    df -h
    echo "  "
}
```

#### lister_pids
```bash
lister_pids() {
    echo "  "
    echo "Liste des processus en cours :"
    ps aux
    echo "  "
}
```

#### supprimer_processus
```bash
supprimer_processus() {
    echo "  "
    read -p "Entrez le nom de l'utilisateur dont vous voulez tuer les processus : " user
    pkill -u "$user"
    echo "Processus de $user supprimés."
    echo "  "
}
```

#### ping_host
```bash
ping_host() {
    echo "  "
    read -p "Entrez l'adresse IP ou le domaine à ping : " host
    ping -c 4 "$host"
    echo "  "
}
```

#### afficher_stats_ram
```bash
afficher_stats_ram() {
    echo "  "
    echo "Statistiques de la mémoire RAM :"
    free -h
    echo "  "
}
```

#### afficher_stats_cpu
```bash
afficher_stats_cpu() {
    echo "  "
    echo "Statistiques du CPU :"
    top -b -n 1 | head -n 10
    echo "  "
}
```

#### clear_screen
```bash
clear_screen() {
    clear
}
```

#### quitter
```bash
quitter() {
    echo "Fermeture du script."
    exit 0
}
```
