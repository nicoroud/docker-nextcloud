#!/bin/bash

# 16-08-2019
# Nicolas Roudninski
#

opt=$1

lastversions=( $( curl -fsSL 'https://download.nextcloud.com/server/releases/' |tac|tac| \
	grep -oE 'nextcloud-[[:digit:]]+(\.[[:digit:]]+){2}' | \
	grep -oE '[[:digit:]]+(\.[[:digit:]]+){2}' | \
	sort -urV ) )

InstalledVersion()
{
	cat /usr/src/nextcloud/version.php | grep OC_VersionString | cut -d\' -f 2
}

while [ "$1" != "" ]; do
	case $opt in 
		-i)	shift
			InstalledVersion
			;;
		-l)	shift
			echo $lastversions
			;;
		*)
			exit
			;;
	esac
	shift
done
