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
1. Once the machine is up and running, navigate to http://192.168.1.12
1. Profit!!!

> ***Note:*** On your first `vagrant up` you will download a ~400MB CentOS image.  This will take some time.  Every subsequent run of `vagrant up` will not re-download the image.

Configuration Files
------------

Since the version bump to 1.1+ for Vagrant, there is a divergence from previous configuration files to the new configuration files.  I have supplied a Vagrantfile\_1 and a Vagrantfile\_2 for use with this project.  By default the contents of Vagrantfile are a direct copy of the contents from Vagrantfile\_2.  I have commented the proper configuration changes that need to be made in the Vagrantfile\_1 if you are using Vagrant < 1.1.

> ***Note:*** The version change has made things a little confusing.  Try and default to using the default setup with Vagrant 1.1+  If that is not an option and you can not get things working on your computer, feel free to contact [@gwagner85](https://twitter.com/gwagner85) on twitter.

Unit Testing
------------

Testing is pretty simple.  Follow these steps if you plan on developing in the application module.  If you are going creating your own module from scratch, use the application module as a template.

* Run tests without code coverage
    1. In your terminal, navigate to your vagrant directory
    1. Run the following command `vagrant ssh -c "sudo php /var/www/zf2/vendor/phpunit/phpunit/phpunit.php -c /var/www/zf2/test/phpunit-fast.xml"`
* Run tests with code coverage
    1. In your terminal, navigate to your vagrant directory
    1. Run the following command `vagrant ssh -c "sudo php /var/www/zf2/vendor/phpunit/phpunit/phpunit.php -c /var/www/zf2/test/phpunit.xml"`

Your testing log files will end up in PROJECT_ROOT/data/log

But, I wana use this with my project!!
------------

You can take the [vagrant directory](https://github.com/gwagner/ZF2VagrantBase/tree/master/vagrant) right out of this project directly into your project and use it.  Once it is on your project (and you have installed VirtualBox / Vagrant), navigate to your vagrant directory and run `vagrant up` from your terminal.  It is very VERY portable that way.  That will give you a VM running on YOUR existing project :thumbsup:

> ***Note:*** You may need to disable the composer module from the [zf2 module](https://github.com/gwagner/ZF2VagrantBase/blob/master/vagrant/modules/zf2/manifests/init.pp) if you are not using composer in your project

Contributors
------------
These contributors are in no particular order


| Contributor  | Provided  |
|---------------|----------------|
| [Zend](http://www.zend.com/en/)    |   [ZendFramekwork](https://github.com/zendframework/zf2) && [ZendSkeletonApplication](https://github.com/zendframework/ZendSkeletonApplication)   |
| [HashiCorp](http://www.hashicorp.com/)    |   [Vagrant GitHub](https://github.com/mitchellh/vagrant) / [Vagrant Website](http://www.vagrantup.com/) |
| [VagrantBox](http://www.vagrantbox.es/) | [CentOS 6.3 i386 Minimal (VirtualBox Guest Additions 4.2.6, Chef 10.16.4, Puppet 3.0.2)](http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.3-i386-v20130101.box)
| [Oracle](http://www.oracle.com/index.html) | [VirtualBox](https://www.virtualbox.org/) |
| [Puppet Labs](https://puppetlabs.com/) | [Puppet](http://info.puppetlabs.com/download-pe.html) |
| [PHP](http://php.net/) | [PHP](http://php.net/) |
| [Geoffrey Wagner](https://twitter.com/gwagner85) | [ZF2VagrantBase](https://github.com/gwagner/ZF2VagrantBase) |
