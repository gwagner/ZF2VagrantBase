class php::tidy-extension
{
    require php::config, repo_ius

    package {
        'php-ext-tidy':
            name => "${php::config::php_prefix}-tidy-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies,;
    }
}