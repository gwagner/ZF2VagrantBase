#!/bin/sh

PUPPET_MODULE_PATH="/media/PuppetModules"

KEEP_UPDATED=false

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

# Install git so we can get all the proper puppet modules from github

    if [ ! -f /usr/bin/git ]
    then
        echo "Installing Git for Puppet Modules"

        yum install -y -q git
    fi

# Install the librarian itself

    if ! gem spec librarian-puppet > /dev/null 2>&1; then
        gem install librarian-puppet
    fi

# Run the puppet librarian
    if [ $KEEP_UPDATED = true ] || [ ! -f $PUPPET_MODULE_PATH/Puppetfile.lock ]
    then
        # Get the current working dir
        CWD=`pwd`

        # CD to the puppet dir
        cd $PUPPET_MODULE_PATH

        # Run the update to get the newest version from the repo
        if [ $KEEP_UPDATED = true ]
        then
            librarian-puppet update
        fi

        #Install all the puppet modules && Move back to the CWD
        librarian-puppet install --path=$PUPPET_MODULE_PATH && cd $CWD
    fi

# Remove current CentOS Repo && Apply the new one

    if [ -f /etc/yum.repos.d/CentOS-Base.repo ]
    then
        echo "Dropping old CentOS Repo"

        rm /etc/yum.repos.d/CentOS-Base.repo

        echo "Ensuring new CentOS repos are in place to install packages"

        puppet apply --modulepath=/etc/puppet/modules:/usr/share/puppet/modules:/media/PuppetModules --verbose -e 'include repo_centos, repo_epel'
    fi

# Send back a clean exit code so vagrant doesn't get angry

    exit 0