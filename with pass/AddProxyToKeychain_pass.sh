#!/bin/bash 

## This script adds to keychain a list of proxy urls provided by file fos the user to not to have to enter allways user and password

## File where mount points are written
archivo="/Users/javier/Desktop/testproxys"   #"/etc/.proxy"
## Checks username (is the same as the AD)
username="$(/usr/bin/stat -f%Su /dev/console)"
## Checks if mounDrives password is created in login.keychain
password="$(osascript -e 'Tell application "System Events" to display dialog "Enter yout password to add proxy to keychain; " default answer "" with title "Add proxy to keychain" with text buttons {"Ok"} default button 1 with hidden answer' -e 'text returned of result')"

# Here begins the mount of all shares, while there are lines in the document continues...
while read line; do

port=${line#*:}
address=${line%:*}
security add-internet-password -a "$username" -w "$password" -r htpx -P "$port" -s "$address" -A -l "$line ($username)" -j "default" -t "dflt" "/Users/$username/Library/keychains/login.keychain"
security add-internet-password -a "$username" -w "$password" -r htsx -P "$port" -s "$address" -A -l "$line ($username)" -j "default" -t "dflt" "/Users/$username/Library/keychains/login.keychain"

done < $archivo


################## NO FUNCIONA BIEN (Pruebas) #########################
#
#       while read line; do
#       line2=${line#*/} ##IMPORTANTE##
#       echo "intentando montar $line en /Users/$userName/Desktop/$line2"
#       mkdir /Volumes/$userName/$line2
#       echo "/Volumes/$userName/$line2 -fstype=smbfs,soft ://javier:12345.Asdfg@$line" >> /etc/auto_master
#       ln -s /Users/$userName/Desktop/$line2 /unidades/
#
#       done < "$1"
#       echo "$line"
#       automount -vc
#
#######################################################################

############# ESTO FUNCIONA ###########################################
#
#       while read line; do
#       line2=${line#*/} ##IMPORTANTE##
#       line2=${line#*/} 
#       mount -t smbfs //javier:12345.Asdfg@$line /Volumes/$line2
#       done < "$1"
#
#       ## Cambiar usuario y password por los del usuario final )variables ##
#
#######################################################################