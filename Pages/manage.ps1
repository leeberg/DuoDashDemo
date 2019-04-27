New-UDPage -Name "Manage" -Icon edit -Content {


    New-UDGrid -Id "grdManageDuoUsers" -Title "Duo Users" -Headers @("UserName","Name","Email","Phone","Status","Last Login","Push","Delete") -Properties @("UserName","UserReal", "UserEmail", "UserPhoneCount","UserStatus","UserLastLogin","Push","Delete") -Endpoint {    

        $DuoUsers = duoGetUser

        $DuoUsers | ForEach-Object{

            [PSCustomObject]@{
                #User = $_
                UserName = $_.username
                UserReal = $_.realname
                UserEmail = $_.email
                UserPhoneCount = $_.phones.count
                UserStatus = $_.status
                UserLastLogin = $_.last_login
                Push = New-UDButton -Text "Push" -OnClick (New-UDEndpoint -Endpoint {                        
                    
                    $searchstring = $ArgumentList[0]

                    Show-UDModal -Content {
                                               
                        New-UDInput -Title "Push Options" -SubmitText "Send Push" -Content {
                             New-UDInputField -Name "PushTitle" -Placeholder "Title" -Type "textbox" -DefaultValue "This is a Test"
                             New-UDInputField -Name "PushInfo" -Placeholder "DetailInfo" -Type "textarea" -DefaultValue "Message=Hello World"
                        } -Endpoint {

                            $user = duoGetUser -username $searchstring
                            $username = $user.username
                            $UserDeviceID = $user.phones.phone_id
                                    
                            $authorization = duoSendAuth -dOrg 'AUTH' -username $username -device $UserDeviceID -PromptTitle $PushTitle -PushInfo $PushInfo

                            If($authorization.result -eq 'allow')
                            {
                                Show-UDToast -Message "User has accecpted MFA!" -Duration 10000 -BackgroundColor '#26c6da'
                            }
                            else 
                            {
                                Show-UDToast -Message "User has failed / denied or timed out mfa!" -Duration 10000 -BackgroundColor '#FF0000'
                            }
                            
                            Sync-UDElement -Id "grdManageDuoUsers" -Broadcast
                            
                        }

                    } 


                } -ArgumentList $_.username)
                Delete = New-UDButton -Text "Delete" -OnClick (New-UDEndpoint -Endpoint {                        
                    
                    $DeleteAction = duoDeleteUser -user_id $ArgumentList[0]

                } -ArgumentList $_.user_id)
            }
            
        } | Out-UDGridData
        
    }
    
}