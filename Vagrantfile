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
