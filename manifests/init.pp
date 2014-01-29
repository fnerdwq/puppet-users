# == Class: users
#
# A small class managing users and its ssh_authorized_keys
#
# === Parameters
#
# users hash must be defined in hiera, see README.
#
# [*merge*]
#   Depending on this parameter a simple hiera lookup or
#   hash lookup is done, merging the users in the hierarchy.
#   *Optional* (defaults to true)
#
# === Examples
#
# include users
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
  $merge=true,
) {

  validate_bool(str2bool($merge))

  # TODO: deeper merge?
  if str2bool($merge) {
    $hash=hiera_hash('users', false)
  } else {
    $hash=hiera('users', false)
  }

  if $hash {

    $users=keys($hash)

    users::manage{ $users: }

  }

}
