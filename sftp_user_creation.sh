#This script creates an SFTP user with proper directories, places them in the SFTPUsers group and then adds them to the vsftpd jail

read -p 'New Username: ' uservar

echo "Adding $uservar username..."
useradd $uservar -d /home/$uservar

echo "Adding $uservar to SFTPUsers group"
#Adds Username to sftpusers group
usermod -g 1001 $uservar

mkdir /home/$uservar/Inbound
mkdir /home/$uservar/Outbound

echo "Creating $uservar\'s Inbound and Outbound folders"
chown $uservar:sftpusers /home/$uservar/Inbound
chown $uservar:sftpusers /home/$uservar/Outbound

echo "Changing permissions on users home folder..."
#Change user's root folder to place them in a jail
chown root:root /home/$uservar/
chmod 755 /home/$uservar

echo "Adding $uservar to /etc/vsftpd/chroot_list"
echo $uservar >> /etc/vsftpd/chroot_list

echo "You need to vi /etc/passwd adjust their shell to /sbin/nologin to prevent them from accessing via cmd line"
