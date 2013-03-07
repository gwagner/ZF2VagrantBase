class repo_centos::config
{
    $base_mirrorlist = ['http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os']

    $updates_mirrorlist = ['http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates']

    $extras_mirrorlist = ['http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras']

    host {
        'repo_centos':
            ip => '64.235.47.134',
            host_aliases => ['mirrorlist.centos.org'],
            ensure => present,
            target => '/etc/hosts';
    }
}