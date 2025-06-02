# Listar todas las interfaces de red

```bash
    ip link show
    
    # También se puede usar
    ifconfig -a  # ifconfig -a pertenece al paquete net-tools
```
> Nota: ifconfig -a pertenece al paquete net-tools

# Identificar qué programas están utilizando una interfaz de red

```bash
    # Usando ss
    sudo ss -tulnp
    # Este comando muestra las conexiones activas (TCP/UDP), los puertos abiertos y los programas asociados.
    
    # Usando netstat
    sudo netstat -tulnp
    # Similar a ss, muestra las conexiones activas y los programas que las utilizan
    
    # Usando lsof
    lsof -i
    # Este comando lista los procesos que están utilizando sockets de red.
```

## Filtrar por interfaz específica

```bash
    # Filtrar por una interfaz específica (ejemplo: eth0)
    sudo tcpdump -i <nombre_interfaz>
```

## Activar una interfaz de red

```bash
    sudo ifconfig eth0 up     # OR
    sudo ip link set eth0 up
```

## Asignar IP a una interfaz

```bash
    sudo ifconfig eth0 192.168.1.2
    # OR
    sudo ip addr add
```

## Asignar máscara de red

```bash
    sudo ifconfig eth0 netmask 255.255.255.0
```

## Asignar la ruta a una interfaz (Puerta de enlace)

```bash
    sudo route add default gw 192.168.1.1 eth0
```

## Configuración de DNS

En sistemas Linux, el archivo `/etc/resolv.conf`, contiene la información DNS del sistema.

```bash
    sudo nano /etc/resolv.conf
    # nameserver 8.8.8.8
    # nameserver 8.8.4.4
```

Después de completar las modificaciones necesarias en la configuración de red, es fundamental asegurarse de que estos cambios se guarden para que persistan tras reiniciar el sistema. Esto se puede
lograr editando el archivo `/etc/network/interfaces`, que define las interfaces de red en sistemas operativos basados en Linux.
Es importante tener en cuenta que los cambios realizados directamente en el archivo `/etc/resolv.conf` no son persistentes tras reiniciar el sistema o al cambiar la configuración de red.

## Editando interfaces

```bash
    sudo nano /etc/network/interfaces
```

**/etc/network/interfaces**

```
auto eth0
iface eth0 inet static
  address 192.168.1.2
  netmask 255.255.255.0
  gateway 192.168.1.1
  dns-nameservers 8.8.8.8 8.8.4.4
```

Salir del editor y reiniciar para aplicar los cambios.

## Reiniciar servicio de red

```bash
    sudo systemctl restart networking
```

