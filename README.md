# Gestionnaire de Système Linux - Script Bash

## Description

Ce projet est un script Bash interactif permettant d'effectuer diverses tâches d'administration système sous Linux. Il offre un menu simple pour automatiser la gestion des utilisateurs, la surveillance du système, la configuration réseau et bien plus encore.

## Prérequis

Ce script est conçu pour les systèmes basés sur **Debian/Ubuntu** ou tout autre système utilisant `apt` comme gestionnaire de paquets. Il ne fonctionnera pas sur des distributions utilisant `yum`, `dnf` (Fedora, CentOS) ou `pacman` (Arch Linux).

## Fonctionnalités

### 🔧 Mise à jour automatique du système
- Mise à jour des paquets ([`auto_update`](#auto_update))

### 👤 Gestion des utilisateurs
- Lister les utilisateurs ([`lister_utilisateurs`](#lister_utilisateurs))
- Créer un utilisateur ([`creer_utilisateur`](#creer_utilisateur))
- Supprimer un utilisateur ([`supprimer_utilisateur`](#supprimer_utilisateur))

### 🌐 Outils réseau
- Effectuer un `nslookup` sur un domaine ([`nslookup_domaine`](#nslookup_domaine))
- Afficher la configuration réseau ([`afficher_config_reseau`](#afficher_config_reseau))
- Pinger un hôte ([`ping_host`](#ping_host)

### 📊 Surveillance du système
- Installation de `btop` ([`installer_btop`](#installer_btop))
- Afficher `btop` ([`afficher_btop`](#afficher_btop))
- Surveillance de l'espace disque ([`surveillance_disque`](#surveillance_disque))
- Lister les processus en cours ([`lister_pids`](#lister_pids))
- Supprimer les processus utilisateur ([`supprimer_processus`](#supprimer_processus))
- Afficher les statistiques de la RAM ([`afficher_stats_ram`](#afficher_stats_ram))
- Afficher les statistiques du CPU ([`afficher_stats_cpu`](#afficher_stats_cpu))

### 🛠 Divers
- Effacer l'écran ([`clear_screen`](#clear_screen))
- Quitter proprement le script ([`quitter`](#quitter))

---
# 📚 Guide d'utilisation du script_menu.sh

1. **Ouvrez un terminal.**

2. **Téléchargez le script depuis Git :**
   - Utilisez la commande `git clone` pour cloner le dépôt contenant le script.
     ```bash
     git clone https://github.com/0x-07n/Menu_BASH.git
     ```
3. **Naviguez jusqu'au répertoire du script :**
   - Utilisez la commande `cd` pour accéder au répertoire où le script a été téléchargé.
     ```bash
     cd <NOM_DU_REPERTOIRE>
     ```
   - Remplacez `<NOM_DU_REPERTOIRE>` par le nom du répertoire contenant le script.

4. **Rendez le script exécutable :**
   - Exécutez la commande suivante :
     ```bash
     chmod +x script_menu.sh
     ```

5. **Exécutez le script :**
   - Tapez `./script_menu.sh` dans le terminal et appuyez sur Entrée.

6. **Utilisez les flèches du clavier pour naviguer dans le menu et sélectionnez une option en tapant le numéro correspondant.**

## Remarques

- Soyez prudent lors de la suppression des processus ou des utilisateurs.
- Certaines actions nécessitent des privilèges administrateur et vous demanderont de confirmer avec votre mot de passe sudo.

---

### 💻 Explication code
([`voir le script`](/script_menu.sh))

#### auto_update
Cette fonction met à jour votre système en téléchargeant et en installant les dernières versions des logiciels disponibles. La fonction demande à l'utilisateur si il veut redémarrer le système.
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


---
#### lister_utilisateurs
Cette fonction affiche une liste de tous les utilisateurs qui ont un compte sur votre système.
```bash
lister_utilisateurs() {
    echo "  "
    echo "Liste des utilisateurs :"
    cut -d: -f1 /etc/passwd
    echo "  "
}
```


---
#### creer_utilisateur
Cette fonction vous permet de créer un nouveau compte utilisateur sur le système.
```bash
creer_utilisateur() {
    echo "  "
    read -p "Entrez le nom du nouvel utilisateur : " username
    sudo adduser "$username"
    echo "Utilisateur $username créé avec succès."
    echo "  "
}
```


---
#### supprimer_utilisateur
Cette fonction supprime un compte utilisateur existant du système. 
```bash
supprimer_utilisateur() {
    echo "  "
    read -p "Entrez le nom de l'utilisateur à supprimer : " username
    sudo deluser "$username"
    echo "Utilisateur $username supprimé."
    echo "  "
}
```


---
#### nslookup_domaine
Cette fonction vous permet de rechercher des informations sur un nom de domaine (comme un site web).
```bash
nslookup_domaine() {
    echo "  "
    read -p "Entrez le domaine à analyser : " domaine
    nslookup "$domaine"
    echo "  "
}
```


---
#### installer_btop
Cette fonction installe un outil appelé btop, qui permet de surveiller les performances de votre système en temps réel.
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

Celle ci permet de le lancer.
#### afficher_btop
```bash
afficher_btop() {
    echo "  "
    echo "Lancement de BTOP..."
    echo "  "
    btop
}
```



---
#### afficher_config_reseau
Cette fonction affiche les détails de la configuration réseau de votre système, comme les adresses IP et les connexions.
```bash
afficher_config_reseau() {
    echo "  "
    echo "Configuration réseau actuelle :"
    ip a
    echo "  "
}
```


---
#### surveillance_disque
Cette fonction surveille l'utilisation de l'espace disque sur votre système et vous avertit si l'espace est presque plein.
```bash
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
```


---
#### lister_pids
Cette fonction affiche une liste de tous les processus en cours d'exécution sur votre système.
```bash
lister_pids() {
    echo "  "
    echo "Liste des processus en cours :"
    ps aux
    echo "  "
}
```


---
#### supprimer_processus
Cette fonction arrête tous les processus en cours d'exécution pour un utilisateur spécifique.
```bash
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
```


---
#### ping_host
Cette fonction envoie des signaux à un autre ordinateur ou serveur pour vérifier s'il est accessible. 
```bash
ping_host() {
    echo "   "
    read -p "Entrez l'adresse IP ou le nom d'hôte à pinguer : " host
    echo "Ping de $host :"
    ping -c 4 "$host"
    echo "   "
}
```


---
#### afficher_stats_ram
Cette fonction affiche des informations sur l'utilisation de la mémoire RAM de votre système.
```bash
afficher_stats_ram() {
    echo "  "
    echo "Statistiques de la mémoire RAM :"
    free -h
    echo "  "
}
```


---
#### afficher_stats_cpu
Cette fonction affiche des informations sur l'utilisation du processeur de votre système.

```bash
afficher_stats_cpu() {
    echo "Statistiques du CPU :"
    top -bn1 | grep "Cpu(s)"
}
```

---

#### clear_screen
Cette fonction efface tout le contenu affiché à l'écran, le rendant vide.
```bash
clear_screen() {
    clear
}
```


---

#### quitter
Cette fonction ferme le script, mettant fin à son exécution.
```bash
quitter() {
    echo "Au revoir !"
    exit 0
}
```


---

#### afficher_menu
Cette fonction affiche un menu avec une liste d'options que vous pouvez choisir pour exécuter différentes tâches.
```bash
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
```

---

#### boucle principale 
Cette boucle maintient le script en cours d'exécution, affichant le menu et attendant que vous choisissiez une option.
```bash 
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
```

---

