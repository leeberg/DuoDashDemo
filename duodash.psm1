function Start-DDash {

    
    $Pages = @()
    $Pages += . (Join-Path $PSScriptRoot "pages\home.ps1")

    Get-ChildItem (Join-Path $PSScriptRoot "pages") -Exclude "home.ps1" | ForEach-Object {
        $Pages += . $_.FullName
    }

    #Load Modules for Pages into Endpoints
    #https://github.com/mbegan/Duo-PSModule
    $BHEndpoints = New-UDEndpointInitialization -Module @("Modules\Duo.psd1") 
    
    #Startup the Dashboard
    $Dashboard = New-UDDashboard -Title "Duo Dash Demo" -Pages $Pages -EndpointInitialization $BHEndpoints

    Try{
        Start-UDDashboard -Dashboard $Dashboard -Port 10000 -Endpoint $AutoLoginEndpoint
    }
    Catch
    {
        Write-Error($_.Exception)
    }
    



}
