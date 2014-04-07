# this define actually manages the users and calls to manage
# ssh_authorized_keys (private)
define users::manage {

  $user=$users::hash[$name]

  user { $name:
    ensure     => $user['ensure'],
    password   => $user['password'],
    uid        => $user['uid'],
    gid        => $user['gid'],
    home       => $user['home'],
    shell      => $user['shell'],
    comment    => $user['comment'],
    managehome => $user['managehome'],
  }

  if $user['ssh_private_key'] {

    $ssh_private_key = $user['ssh_private_key']

    if $user['home'] {
      $home = $user['home']
    } else {
      $home = "/home/${name}"
    }

    if $ssh_private_key['name'] {
      $keyname = $ssh_private_key['name']
    } else {
      $keyname = 'id_rsa'
    }

    file { "${home}/.ssh":
      ensure  => directory,
      owner   => $name,
      group   => $user['gid'],
      mode    => '0700',
      require => User[$name],
    }

    file { "${home}/.ssh/${keyname}":
      owner   => $name,
      group   => $user['gid'],
      mode    => '0600',
      content => $ssh_private_key['content'],
      source  => $ssh_private_key['source'],
      require => File["${home}/.ssh"],
    }
  }

  if $user['ssh_authorized_keys'] {

    # so complicated since ssh_authorized_key name/comment must be unique
    # over all users!
    $user_sshkey_comments = prefix(
                        keys($user['ssh_authorized_keys']), "${name} --- ")
    users::ssh_authorized_key { $user_sshkey_comments: }
  }

}
