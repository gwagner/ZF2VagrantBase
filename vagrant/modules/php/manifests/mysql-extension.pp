class php::mysql-extension
{
    require php::config, repo_ius

    package {
        'php-ext-mysql':
            name => "${php::config::php_prefix}-mysql-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}