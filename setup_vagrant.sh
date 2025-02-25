#!/bin/bash

# Nom du projet
PROJECT_NAME="projet_vagrant"
VAGRANT_BOX="debian/bookworm64"

# Vérification de l'installation de Vagrant
if ! command -v vagrant &> /dev/null; then
    echo "❌ Vagrant n'est pas installé. Installez-le depuis https://developer.hashicorp.com/vagrant/downloads"
    exit 1
fi

# Création du dossier et initialisation
mkdir -p "$PROJECT_NAME" && cd "$PROJECT_NAME"
echo "📁 Création du projet Vagrant : $PROJECT_NAME"

# Initialisation avec la box souhaitée
vagrant init "$VAGRANT_BOX"
echo "📦 Box Vagrant initialisée avec $VAGRANT_BOX"

# Modification du Vagrantfile (ajout d'une IP statique et d'un dossier partagé)
cat > Vagrantfile <<EOL
Vagrant.configure("2") do |config|
  config.vm.box = "$VAGRANT_BOX"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder "./data", "/vagrant_data"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = 1
  end
end
EOL

echo "🛠 Vagrantfile généré avec une configuration personnalisée"

# Validation de la configuration
vagrant validate
if [ $? -ne 0 ]; then
    echo "❌ Erreur dans le Vagrantfile. Vérifiez la syntaxe."
    exit 1
fi

# Lancement de la VM
vagrant up
if [ $? -ne 0 ]; then
    echo "❌ Échec du démarrage de la VM"
    exit 1
fi

# Affichage de la configuration SSH
echo "🔑 Configuration SSH :"
vagrant ssh-config

echo "✅ Machine Vagrant prête ! Connectez-vous avec : vagrant ssh"
