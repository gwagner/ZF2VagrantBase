#!/bin/sh

PUPPET_MODULE_PATH="/media/PuppetModules"

KEEP_UPDATED=true

# Make sure heira.yaml is in the puppet dir

    if [ ! -f /etc/puppet/hiera.yaml ]
    then
        echo "Building /etc/puppet/hiera.yaml"

        echo ":backends: yaml" >> /etc/puppet/hiera.yaml
        echo ":yaml:" >> /etc/puppet/hiera.yaml
        echo "  :datadir: /var/lib/hiera" >> /etc/puppet/hiera.yaml
        echo ":hierarchy: common" >> /etc/puppet/hiera.yaml
        echo ":logger: console" >> /etc/puppet/hiera.yaml
    fi

# Install a puppet module for iptables

    if [ ! -f /var/lib/install-puppet-module-firewall ]
    then
        echo "Installing Puppet Module erwbgy/iptables"

        puppet module install erwbgy/iptables

        touch /var/lib/install-puppet-module-firewall
    fi


# Install git so we can get all the proper puppet modules from github

    if [ ! -f /usr/bin/git ]
    then
        echo "Installing Git for Puppet Modules"

        yum install -y -q git
    fi

# Finally checkout all of the modules we need to build the machine

    # Declare an associative array in bash (Bash 4.0+)

    declare -A modules

    # Module Recepie for Puppet.  These are all needed modules to setup the VM

    modules[fedora]="https://github.com/gwagner/puppet-fedora.git"
    modules[firewall]="https://github.com/gwagner/puppet-firewall.git"
    modules[git]="https://github.com/gwagner/puppet-git.git"
    modules[httpd]="https://github.com/gwagner/puppet-httpd.git"
    modules[memcached]="https://github.com/gwagner/puppet-memcached.git"
    modules[mysqld]="https://github.com/gwagner/puppet-mysqld.git"
    modules[nano]="https://github.com/gwagner/puppet-nano.git"
    modules[php-httpd]="https://github.com/gwagner/puppet-php-httpd.git"
    modules[php]="https://github.com/gwagner/puppet-php.git"
    modules[repo_epel]="https://github.com/gwagner/puppet-repo-epel.git"
    modules[repo_ius]="https://github.com/gwagner/puppet-repo-ius.git"
    modules[repo_centos]="https://github.com/gwagner/puppet-repo-centos.git"

    for mod in "${!modules[@]}"
    do
        CURRENT_DIR=`pwd`

        echo "Checking for $mod"

        if [ ! -d $PUPPET_MODULE_PATH/$mod ]
        then
            echo "Module $mod Not Found.  Cloning from Github ${modules[$mod]}"

            git clone "${modules[$mod]}" $PUPPET_MODULE_PATH/$mod

        # If we are not in development, make sure we pull down any changes from github for the freshest build
        elif [ $KEEP_UPDATED = true ]
        then
            echo "Module $mod Found.  Pulling from Github ${modules[$mod]}"

            # Move to the proper dir
            cd $PUPPET_MODULE_PATH/$mod/

            # Do the git pull, we need to do it this way becaue of a git bug
            git pull origin master

            # Move back to the original dir
            cd $CURRENT_DIR

        else
            echo "Taking no action on module $mod"
        fi
    done

# Remove current CentOS Repo && Apply the new one

    if [ -f /etc/yum.repos.d/CentOS-Base.repo ]
    then
        echo "Dropping old CentOS Repo"

        rm /etc/yum.repos.d/CentOS-Base.repo

        echo "Ensuring new CentOS repos are in place to install packages"

        puppet apply --modulepath=/etc/puppet/modules:/usr/share/puppet/modules:/media/PuppetModules --verbose -e 'include repo_centos, repo_epel'
    fi

exit 0