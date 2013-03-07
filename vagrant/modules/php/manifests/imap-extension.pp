class php::imap-extension
{
    require php::config, repo_ius

    package {
        'php-ext-imap':
            name => "${php::config::php_prefix}-imap-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}