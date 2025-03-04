# Gestionnaire de Système Linux - Script Bash

## Description

Ce projet est un script Bash interactif permettant d'effectuer diverses tâches d'administration système sous Linux. Il offre un menu simple pour automatiser la gestion des utilisateurs, la surveillance du système, la configuration réseau et bien plus encore.

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

## Installation et Utilisation

### 📥 Installation des dépendances
Assurez-vous que votre système dispose des outils nécessaires avant d'exécuter le script :

```bash
sudo apt-get update && sudo apt-get install btop -y
