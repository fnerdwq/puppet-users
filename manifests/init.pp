# == Class: users
#
# A small class managing users and its ssh_authorized_keys
#
# === Parameters
#
# users hash must be defined in hiera, see README.
#
# === Examples
#
#  include users
#
# In hiera a users hash should be defined. See README.
#
# === Authors
#
# Frederik Wagner <wagner@wagit.de>
#
# === Copyright
#
# Copyright 2014 Frederik Wagner
#
class users (
  $match='all',  # TODO: hiera match!
) {

  $hash=hiera('users', undef)

  if $hash {

    $users=keys($hash)

    users::manage{ $users: }

  }

}
