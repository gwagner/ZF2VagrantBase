#!/bin/sh

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

# Remove current CentOS Repo && Apply the new one

    if [ -f /etc/yum.repos.d/CentOS-Base.repo ]
    then
        echo "Dropping old CentOS Repo"

        rm /etc/yum.repos.d/CentOS-Base.repo

        echo "Ensuring new CentOS repos are in place to install packages"

        puppet apply --modulepath=/etc/puppet/modules:/usr/share/puppet/modules:/media/PuppetModules --verbose -e 'include repo_centos, repo_epel'
    fi

exit 0