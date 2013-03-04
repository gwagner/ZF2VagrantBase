class php::enchant-extension
{
    require php::config, repo-ius

    package {
        "${php::config::php_prefix}-enchant-${php::config::php_version}":
            ensure => installed,
            provider => 'yum',
            require => [
                Yumrepo['ius'],
                Package['re2c'],
                Package['gcc'],
                Package["php-common"],
                Package["php-cli"]
            ];

    }
}