git log
git status
git add .
git commit -m "added comment to the script"
git config --global user.email "satishlcs527@gmail.com"
git config --global user.name "SatishInfy68"
git push origin main

**read -p "Enter your name: " name** (Prompt)
Purpose: Displays a prompt message before waiting for user input.
Usage: Used when you want to prompt the user for input directly within the script.

**read -s "Enter your password: " password** (Silent)
Purpose: Suppresses the input from being echoed on the screen.
Usage: Used for sensitive information like passwords.


Linux Interview Q&A:
1.
In the context of the Linux top or ps commands, JCPU and PCPU refer to different types of CPU usage metrics for processes:
JCPU (Job CPU Time)
•	Definition: The total CPU time consumed by all processes attached to a session.
•	Includes:
•	The CPU time used by the current shell session.
•	The CPU time of processes spawned by the shell (like background jobs or commands).
•	Use Case: Indicates how much CPU time has been spent on the entire "job" associated with a shell or terminal.
________________________________________
PCPU (Process CPU Time)
•	Definition: The percentage of CPU currently being used by an individual process.
•	Measured: As a percentage of total CPU time.
•	Use Case: Indicates the real-time CPU usage of a single process, helping to identify which process is consuming the most CPU resources.

2. find . -type f -mtime -30 > log_list.txt
tar -cvzf logs_last_30_days.tar.gz -T log_list.txt
scp logs_last_30_days.zip user@destination_server:/path/

3. CPU Load high

1.	
•	In top:
•	%CPU shows the PCPU of each process.
•	In w or who command:
•	JCPU appears as the time spent on the session, giving a cumulative measure of activity.
Let me know if you'd like further details or examples!
2.	You said:
how to check if linux server is overloaded and trouble shoot realtime
3.	ChatGPT said:
To check if a Linux server is overloaded and troubleshoot in real-time, follow these steps:
________________________________________
1. Check System Load
Use uptime or top:
bash
Copy code
uptime 
•	Look at the load average (e.g., 0.75, 0.60, 0.90 for the past 1, 5, and 15 minutes).
•	A rule of thumb:
•	Load average <= Number of CPU cores → Healthy.
•	Load average > Number of CPU cores → Potential overload.
Use top or htop:
bash
Copy code
top 
•	Key metrics:
•	%CPU: Check if processes are maxing out the CPU.
•	%MEM: Spot memory-hungry processes.
•	Swap usage: Indicates potential memory issues.
•	Zombie processes (Z state): Can signal issues with process management.
________________________________________
2. Analyze CPU Usage
Real-time monitoring with top:
•	Look for processes with high %CPU usage.
Use mpstat (from sysstat package):
bash
Copy code
mpstat -P ALL 1 
•	Analyze per-core CPU utilization. High %iowait indicates disk bottlenecks.
Identify top CPU consumers:
bash
Copy code
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head 
________________________________________
3. Check Memory Usage
Use free to monitor memory:
bash
Copy code
free -h 
•	Look for:
•	Low free memory combined with high swap usage → Potential memory exhaustion.
Use smem for detailed memory consumption (install if needed):
bash
Copy code
smem -t 
Use top:
•	Processes with high %MEM.
________________________________________
4. Check Disk I/O
Use iostat (from sysstat package):
bash
Copy code
iostat -x 1 
•	Look for:
•	High %util → Disk is busy.
•	High await → I/O latency issue.
Use iotop (real-time disk I/O monitoring):
bash
Copy code
iotop 
•	Identify processes causing high I/O.
________________________________________
5. Check Network Activity
Use iftop (real-time bandwidth usage):
bash
Copy code
iftop 
•	Identify connections consuming high bandwidth.
Use netstat:
bash
Copy code
netstat -antp | grep ESTABLISHED 
•	Monitor active network connections and associated processes.
Check dropped packets/errors:
bash
Copy code
ifconfig eth0 | grep "RX packets\|TX packets" 
________________________________________
6. Check System Logs
Inspect logs for errors or warnings:
bash
Copy code
tail -f /var/log/syslog 
Or for specific services (e.g., Apache):
bash
Copy code
tail -f /var/log/apache2/error.log 
________________________________________
7. Monitor Real-Time Processes
Use strace to debug specific processes:
bash
Copy code
strace -p <PID> 
Use dstat for overall performance:
bash
Copy code
dstat -c -d -n -m --top-cpu --top-mem 
________________________________________
8. Identify Potential Bottlenecks
•	High CPU: Check for rogue processes and optimize or restart them.
•	High Memory: Identify memory leaks and restart applications if necessary.
•	Disk I/O: Ensure no runaway disk operations or slow disks.
•	Network: Check for DDoS or misconfigured services.
________________________________________
9. Take Action
•	Restart problematic services:
bash
Copy code
sudo systemctl restart <service_name> 
•	Kill high-resource processes:
bash
Copy code
kill -9 <PID> 
•	Free up disk space if necessary:
bash
Copy code
du -sh /* | sort -h 


patching:
[ -d /sys/firmware/efi ] && echo "UEFI" || echo "bios"
sudo yum updateinfo
sudo yum update
sudo yum check-update | grep bash
sudo yum update
sudo yum --security update
sudo yum -x 'kernel*' -x 'bash*' update
hostnamectl | grep Kernel
yum list installed kernel
rpm -qa | grep -i kernel
sudo find /boot/ -iname "vmlinuz*"
find /boot/ -iname "vmlinuz*"
to change the defualt kernels and get the list of kernels
grubby --default-kernel, grubby --default-index
grubby --info=ALL | egrep -i 'index|title'
grubby --set-default vmlinuz-4.18.0-425.19.2.el8_7.x86_64
grubby --set-default-index=1, grubby --info=ALL
/etc/grub2.cfg  ------->link file for /boot/grub2/grub.cfg
grub2-set-default 1, cat /boot/grub2/grubenv | grep saved, saved_entry=1
grub2-mkconfig -o /boot/grub2/grub.cfg -- for bios
grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg -- for UEFI, shutdown -r now

remove old kernels
rpm -q kernel
sudo package-cleanup --oldkernels --count=2 or sudo rpm -e [old-kernel-package]
sudo grub2-mkconfig -o /boot/grub2/grub.cfg   # For GRUB2
sudo grub2-mkconfig -o /boot/grub/grub.cfg    # For older GRUB versions
reboot

rescue and single user modes:

systemd.unit=rescue.target
systemd.unit=emergency.target
rd.break enforcing=0
mount -o remount,rw /sysroot || mount -o remount,rw /
chroot /sysroot
touch /.autorelabel


* check inode and block state
1. stat file/dir name, 2. df -i
chec disk-sudo yum install smartmontools - sudo smartctl -a /dev/sdX - fsck -a /dev/sdb
1. yum update --exclude=kernel*, --exclude=gcc* --exclude=php*, yum upgrade and downgrad
2. permanent in /etc/yum.conf (exclude=kernel* redhat-release*), exclude=*.i?86 *.i686
mbr(dos) - bios and gpt(gpt) - uefi - unified extensible firmware interface

Luns scanning steps:
count=$(ls /sys/class/scsi_host) #--- detect the hosts
for host in $count
do
echo "- - -" > /sys/class/scsi_host/$host/scan # --- will scan the luns
 echo "$host scanning done"
done
--- = c t l
c – Channel on the HBA
t – SCSI target ID
l – LUN ID

- sudo yum-config-manager --enable <repository_id_or_name> --- enable yum repository

- parted /dev/sdb mklabel gpt/mbr -parted /dev/sdb print/mkpart-2048s-100MB-quit-udevadm settle-rm 1-/etc/fstab - mkfs -t xfs /dev/sdb - systemctl daemon-reload-lsblk --fs

- grub default file - /etc/default/grup , GRUB_DEFAULT=1, GRUB_DEFAULT="saved", update-grub, dpkg -l | grep linux-image, rpm -qa | grep kernel

-creating 4TB partition - gdisk /dev/sdb -w-y then it will convert to gpt then create patition

-dracut -f initramfs-$(uname -r).img $(uname -r) --will create new initramfs in resucue mode

-grub2-mkconfig -o /boot/grub2/grub.conf -- creates new grub file if grub file missed

- chroot /mnt/sysimage then grub2-install /dev/sda -- if mbr currupted

- mount -o rw,remount / --mv /etc/fstabbk /etc/fstab - copy back file if fstab missed.

/etc/login.defs - umask - usrmail dir, password policies
/etc/default/useradd - user defalt home dir, shell, guid
xfs file system does not support lvm reduction
umount /home/, e2fsck -f /dev/mapper/vg_cloud-LogVol00
resize2fs /dev/mapper/vg_cloud-LogVol00 10G
lvreduce -L 10G /dev/mapper/vg_cloud-LogVol00 OR lvextend -L +2G /dev/mapper/vg_cloud-LogVol00
resize2fs /dev/mapper/vg_cloud-LogVol00 or xfs_growfs /dev/vg_test/lv_test
lvdisplay -m --display which pvs using lvm

"$*" - dispaly as single value - horizontal - "2 3" = 2 3 - two values
"$@" - display perfect output - vertical and use always - "2 3" = 23 single value

vi /etc/lvm/lvm.conf --user_devicefile = 0 from rhel 8 onwards for lvm use

1. badblocks -v /dev/sda1 > badsectors.txt,  lsblk -fb, locate -n 5 -i passwd
need to give wwn(fc)card - world wide num so that storage team will assign raw disk then we need to create partitions etc. mkfs -t xfs /dev/sdb
2. install net-tools for network tools
3. iostat --iowait should not reach  >60%
4. if kill parent process it will killed child as well
5. lvm partition -- t - L - 8e -- lvm( id-8e linux lvm)
6. change man, incident man and problem management and sops
7. Nagios core opens , nagios x1 , key perm indicator - kpi --disc, ram service-
will raise incidents snow integrated with nagios
8. normal change - weeken, expidited -- non business , emergency - business hrs
CAB - change advisory board 
9. change port in /etc/ssh/sshd_config -- connect ssh -p port user@ip
10. tar -cvf dest.tar source -cvzf dest.tar.gz, bz2 , x-extract, t- display
11. find and locate - updatedb for search for files
12. scp abc.file root@ip:/tmp local  <==> remote, rsync -a source dest -- copy latest
13. ps -ef | grep httpd, pstree, pmap -x pid -- minute checking
14. rsyslog - 514, vnc-5901 to 5908, rdp- 3389, ntp-123
15. s -rwx S or 4-rw only, suid -- only user level special permission can give
16. guid - set perm on dir and all server get same group name in all created files
sticky bit can created on dir 1777 other cannot delete files
SSH configuration:
17. disable root login - in ssh.conf file -- set no PermitRoot login restart sshd
take ssh file backup with time -date_format=`date +%Y_%m_%d:%H:%M:%S`
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config_$date_format
18. allow or deny specific users, changing ssh port, search /port to 222 and check
in selinux port is allowd or not, yum install telnet- netstat -tanlp | grep -i :23
cd /etc/xinetd.d-telnet file - service restart xinetd --to check status of port listet
semanage port -a -t ssh_port_t -p tcp 33000
firewall-cmd --add-port=33000/tcp --permanent
firewall-cmd --remove-service=ssh --permanent, netstat -tunl | grep 33000
firewall-cmd --add-port=33000/tcp --permanent
19. bg- ls & , fg ctl+c --terminate, ctl+z -- stoped
20. dd - data duplicator -- copy the file bs - read sectors 1024 bites , count =100 time will read if=/dev/sda of=/temp/dd.file 
21. local var= can access locally within shell, env var= can access any where, sys var= system created vars. env - will show env vars & set - shows system vars
22. > - sent result to output, 2> - sent error output. >> or 2>>- append to exist fi --2>&1
23.  chage --list awsadmin, chage -l data , -W warn, -E "date"acc exp, -M max pass change, -m min pas change, cap-i - inactive pass
acl's by defualt enabled from rhel 7 onwards | ls -l if + sym acl's enabled. if want to give rwx perm to particular user to particular file or dif then acl's comes
Redhat -8:
Cockpit: using for webconsole login and monitoring entiresystem in gui mode.
dhcp: port 57 discover - offer - request - acknowledgement
/usr/share/doc/dhcp-4.2.5/dhcpd.conf - configuration info, /var/lib/dhcpd/dhcpd.leases - stores the rcords, /etc/dhcp/dhcpd.conf -- configuration file get copied from /usr/share file
range, defauld lease time, max lease time
Mariadb: install, start and enable serive, mysql -u root, show databases; CREATE DATABASES employees;
user employees; create tables and describe teachers;
yum search, info, update, install, provide , yum module info, provide, --profile <pack> minimal, devel, commom
yum group list hidden -- will show all, yum histroy undo, id num
rpm ql, qc, qp
rsyslog - 514
vnc-5901 to 5908
Rdp- 3389
Ntp-123
Iscsi-3260
Mysql -3306

Linux troubleshooting and monitoring commands:
1.lshw -short, lscpu, lspci, dmidecode -t and check all available info like dmidecode system etc..
2. ls & -background process, ps -ao tty,pid,nice,%mem,%cpu, 
3. lsof -D /dir, lsof -c sshd, 
- tcpdump -c 20 -i enp0s3 for read- tcpdump -r 0001.pcap, tcpdump -i enp0s3 port 22
  tcpdump -i enp0s3 tcp, tcpdump -i enp0s3 -s 0 host 192.168.0.20 - check traffice to dest
- ps -eo pmem,pcpu,pid,args|tail -n +2|sort -rnk 1 | head
find: 
- find . -name ansible.cfg, find / -name ansible.cfg, find / -iname ansible.cfg - ignore case
- find / -type d -iname Videos, find / -type f -iname ansible.cfg, find / -type f -name "*.txt"
- find / -type f -perm 0755 -print, find / -type f -perm 0755 -print -exec ls -ltr {} \;
- find / -type f -empty --emply file, find / -type f -name ".*" - hidden files
- find / -mtime -180 , atime, -mmin -60, cmin -60
- find / -size +1M, 

Linux and Shell Scripting RealTime:
setfacl -Rd -m u:ansadmin:rwx /directory -- recursively apply all newly created file contents 
* << com    com   ----multi line comments
frintf - %d -interger %f - float %s - string, use \n for tab -- %d $x(variable)

echo "- - -" > /sys/class/scsi_host/host[n]/scan
ls /sys/class/scsi_host
host0 host1 host2
for host in `ls /sys/class/scsi_host`; do echo "Scanning $host...Completed"; echo "- - -" > /sys/class/scsi_host/$host/scan; done
ls /dev/disk/by-id | grep -i "LUN ID"

-1. head -12 xyz.txt | tail -7 or awk 'NR>=6 && NR<=12 {print}' xyz.txt
    or sed -n '6,12p' xyz.txt -- to print above and below line numbers...
- realpath case2.sh -- will show complete location of file,basename-suffix .sh
- dirname /root/case.sh - remove last / path and show location only /root
- need to take {} if two digit number ex: ${10}, test -- test before excution
- ls;pwd;ps -ef, 2>&1 1>/dev/null -- nullify standard output.
- arithmetic operators - 1. (($x+$y)) 2. bc<<<"scale=2;$x/$y" -- will show 2 decimal values
3). IP configuration in  ubuntu 20
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    enp0s3:
      dhcp4: no
      addresses:
        - 192.168.1.10/24
      gateway4: 192.168.1.1
      nameservers:
          addresses: [8.8.8.8, 1.1.1.1]

AWK: find and replace text
begin, end, f1 -awk script exec-write all login in one file cd 
awk '/manager/ {print}' employee.txt --searchsc
awk '{print $1,$4}' employee.txt
awk '{print NR,$0}' employee.txt -- line num
awk '{print $1,$NF}' employee.txt--last field
awk 'NR==3, NR==6 {print NR,$0}' employee.txt --line 3 to 6
awk 'END { print NR }' geeksforgeeks.txt --count line num
awk -F: '{print $3}' /etc/passwd --remove : 
awk '{print NF}'--num of fields
NR-number of records
NF- number of fields

CUT:
cut -b 1,2,3 state.txt
cut -b 1-3,5-7 state.txt
cut -b 1- state.txt
cut -b -3 state.txt
cut -c 2,5,7 state.txt
cut -c 1-7 state.txt
cut -d " " -f 1 state.txt
cut -d " " -f 1-4 state.txt
cat state.txt | cut -d ' ' -f 1 | sort -r

TR: translate 
cat greekfile | tr “[a-z]” “[A-Z]”
cat geekfile | tr “[:lower:]” “[:upper:]”
echo "Welcome To GeeksforGeeks" | tr [:space:] '\t'
tr '{}' '()'   newfile.txt
echo "Welcome To GeeksforGeeks" | tr -d 'w'
echo "my ID is 73535" | tr -d [:digit:]
echo "my ID is 73535" | tr -cd [:digit:]
echo "Welcome    To    GeeksforGeeks" | tr -s [:space:] ' ' -single space

tee: save output to antother fine and display
comand | tee xyz.txt
comand | tee -a xyz.txt -- append next line

Sort and Uniq:
sort file | uniq –c
sort file | uniq –d --repeted lines
sort –r file
sort –k2 file --sort 2nd field

grep:
grep –c keyword file --keyword and count
grep –v keyword file
grep –n keyword file

diff(Line by line)
cmp(Byte by byte)

truncate –s 10 filename

tee -a --shows output and copy the data

Sed:delete, replace, search lines and words
sed 's/unix/linux/' geekfile.txt--replacing single
sed 's/unix/linux/2' geekfile.txt--replacing 2 one
sed 's/unix/linux/g' geekfile.txt--replacing all
sed 's/unix/linux/3g' geekfile.txt--replacing 3 to all
sed '3 s/unix/linux/' geekfile.txt--replacing 3 rd line
sed 's/unix/linux/p' geekfile.txt--duplicating replaced line
sed -n 's/unix/linux/p' geekfile.txt--pinting only replces lines
sed '1,3 s/unix/linux/' geekfile.txt--replace things in 1 and 3
sed '5d' filename.txt--deletes 5 line
sed '$d' filename.txt--deletes last line
sed '12,$d' filename.txt--to delte 12 to lase line
sed G a.txt--insert one blank line
sed 'G;G' a.txt--insert two blank lines
sed '/love/G' a.txt--space love love line
sed '/life/d' a.txt--deletes life line 

lsof -i :80--LiSt Open Files
fuser 80/tcp--
netstat -ltnp--network statistics
tcpdump -i--
kill -9 `lsof -t -u tecmint`--kill all activities of particula user
ps -p 111 -o comm= --shows name of process with pid
curl ipinfo.io/ip
grep -i erro /var/log/messages | grep "Aug 27" | wc -l
rpm -ivh --test, rpm -qip or qi, rpm -qf command pack
rpm -qlc vsftpd or qld --configuratin files and directories
rpm -Uvh packname

Become root 
yum install ImageMagick –y 
display image-file 

vi /etc/login.defs --defualt settings for user.
chage -m 5 -M 180 -W 10 -I 3 -E 
 systemctl list-units --type=service --all
chroot /mnt/sysimage--->grub2-install /dev/sda
grub2-mkconfig -o /boot/grub2/grub.cfg 

java installation and tomcat

yum search openjdk
yum install java-11-openjdk
java --version

sync; echo 3 > /proc/sys/vm/drop_caches 

#!/bin/bash
yum update -y
amazon-linux-extras install nginx1.12
service nginx start
echo '<h1>WEBSERVER-1</h1>' >> /usr/share/nginx/html/index.html

    1  clear
    2  sudo apt-get update
    3  apt install software-properties-common -y
    4  apt-add-repository --yes --update ppa:ansible/ansible
    5  apt get update
    6  apt update
    7  apt install ansible -y
    8  apt install nginx -y
    9  apt install -y git stress
   10  git clone -b aws-autoscaling https://github.com/mavrick202/ansibletemplat
   11.for ami ec2--/bin/bash--ansible-playbook /myrepo/playbook.yaml

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head
top -b -o +%MEM | head -n 22 > topreport.txt
date +"%a %d %b %y" -- Sun 17 Jul 22
who -a, who -q(list of users) and uname -a
Variables:
x="shell scripting"
echo "{y}", "{#y}"--leanghth of the sentense.
init
Imp:
-e -file exist or not
-r - have read perm or not
-w - write
-x - excution
-d - direcotry  or not
-f - file or not
-s - file has some size none zero
Loops:
for each in $(ls -ltr | awk '{print $9}')
given_path=$1 ---can give specific dir to check files inside
exit - terminate the  complete shell script after current iteration. wont execute next item 
break - terminate loop at specific condition. and will execute next items in the loop
continue- will skip the conditional iteration and will continue with next iteration
find /path/to/directories -type d -mtime +180 -exec rmdir {} \; -- 6months old directories
find /home/ansadmin -type f -mtime +180 -exec ls -l {} \;  --- for files
sudo find /home f -mtime +180 -exec ls -l {} \; | awk '{print $3}' | sort | uniq   - 6m old users
 


Linux Real-time Commands for practice:

Log rotate:
Shell Script for Log Rotation
bash
CopyEdit
#!/bin/bash

# Define the log directory
LOG_DIR="/var/log/myapp"  # Change this to your log directory

# Number of days to keep logs
RETENTION_DAYS=30
COMPRESS_AFTER_DAYS=7

# Find and delete logs older than 30 days
find "$LOG_DIR" -type f -name "*.log" -mtime +$RETENTION_DAYS -exec rm -f {} \;

# Compress logs older than 7 days but younger than 30 days
find "$LOG_DIR" -type f -name "*.log" -mtime +$COMPRESS_AFTER_DAYS -mtime -$RETENTION_DAYS -exec gzip {} \;

# Optional: Restart logging service (if required)
# systemctl restart myapp-logging.service  # Uncomment and modify if needed

echo "Log rotation completed. Logs older than $RETENTION_DAYS days are deleted."
________________________________________
How to Use the Script
1.	Save the script as logrotate.sh
2.	Make it executable:
bash
CopyEdit
chmod +x logrotate.sh
3.	Run it manually:
bash
CopyEdit
./logrotate.sh
4.	Schedule it via Cron for automation:
Open the cron job editor:
bash
CopyEdit
crontab -e
Add this line to run it daily at midnight:
bash
CopyEdit
0 0 * * * /path/to/logrotate.sh
________________________________________
Explanation
•	find "$LOG_DIR" -type f -name "*.log" -mtime +$RETENTION_DAYS -exec rm -f {} \;
→ Finds and removes log files older than 30 days.
•	find "$LOG_DIR" -type f -name "*.log" -mtime +$COMPRESS_AFTER_DAYS -mtime -$RETENTION_DAYS -exec gzip {} \;
→ Compresses logs between 7 and 30 days old.
•	Cron job ensures it runs daily.
________________________________________
Alternative: Use logrotate (Recommended)
Instead of a script, you can use the built-in logrotate tool:
1.	Create a config file
bash
CopyEdit
sudo nano /etc/logrotate.d/myapp
2.	Add the following content:
bash
CopyEdit
/var/log/myapp/*.log {
    daily
    rotate 30
    compress
    missingok
    notifempty
}
3.	Test it:
bash
CopyEdit
logrotate -d /etc/logrotate.d/myapp

1. What is Logrotate?
logrotate is a system utility in Linux used for automatic log file management. It helps:
•	Rotate logs (create new log files and archive old ones).
•	Compress logs to save space.
•	Delete old logs after a specified period.
•	Manage log files automatically via scheduled cron jobs.
How Logrotate Works in RHEL 9
•	Configuration Files:
o	Main config: /etc/logrotate.conf
o	Per-service configs: /etc/logrotate.d/
•	Rotation Triggers:
o	Size-based (size 100M → Rotates when log size exceeds 100MB).
o	Time-based (daily, weekly, monthly).
•	Default Behavior:
o	Runs daily via cron job (/etc/cron.daily/logrotate).
o	Keeps logs for a specific period (as per config).
o	Uses gzip compression to save space.
Example Logrotate Config (/etc/logrotate.d/dnf for dnf.log):
bash
CopyEdit
/var/log/dnf.log {
    weekly
    rotate 4
    compress
    missingok
    notifempty
}
•	Rotates logs weekly.
•	Keeps last 4 logs.
•	Compresses old logs.
•	Skips if empty (notifempty).
________________________________________
2. What is Rsyslog?
rsyslog is the default syslog service in RHEL 9, used for:
•	Collecting and storing system logs.
•	Sending logs to remote servers.
•	Filtering and forwarding logs based on rules.
How Rsyslog Works in RHEL 9
•	Config File: /etc/rsyslog.conf
•	Includes Additional Configs: /etc/rsyslog.d/*.conf
•	Default Log Storage Location: /var/log/
•	Key Modules:
o	imjournal: Reads logs from systemd-journald.
o	omfile: Writes logs to files.
o	omfwd: Sends logs to remote servers.
Default Behavior
•	System logs are stored in /var/log/:
o	/var/log/messages → General system logs.
o	/var/log/secure → Authentication logs.
o	/var/log/dnf.log → DNF package manager logs.
•	Log Rotation: Rsyslog works with logrotate to manage log files.
Restarting and Checking Rsyslog
bash
CopyEdit
sudo systemctl restart rsyslog
sudo systemctl status rsyslog
________________________________________
3. Script to Delete Logs Older than 30 Days and Zip Older than 7 Days (for dnf.log)
bash
CopyEdit
#!/bin/bash

LOG_FILE="/var/log/dnf.log"

# Check if log file exists
if [ -f "$LOG_FILE" ]; then
    # Find and delete old logs older than 30 days
    find /var/log/ -name "dnf.log-*" -mtime +30 -exec rm -f {} \;

    # Compress logs older than 7 days but younger than 30 days
    find /var/log/ -name "dnf.log-*" -mtime +7 -mtime -30 -exec gzip {} \;

    echo "Log cleanup completed."
else
    echo "Log file not found: $LOG_FILE"
fi
How to Use:
1.	Save the script as dnf_log_rotate.sh.
2.	Make it executable:
bash
CopyEdit
chmod +x dnf_log_rotate.sh
3.	Run it manually or add it to cron (crontab -e):
bash
CopyEdit
0 0 * * * /path/to/dnf_log_rotate.sh
Would you like help setting up a custom log rotation policy? 🚀
4o
You said:
what exactly will do /var/log/myapp/*.log { daily rotate 30 compress missingok notifempty }
ChatGPT said:
This logrotate configuration:
bash
CopyEdit
/var/log/myapp/*.log {
    daily
    rotate 30
    compress
    missingok
    notifempty
}
What it does:
1.	Applies to all logs in /var/log/myapp/ with .log extension.
2.	Runs daily (daily) → Checks and rotates logs every day.
3.	Keeps last 30 log files (rotate 30) → Older logs beyond 30 days are deleted.
4.	Compresses rotated logs (compress) → Uses gzip (e.g., myapp.log-20250221.gz).
5.	Ignores missing files (missingok) → No error if logs don’t exist.
6.	Skips rotation if log is empty (notifempty) → Won’t rotate if no data is present.
Example Log Rotation Process
Assume today is Feb 21, 2025, and you have a log file:
/var/log/myapp/app.log
Day 1 (Feb 21)
•	The log is rotated and renamed:
lua
CopyEdit
app.log → app.log-20250221
•	A new empty app.log is created.
Day 2 (Feb 22)
•	The rotated log is compressed:
lua
CopyEdit
app.log-20250221 → app.log-20250221.gz
•	app.log is rotated again:
lua
CopyEdit
app.log → app.log-20250222
After 30 Days (March 22)
•	app.log-20250121.gz (oldest log) is deleted.
•	The cycle continues, keeping only the last 30 days of logs.
________________________________________
How to Apply & Test This Config
1.	Create the config file:
bash
CopyEdit
sudo nano /etc/logrotate.d/myapp
2.	Paste the configuration and save.
3.	Test it without making changes:
bash
CopyEdit
logrotate -d /etc/logrotate.d/myapp
4.	Run manually for testing:
bash
CopyEdit
logrotate -f /etc/logrotate.d/myapp


