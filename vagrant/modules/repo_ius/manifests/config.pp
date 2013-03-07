class repo_ius::config
{
    $base_mirrorlist = ['http://dmirr.iuscommunity.org/mirrorlist/?repo=ius-el$releasever&arch=$basearch']

    $archive_mirrorlist = ['http://dmirr.iuscommunity.org/mirrorlist/?repo=ius-el$releasever-archive&arch=$basearch']

    $devel_mirrorlist = ['http://dmirr.iuscommunity.org/mirrorlist/?repo=ius-el$releasever-dev&arch=$basearch']

     host {
        'ius':
            ip => '50.57.54.209',
            host_aliases => ['dl.iuscommunity.org', 'iuscommunity.org'],
            ensure => present,
            target => '/etc/hosts';
    }
}