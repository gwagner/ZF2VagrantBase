class php::config {

    # PHP Vars need to install PHP
    $php_prefix = 'php54'
    $php_version = '5.4.11-1.ius.el6.x86_64'
    $php_pear_version = '1.9.4-1.ius.el6'
    $php_xdebug_version = '2.2.1-2.ius.el6'
    $php_timezone = 'America/Chicago'

    # Extension Version Information
    $memcache_version = '3.0.7-2.ius.el6'
    $memcached_version = '2.1.0-2.ius.el6'
    $mongo_version = '1.2.12'

    $extension_dependencies = [
        File['/etc/php.d'],
        Yumrepo['ius'],
        Yumrepo['ius-development'],
        Package['re2c'],
        Package['gcc'],
        Package["php-common"],
        Package["php-cli"],
        Package["php-devel"]
    ]
}