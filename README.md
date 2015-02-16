# OpenDevManagement
An open source solution for managing projects with GitHub integration.

## Installation

This application includes a Vagrant file to automate configuring development environments

### Prerequisites

This application requires the following two application packages to be installed on the host system in order to use the preconfigured development environment. 

1. [VirtualBox](https://www.virtualbox.org)
2. [Vagrant](https://www.vagrantup.com)

### Installation

#### Mac OS X

1. Clone the repo: `git clone https://github.com/OpenDevGroup/OpenDevManagement.git`
2. Navigate into project directory: `cd OpenDevManagement/`
3. Run Vagrant build: `vagrant up`

**Running the `vagrant up` command for the first time will take quite a while**.
During this process, your machine will:

1. Download a copy of the 64 bit Trusty Tahr Unbuntu box from Atlas - https://atlas.hashicorp.com/boxes/search
2. Boot that image using VirtualBox and starts the bootstrapping bash script in the Vagrantfile
3. Runs system updates
3. Installs base development libraries
4. Installs Ruby 2.1.5 (Go make yourself a cup of coffee at this point)
5. Updates rubygems (the 'gem' command)
6. Installs Postgres & sets up the databases (one for dev data, the other for test data)
7. Installs some system gems
8. Installs the applicaiton specific gems
9. Installs the Puma webserver
10. Boots the application with Foreman

After which, the application should be available at http://localhost:8080

