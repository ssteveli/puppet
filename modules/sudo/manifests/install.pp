class sudo::install {
	package { "sudo":
		ensure => installed,
		allow_virtual => false,
	}
}

