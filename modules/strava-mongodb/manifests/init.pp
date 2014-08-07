class strava-mongodb {
	
	$content = "[Unit]
Description=MongoDb Container
After=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker start -a strava-mongodb
ExecStop=/usr/bin/docker stop -t 2 strava-mongodb
Restart=on-failure

[Install]
WantedBy=local.target
"
	file { '/usr/lib/systemd/system/strava-mongodb.service':
		ensure => 'present',
		content => "$content",
		owner => 'root',
		group => 'root',
		mode => '0644',
	}
	
	service { 'strava-mongodb':
		ensure => 'running',
		require => [File ['/usr/lib/systemd/system/strava-mongodb.service'], Service['docker']]
	}
}