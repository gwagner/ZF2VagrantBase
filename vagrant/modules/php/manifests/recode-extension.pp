class php::recode-extension
{
    require php::config, repo_ius

    package {
        'php-ext-recode':
            name => "${php::config::php_prefix}-recode-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;
    }
}