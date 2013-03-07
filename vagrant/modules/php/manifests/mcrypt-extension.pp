class php::mcrypt-extension
{
    require php::config, repo_ius

    package {
        'php-ext-mcrypt':
            name => "${php::config::php_prefix}-mcrypt-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}