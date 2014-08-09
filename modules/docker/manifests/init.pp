class docker {
	package { 'docker':
		ensure => 'installed',
		allow_virtual => false,
	}

	service { 'docker':
		ensure => 'running',
		require => Package['docker'],
	}		
}