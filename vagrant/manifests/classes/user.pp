define add_user ( $email, $uid ) {

            $username = $title

            user { $username:
                    comment => "$email",
                    home    => "/home/$username",
                    shell   => "/bin/bash",
                    uid     => $uid,
                    groups  => "vagrant"
            }

            group { $username:
                    gid     => $uid,
                    require => User[$username]
            }

            file { "/home/$username/":
                    ensure  => directory,
                    owner   => $username,
                    group   => $username,
                    mode    => 750,
                    require => [ User[$username], Group[$username] ]
            }

            file { "/home/$username/.ssh":
                    ensure  => directory,
                    owner   => $username,
                    group   => $username,
                    mode    => 700,
                    require => File["/home/$username/"]
            }


            # now make sure that the ssh key authorized files is around
            file { "/home/$username/.ssh/authorized_keys":
                    ensure  => present,
                    owner   => $username,
                    group   => $username,
                    mode    => 600,
                    require => File["/home/$username/"]
            }
    }