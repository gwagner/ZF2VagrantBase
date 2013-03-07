class php::enchant-extension
{
    require php::config, repo_ius

    package {
        'php-ext-enchant':
            name => "${php::config::php_prefix}-enchant-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}