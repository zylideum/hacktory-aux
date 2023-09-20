# fwdlookup

`./fwdlookup.sh [-f | --filter] [--no-color] [-o | --output <file>]`

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