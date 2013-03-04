class repo-ius
{
    yumrepo {
        # PHP Source
        "ius":
            mirrorlist => 'http://dmirr.iuscommunity.org/mirrorlist/?repo=ius-el$releasever&arch=$basearch',
            descr => 'IUS Community Packages for Enterprise Linux $releasever - $basearch',
            failovermethod => 'priority',
            enabled => 1,
            gpgcheck => 0,
            require => [
                Host['ius']
            ];

        # Archive for older versions
        "ius-archive":
            mirrorlist => 'http://dmirr.iuscommunity.org/mirrorlist/?repo=ius-el$releasever-archive&arch=$basearch',
            descr => 'IUS Community Archive Packages for Enterprise Linux $releasever - $basearch',
            failovermethod => 'priority',
            enabled => 1,
            gpgcheck => 0,
            require => [
                Host['ius']
            ];
    }

    host {
        'ius':
            ip => '50.57.54.209',
            host_aliases => ['dl.iuscommunity.org', 'iuscommunity.org'],
            ensure => present,
            target => '/etc/hosts';
    }
}