class repo_centos
{
    include repo_centos::config

    yumrepo {
        # CentOS Source Files
        "centos-base":
            mirrorlist => $repo_centos::config::base_mirrorlist,
            descr => 'CentOS-$releasever - Base',
            failovermethod => 'priority',
            enabled => 1,
            gpgcheck => 0,
            require => [
                Host['repo_centos']
            ];

        "centos-updates":
            mirrorlist => $repo_centos::config::updates_mirrorlist,
            descr => 'CentOS-$releasever - Updates',
            failovermethod => 'priority',
            enabled => 1,
            gpgcheck => 0,
            require => [
                Host['repo_centos']
            ];

        "centos-extras":
            mirrorlist => $repo_centos::config::extras_mirrorlist,
            descr => 'CentOS-$releasever - Extras',
            failovermethod => 'priority',
            enabled => 1,
            gpgcheck => 0,
            require => [
                Host['repo_centos']
            ];
    }
}