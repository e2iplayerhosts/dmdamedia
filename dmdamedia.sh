#!/bin/sh
echo "dmdamedia.sh: start"
cp $1/iptvupdate/custom/dmdamedia.sh $2/iptvupdate/custom/dmdamedia.sh
status=$?
if [ $status -ne 0 ]; then
	echo "dmdamedia.sh: Critical error. The $0 file can not be copied, error[$status]."
	exit 1
fi
cp $1/hosts/hostdmdamedia.py $2/hosts/
hosterr=$?
cp $1/icons/logos/dmdamedialogo.png $2/icons/logos/
logoerr=$?
cp $1/icons/PlayerSelector/dmdamedia*.png $2/icons/PlayerSelector/
iconerr=$?
if [ $hosterr -ne 0 ] || [ $logoerr -ne 0 ] || [ $iconerr -ne 0 ]; then
	echo "dmdamedia.sh: copy error from source hosterr[$hosterr], logoerr[$logoerr, iconerr[$iconerr]"
fi
wget --no-check-certificate https://github.com/e2iplayerhosts/dmdamedia/archive/master.zip -q -O /tmp/dmdamedia.zip
if [ -s /tmp/dmdamedia.zip ] ; then
	unzip -q -o /tmp/dmdamedia.zip -d /tmp
	cp -r -f /tmp/dmdamedia-master/IPTVPlayer/hosts/hostdmdamedia.py $2/hosts/
	hosterr=$?
	cp -r -f /tmp/dmdamedia-master/IPTVPlayer/icons/* $2/icons/
	iconerr=$?
	if [ $hosterr -ne 0 ] || [ $iconerr -ne 0 ]; then
		echo "dmdamedia.sh: copy error from dmdamedia-master hosterr[$hosterr], iconerr[$iconerr]"
	fi
else
	echo "dmdamedia.sh: dmdamedia.zip could not be downloaded."
fi
rm -r -f /tmp/dmdamedia*
echo "dmdamedia.sh: exit 0"
exit 0