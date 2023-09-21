# Documentation

Documentation for all tools in this repository are available below.

# fwdlookup

`./fwdlookup.sh [-f | --filter] [--no-color] [-o | --output <file>] [host] [wordlist_path]`

#### Required Arguments
- `[host]` like google.com
- `[wordlist_path]` like /path/wordlist

#### Optional Arguments
- *`-f`* or *`--filter`* restricts output to display valid subdomains only.
- *`--no-color`* disables terminal coloring.
- *`-o`* or *`--output`* outputs the valid subdomains to a specified file.

#### Sample Usage

>`./fwdlookup.sh -f -o valid.txt google.com /path/subdomains.txt`

#### How it Works

The script uses the `host` command, which comes installed by default in many (all?) Linux distributions.
It uses a specified wordlist of subdomains to look up DNS records. If there are valid A or AAAA records returned by the command, we know it is a valid subdomain. Otherwise, it does not exist.

#### Installation

```bash
wget https://raw.githubusercontent.com/zylideum/hacktory-aux/main/dns-enumeration/subdomain/host/fwdlookup.sh; 
chmod +x fwdlookup.sh
```

#### Screenshots 

<p align="center">
  <img src="/dns-enumeration/subdomain/host/readme-imgs/fwdlookup.png" />
  <figcaption>Fig. 1 Performing forward lookup against Google with "list" wordlist.</figcaption>
</p>
<br>
<br>
<p align="center">
  <img src="/dns-enumeration/subdomain/host/readme-imgs/fwdoutput.png" />
  <figcaption>Fig. 2 Output of scan when using -o flag.</figcaption>
</p>
<br>
<br>

---
---
# revlookup

`./revlookup.sh [-a | --address] [--no-color] [-o | --output <file>]`

#### Required Arguments
- `[-a | --address]` like 192.168.0.1

#### Optional Arguments
- *`--no-color`* disables terminal coloring.
- *`-o`* or *`--output`* outputs the valid subdomains to a specified file.

#### Sample Usage

>`./revlookup.sh -a 192.168.0.1 -o subdomains.txt`

#### How it Works

The script uses the `host` command, which comes installed by default in many (all?) Linux distributions.

It uses the provided IP and performs `host` lookups on the entire /24 subnet. If there is a valid domain name pointer returned by the command, we know it is a valid subdomain. Otherwise, it does not exist.

#### Warning

This script runs host against all 255 hosts in the /24 subnet your IP resides in. Carefully analyze returned subdomains to ensure your target is in-scope for your testing. This is considered active testing against hosts that are not in-scope. Use at your own discretion.

#### Installation

```bash
wget https://raw.githubusercontent.com/zylideum/hacktory-aux/main/dns-enumeration/subdomain/host/revlookup.sh;

chmod +x revlookup.sh
```

#### Screenshots

<p align="center">
  <img src="/dns-enumeration/subdomain/host/readme-imgs/revlookup.png" />
  <figcaption>Fig. 3 Performing reverse lookup against 142.250.68.1 (Google)</figcaption>
</p>
<br>
<br>
<p align="center">
  <img src="/dns-enumeration/subdomain/host/readme-imgs/revoutput.png" />
  <figcaption>Fig. 4 Output of scan when using -o flag.</figcaption>
</p>
<br>
<br>
