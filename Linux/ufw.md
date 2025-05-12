# Comandos más usados en UFW

## Habilitar/Deshabilitar UFW
```bash

# Habilitar el firewall
sudo ufw enable

# Deshabilitar el firewall
sudo ufw disable
```

## Ver el estado de UFW
```bash

# Ver el estado del firewall
sudo ufw status

# Ver el estado con detalles
sudo ufw status verbose
```

## Permitir conexiones
```bash

# Permitir un puerto específico (ejemplo: 22 para SSH)
sudo ufw allow 22

# Permitir un rango de puertos (ejemplo: 1000-2000)
sudo ufw allow 1000:2000/tcp

# Permitir conexiones desde una IP específica
sudo ufw allow from 192.168.1.100

# Permitir conexiones desde una IP a un puerto específico
sudo ufw allow from 192.168.1.100 to any port 80
```

## Denegar conexiones
```bash

# Denegar un puerto específico
sudo ufw deny 22

# Denegar conexiones desde una IP específica
sudo ufw deny from 192.168.1.100
```

## Eliminar reglas
```bash

# Eliminar una regla de permitir
sudo ufw delete allow 22

# Eliminar una regla de denegar
sudo ufw delete deny 22
```

## Restablecer UFW
```bash
# Restablecer todas las reglas a los valores predeterminados

sudo ufw reset
```

## Registrar actividad
```bash

# Habilitar el registro
sudo ufw logging on

# Deshabilitar el registro
sudo ufw logging off

# Cambiar el nivel de registro (low, medium, high, full)
sudo ufw logging medium
```

## Otras configuraciones
```bash

# Bloquear todo el tráfico entrante y permitir el saliente
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Permitir todo el tráfico entrante y saliente
sudo ufw default allow incoming
sudo ufw default allow outgoing
```