class repo_ius
{
    include repo_ius::config

    yumrepo {
        # PHP Source
        "ius":
            mirrorlist => $repo_ius::config::base_mirrorlist,
            descr => 'IUS Community Packages for Enterprise Linux $releasever - $basearch',
            failovermethod => 'priority',
            enabled => 1,
            gpgcheck => 0,
            require => [
                Host['ius']
            ];

        # Archive for older versions
        "ius-archive":
            mirrorlist => $repo_ius::config::archive_mirrorlist,
            descr => 'IUS Community Archive Packages for Enterprise Linux $releasever - $basearch',
            failovermethod => 'priority',
            enabled => 1,
            gpgcheck => 0,
            require => [
                Host['ius']
            ];

        # Archive for older versions
        "ius-development":
            mirrorlist => $repo_ius::config::devel_mirrorlist,
            descr => 'IUS Community Archive Packages for Enterprise Linux $releasever - $basearch',
            failovermethod => 'priority',
            enabled => 1,
            gpgcheck => 0,
            require => [
                Host['ius']
            ];
    }
}