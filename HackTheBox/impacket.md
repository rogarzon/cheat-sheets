# [Impacket](https://github.com/fortra/impacket)

Impacket es una colección de clases Python para trabajar con protocolos de red, mantenida por Fortra's Core Security. Permite construir y analizar paquetes de red con implementaciones de alto nivel de SMB1-3 y MSRPC.

## Protocolos soportados
- **Red:** Ethernet, IP, TCP, UDP, ICMP, IGMP, ARP, IPv4/IPv6
- **SMB:** SMB1, SMB2, SMB3
- **MSRPC:** 5 (TCP, SMB/TCP, SMB/NetBIOS, HTTP)
- **Autenticación:** Plain, NTLM, Kerberos (contraseñas, hashes, tickets)
- **Otros:** TDS (MSSQL), LDAP

## Herramientas principales

| Herramienta | Descripción |
|-------------|-------------|
| `smbclient.py` | Cliente interactivo SMB |
| `psexec.py` | Ejecución remota vía SMB/DCOM |
| `secretsdump.py` | Extracción de credenciales de SAM/LSA |
| `mimikatz.py` | Extracción de credenciales (tipo Mimikatz) |
| `wmiexec.py` | Ejecución remota vía WMI |
| `atexec.py` | Programación de tareas remotas |
| `dpapi.py` | Descifrado de secrets DPAPI |
| `ntlmrelayx.py` | Relaying NTLM |
| `getTGT.py` | Solicitar tickets Kerberos TGT |
| `getST.py` | Solicitar tickets Kerberos Service Ticket |
| `smbexec.py` | Ejecución remota vía SMB |
| `dcomexec.py` | Ejecución remota vía DCOM |

## Instalación
```bash
pip install impacket
```

## Uso general
```bash
python3 <herramienta>.py -h
```
