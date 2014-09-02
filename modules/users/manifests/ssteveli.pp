class users::ssteveli {
	group { 'ssteveli':
		ensure => 'present',
	}

	user { 'ssteveli':
		ensure => 'present',
		gid => 'ssteveli',
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
		owner => 'ssteveli',
		group => 'ssteveli',
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

	ssh_authorized_key { 'ssteveli-ssh-key-macbookpro':
		ensure => 'present',
		type => 'ssh-rsa',
		key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDl/CnkZLlIYBvt9P6NfwcxVp/nh6PbftvhkyGf7jSrB7QJj805HoMoDoLpAGeXov0sSh16xkg/enNNJnXBvmJVKYDTdnUCZSaqR6+Cs87Q5hEAsdMLMn34qN+SGyZfS5SW1UpuKjMUPCg9FFUbFuukUOTp/5cQROdjPcRkmMnwmHMsFexM5V154+19B+vEK6zxPMsyneiKUxrwX1kz3VJssWbOcI15pdP1fixUvSCP0xze24SdidN1ejhFwxixgjz92PrZownrySuuuuaOkgAIHI2MoeBadllEgmRDBgdSbfoJF5RxtA+8SCoXeNn7SK8u8OXn0N0aXsk/c2jRsSbF',
		user => 'ssteveli',
		require => File['/home/ssteveli/.ssh'],
	}

	ssh_authorized_key { 'ssteveli-ssh-key-imac':
		ensure => 'present',
		type => 'ssh-rsa',
		key => 'AAAAB3NzaC1yc2EAAAABIwAAAQEA4gBGNQYvtf1Nq+UZAtRkq+2ckTyETPQhlsCRVkmhcWMOznfOz1ozsDAXfkdQPbFEgGPjEGYOEbTSUnoTF6IxdE6s91trPTIQkXqQzg0LwEZtoPbyaDxopUEXPG5nvlpB33wcGEpDhWp7pwOeUwMyLP3lGX/IT2GhhwXtr50PPfxKY1hqPQW1KAuslLPE939V8iyuJsY/+tpibBYkkWTJK7m9LS+3NC0SMNganhkVg/IBuD9FwefOepoNJTo39NWyloUufSQKxDJVo0QXWu86q/BbyeDmtIaH8a5TLJyWCjOK1tAWNz8BhrviVxORhQdC17qjx6MxsdZkf3bM1yOHmQ==',
		user => 'ssteveli',
		require => File['/home/ssteveli/.ssh'],
	}

	ssh_authorized_key { 'ssteveli-ssh-key-macbookair':
		ensure => 'present',
		type => 'ssh-rsa',
		key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDWxWY2OUadNjOiUL4YWMX+ZOvItNIo8zcMAfgXqRS1+vyClzIRZFDkTzgdG7jdrD2rIpa/Il70iW64PzP9gx65kVCPGsGmP6ay1MbMEP/y8toUakskT9ZHBykD0FFZ0KS1i2J0S6SKVLg0UXO8ysUtructyoBArvqE95X355BioLDJYmpuJpbnpJswPMuJA4DW+WmYjfC9wHjMjtpomwGM7bCO3hkjdp+DCjSzyHrC9dod+3MqYqk9yENwfHKS4BE1cYzDW8ixcYmqYzXwK1BHbiIlqYpSJut+q9QmGFqLxukPzZrhJHWxInvkVE3vgURC7C6EH+Z8ydoGvLYQ//Qb',
		user => 'ssteveli',
		require => File['/home/ssteveli/.ssh'],
	}

}
