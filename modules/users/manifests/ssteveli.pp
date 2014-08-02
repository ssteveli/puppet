class users::ssteveli {
	group { 'ssteveli':
		ensure => 'present',
	}

	user { 'ssteveli':
		ensure => 'present',
		gid => 'build',
		managehome => true,
		password => '*',
		require => Group['ssteveli'],
	}

	file { '/home/ssteveli':
		ensure => 'directory',
		owner => 'ssteveli',
		group => 'ssteveli',
		require => [User['ssteveli'], Group['ssteveli']],
	}

	file { '/home/ssteveli/.ssh':
		ensure => 'directory',
		owner => 'build',
		group => 'build',
		mode => '0700',
		require => File['/home/ssteveli'],
	}
	
	file { '/etc/sudoers.d/ssteveli':
		ensure => 'file',
		content => 'ssteveli ALL=(ALL) NOPASSWD: ALL',
		mode => '440',
		owner => 'root',
		group => 'root',
	}

	ssh_authorized_key { 'ssteveli-ssh-key':
		ensure => 'present',
		type => 'ssh-rsa',
		key => 'AAAAB3NzaC1yc2EAAAABIwAAAQEA4gBGNQYvtf1Nq+UZAtRkq+2ckTyETPQhlsCRVkmhcWMOznfOz1ozsDAXfkdQPbFEgGPjEGYOEbTSUnoTF6IxdE6s91trPTIQkXqQzg0LwEZtoPbyaDxopUEXPG5nvlpB33wcGEpDhWp7pwOeUwMyLP3lGX/IT2GhhwXtr50PPfxKY1hqPQW1KAuslLPE939V8iyuJsY/+tpibBYkkWTJK7m9LS+3NC0SMNganhkVg/IBuD9FwefOepoNJTo39NWyloUufSQKxDJVo0QXWu86q/BbyeDmtIaH8a5TLJyWCjOK1tAWNz8BhrviVxORhQdC17qjx6MxsdZkf3bM1yOHmQ==',
		user => 'ssteveli',
		require => File['/home/ssteveli/.ssh'],
	}
}
