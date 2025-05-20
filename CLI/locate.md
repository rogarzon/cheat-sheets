Locate
It will take much time to search through the whole system for our files and directories to perform many different searches. The command locate offers us a quicker way to search through the system. In
contrast to the find command, locate works with a local database that contains all information about existing files and folders. We can update this database with the following command.

```bash

sudo updatedb
```

If we now search for all files with the ".conf" extension, you will find that this search produces results much faster than using find.

```bash

rogarzon@htb[/htb]$ locate *.conf

#/etc/GeoIP.conf
#/etc/NetworkManager/NetworkManager.conf
#/etc/UPower/UPower.conf
#/etc/adduser.conf
```

However, this tool does not have as many filter options that we can use. So it is always worth considering whether we can use the locate command or instead use the find command. It always depends on
what we are looking for.


