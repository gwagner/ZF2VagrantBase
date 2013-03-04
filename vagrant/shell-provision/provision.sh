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

exit 0