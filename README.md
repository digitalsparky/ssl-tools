# ssl-tools

# Private Certificate Authority

```
Usage:
ca.sh -n <common-name> <options>
common-name: the FQDN or identifying name for the certificate (ie: your name, or host.example.com)
options:
    -k:     generate an rsa key for the common-name
    -c:     generate a certificate signing request for the common-name (requires key)
    -s:     sign a certificate signing request against the CA
    
Example:
ca.sh -n example.com -k -c -s
Generates the rsa key, and signing request, then signs the request with the certificate authority
ca.sh -n example.com -k
Generates only the rsa key for the common-name
ca.sh -n example.com -k -c
Generates the rsa key and certificate signing request based on that key
ca.sh -n example.com -c
Generates an rsa key based on a pre-existing key only
This requires the key to exist in the private directory, eg:
./my-ca/priv/example.com.key
ca.sh -n example.com -s
Signs an existing csr with the certificate authority
This requires the csr to exist in the csr directory, eg:
./my-ca/csr/example.com.csr
```
# Key generation and Certificate Signing Request generation

```
Usage:
csrgen.sh -n <common-name> <options>
common-name: the FQDN or identifying name for the certificate (ie: your name, or host.example.com)
options:
    -k:     generate an rsa key for the common-name
    -c:     generate a certificate signing request for the common-name (requires key)
    
Example:
csrgen.sh -n example.com -k
Generates only the rsa key for the common-name
csrgen.sh -n example.com -k -c
Generates the rsa key and certificate signing request based on that key
csrgen.sh -n example.com -c
Generates an rsa key based on a pre-existing key only
This requires the key to exist in the private directory, eg:
./priv/example.com.key
```

# Debian CA Installer

```
cd into your CA folder

./installca.debian.sh <yourcaname>
```

# Like my stuff?

Would you like to buy me a coffee or send me a tip?
While it's not expected, I would really appreciate it.

[![Paypal](https://www.paypalobjects.com/webstatic/mktg/Logo/pp-logo-100px.png)](https://paypal.me/MattSpurrier) <a href="https://www.buymeacoffee.com/digitalsparky" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/white_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>


```
