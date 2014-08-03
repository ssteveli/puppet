class fail2ban {
	package { 'epel-release-7-0.2.noarch':
		provider => 'rpm',
		ensure => 'installed',
		source => 'http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm'
	}

	package { 'fail2ban':
		ensure => 'installed',
		require => Package['epel-release-7-0.2.noarch'],
		allow_virtual => false,
	}

	service { 'fail2ban':
		ensure => 'running',
		require => Package['fail2ban'],
	}
}