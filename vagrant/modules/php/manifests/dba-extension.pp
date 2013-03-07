class php::dba-extension
{
    require php::config, repo_ius

    package {
        'php-ext-dba':
            name => "${php::config::php_prefix}-dba-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}