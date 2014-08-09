class docker {
	package { 'docker':
		ensure => 'installed',
		allow_virtual => false,
	}

	service { 'docker':
		ensure => 'running',
		require => Package['docker'],
	}
	
	firewall { '300 allow docker0 connections':
		chain => 'FORWARD',
		action => 'ACCEPT',
		outiface => 'docker0',
		ctstate => ['RELATED','ESTABLISHED'],
		proto => 'all',
	}
	
	firewall { '301 allow docker0 traffic out':
		chain => 'FORWARD',
		action => 'ACCEPT',
		proto => 'all',
		iniface => 'docker0',
		outiface => 'eth0',
	}
	
	firewall { '302 allow docker0 traffic to docker0':
		chain => 'FORWARD',
		action => 'ACCEPT',
		proto => 'all',
		iniface => 'docker0',
		outiface => 'docker0',
	}
		
}