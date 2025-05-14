# Listar todas las interfaces de red

```bash

ip link show

# También se puede usar
ifconfig -a  # ifconfig -a pertenece al paquete net-tools
```

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