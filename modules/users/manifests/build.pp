class users::build {
	group { 'build':
		ensure => 'present',
	}

	user { 'build':
		ensure => 'present',
		gid => 'build',
		managehome => true,
		password => '*',
		require => Group['build'],
	}

	file { '/home/build':
		ensure => 'directory',
		owner => 'build',
		group => 'build',
		require => [User['build'], Group['build']],
	}

	file { '/home/build/.ssh':
		ensure => 'directory',
		owner => 'build',
		group => 'build',
		mode => '0700',
		require => File['/home/build'],
	}
	
	file { '/etc/sudoers.d/build':
		ensure => 'file',
		content => 'build ALL=(ALL) NOPASSWD: ALL',
		mode => '440',
		owner => 'root',
		group => 'root',
	}

	ssh_authorized_key { 'build-ssh-key':
		ensure => 'present',
		type => 'ssh-rsa',
		key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCyps/UgRdHZyhW0sokRLTxTD3bk6cyi+Zfz8W6eZ1xZ0X15e5mao84r3fJsYLyTFl4NZzAuwfRAiOxi4CZP0iMyDyn4ZZzuTMcx/tp3s71StiibSnuzvKkrHBu5iDhCRphrJCt7SHycjvQ4WgmIgnB27vO4Cb6z8x4Iru6HuPTVNh6N9DoujxVWXBfdklBTVB3BWOCyfmw5SMEJ7QgiHnoAoB5zUWPIz1ymt2Zuv/IKoT44WEvY30kz3BM/6w+I/VlgLJ+gh0IGbsRfGe61sFVtYJRAXlbCrAHIM0KiGF9IWsWZwjWSuGjK6VAmA6OiMZd42Iw0yzrwDBnWVpj+cpj',
		user => 'build',
		require => File['/home/build/.ssh'],
	}
}
