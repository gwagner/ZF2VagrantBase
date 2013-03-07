class nano
{
    include repo_epel, repo_centos

    package {
        #packages require a repo
        'nano':
            ensure => 'installed',
            provider => 'yum',
            require => Yumrepo['epel', 'centos-base', 'centos-updates', 'centos-extras'];
    }
}