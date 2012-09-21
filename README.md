pentaho-biserver-installer
==========================

Pentaho biserver installer, make installation easy.


# Features
*   Support Red Hat/Fedora/CentOS both 32bit and 64bit
*   A key installation
*   Include jre 1.7.0_07
*   Include biserver 4.5.0-stable
*   Biserver run at port 80


# TODO/In progress (Don't be shy to suggest or work on them)
*   Mysql configuration
*   Oracle configuration
*   httpd/nginx integration
*   ...


# Usage
## Red Hat/Fedora/CentOS
Modify command as flow, replace ${biserver.version} to you wanted, we just support 4.5.0-stable now. So replace {biserver.version} to 4.5.0-stable. 

    wget --no-check-certificate 'https://raw.github.com/belerweb/pentaho-biserver-installer/biserver-${biserver.version}/shell/pentaho-biserver-installer-redhat.sh'

    chmod +x pentaho-biserver-installer-redhat.sh

    sudo ./pentaho-biserver-installer-redhat.sh
