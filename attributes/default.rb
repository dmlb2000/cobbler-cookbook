#
# Cookbook Name:: cobblerd
# Attribute:: default
#
# Copyright (C) 2014 Bloomberg Finance L.P.
#

default[:cobbler][:web_username] = 'cobbler'
default[:cobbler][:web_password] = 'cobbler'

default[:cobbler][:ks][:username] = 'cloud'

default[:cobbler][:resource_storage] = '/var/local/cobbler/images/'

# $ echo 'cobbler' | mkpasswd -S LQTvGQ11AIG0k -s -m sha-512
default[:cobbler][:ks][:root_password] = '$6$LQTvGQ11AIG0k$TOSqMnXrQ9Y.3AP6KwRnMitmRaIeteoDKlxVbJgxXB07bK8HdzthHps8gjbIn0iYbTI1BpOVIUtqks6Ed06E7/'
default[:cobbler][:ks][:user_password] = '$6$LQTvGQ11AIG0k$TOSqMnXrQ9Y.3AP6KwRnMitmRaIeteoDKlxVbJgxXB07bK8HdzthHps8gjbIn0iYbTI1BpOVIUtqks6Ed06E7/'

# replaced barewords found via grep -h 'name.replace' /usr/lib/python2.7/dist-packages/cobbler/modules/*|sort -u
default[:cobbler][:distro][:reserved_words][:bare_words] = ["--", "-amd64", "-boot", "chrp", "-i386",
     "-images", "-install", "-isolinux", "ks_mirror-", "-loader", "-netboot", "-os",
     "-pxeboot", "srv-www-cobbler-", "-tree", "-ubuntu-installer", "var-www-cobbler-"]

# reserved arches and separators found via grep -B2 -h 'name.replace("%s%s"' /usr/lib/python2.7/dist-packages/cobbler/modules/*
default[:cobbler][:distro][:reserved_words][:arch] = ["i386" , "x86_64" , "ia64" , "ppc64",
     "ppc32", "ppc", "x86" , "s390x", "s390" , "386" , "amd", "arm"]
default[:cobbler][:distro][:reserved_words][:separators] = ["-", "_", "."]

default[:cobbler][:distro][:use_databags] = false
default[:cobbler][:distro][:data_bag] = 'cobbler_distros'
default[:cobbler][:profile][:use_databags] = false
default[:cobbler][:profile][:data_bag] = 'cobbler_profiles'
default[:cobbler][:repo][:use_databags] = false
default[:cobbler][:repo][:data_bag] = 'cobbler_repos'
