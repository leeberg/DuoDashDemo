New-UDPage -Name "Home" -Icon home -Endpoint {

    $DuoUsers = duoGetUser

    
    New-UDLayout -Columns 4 -Content {  
      
        New-UDCard -Id "card1" -Title 'All User Count' -Text ($DuoUsers.Count) -BackgroundColor '#379af0' 
        New-UDCard -Id "card2" -Title "Active User Count" -Text ($DuoUsers | Where-Object {$_.status -eq 'Active'} | Measure-Object).Count -BackgroundColor '#26c6da'
    
    }


    New-UDGrid -Title "Duo Users" -Headers @("UserName","Name","Email","Phone","Status","Last Login","Push","Delete") -Properties @("UserName","UserReal", "UserEmail", "UserPhoneCount","UserStatus","UserLastLogin","Push","Delete") -Endpoint {    
        
        $DuoUsers | ForEach-Object{

            [PSCustomObject]@{
                #User = $_
                UserName = $_.username
                UserReal = $_.realname
                UserEmail = $_.email
                UserPhoneCount = $_.phones.count
                UserStatus = $_.status
                UserLastLogin = $_.last_login
            }
            
        } | Out-UDGridData
        
    }
    
}