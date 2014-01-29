# this define actually manges ssh_authorized_keys for a user
# (private)
define users::ssh_authorized_key {

  # extract user uand sshkey_comment from unique title/name
  $splitted_name = split($name, ' --- ')
  $user = $splitted_name[0]
  $sshkey_comment = $splitted_name[1]

  # the ssh key for the user with the given comment ($name)
  $sshkey=$users::hash[$user]['ssh_authorized_keys'][$sshkey_comment]

  ssh_authorized_key { $name:
    ensure  => $sshkey['ensure'],
    key     => $sshkey['key'],
    options => $sshkey['options'],
    type    => $sshkey['type'],
    user    => $user,
  }

}
