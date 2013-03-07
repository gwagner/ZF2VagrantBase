class php::fpm-extension
{
    require php::config, repo_ius

    package {
        'php-ext-fpm':
            name => "${php::config::php_prefix}-fpm-${php::config::php_version}":
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}