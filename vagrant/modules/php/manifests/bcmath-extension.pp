class php::bcmath-extension
{
    require php::config, repo_ius

    package {
        'php-ext-bcmath':
            name => "${php::config::php_prefix}-bcmath-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}