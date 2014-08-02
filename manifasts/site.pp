resources { "firewall":
	purge => true,
}

Firewall {
	before => Class['my_fw::post'],
	require => Class['my_fw::pre'],
}

class { ['myfw::pre', 'my_fw::post']: }
class { 'firewall': }

node default {
	include sudo::install
	include sudo::sudoers
	
	include users::build
	include users::ssteveli
	
	include sshd
}

