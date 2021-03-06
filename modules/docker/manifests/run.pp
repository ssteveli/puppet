define docker::run(
	$image,
	$after='docker.service',
	$volumes=[],
	$links=[],
	$ports=[]) {

	$volumes_array = any2array($volumes)
	$ports_array = any2array($ports)
	$links_array = any2array($links)

	file { "/usr/bin/docker-$name-start.sh":
		ensure => 'present',
		content => template('docker/docker-start.erb'),
		owner => 'root',
		group => 'root',
		mode => '0755',
	}

	file { "/usr/bin/docker-$name-stop.sh":
		ensure => 'present',
		content => template('docker/docker-stop.erb'),
		owner => 'root',
		group => 'root',
		mode => '0755',
	}

	file { "/usr/bin/docker-$name-update.sh":
		ensure => 'present',
		content => template('docker/docker-handleupdate.erb'),
		owner => 'root',
		group => 'root',
		mode => '0755',
	}

	file { "/usr/lib/systemd/system/$name.service":
		ensure => 'present',
		content => template('docker/systemd-container.erb'),
		owner => 'root',
		group => 'root',
		mode => '0644',
	}

	service { "$name":
		ensure => 'running',
		require => [
			File ["/usr/lib/systemd/system/$name.service"],
			File ["/usr/bin/docker-$name-start.sh"],
			File ["/usr/bin/docker-$name-stop.sh"],
			Service['docker']
		]
	}

}