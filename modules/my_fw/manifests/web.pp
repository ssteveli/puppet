class my_fw::web {
firewall { '100 web traffic':
		proto => 'tcp',
		port => [80,443],
		action => 'accept',
	}
}