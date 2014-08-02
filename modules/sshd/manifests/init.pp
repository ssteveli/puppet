class sshd {
	package { "openssh-server":
		ensure => "installed",
		allow_virtual => false,
	}
	
	service { "sshd":
		ensure => "running",
		enable => true,
		require => Package["openssh-server"],
	}
	
	augeas { "configure_sshd":
		context => "/files/etc/ssh/sshd_config",
		changes => [
			"set PasswordAuthentication no",
			"set PermitRootLogin no"
		],
		require => Package["openssh_server"],
		notify => Service["sshd"],
	}		
}