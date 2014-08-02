node default {
	include sudo::install
	include sudo::sudoers
	include users::build
	include sshd
}

