#!/bin/bash

#Save the Path from which the script is executed
declare pfad=`pwd`

#First of all, setup the htdig configuration has
#to be set up to fit for GHS

echo "ht://dig - Configuration is being set up for GHS"
echo "-----------------------------------------------------------------"
if [ -d /etc/htdig/ ]
then
	echo "   --> /etc/htdig/ already exists - examining"
	cd /etc/htdig/

	if [ -e htdig.conf ]
	then
    	    echo "   --> There is an old ht://dig config - backup"
	    if [ -e htdig.tar.gz ]
	    then
		rm htdig.tar.gz
	    fi
	    tar -czf htdig.tar.gz htdig.conf
	    rm htdig.conf
	fi
	cd $pfad
fi

cp ./htdigopts.tar.gz /etc/htdig/	#Copy the file to its destination...
cd /etc/htdig/			  			#...cd to that directory...
tar -xzf htdigopts.tar.gz	  		#...untar it...
rm htdigopts.tar.gz		  			#...remove the tar-file...
cd $pfad			  				#...cd to the original dir...
echo ">>> done <<<"			  			#...and that's it

echo
echo "-----------------------------------------------------------------"
echo

#Copy the Optical Stuff for ht://dig to the appropriate
#Webserver directory

echo "ht://dig - Optical Stuff is being installed"
echo "-----------------------------------------------------------------"
if [ -d /home/httpd/htdocs/htdig ]
then
	echo "   --> /home/httpd/htdocs/htdig already exists - examining"
	cd /home/httpd/htdocs/htdig/

	if [ -e htdig.png ]
	then
		echo "   --> Removing the old optical stuff..."
    	rm *
	fi

	cd $pfad
fi

cp ./htdo.tar.gz /home/httpd/htdocs/htdig/
cd /home/httpd/htdocs/htdig/
tar -xzf htdo.tar.gz
rm htdo.tar.gz
cd $pfad
echo ">>> done <<<"

echo
echo "-----------------------------------------------------------------"
echo




#Copy the html-output templates for htdig into the
#appropriate directory

echo "ht://dig - html-templates are being installed"
echo "-----------------------------------------------------------------"
if [ -d /usr/share/htdig ]
then
	echo "   --> /usr/share/htdig already exists - examining"
	cd /usr/share/htdig/

	if [ -e header.html ]
	then
		echo "   --> Removing old html-templates stuff..."
    	rm *
	fi

	cd $pfad
fi

cp ./htddocs.tar.gz /usr/share/htdig/
cd /usr/share/htdig/
tar -xzf htddocs.tar.gz
rm htddocs.tar.gz
cd $pfad
echo ">>> done <<<"

echo
echo "-----------------------------------------------------------------"
echo


#The last part is to install http://localhost/gentoo.
#This is the Main-Page of GHS, where the user should
#start

echo "GHS - Gentoo-Help-System is being installed"
echo "-----------------------------------------------------------------"
if [ -d /home/httpd/htdocs/gentoo ]
then
    echo "   --> GHS already seems to exist - removing its contents"
	cd /home/httpd/htdocs/gentoo/
	
	if [ -e main-new.css ]
	then
		echo "   --> Removing old Help-System"
		rm *
	fi
	
	cd $pfad
else
    mkdir /home/httpd/htdocs/gentoo
fi

cp ./ghs.tar.gz /home/httpd/htdocs/gentoo/
cd /home/httpd/htdocs/gentoo/
tar -xzf ghs.tar.gz
rm ghs.tar.gz
cd $pfad
echo ">>> done <<<"

echo
echo "-----------------------------------------------------------------"
echo


echo "GHS is now being initialized"
echo "-----------------------------------------------------------------"
echo "Creating symlink /home/httpd/htdocs/doc (will point to /usr/share/doc)..."

cd /home/httpd/htdocs/

if [ -L doc ]
then
    echo "   --> Symlink already exists"
else
    ln -s /usr/share/doc/ doc
fi

echo
echo "The ht://dig search-engine is now being initialized."
echo "This may take a loooong time"

rundig

echo 

echo ">>> done <<<"
echo
echo "-----------------------------------------------------------------"
echo
echo "OK - That's it. You can reach GHS by starting"
echo "a Webbrowser and enter the URL"
echo
echo "  http://localhost/gentoo"
echo
echo "But before make sure, that Apache is up and running ;-)"



