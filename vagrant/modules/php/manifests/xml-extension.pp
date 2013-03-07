class php::xml-extension
{
    require php::config, repo_ius

    package {
        'php-ext-xml':
            name => "${php::config::php_prefix}-xml-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}