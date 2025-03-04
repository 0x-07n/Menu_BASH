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

``` bash
# Fonction pour auto_update
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

