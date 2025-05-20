# NFS

Network File System (NFS) is a network protocol that allows us to store and manage files on remote systems as if they were stored on the local system.

## Install NFS

```bash
    sudo apt install nfs-kernel-server
```

## Server status

Check the status of the NFS server:

```bash
    sudo systemctl status nfs-server
```

We can configure NFS via the configuration file `/etc/exports`. This file specifies which directories should be shared and the access rights for users and systems. It is also possible to configure
settings such as the transfer speed and the use of encryption. NFS access rights determine which users and systems can access the shared directories and what actions they can perform. Here are some
important access rights that can be configured in NFS:

| Permission     | Description                                                                                                |
|----------------|------------------------------------------------------------------------------------------------------------|
| rw             | Gives users and systems read and write permissions to the shared directory.                                |
| ro             | Gives users and systems read-only access to the shared directory.                                          |
| no_root_squash | Prevents the root user on the client from being restricted to the rights of a normal user.                 |
| root_squash    | Restricts the rights of the root user on the client to the rights of a normal user.                        |
| sync           | Synchronizes the transfer of data to ensure that changes are only transferred after they have been saved.  |
| async          | Transfers data asynchronously, which is faster but may cause inconsistencies if changes are not committed. |

For example, we can create a new folder and share it temporarily in NFS. We would do this as follows:

## Create NFS Share

```bash
    mkdir nfs_sharing
    echo '/home/cry0l1t3/nfs_sharing hostname(rw,sync,no_root_squash)' >> /etc/exports
    cat /etc/exports | grep -v "#"
    
    # /home/cry0l1t3/nfs_sharing hostname(rw,sync,no_root_squash)
```

If we have created an NFS share and want to work with it on the target system, we have to mount it first. We can do this with the following command:

## Mount NFS Share

```bash
     mkdir ~/target_nfs
     mount 10.129.12.17:/home/john/dev_scripts ~/target_nfs
 
```

So we have mounted the NFS share (dev_scripts) from our target (10.129.12.17) locally to our system in the mount point target_nfs over the network and can view the contents just as if we were on the
target system.
