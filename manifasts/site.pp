resources { "firewall":
	purge => true,
}

Firewall {
	before => Class['my_fw::post'],
	require => Class['my_fw::pre'],
}

class { ['my_fw::pre', 'my_fw::post']: }
class { 'firewall': }

node default {
	include sudo::install
	include sudo::sudoers

	include users::build
	include users::ssteveli

	include sshd

	include docker
	
	include papply
}

node /^sc-mongodb\d+$/ inherits default {
	include strava-mongodb
}

node /^sc-web\d+$/ inherits default {
	docker::image { 'rgarcia/gearmand':
		ensure => 'present',
	}
	
	docker::run { 'strava-gearmand':
		image => 'rgarcia/gearmand'
	}
	
	docker::image { 'ssteveli/strava-gearman-workers':
		ensure => 'latest',
	}

	docker::image { 'ssteveli/strava-api':
		ensure => 'latest',
	}

	docker::image { 'ssteveli/strava-web':
		ensure => 'latest',
	}
	
	docker::run { 'strava-gearmandworker':
		image => 'ssteveli/strava-gearman-workers',
		volumes => ['/data'],
		links => ['strava-gearmand:strava-gearmand'],
	}
}



