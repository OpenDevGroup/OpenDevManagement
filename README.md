# OpenDevManagement
An open source solution for managing projects with GitHub integration.

[![Code Climate](https://codeclimate.com/github/OpenDevGroup/OpenDevManagement/badges/gpa.svg)](https://codeclimate.com/github/OpenDevGroup/OpenDevManagement)

[![Test Coverage](https://codeclimate.com/github/OpenDevGroup/OpenDevManagement/badges/coverage.svg)](https://codeclimate.com/github/OpenDevGroup/OpenDevManagement)

## Installation

This application includes a Vagrantfile to automate configuring development environments

### Prerequisites

This application requires the following two application packages to be installed on the host system in order to use the preconfigured development environment. 

1. [VirtualBox](https://www.virtualbox.org)
2. [Vagrant](https://www.vagrantup.com)

#### Mac OS X

1. Clone the repo: `git clone https://github.com/OpenDevGroup/OpenDevManagement.git`
2. Navigate into project directory: `cd OpenDevManagement/`
3. Run Vagrant build: `vagrant up`

**Running the `vagrant up` command for the first time will take quite a while**.
During this process, your machine will (amongst other things):

1. Download a copy of the 64 bit Precise Pangolin Unbuntu box from Atlas - https://atlas.hashicorp.com/boxes/search
2. Boot that image using VirtualBox and starts the bootstrapping bash script in the Vagrantfile
3. Runs system updates
3. Install base development libraries
4. Install Ruby 2.1.5 (Go make yourself a cup of coffee or two at this point)
5. Update rubygems (the 'gem' command)
6. Install Postgres & sets up the databases (one for dev data, the other for test data)
7. Install some system gems
8. Install the applicaiton specific gems
9. Install the Puma webserver
10. Boot the application with Foreman

After which, the application will be available at http://localhost:3005

Post initial installation, the `vagrant up` command will bring the project up much faster. 

For more information, checkout the Vagrantfile in the root directory. 

