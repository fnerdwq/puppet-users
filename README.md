#puppet-users

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What Users affects](#what-users-affects)
    * [Setup requirements](#setup-requirements)
4. [Usage](#usage)
5. [Limitations](#limitations)
6. [TODOs](#todos)

##Overview

This small users module manages users defined in hashes through hiera.
The user resource and possibly ssh_authorized_key are managed.

Written for Puppet >= 3.4.0.

##Module Description

See [Overview](#overview) for now.

##Setup

###What Users affects

* All in hiera defined users.
* Passwords, Homes, ...
* ssh authorized key: *only* the explicitly managed key, non managed keys are *not* deleted!

###Setup Requirements

Hiera has to used to define the users.
	
##Usage

In hiera (yaml) the key `users` key is defined holding a hash of all the users, e.g.:

```yaml
users:
  root:
    ensure: present
    password: '<Password Hash>'
    gid: root
    home: /root
    shell: /bin/bash
    comment: Big Root
    managehome: false
    ssh_private_key:
      keyname: id_rsa
      content: |
       -----BEGIN RSA PRIVATE KEY-----
       ...
       -----END RSA PRIVATE KEY-----
    ssh_authorized_keys:
      'SSH Key Comment':
        ensure: present
        type: ssh-rsa
	options: ...
        key: '<SSH Public Key>'
      'Possibly second key':
        ...
  seconduser:
    ...
```

For *ssh_priavate_key* either *content* or *source* can be specified.

With this yaml definition, a simple
```puppet
include users
```
takes care of everything.

##Limitations:

Debian and RedHat like systems.
Tested on:

* Debian 7
* CentOs 6.x

Puppet Version >= 3.4.0, due to specific hiera usage.

##TODOs:

* non managed user ssh key should be deleted
* parameter validation
* ...a lot
