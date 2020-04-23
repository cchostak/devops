# Puppet 

Resource type format:

```sh
<TYPE>('<TITLE>':
    <ATTRIBUTE> => <VALUE>,
)
```

Example:
```sh
user('username':
    ensure => present,
    uid => '102',
    gid => 'wheel',
    shell => '/bin/bash',
    home => '/home/username',
    managehome => true,
)
```

# Puppet commands

```sh
puppet apply : manages systems without needing to contact a Puppet master server
puppet agent : manages systems, with the help of a Puppet Master 
puppet cert : helps manage Puppets built-in certificate authority (CA)
puppet module : is a multi-purpose tool for working with Puppet modules
puppet resource : lets you interactively inspect and manipulate resources on a system
puppet parser : lets you validate Puppet code to make sure it contains no syntax errors
```