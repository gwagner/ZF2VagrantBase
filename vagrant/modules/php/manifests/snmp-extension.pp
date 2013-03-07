class php::snmp-extension
{
    require php::config, repo_ius

    package {
        'php-ext-snmp':
            name => "${php::config::php_prefix}-snmp-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;
    }
}