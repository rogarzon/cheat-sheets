# RSYNC, Backup & Restore

## Install Rsync

```bash
  sudo apt install rsync
```

## Transfer options

```bash
    -z, --compress
    -n, --dry-run
        --partial   # allows resuming of aborted syncs
        --bwlimit=RATE    # limit socket I/O bandwidth
```

## Display options

```bash
    -q, --quiet
    -v, --verbose
        --stats
    -h, --human-readable
        --progress
    -P                     # same as --partial --progress
```

## Archive options

```bash
    -a, --archive    # archive (-rlptgoD)
    
    -r, --recursive
    -l, --links      # copy symlinks as links
    -p, --perms      # preserve permissions
    -t, --times      # preserve times
    -g, --group      # preserve group
    -o, --owner      # preserve owner
    -D               # same as --devices --specials
    
    --delete         # Delete extra files
```

## Backup options

```bash
    -b, --backup           # backup with suffix
        --suffix=SUFFIX    # default ~ without --backup-dir
        --backup-dir=DIR
```

## Include options

```bash
    --exclude=PATTERN
    --include=PATTERN
    
    --exclude-from=FILE
    --include-from=FILE
    --files-from=FILE    # read list of filenames from FILE
    
    -C, --cvs-exclude    # exclude from local/global .cvsignore
```

## Rsync - Backup a local Directory to our Backup-Server

```bash
  rsync -av /path/to/mydirectory user@backup_server:/path/to/backup/directory
```

We can also add additional options to customize the backup process, such as using compression and incremental backups. We can do this like the following:

```bash
  rsync -avz --backup --backup-dir=/path/to/backup/folder --delete /path/to/mydirectory user@backup_server:/path/to/backup/directory
```

With this, we back up the `mydirectory` to the remote `backup_server`, preserving the original file attributes, timestamps, and permissions, and enabled compression `(-z)` for faster transfers. The
`--backup` option creates incremental backups in the directory `/path/to/backup/folder`, and the `--delete` option removes files from the remote host that is no longer present in the source directory.

### Rsync - Restore our Backup

```bash
  rsync -av user@remote_host:/path/to/backup/directory /path/to/mydirectory
```

## Encrypted Rsync

To ensure the security of our `rsync` file transfer between our local host and our backup server, we can combine the use of SSH and other security measures

```bash
    rsync -avz -e ssh /path/to/mydirectory user@backup_server:/path/to/backup/directory
```

## Auto-Synchronization

To enable auto-synchronization using `rsync`, you can use a combination of `cron` and `rsync` to automate the synchronization process
Therefore we create a new script called `RSYNC_Backup.sh`, which will trigger the `rsync` command to sync our local directory with the remote one. However, because we are using a script to perform SSH
for the rsync connection, we need to configure key-based authentication. This is to bypass the need to input our password when connecting with SSH.

```bash
  # First, we generate a key pair for our user.
  ssh-keygen -t rsa -b 4096
  # Copy our public key to the remote server. 
  ssh-copy-id user@backup_server
```

RSYNC_Backup.sh

```bash
  #!/bin/bash
  rsync -avz -e ssh /path/to/mydirectory user@backup_server:/path/to/backup/directory
```
Ensure that the script is able to execute properly and  make sure that the script is owned by the correct user.

```bash
  chmod +x RSYNC_Backup.sh
  chown user:user RSYNC_Backup.sh
```

Now we can set up a cron job to run the script at a specific time. To do this, we can use the `crontab` command to edit our cron jobs.

```bash
  crontab -e
```

Then add the following line to schedule the script to run every day at 2 AM.

```bash
  0 2 * * * /path/to/RSYNC_Backup.sh
```