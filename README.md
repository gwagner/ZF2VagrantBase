ZF2VagrantBase
=======================

Introduction
------------

This is specifically designed to give you a fully working ZF2 Skeleton Application in a vagrant environment. I have gone through and painstakingly put together a setup that once cloned will require X steps to completely have a working LAMP stack in a virtual machine. If you are looking for a guide on how to work with [ZendFramekwork](https://github.com/zendframework/zf2), [VirtualBox](https://www.virtualbox.org/), or [Vagrant](http://downloads.vagrantup.com/) go to their website's and RTM.

Installation
------------

1. Clone [ZF2VagrantBase](https://github.com/gwagner/ZF2VagrantBase) `https://github.com/gwagner/ZF2VagrantBase.git`
1. Install [Vagrant](http://downloads.vagrantup.com/) `http://downloads.vagrantup.com/`
1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) `https://www.virtualbox.org/wiki/Downloads`
1. Inside of your clone of [ZF2VagrantBase](https://github.com/gwagner/ZF2VagrantBase), navigate to the vagrant directory
1. Type `vagrant up`
1. Once the machine is up and running, navigate to http://192.168.1.10
1. Proffit!!!

> Please note, on your first `vagrant up` you will download a 400MB CentOS image.  This will take some time.  Every subsequent time you use this, if you keep the VM name the same, you will not need to re-download.

But, I wana use this with my project!!
------------

You can take the [vagrant directory](https://github.com/gwagner/ZF2VagrantBase/tree/master/vagrant) right out of this project directly into your project and use it.  Once it is on your project (and you have installed VBox / Vagrant), navigate to your vagrant directory and run `vagrant up` from your terminal.  It is very VERY portable that way.  That will give you a VM running on YOUR existing project :thumbsup:

> ***Note:*** You may need to disable the composer module from the [zf2 module](https://github.com/gwagner/ZF2VagrantBase/blob/master/vagrant/modules/zf2/manifests/init.pp) if you are not using composer in your project

Contributors
------------
These contributors is in no particular order


| Contributor  | Provided  |
|---------------|----------------|
| [Zend](http://www.zend.com/en/)    |   [ZendFramekwork](https://github.com/zendframework/zf2) && [ZendSkeletonApplication](https://github.com/zendframework/ZendSkeletonApplication)   |
| [Vagrant](http://www.vagrantup.com/)    |   [Vagrant](https://github.com/mitchellh/vagrant)   |
| [Oracle](http://www.oracle.com/index.html) | [VirtualBox](https://www.virtualbox.org/) |
| [Puppet Labs](https://puppetlabs.com/) | [Puppet](http://info.puppetlabs.com/download-pe.html) |
| [PHP](http://php.net/) | [PHP](http://php.net/) |
| [Geoffrey Wagner](https://twitter.com/gwagner85) | [ZF2VagrantBase](https://github.com/gwagner/ZF2VagrantBase) |