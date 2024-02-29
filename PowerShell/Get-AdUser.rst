* To find default user information which meets a specific name with *svc*: 

    Get-AdUser -filter {name -like 'svc'}


* To obtain a list of userfile user data and return the results in table format:

    Get-AdUser -properties * -filter {name -like '*paul*'} | format-table GivenName,Surname,EmployeeID,mail,Company,Department,l,Manager
