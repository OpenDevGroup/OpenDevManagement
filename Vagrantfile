# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 3000, host: 8081

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true
  
    # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    #!/usr/bin/env bash

    # Run system updates
    apt-get -y update

    # Install development libraries
    apt-get -y install make
    apt-get -y install libncurses5-dev
    apt-get -y install libffi-dev
    apt-get -y install libyaml-dev
    apt-get -y install libxml2-dev
    apt-get -y install libgdbm-dev
    apt-get -y install libxslt-dev
    apt-get -y install g++
    apt-get -y install postgresql
    apt-get -y install postgresql-contrib
    apt-get -y install postgresql-common
    apt-get -y install libpq-dev
    apt-get -y install git-core
    apt-get -y install screen
    apt-get -y install libreadline-dev

     
    # Install rbenv
    echo "Installing rbenv.."
    git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv
     
    # Add rbenv to the path:
    echo '# rbenv setup' > /etc/profile.d/rbenv.sh
    echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
    echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
    echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
     
    chmod +x /etc/profile.d/rbenv.sh
    source /etc/profile.d/rbenv.sh
     
    # Install ruby-build:
    echo "Installing ruby-build..."
    pushd /tmp
      git clone git://github.com/sstephenson/ruby-build.git
      cd ruby-build
      ./install.sh
    popd

    echo "Installing ruby 2.1.5.."
    rbenv install 2.1.5
    rbenv global 2.1.5
    rbenv rehash

    # Remove default web directory and replaced it with vagrant shared folder
    rm -rf /var/www
    ln -fs /vagrant /var/www

    # Move into the rails app dir
    echo "Moving into project directory.."
    cd /var/www
    echo "$(pwd)"

    # Update rubygems
    echo "Checking if we need to update rubygems..."
    gem update --system
    echo "... done with rubygems."
    echo "Installing ruby readline bindings.."
    gem install rb-readline

    rbenv rehash

    # Bootstrap rails app
    /usr/local/rbenv/shims/gem install bundler
    rbenv rehash
    echo "Preparing to boostrap $(pwd)..."
    bundle install
    echo "Boostrapping databases"
    rbenv rehash

    # Create databases
    sudo -u postgres createdb --template=template0 --encoding=UTF8 "opendev_dev"
    sudo -u postgres createdb --template=template0 --encoding=UTF8 "opendev_test"

    # Setup Postgres
    # Set postgres user/pass
    sudo -u postgres psql -U postgres -c "alter user postgres with password 'password';"
    # run app db setup
    bundle exec rake db:migrate
    bundle exec rake db:test:prepare
    echo "... done."

    #run app test suite
    echo "Running test suite..."
    bundle exec rspec -f d
    echo "... Test run complete."

    # Seed default user data - bob@example.com | password
    echo "Seeding database"
    bundle exec rake db:seed

    # start webserver
    echo "Installing Foreman"
    gem install foreman

    echo "Booting Application Services..."
    bundle exec foreman start

  SHELL
end
