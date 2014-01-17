# this define actually manges ssh_authorized_keys for a user
#
# (private)
define users::ssh_authorized_key (
  $user
) {

  # the ssh key for the user with the given comment ($name)
  $sshkey=$users::hash[$user]['ssh_authorized_keys'][$name]

  ssh_authorized_key { "${user}-${name}":
    ensure  => $sshkey['ensure'],
    name    => $name,	# the comment
    key     => $sshkey['key'],
    options => $sshkey['options'],
    type    => $sshkey['type'],
    user    => $user,
  }

}
