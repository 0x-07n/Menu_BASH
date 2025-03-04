#!/bin/bash
clear 
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

# Fonction pour lister les utilisateurs
lister_utilisateurs() {
    echo "  "
    echo "Liste des utilisateurs :"
    cut -d: -f1 /etc/passwd
    echo "  "
}

# Fonction pour créer un utilisateur
creer_utilisateur() {
    echo "  "
    read -p "Entrez le nom du nouvel utilisateur : " username
    sudo useradd -m "$username"
    echo "Utilisateur $username créé."
    echo "  "
}

# Fonction pour supprimer un utilisateur
supprimer_utilisateur() {
    echo "  "
    read -p "Entrez le nom de l'utilisateur à supprimer : " username
    sudo userdel -r "$username"
    echo "Utilisateur $username supprimé."
    echo "  "
}

# Fonction pour effectuer un nslookup d'un domaine
nslookup_domaine() {
    echo "  "
    read -p "Entrez le nom de domaine : " domaine
    nslookup "$domaine"
    echo "  "
}

# Fonction pour installer BTOP
installer_btop() {
    echo "  "
    echo "Installation de BTOP..."
    sudo apt-get install btop -y
    echo "BTOP installé."
    echo "  "
}

# Fonction pour afficher BTOP
afficher_btop() {
    echo "  "
    echo "Lancement de BTOP..."
    echo "  "
    btop
}

# Fonction pour afficher la configuration réseau
afficher_config_reseau() {
    echo "Configuration réseau :"
    echo "Nom d'hôte : $(hostname)"
    echo "Adresses IP et interfaces :"
    ip addr show
}

# Fonction pour surveiller l'espace disque
surveillance_disque() {
    echo "  "
    echo "Utilisation de l'espace disque :"
    df -h
    seuil=80
    while IFS= read -r ligne; do
        usage=$(echo "$ligne" | grep -oP '\d+%' | grep -oP '\d+')
        if [[ "$usage" -gt "$seuil" ]]; then
            echo "Attention : Le disque est utilisé à plus de $seuil%."
        fi
    done <<< "$(df -h | grep -vE '^Filesystem|tmpfs|cdrom')"
    echo "  "
}

# Fonction pour lister tous les PID en cours
lister_pids() {
    echo "  "
    echo "Liste des PID en cours :"
    ps -e -o pid,comm
    echo "  "
}

# Fonction pour supprimer tous les processus (à utiliser avec précaution)
supprimer_processus() {
    echo "Attention : Vous êtes sur le point de supprimer tous les processus utilisateur."
    read -p "Êtes-vous sûr de vouloir continuer ? (o/n) " response
    if [[ "$response" =~ ^[Oo]$ ]]; then
        echo "Suppression de tous les processus utilisateur..."
        sudo pkill -u "$(whoami)"
        echo "Processus utilisateur supprimés."
    else
        echo "Suppression annulée par l'utilisateur."
    fi
}

# Fonction pour effectuer un ping sur un hôte
ping_host() {
    echo "   "
    read -p "Entrez l'adresse IP ou le nom d'hôte à pinguer : " host
    echo "Ping de $host :"
    ping -c 4 "$host"
    echo "   "
}

# Fonction pour afficher les statistiques de la RAM
afficher_stats_ram() {
    echo "Statistiques de la RAM :"
    free -h
}

# Fonction pour afficher les statistiques du CPU
afficher_stats_cpu() {
    echo "Statistiques du CPU :"
    top -bn1 | grep "Cpu(s)"
}

# Fonction pour effacer l'écran
clear_screen() {
    clear
}

# Fonction pour quitter le script
quitter() {
    echo "Au revoir !"
    exit 0
}

# Fonction pour afficher le menu
afficher_menu() {
    echo "╔════════════════════════════════════════════════════════════════════════════╗"
    echo "║                             Menu Principal                                 ║"
    echo "╠════════════════════════════════════════════════════════════════════════════╣"
    echo "║ 1. Auto Update                                                             ║"
    echo "║ 2. Lister les utilisateurs                                                 ║"
    echo "║ 3. Créer un utilisateur                                                    ║"
    echo "║ 4. Supprimer un utilisateur                                                ║"
    echo "║ 5. Effectuer un nslookup d'un domaine                                      ║"
    echo "║ 6. Installer BTOP                                                          ║"
    echo "║ 7. Afficher BTOP                                                           ║"
    echo "║ 8. Afficher la configuration réseau                                        ║"
    echo "║ 9. Surveiller l'espace disque                                              ║"
    echo "║ 10. Lister tous les PID en cours                                           ║"
    echo "║ 11. Supprimer tous les processus utilisateur sauf ce script                ║"
    echo "║ 12. Effectuer un ping                                                      ║"
    echo "║ 13. Afficher les statistiques de la RAM                                    ║"
    echo "║ 14. Afficher les statistiques du CPU                                       ║"
    echo "║ 15. Effacer l'écran                                                        ║"
    echo "║ 16. Quitter                                                                ║"
    echo "╚════════════════════════════════════════════════════════════════════════════╝"
}

# Boucle principale du script
while true; do
    afficher_menu
    read -p "Entrez votre choix (1-16) : " choix

    case $choix in
        1)
            auto_update
            ;;
        2)
            lister_utilisateurs
            ;;
        3)
            creer_utilisateur
            ;;
        4)
            supprimer_utilisateur
            ;;
        5)
            nslookup_domaine
            ;;
        6)
            installer_btop
            ;;
        7)
            afficher_btop
            ;;
        8)
            afficher_config_reseau
            ;;
        9)
            surveillance_disque
            ;;
        10)
            lister_pids
            ;;
        11)
            supprimer_processus
            ;;
        12)
            ping_host
            ;;
        13)
            afficher_stats_ram
            ;;
        14)
            afficher_stats_cpu
            ;;
        15)
            clear_screen
            ;;
        16)
            quitter
            ;;
        *)
            echo "Choix invalide. Veuillez entrer un nombre entre 1 et 16."
            ;;
    esac
done
