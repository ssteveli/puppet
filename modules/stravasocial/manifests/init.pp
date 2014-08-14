class stravasocial(
	$mongohost = 'strava-mongodb',
	$mongoport = '27017',
	$stravaclientid,
	$stravaclientsecret
) {
	package { 'git':
		ensure => 'present',
	}
	
	file { ['/data','/data/cache']:
		ensure => 'directory',
		owner => 'root',
		group => 'root',
		mode => '0755',
	}
	
	exec { 'initial stravasocial git clone':
		path => ['/bin', '/usr/bin'],
		creates => '/data/stravasocial',
		command => 'git clone https://github.com/ssteveli/stravasocial /data/stravasocial',
		require => [Package['git'], File['/data']],
	}
	
	file { ['/data/stravasocial/app/api/localconfig.py', '/data/stravasocial/app/loader/localconfig.py']:
		ensure => 'present',
		owner => 'root',
		group => 'root',
		mode => '0644',
		content => template('stravasocial/localconfig.erb'),
		require => Exec['initial stravasocial git clone'],
	}
}
