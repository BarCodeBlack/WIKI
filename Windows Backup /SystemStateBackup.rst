* To list all the details of backups that can be restored, use the following:

    WBADMIN GET VERSIONS


* To delete all versions of a SystemState backup stored in the backup catalog:

    WBADMIN DELETE SYSTEMSTATEBACKUP -keepversions:0


* To backup the SystemState to a local (D:\) partition:

    WBADMIN START SYSTEMSTATEBACKUP -backupTarget:D:


* To backup the SystemState to a network partition:

    WBADMIN START SYSTEMSTATEBACKUP -backupTarget:\\<Servername>\<Folder>


* By default, it is not possisble to backup systemstate information to the local system partition i.e. C:\ however, there is a workaround by applying the following registry edit:

    Windows Registry Editor Version 5.00

    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wbengine\SystemStateBackup]
    "AllowSSBToAnyVolume"=dword:00000001::
