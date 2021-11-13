# sftp-server
An docker/alpine based sftp server with basic functionality.

The server acts as an sftp-daemon, providing separate file storage for each *sftp-user*. 
Hence, each *sftp-user* represents a project and the server provides storage space for that project.
Access is provided by means of ssh-keys. The storage spaces of other *sftp-users* are not visible, even the existence of other *sftp-users* is invisible.

## Storage for each project/sftp-user
The root folder is not writable by the user. This is a shortcoming of this setup. However, there are several writable subfolders:
* etc/ which contains the file *ssh_keys* - edit this file to give access to other project members
* docs - intended for documentation
* files - intended for upload/download of files
* notes - intended for all lesser important written stuff 


## Configuration

The docker-compose file specifies on which port the sshd is listening. Moreover, it specifies the data storage place under volume. The storage place should only be writable by root.

A banner message can be customized under *opt/ssh/banner*.

*NOTE* before starting the docker container the first time, ensure that the administrator has added his/her public key to *opt/skel/etc/ssh_keys*. This will give access for the administrator to that project. Further access is given to the project members via editing the *etc/ssh_keys* of that project.

## Usage

### Startup
```
docker-compose up -d
```

### Adding a new user/directory
Log into the docker entity by
```
docker-compose exec ssv sh
```
Then enter the */opt* directory and enter the following command:
```
./create.sh <username>
```
Please make sure that the user/project name does not contain any spaces, since it breaks scripts. Also, don't create a user *etc*.

### Removing users/directories
Just remove the created directories in the data storage. Once the directories are gone, the next *create.sh* call will remove the users from */etc/passwd*.

### Special user/project *skel*

The *sftp-user* *skel* is the skeleton user. Whatever this user has is copied over to the new user by the script *create.sh*. This can be used to add several ssh-keys to the administrator.
