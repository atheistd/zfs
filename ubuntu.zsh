#!/usr/bin/zsh

# update & install
sudo apt update
sudo apt upgrade
sudo apt install zfsutils-linux -y

# create pools & datasets
sudo zpool create heathen_disk raidz1 <devs>
sudo zfs create heathen_disk/personal
sudo zfs create heathen_disk/work

sudo zfs create heathen_disk/personal/media
sudo zfs create heathen_disk/personal/media/movies
sudo zfs create heathen_disk/personal/media/tv_series
sudo zfs create heathen_disk/personal/media/camera_roll

sudo zfs create heathen_disk/personal/z_pesky
sudo zfs create heathen_disk/personal/backup
sudo zfs create heathen_disk/personal/fonts

sudo zfs create heathen_disk/work/ml_datasets
sudo zfs create heathen_disk/work/nix

# set dataset properties
sudo zfs set atime=off heathen_disk
sudo zfs set primarycache=none heathen_disk
sudo zfs set snapdir=visible heathen_disk

sudo zfs set checksum=sha512 heathen_disk/work
sudo zfs set copies=2 heathen_disk/work/ml_datasets

sudo zfs set checksum=sha512 heathen_disk/personal/media
sudo zfs set copies=2 heathen_disk/personal/media
sudo zfs set compression=off heathen_disk/personal/media

sudo zfs set compression=gzip-9 heathen_disk/personal/z_pesky
sudo zfs set compression=gzip-9 heathen_disk/personal/backup
sudo zfs set compression=gzip-9 heathen_disk/personal/fonts

# verify created pools
zpool status -v
zfs list

# own mount points
sudo chown atheistd:root -R /heathen_disk
sudo chmod 774 -R /heathen_disk


# create nfs user
sudo useradd -m nfs_user
sudo passwd nfs_user
cd /home/nfs_user/
sudo ln -s <path to mount-point /home/atheistd/ssd_mount> ./heathen_disk
sudo chmod 774 -R heathen_disk
sudo chown nfs_user:nfs_user -R heathen_disk




