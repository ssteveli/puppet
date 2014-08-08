class stravasocial {
	package { 'git':
		ensure => 'present',
	}
	
	file { '/data':
		ensure => 'directory',
		owner => 'root',
		group => 'root',
		mode => '0755',
	}
	
	exec { 'initial stravasocial git clone':
		path => ['/bin', '/usr/bin'],
		creates => '/data/stravasocial',
		command => 'git clone https://github.com/ssteveli/stravasocial /data/stravasocial'
		require => [Package['git'], File['/data']]
	}
}
