#!/bin/bash

function checkAndInstallApache2Server() {
    dpkg -s apache2 >> /dev/null
    local APACHE2_SERVER_FOUND=$?
    if [ $APACHE2_SERVER_FOUND -ne 0 ]
    then
       sudo apt update -y
       sudo apt install -y apache2
       local APACHE2_INSTALL_STATUS=$?
       if [ $APACHE2_INSTALL_STATUS -ne 0 ] 
       then
        return 200
       fi
    else
       local APACHE2_SERVER_STATUS=$(sudo systemctl status apache2 | grep "Active:" | awk '{print $2}')
       if [ $APACHE2_SERVER_STATUS == "inactive" ]
       then
            return 300
       fi
    fi
    return 0
}

function setupSiteDirectory() {
    if [ ! -e $ZIP_LOC ]
    then
        return 400
    fi
    if [ -e /var/www/$SITE_DIR ]
    then
        TODAY=`date +%m%d%y%H%M`        
        sudo mv /var/www/$SITE_DIR /var/www/$SITE_DIR-$TODAY
    fi
    sudo cp $ZIP_LOC /var/www
    sudo tar -xzvf /var/www/$SITE_DIR.tar.gz -C /var/www 
    sudo chmod -R 755 /var/www/$SITE_DIR
    sudo rm /var/www/$SITE_DIR.tar.gz
    return 0
}

function configureApache2Site() {
    if [ ! -e /etc/apache2/sites-available/$SITE_DIR.conf ]        
    then
        sudo cp apache2site.conf.tmpl /etc/apache2/sites-available/$SITE_DIR.conf
        sudo sed -i "s/:DOMAIN_NM:/$DOMAIN_NM/g" /etc/apache2/sites-available/$SITE_DIR.conf
        sudo sed -i "s/:SITE_DIR:/$SITE_DIR/g" /etc/apache2/sites-available/$SITE_DIR.conf
        sudo a2ensite $SITE_DIR
        sudo systemctl reload apache2
        local APACHE2_RELOAD_STATUS=$?
        return $APACHE2_RELOAD_STATUS
    fi    
    return 0
}

function configureDNSEntry() {
    grep $DOMAIN_NM /etc/hosts
    local DNS_ENTRY_STATUS=$?
    if [ $DNS_ENTRY_STATUS -ne 0 ]
    then
        sudo cp /etc/hosts /etc/hosts.bak
        sudo chmod 755 /etc/hosts
        sudo -- sh -c "echo 127.0.0.1  ${DOMAIN_NM} >> /etc/hosts"
    fi
    return 0
}

function ufwCheckEnableHttp() {
    local UFW_STATUS=$(sudo ufw status | grep "Status:" | awk '{print $2}')
    if [ $UFW_STATUS == "active" ]
    then
        sudo ufw status | grep "80/tcp" | awk '{print $2}' | grep -v "(v6)"
        local HTTP_STATUS_EXIT_CODE=$?
        
        if [ $HTTP_STATUS_EXIT_CODE -ne 0 ]
        then
            sudo ufw allow 80/tcp
            return 0 
        else
         local HTTP_STATUS=$(sudo ufw status | grep "80/tcp" | awk '{print $2}' | grep -v "(v6)")   
            if [ $HTTP_STATUS == "DENY" ]
            then
                return 600        
            fi
        fi
    fi
}

#main block
NARGS=$#
if [ $NARGS -ne 3 ]
then
    echo "error: site directory, zip location and domain name are required"    
    exit 100
fi
SITE_DIR=$1
ZIP_LOC=$2
DOMAIN_NM=$3

checkAndInstallApache2Server
APACHE2_SERVER_INSTALL_STATUS=$?
if [ $APACHE2_SERVER_INSTALL_STATUS -eq 200 ]
then
    echo "error: failed during installation of apache2 server, please check the logs"
    exit 200
elif [ $APACHE2_SERVER_INSTALL_STATUS -eq 300 ]
then
    echo "error: apache2 server is not active, start and relaunch the script to host the site"
    exit 300
fi

setupSiteDirectory
SITE_DIR_STATUS=$?
if [ $SITE_DIR_STATUS -eq 400 ]
then
    echo "error: $ZIP_LOC not found"
    exit 400
fi

configureApache2Site
APACHE2_SITE_CONFIGURE_STATUS=$?
if [ $APACHE2_SITE_CONFIGURE_STATUS -ne 0 ]
then
    echo "error: failed configuring apache2 site"
    exit $APACHE2_SITE_CONFIGURE_STATUS
fi

configureDNSEntry 
ufwCheckEnableHttp
UFW_STATUS=$?
if [ $UFW_STATUS -eq 600 ]
then
    echo "error! HTTP port has been denied, please open it for allowing traffic"
    exit 600
fi


















