class php::embedded-extension
{
    require php::config, repo_ius

    package {
        'php-ext-embedded':
            name => "${php::config::php_prefix}-embedded-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}