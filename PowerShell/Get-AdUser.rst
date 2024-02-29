* To find default user information which meets a specific name with *svc*: 

    Get-AdUser -filter {name -like 'svc'}


* To obtain a list of useful user data for all accounts containing John and return the results in table format:

    Get-AdUser -properties * -filter {name -like '*John*'} | format-table GivenName,Surname,EmployeeID,mail,Company,Department,l,Manager


* To obtain a list of useful user data for all users and export the results to a csv file:

    Get-AdUser -properties * -Filter * | select GivenName,Surname,EmployeeID,mail,Company,Department,l,Manager | export-csv -Path C:\Temp\user_list.csv



