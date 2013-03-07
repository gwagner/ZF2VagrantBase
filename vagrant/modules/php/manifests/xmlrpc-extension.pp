class php::xmlrpc-extension
{
    require php::config, repo_ius

    package {
        'php-ext-xmlrpc':
            name => "${php::config::php_prefix}-xmlrpc-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;
    }
}