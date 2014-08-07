class docker::run($image) {
	file { "/usr/bin/docker-$name-start.sh":
		ensure => 'present',
		content => template('docker/docker-start.erb'),
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
			Service['docker']
		]
	}

}