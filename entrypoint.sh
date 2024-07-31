#!/bin/sh

if [ ! -z "${SMB_USER}" ]; then
  if [ ! -z "${SMB_UID}" ]; then
    cmd="$cmd --uid ${SMB_UID}"
  fi
  if [ ! -z "${SMB_GID}" ]; then
    cmd="$cmd --gid ${SMB_GID}"
    groupadd --gid ${SMB_GID} ${SMB_USER}
  fi
  adduser $cmd --no-create-home --disabled-password --gecos '' "${SMB_USER}"
  if [ ! -z "${SMB_PASSWORD}" ]; then
    echo -e "$SMB_PASSWORD\n$SMB_PASSWORD" | smbpasswd -s -a "$SMB_USER"
  fi
fi

if [ ! -d /media/share ]; then
  mkdir /media/share
  echo "use -v /my/dir/to/share:/media/share" >readme.txt
fi
chown "${SMB_USER}" /media/share

sed -i'' -e "s,%SMB_USER%,${SMB_USER:-},g" /etc/samba/smb.conf

echo ---begin-smb.conf--
cat /etc/samba/smb.conf
echo ---end---smb.conf--

exec ionice -c 3 smbd -F --no-process-group </dev/null