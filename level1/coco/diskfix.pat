* Patches Level I Ver. 2
* CCDisk to read, write
* and format both single
* and double sided disks
* Rainbow, Oct '88, p 157
t
tmode .1 -pause
save /d0/ccdisk ccdisk
debug
lccdisk
. .+7
=80
$load /d0/ccdisk
lccdisk
. .+3
=82
lccdisk
. .+1c9
=16
=01
=84
lccdisk
. .+1f8
=5f
=17
=01
=76
lccdisk
. .+2ae
=e6
=c9
=00
=a9
=16
=00
=8c
=12
=23
=02
lccdisk
. .+2dd
=40
=12
=12
=12
=17
=00
=90
. .+3
=5f
=16
=00
=81
lccdisk
. .+341
=a6
=07
=85
=01
=26
=02
=ca
=40
=a6
=09
=81
=15
=16
=ff
=66
=a6
=88
=10
=85
=01
=27
=0e
=64
=e4
=24
=0a
=a6
=c9
=00
=a9
=8a
=40
=a7
=c9
=00
=a9
=35
=02
=81
=15
=16
=fe
=61
=ea
=a8
=22
=16
=ff
=01
=cb
=10
=ea
=a8
=22
=34
=02
=17
=fe
=f7
=35
=02
=39
q
del /d0/ccdisk
save /d0/temp ccdisk
verify u</d0/temp >/d0/ccdisk
del temp
tmode .1 pause
-t
