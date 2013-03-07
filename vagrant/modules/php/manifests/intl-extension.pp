class php::intl-extension
{
    require php::config, repo_ius

    package {
        'php-ext-intl':
            name => "${php::config::php_prefix}-intl-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}