# File Management

## Disk & Drives

The main tool for disk management on Linux is the `fdisk`, which allows us to **create**, **delete**, and **manage partitions on a drive**

```bash
    sudo fdisk -l
```

- `lsblk` - List block devices

## Mounting

The `mount` command is commonly used to manually mount file systems on Linux. However, if you want certain file systems or partitions to be automatically mounted when the system boots, you can define
them in the `/etc/fstab` file.

```bash
    cat /etc/fstab
```

**File /etc/fstab**

* `<file system>` - The file system to be mounted. This can be a device name (like `/dev/sda1`), a UUID (like `UUID=1234-5678`), or a label (like `LABEL=mydisk`).
* `<mount point>` - The directory where the file system will be mounted. This directory must exist before you can mount the file system.
* `<type>` - The type of file system (like `ext4`, `ntfs`, `vfat`, etc.).
* `<options>` - Mount options (like `defaults`, `ro`, `rw`, etc.). These options control how the file system is mounted.
* `<dump>` - Used by the `dump` command to determine if a file system should be backed up. Usually set to `0` or `1`.
* `<pass>` - Used by the `fsck` command to determine the order in which file systems should be checked at boot time. The root file system should be `1`, and other file systems should be `2`. If you
  don't want a file system to be checked, set this to `0`.

```bash
    UUID=1234-5678 /mnt/mydisk ext4 defaults 0 2
```

### List Mounted Drives
```bash
    mount
    # sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
```

```bash
    df -h
    # /dev/nvme1n1p4   303G    89G  215G  30% /media/omen/DATOS
```
### Mount a USB drive
```bash
    sudo mount /dev/sdb1 /mnt/usb
```
### Unmount a USB drive
```bash
    sudo umount /mnt/usb
```
