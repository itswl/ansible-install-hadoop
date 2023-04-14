#!/bin/expect

spawn kdb5_ldap_util -D cn=admin,dc=zetyun,dc=com -w Zetyun_2021 stashsrvpw -f /etc/krb5.ldap cn=admin,dc=zetyun,dc=com
expect "Password for \"cn=admin,dc=zetyun,dc=com\": "
send "Zetyun_2021\r"
expect "Re-enter password for \"cn=admin,dc=zetyun,dc=com\": "
send "Zetyun_2021\r"
expect eof
