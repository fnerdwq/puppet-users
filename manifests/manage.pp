# this define actually manages the users and calls to manage
# ssh_authorized_keys
#
# (private)
define users::manage {

  $user=$users::hash[$name]

  user { $name:
    ensure     => $user['ensure'],
    password   => $user['password'],
    managehome => $user['managehome'],
  }

  if $user['ssh_authorized_keys'] {

    $sshkey_comments=keys($user['ssh_authorized_keys'])
    users::ssh_authorized_key { $sshkey_comments:
      user => $name
    }
  }

}
