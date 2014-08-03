class papply {
	$content = "#!/bin/sh
cd /opt/puppet; git pull
puppet apply /opt/puppet/manifasts/site.pp --modulepath=/opt/puppet/modules --hiera_config=/opt/puppet/hiera.yaml > /tmp/puppet.log 2>&1
"
		
	file { '/usr/bin/papply':
		ensure => 'present',
		content => "$content",
		owner => 'root',
		group => 'root',
		mode => '0755',
	}
	
	cron { 'papply':
		command => '/usr/bin/papply',
		user => 'root',
		minute => '*/5',
		require => File['/usr/bin/papply'],
	}
}