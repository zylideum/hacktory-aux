# Documentation

Documentation for all tools in this section are available below.

# smtpusers

`python3 <IP> </wordlist/path> [--output FILE] [--batch-size INT]`

#### Required Arguments
- `<IP>` like 192.168.0.1
- `</wordlist/path>` like /usr/share/wordlists/etc

#### Optional Arguments
- *`--output`* outputs valid usernames to a file.
- *`--batch-size`* controls the amount of commands sent per connection.

#### Sample Usage

>`python3 smtpusers.py 192.168.0.1 /wordlist/file --output users.txt --batch-size 100`

#### How it Works

The script initiates a connection to SMTP port 25 on the target and issued a `VRFY` command for each user in the wordlist. If the user exists, the target will respond with a code of 252.

The *`batch-size`* argument was created due to issues with rate limiting and disconnects from SMTP targets. Each batch is the number of `VRFY` command ran in one connection to SMTP. By default, this value is 10; however, it can be increased as high as the target server will support.

#### Warning

This script can be relatively slow as far as brute-forcing goes. Increase the *`batch-size`* where possible and use smaller wordlist.

#### Installation

```bash
wget https://raw.githubusercontent.com/zylideum/hacktory-aux/main/service-enumeration/smtp/smtpusers.py;
```

#### Screenshots

<p align="center">
  <img src="/service-enumeration/smtp/readme-imgs/smtpusers.png" />
</p>
<p align="center"><i>Fig. 1 Using a lengthy wordlist against an SMTP server.</i></p>
<br>
<br>
<p align="center">
  <img src="/service-enumeration/smtp/readme-imgs/smtpresults.png" />
</p>
<p align="center"><i>Fig. 2 Output of scan when using --output flag.</i></p>
<br>
<br>