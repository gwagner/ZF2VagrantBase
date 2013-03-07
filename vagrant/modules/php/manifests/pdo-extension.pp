class php::pdo-extension
{
    require php::config, repo_ius

    package {
        'php-ext-pdo':
            name => "${php::config::php_prefix}-pdo-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}