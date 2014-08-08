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
	$environment = 'production'
	
	include strava-mongodb
}

node /^sc-web\d+$/ inherits default {
	$environment = 'production'
	
	include stravasocial->
	
	docker::image { 'rgarcia/gearmand':
		ensure => 'present',
	}->

	docker::run { 'strava-gearmand':
		image => 'rgarcia/gearmand'
	}->

	docker::image { 'ssteveli/strava-gearman-workers':
	}->

	docker::run { 'strava-gearmandworker':
		image => 'ssteveli/strava-gearman-workers',
		volumes => ['/data:/data'],
		links => ['strava-gearmand:strava-gearmand'],
	}->

	docker::image { 'ssteveli/strava-api':
	}->

	docker::run { 'strava-api':
		image => 'ssteveli/strava-api',
		volumes => ['/data:/data'],
		links => ['strava-gearmand:strava-gearmand'],
	}->

	docker::image { 'ssteveli/strava-web':
	}->

	docker::run { 'strava-web':
		image => 'ssteveli/strava-web',
		volumes => ['/data:/data'],
		links => ['strava-api:strava-api'],
		ports => ['80:80']
	}

}



