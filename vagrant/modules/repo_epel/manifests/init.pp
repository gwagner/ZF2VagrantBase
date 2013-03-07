class repo_epel
{
    include repo_epel::config

    yumrepo {
        "epel":
            mirrorlist => $repo_epel::config::base_mirrorlist,
            descr => 'Extra Packages for Enterprise Linux $releasever - $basearch',
            failovermethod => 'priority',
            enabled => 1,
            gpgcheck => 0;
    }
}