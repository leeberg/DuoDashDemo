New-UDPage -Name "Provision User" -Icon user_plus -Content {

    New-UDInput -Title "Create New DUO User" -SubmitText "Create" -Content {
        New-UDInputField -Name "txtRealName" -Placeholder "RealName" -Type "textbox" 
        New-UDInputField -Name "txtEmail" -Placeholder "Email" -Type "textbox" 
        New-UDInputField -Name "txtUserName" -Placeholder "UserName" -Type "textbox"
        New-UDInputField -Name "selStatus" -Placeholder "Status" -Type "select" -Values @('active','disabled','bypass') -DefaultValue "active"
        New-UDInputField -Name "txtNotes" -Placeholder "Notes" -Type "textbox" -DefaultValue ""
        

   } -Endpoint {

        $CreatedUser = duoCreateUser -realname $txtRealName -email $txtEmail -username $txtUserName -status $selStatus -notes $txtNotes
        Show-UDToast -Message "Created User: $txtRealName" -Duration 10000 -BackgroundColor '#26c6da'

   }

    
}