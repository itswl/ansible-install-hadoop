#!/bin/expect

spawn kdb5_ldap_util -D cn=admin,dc=zetyun,dc=com -w Zetyun_2021 -H ldap:/// create -r ZETYUN.COM -s
expect "Enter KDC database master key: "
send "Zetyun_2021\r"
expect "Re-enter KDC database master key to verify:"
send "Zetyun_2021\r"
expect eof
