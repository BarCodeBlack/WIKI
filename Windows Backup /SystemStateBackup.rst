



* To list details of backups that can be revoered

    WBADMIN GET VERSIONS

Once 

* To delete all versions of a SystemState backup stored in the backup catalog:

    WBADMIN DELETE SYSTEMSTATEBACKUP -keepversions:0

* To backup the SystemState to a local (D:\) partition:

    WBADMIN START SYSTEMSTATEBACKUP -backupTarget:D:

* To backup the SystemState to a a network partition:

    WBADMIN START SYSTEMSTATEBACKUP -backupTarget:\\



* By default, it is not possisble to backup systemstate information to the local system partition i.e. C:\ however, there is a workaround 

HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wbengine\SystemStateBackup\  
 
Name: AllowSSBToAnyVolume
Data type: DWORD
Value data: 1



