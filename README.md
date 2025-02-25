# 📌 Mémo Vagrant

Ce mémo regroupe les commandes essentielles et les bonnes pratiques pour utiliser **Vagrant** et déployer rapidement des machines virtuelles de n'importe où.

## 📂 Sommaire

1. [Installation et Prérequis](#installation-et-prérequis)
2. [Création d'une Machine Virtuelle](#création-dune-machine-virtuelle)
3. [Gestion des Machines Virtuelles](#gestion-des-machines-virtuelles)
4. [Gestion des Images (Boxes)](#gestion-des-images-boxes)
5. [Connexion à la Machine Virtuelle](#connexion-à-la-machine-virtuelle)
6. [Exemple de Vagrantfile](#exemple-de-vagrantfile)
7. [Dépannage et Astuces](#dépannage-et-astuces)
8. [Ressources utiles](#ressources-utiles)

---

## 🏗 <a name="installation-et-prérequis"></a>Installation et Prérequis

### 1️⃣ Installer Vagrant et VirtualBox

Avant d'utiliser **Vagrant**, installe les dépendances suivantes :

- [Télécharger et installer Vagrant](https://developer.hashicorp.com/vagrant/downloads)
- [Télécharger et installer VirtualBox](https://www.virtualbox.org/wiki/Downloads)

**Vérifier l'installation :**
```sh
vagrant --version
virtualbox --help
```

---

## 🚀 <a name="création-dune-machine-virtuelle"></a>Création d'une Machine Virtuelle

### 1️⃣ Initialiser Vagrant
Créer un dossier dédié et y initialiser un environnement Vagrant :
```sh
mkdir mon_projet_vagrant && cd mon_projet_vagrant
vagrant init
```
Cela crée un fichier **Vagrantfile** dans le dossier courant.

### 2️⃣ Ajouter et utiliser une image (box)
Rechercher une image dans le **catalogue Vagrant Cloud** :  
🔗 [Vagrant Cloud](https://app.vagrantup.com/boxes/search)

```sh
vagrant box add <nom_de_la_box>
vagrant init <nom_de_la_box>
```
Exemple avec Ubuntu :
```sh
vagrant init ubuntu/trusty64
```

### 3️⃣ Modifier le fichier `Vagrantfile`
Avant de démarrer la VM, personnalise le fichier `Vagrantfile` (voir [exemple ci-dessous](#exemple-de-vagrantfile)).

### 4️⃣ Vérifier la configuration
```sh
vagrant validate
```

### 5️⃣ Démarrer la machine
```sh
vagrant up
```

### 6️⃣ Se connecter en SSH
```sh
vagrant ssh
```

---

## 🔄 <a name="gestion-des-machines-virtuelles"></a>Gestion des Machines Virtuelles

| Commande | Description |
|----------|------------|
| `vagrant up` | Démarre l'environnement et la machine virtuelle |
| `vagrant halt` | Arrête la VM proprement |
| `vagrant suspend` | Met en pause la VM et sauvegarde son état |
| `vagrant reload` | Redémarre la VM et recharge le `Vagrantfile` |
| `vagrant reload --provision` | Redémarre la VM et force l'approvisionnement |
| `vagrant destroy` | Détruit la VM et supprime ses fichiers |

---

## 📦 <a name="gestion-des-images-boxes"></a>Gestion des Images (Boxes)

| Commande | Description |
|----------|------------|
| `vagrant box list` | Liste les images installées localement |
| `vagrant box add <nom>` | Télécharge une image depuis Vagrant Cloud |
| `vagrant box outdated` | Vérifie si une mise à jour est disponible |
| `vagrant box remove <nom>` | Supprime une image locale |

---

## 🔌 <a name="connexion-à-la-machine-virtuelle"></a>Connexion à la Machine Virtuelle

| Commande | Description |
|----------|------------|
| `vagrant ssh` | Connexion SSH à la VM |
| `vagrant ssh-config` | Affiche la configuration SSH (utile pour configurer un client SSH externe) |

Exemple pour se connecter sans passer par `vagrant ssh` :
```sh
ssh -i .vagrant/machines/default/virtualbox/private_key vagrant@192.168.33.10
```

---

## 📝 <a name="exemple-de-vagrantfile"></a>Exemple de `Vagrantfile`

Voici un exemple fonctionnel de **Vagrantfile** avec :
- Une image Debian 12
- Un réseau privé (`192.168.33.10`)
- Un dossier partagé entre l'hôte et la VM (`/vagrant_data`)
- 1 CPU et 1 Go de RAM alloués

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"
  config.vm.box_version = "12.20250126.1"
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder "C:\\Users\\cleroy\\Documents\\projets\\vagrant\\data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "1024"
    vb.cpus = 1
  end
end
```

---

## 🛠 <a name="dépannage-et-astuces"></a>Dépannage et Astuces

### 📌 Problème de permissions sur un dossier partagé
Ajouter cette ligne dans `Vagrantfile` :
```ruby
config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
```

### 📌 Problème de connexion SSH
Vérifier la config avec :
```sh
vagrant ssh-config
```
Si besoin, modifier les permissions de la clé privée :
```sh
chmod 600 .vagrant/machines/default/virtualbox/private_key
```

### 📌 Changer le fournisseur (ex: utiliser VMware)
Par défaut, Vagrant utilise VirtualBox. Pour utiliser un autre provider :
```sh
vagrant up --provider=vmware_desktop
```

---

## 🎯 <a name="ressources-utiles"></a>Ressources Utiles

- 🌐 [Vagrant Documentation Officielle](https://developer.hashicorp.com/vagrant)
- 🌍 [Vagrant Cloud (catalogue des images)](https://app.vagrantup.com/boxes/search)
- 🛠 [Dépannage & Astuces sur StackOverflow](https://stackoverflow.com/questions/tagged/vagrant)

---

### 📌 Conclusion

Ce mémo Vagrant a pour but de simplifier et accélérer la création de machines virtuelles en fournissant une référence claire et concise des commandes essentielles.

Grâce à ce guide, tu peux :
- ✅ Initialiser rapidement un environnement Vagrant depuis n'importe où.
- ✅ Gérer efficacement tes machines virtuelles (démarrage, arrêt, destruction, mise à jour).
- ✅ Configurer et personnaliser tes VMs avec un Vagrantfile adapté à tes besoins.
- ✅ Faciliter la gestion des connexions SSH et des fichiers partagés.
