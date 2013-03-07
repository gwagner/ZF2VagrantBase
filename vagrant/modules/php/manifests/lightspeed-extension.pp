class php::lightspeed-extension
{
    require php::config, repo_ius

    package {
         'php-ext-lightspeed':
            name => "${php::config::php_prefix}-lightspeed-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}