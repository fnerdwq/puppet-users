# this define actually manages the users and calls to manage
# ssh_authorized_keys (private)
define users::manage {

  $user=$users::hash[$name]

  user { $name:
    ensure     => $user['ensure'],
    password   => $user['password'],
    managehome => true, #$user['managehome'],
  }

  if $user['ssh_authorized_keys'] {

    # so complicated since ssh_authorized_key name/comment must be unique
    # over all users!
    $user_sshkey_comments=prefix(keys($user['ssh_authorized_keys']), "${name} --- ")
    users::ssh_authorized_key { $user_sshkey_comments: }
  }

}
