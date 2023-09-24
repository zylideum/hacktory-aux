# Documentation

Documentation for all tools in this section are available below.

# Port Enumeration

### One-Liner
```powershell
1..1024 | % {echo ((New-Object Net.Sockets.TcpClient).Connect("{IP}", $_)) "TCP port $_ is open"} 2>$null
```

#### Required Arguments
- `{IP}` - replace with the target IP.

#### Optional Arguments
- Replace the `1..1024` portion with the port range desired.

#### How it Works

PowerShell will sequentially attempt to make a TCP connection to the specified port numbers in the range. If the connection is successful, it will return to the terminal. This command also works with domain names.

#### Warning

Scanning with PowerShell can be very time-consuming. Be patient if you do not see immediate results.

#### Screenshots 

<p align="center">
  <img src="/port-scanning/windows/powershell/readme-imgs/pstcp.png" />
</p>
<p align="center"><i>Fig. 1 Using PowerShell (in Kali) to enumerate ports.</i></p>
<br>
<br>