# Documentation

Documentation for all tools in this section are available below.

# TCP Connect Scan

### One-Liner
```bash
nc -nvv -w 1 -z {IP} 1-65535 2>&1 | awk ' /Connection refused/{gsub(/Connection refused/, "\033[31m&\033[0m")} /open/{gsub(/open/, "\033[32m&\033[0m")} 1'
```

#### Required Arguments
- `{IP}` - replace with the target IP.

#### Optional Arguments
This one-liner depends on `awk` to function. If the restricted host does not have `awk`, remove the piped command. This is for coloring only.

This one-liner can be piped into `grep "open"` to filter results.

#### How it Works

The one-liner uses the `netcat` command, which usually comes pre-installed in many Linux distributions.

It uses Zero I/O mode (`-z`) for scanning and performs a TCP connection. If the connection is successful, the port is open. If not, the port is closed and "Connection refused" will be returned, colored red for the specific port.

#### Screenshots 

<p align="center">
  <img src="/port-scanning/restricted-host/netcat/readme-imgs/nctcp.png" />
</p>
<p align="center"><i>Fig. 1 Using Netcat to discover open TCP ports.</i></p>
<br>
<br>
<p align="center">
  <img src="/port-scanning/restricted-host/netcat/readme-imgs/nctcpgrep.png" />
</p>
<p align="center"><i>Fig. 2 Filtering results with grep.</i></p>
<br>
<br>

---
---
# UDP Scan

### One-Liner
```bash
nc -nvvu -w 1 -z {IP} 1-100 2>&1 | awk '!/\(\?\)/ && /open/ {gsub(/open/, "\033[32m&\033[0m")} /\(\?\)/ {gsub(/open/, "\033[31m&\033[0m")} 1'
```

#### Required Arguments
- `{IP}` - replace with the target IP.

#### Optional Arguments
This one-liner depends on `awk` to function. If the restricted host does not have `awk`, remove the piped command. This is for coloring only.

This one-liner can be piped into `grep "open"` to filter results.

#### How it Works

The one-liner uses the `netcat` command, which usually comes pre-installed in many Linux distributions.

It uses Zero I/O mode (`-z`) for scanning and performs a UDP connection (`-u`). A port is considered open if the "*`ICMP Port Unreachable`*" error is not returned by the target. This could result in false positives if a firewall blocks ICMP traffic completely. If the error is returned, we can immediately determine it is a closed port.

The coloring is different here as many hosts will respond as if all ports are open. Only those that are passed to the application layer should be reported.

#### Warning

UDP scanning tends to be slow and inaccurate. It is recommended to run this against a small selection of ports with careful scrutiny.

#### Screenshots 

<p align="center">
  <img src="/port-scanning/restricted-host/netcat/readme-imgs/ncudp.png" />
</p>
<p align="center"><i>Fig. 1 Using Netcat to discover open UDP ports.</i></p>
<br>
<br>