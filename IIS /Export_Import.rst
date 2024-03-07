One of the most boring things to do while configuring multiple web server nodes (cluster, server farm or other load balanced environments) is having to setup the entire website configuration tree in each IIS instance. Not to mention Application Pools, which are often a pain to configure properly.

Luckily enough, starting from IIS7+, there's a nice command-line utility called appcmd who can effectively export the entire IIS websites & app pools configuration in xml format and also import these same xml into another IIS instance. Let's see how we can do this.

Export configuration
====================

* To export the Application Pools:
    %windir%\system32\inetsrv\appcmd list apppool /config /xml > C:\Temp\AppPools.xml

* To export the website configuration:
    %windir%\system32\inetsrv\appcmd list site /config /xml > C:\Temp\Websites.xml

The resultant files aca

Import configuration
====================

* To import the Application Pools:
    %windir%\system32\inetsrv\appcmd add apppool /in < C:\Temp\AppPools.xml

* To import the website configuration:
    %windir%\system32\inetsrv\appcmd add site /in < C:\Temp\Websites.xml
