class php::pear-extension
{
    require php::config, repo_ius

    package {
        'php-ext-pear':
            name => "${php::config::php_prefix}-pear-${php::config::php_pear_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}