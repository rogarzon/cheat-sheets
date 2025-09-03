# File Encryption on Windows

One of the simplest methods is the [Invoke-AESEncryption.ps1](./Functions_Invoke-AESEncryption.ps1) PowerShell script

```powershell
.EXAMPLE
Invoke-AESEncryption -Mode Encrypt -Key "p@ssw0rd" -Text "Secret Text" 

Description
-----------
Encrypts the string "Secret Test" and outputs a Base64 encoded ciphertext.
 
.EXAMPLE
Invoke-AESEncryption -Mode Decrypt -Key "p@ssw0rd" -Text "LtxcRelxrDLrDB9rBD6JrfX/czKjZ2CUJkrg++kAMfs="
 
Description
-----------
Decrypts the Base64 encoded string "LtxcRelxrDLrDB9rBD6JrfX/czKjZ2CUJkrg++kAMfs=" and outputs plain text.
 
.EXAMPLE
Invoke-AESEncryption -Mode Encrypt -Key "p@ssw0rd" -Path file.bin
 
Description
-----------
Encrypts the file "file.bin" and outputs an encrypted file "file.bin.aes"
 
.EXAMPLE
Invoke-AESEncryption -Mode Decrypt -Key "p@ssw0rd" -Path file.bin.aes
 
Description
-----------
Decrypts the file "file.bin.aes" and outputs an encrypted file "file.bin"
```

## Import Module Invoke-AESEncryption.ps1

```powershell
C:\htb> Import-Module .\Invoke-AESEncryption.ps1
```

After the script is imported, it can encrypt strings or files, as shown in the following examples. This command creates an encrypted file with the same name as the encrypted file but with the
extension "`.aes`."

```powershell
PS C:\htb> Invoke-AESEncryption -Mode Encrypt -Key "p4ssw0rd" -Path .\scan-results.txt

File encrypted to C:\htb\scan-results.txt.aes
```

# File Encryption on Linux

- `-aes256` used as an example algorithm
- `-pbkdf2` to use the Password-Based Key Derivation Function 2 algorithm. 
- override the default iterations counts with the option `-iter 100000`

## Encrypting /etc/passwd with openssl

```bash
  openssl enc -aes256 -iter 100000 -pbkdf2 -in /etc/passwd -out passwd.enc
# enter aes-256-cbc encryption password:
#Verifying - enter aes-256-cbc encryption password:
```

## Decrypt passwd.enc with openssl
```bash
  openssl enc -d -aes256 -iter 100000 -pbkdf2 -in passwd.enc -out passwd                    
# enter aes-256-cbc decryption password:
```