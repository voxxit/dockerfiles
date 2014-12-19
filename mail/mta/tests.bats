#!/usr/bin/env bats

@test "/usr/sbin/postfix exists" {
  run test -f /usr/sbin/postfix
  [ $status = 0 ]
}

@test "/usr/sbin/grossd exists" {
  run test -f /usr/sbin/grossd
  [ $status = 0 ]
}

@test "resolv.conf exists in /var/spool/postfix" {
  run test -f /var/spool/postfix/etc/resolv.conf
  [ $status = 0 ]
}

@test "container can find google.com" {
  run ping -c1 google.com >/dev/null
  [ $status = 0 ]
}

@test "postfix config OK" {
  run postfix check
  [ $status = 0 ]
}

@test "dovecot config OK" {
  run doveconf -a
  [ $status = 0 ]
}

@test "aliases.db exists after running newaliases" {
  run /usr/bin/newaliases && test -f /etc/postfix/aliases.rb
  [ $status = 0 ]
}
