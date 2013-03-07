class php::ldap-extension
{
    require php::config, repo_ius

    package {
        'php-ext-ldap':
            name => "${php::config::php_prefix}-ldap-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}