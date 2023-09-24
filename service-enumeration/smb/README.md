# Documentation

Documentation for all tools in this section are available below.

# Nmap Scripts

### One-Liner
```bash
sudo nmap -sS {IP} --script=smb-protocols,smb-security-mode,smb-enum-users,smb-enum-shares,smb-os-discovery
```

#### Required Arguments
- `{IP}` - replace with the target IP.

#### Optional Arguments
- If you are testing an unstable environment, production environment, or lack sudo permissions, omit the `sudo... -sS` in exchange for a default TCP connect scan (`-sT`) for all future `nmap` scans.

#### How it Works

The `nmap` scripting engine will perform actions related to the 5 scripts in the command. Their documentation can be found here: https://nmap.org/nsedoc/scripts/

#### Screenshots 

*Needs screenshot*