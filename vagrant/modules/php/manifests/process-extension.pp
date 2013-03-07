class php::process-extension
{
    require php::config, repo_ius

    package {
        'php-ext-process':
            name => "${php::config::php_prefix}-process-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}