# Task Scheduling

## Systemd Timers

Systemd timers are a powerful way to schedule tasks in Linux. They can be used as an alternative to cron jobs and provide more flexibility and features.

### How to create a systemd timer

El servicio se asocia con el temporizador mediante el nombre del archivo. Por ejemplo, si tienes un archivo de temporizador llamado `mytask.timer`, systemd buscará automáticamente un archivo de
servicio llamado `mytask.service` en el mismo directorio (`/etc/systemd/system/`). El temporizador activa el servicio con el mismo prefijo de nombre. No es necesario especificar explícitamente el
servicio dentro del archivo `.timer`; la asociación se realiza por convención de nombres.

1. Create a service file in `/etc/systemd/system/` with the `.service` extension. This file defines the task you want to run.

   ```bash
   [Unit]
   Description=My Scheduled Task

   [Service]
   Type=oneshot
   ExecStart=/path/to/your/script.sh
   
   [Install]
   WantedBy=multi-user.target
   ```
   * Type `oneshot` indicates that the service will run a single task and then exit.
   * WantedBy specifies the target that the service should be started under. In this case, `multi-user.target` is used, which is a common target for system services.
   
2. Create a timer file in `/etc/systemd/system/` with the `.timer` extension. This file defines when the task should run.

   ```bash
    [Unit]
    Description=Run My Scheduled Task every day at 2 AM
    [Timer]
    OnCalendar=*-*-* 02:00:00
    Persistent=true
    [Install]
    WantedBy=timers.target
    ```
   OnCalendar uses the following format:

   ```
    OnCalendar=YYYY-MM-DD HH:MM:SS
   ```

3. Enable and start the timer.
4. Enable the timer to start at boot:

   ```bash
   sudo systemctl enable mytask.timer
   ```
5. Start the timer:

   ```bash
    sudo systemctl start mytask.timer
    ```

## Automation in Linux – Automate Tasks with Cron Jobs

How to control access to crons

In order to use cron jobs, an admin needs to allow cron jobs to be added for users in the `/etc/cron.allow` file

If you get a prompt like this, it means you don't have permission to use cron.

`$ crontab -e`

#You (john) are not allowed to use this program (crontab)

To allow John to use crons, include his name in `/etc/cron.allow`. Create the file if it doesn't exist.

`sudo cat cron.allow john`

Users can also be denied access to cron job access by entering their usernames in the file `/etc/cron.d/cron.deny`.

### How to add cron jobs in Linux

First, to use cron jobs, you'll need to check the status of the cron service. If cron is not installed

#Check cron service on Linux system

`sudo systemctl status cron.service`

### Cron job syntax

* `crontab -e`: edits crontab entries to add, delete, or edit cron jobs.
* `crontab -l`: list all the cron jobs for the current user.
* `crontab -u username -l`: list another user's crons.
* `crontab -u username -e`: edit another user's crons.

When you list crons and they exist, you'll see something like this:

#Cron job example\
`* * * * * sh /path/to/script.sh`

In the above example,

* represents **minute(s)** **hour(s)** **day(s)** **month(s)** **weekday(s)**, respectively. See details of these values below:

|          | VALUE | DESCRIPTION                                                  |
|----------|-------|--------------------------------------------------------------|
| Minutes  | 0-59  | Command will be executed at the specific minute.             |
| Hours    | 0-23  | Command will be executed at the specific hour.               |
| Days     | 1-31  | Commands will be executed in these days of the months.       |
| Months   | 1-12  | The month in which tasks need to be executed.                |
| Weekdays | 0-6   | Days of the week where commands will run. Here, 0 is Sunday. |

* `sh` represents that the script is a bash script and should be run from /bin/bash.
* `/path/to/script.sh` specifies the path to the script.

### Cron job examples

Below are some examples of scheduling cron jobs.

| SCHEDULE     | SCHEDULED VALUE                                           |
|--------------|-----------------------------------------------------------|
| 5 0 * 8 *    | At 00:05 in August.                                       |
| 5 4 * * 6    | At 04:05 on Saturday.                                     |
| 0 22 * * 1-5 | At 22:00 on every day-of-week from Monday through Friday. |

You can practice and generate cron schedules with the [crontab guru](https://crontab.guru/) website.

### How to set up a cron job

1. Create a script called **date-script.sh** which prints the system date and time and appends it to a file. The script is shown below:

   #!/bin/bash

   ``echo `date` >> date-out.txt``
2. Make the script executable by giving it execution rights.

   `chmod 775 date-script.sh`

3. Add the script in the crontab using `crontab -e`.

   `*/1 * * * * /bin/sh /root/date-script.sh`

4. Check the output of the file **date-out.txt**. According to the script, the system date should be printed to this file every minute.

   `cat date-out.txt`

   #output\
   Wed 26 Jun 16:59:33 PKT 2024\
   Wed 26 Jun 17:00:01 PKT 2024\
   .............................

### How to troubleshoot crons

1. Check the schedule.

   First, you can try verifying the schedule that's set for the cron. You can do that with the syntax you saw in the above sections.

2. Check cron logs.

   First, you need to check if the cron has run at the intended time or not. In Ubuntu, you can verify this from the cron logs located at
   `/var/log/syslog`.

   1 Jun 26 17:02:01 zaira-ThinkPad CRON[27834]: (zaira) CMD (/bin/sh /home/zaira/date-script.sh)\
   2 Jun 26 17:02:02 zaira-ThinkPad systemd[2094]: Started Tracker metadata extractor.\
   3 Jun 26 17:03:01 zaira-ThinkPad CRON[28255]: (zaira) CMD (/bin/sh /home/zaira/date-script.sh)\

3. Redirect cron output to a file.

   #Redirect cron output to a file

   `* * * * * sh /path/to/script.sh &> log_file.log`