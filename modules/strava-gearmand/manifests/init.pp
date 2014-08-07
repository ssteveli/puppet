class strava-gearmand {
	
	$content = "[Unit]
Description=Gearmand Container
After=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker start -a strava-gearmand
ExecStop=/usr/bin/docker stop -t 2 strava-gearmand
Restart=on-failure

[Install]
WantedBy=local.target
"
	file { '/usr/lib/systemd/system/strava-gearmand.service':
		ensure => 'present',
		content => "$content",
		owner => 'root',
		group => 'root',
		mode => '0644',
	}
	
	service { 'strava-gearmand':
		ensure => 'running',
		require => [File ['/usr/lib/systemd/system/strava-gearmand.service'], Service['docker']]
	}
}