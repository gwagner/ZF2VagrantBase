class nano
{
    include repo-epel

    package {
        #packages require a repo
        'nano':
            ensure => 'installed',
            provider => 'yum',
            require => Yumrepo['epel'];
    }
}