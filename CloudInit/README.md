# Cloud Init

Multi distribution package that handles early initialization of a cloud instance
Cloud Int is a great way to configure your cloud instances when they first spin up. In this lesson, we will talk about some of the basic commands and formats that Cloud Init uses.

https://cloudinit.readthedocs.io/en/latest/topics/availability.html

Use Cases:

1. Default locale
2. Private SSH
3. Ephemeral mount point

```sh
cloud-init init # Initialize modules
cloud-init modules # Activates modules using a given configuration key
cloud-init single # Runs a single module
cloud-init dhclient-hook # runs the dhclient to record network info
cloud-init features # Lists defined features
cloud-init analyze # Analyze cloud-init logs and data
cloud-init devel # Runs development tools
cloud-init collect-logs # Collects and tar all cloud-init debug info
cloud-init clean # Removes logs and artifacts so cloud-init can re-run
cloud-init status
```

It comes installed on all ubuntu cloud images and images available on EC2, Azure and GCE, Fedora, Debian, RHEL and CentOS

# Example resolv.conf, more on https://cloudinit.readthedocs.io/en/latest/topics/examples.html

```sh
#cloud-config
#
# This is an example file to automatically configure resolv.conf when the
# instance boots for the first time.
#
# Ensure that your yaml is valid and pass this as user-data when starting
# the instance. Also be sure that your cloud.cfg file includes this
# configuration module in the appropriate section.
#
manage_resolv_conf: true

resolv_conf:
  nameservers: ['8.8.4.4', '8.8.8.8']
  searchdomains:
    - foo.example.com
    - bar.example.com
  domain: example.com
  options:
    rotate: true
    timeout: 1
```