class repo-epel
{
    yumrepo {
        "epel":
            mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch&country=us',
            descr => 'Extra Packages for Enterprise Linux $releasever - $basearch',
            enabled => 1,
            gpgcheck => 0;
    }
}