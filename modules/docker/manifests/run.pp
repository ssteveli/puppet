class docker::run {
	file : { "/usr/bin/docker-$title-start.sh":
		ensure => 'present',
		content => template('docker-start.erb'),
		owner => 'root',
		group => 'root',
		mode => '0755',
	}

	file { "/usr/lib/systemd/system/$title.service":
		ensure => 'present',
		content => template('systemd-container.erb'),
		owner => 'root',
		group => 'root',
		mode => '0644',
	}

	service { "$title":
		ensure => 'running',
		require => [
			File ["/usr/lib/systemd/system/$title.service"],
			File ["/usr/bin/docker-$title-start.sh"],
			File ["/usr/bin/docker-$title-stop.sh"],
			Service['docker']
		]
	}

}