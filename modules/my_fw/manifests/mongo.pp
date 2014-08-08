class my_fw::mongo {
firewall { '101 mongo traffic':
		proto => 'tcp',
		port => [27017],
		action => 'accept',
	}
}