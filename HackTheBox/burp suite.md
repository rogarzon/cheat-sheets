# Burp Suite

Burp Suite es una plataforma integral de pruebas de seguridad web desarrollada por PortSwigger. Es la herramienta estándar en la industria para pentesting web, auditoría de seguridad y análisis de vulnerabilidades.

## Componentes Principales

### Proxy
El componente central que intercepta el tráfico HTTP/HTTPS entre el navegador y el servidor web.

**Configuración básica:**
1. Configurar el navegador para usar el proxy de Burp (por defecto: `127.0.0.1:8080`)
2. Habilitar el "Intercept" para capturar y modificar peticiones en tiempo real

**Ejemplo de uso:**
- Modificar parámetros de una petición POST para probar inyección SQL
- Cambiar cookies para probar escalación de privilegios
- Alterar headers para bypass de controles de acceso

### Repeater
Permite reenviar peticiones HTTP modificadas manualmente y ver las respuestas.

**Ejemplo de uso:**
```http
GET /api/users?id=1' OR '1'='1 HTTP/1.1
Host: target.com
Cookie: session=abc123
```
Útil para probar payloads de forma iterativa sin repetir el flujo completo.

### Intruder
Herramienta de automatización para ataques de fuerza bruta y fuzzing.

**Tipos de ataque:**
- **Sniper:** Un payload a la vez en una posición
- **Battering Ram:** Mismo payload en todas las posiciones
- **Pitchfork:** Múltiples payloads en múltiples posiciones (uno por uno)
- **Cluster Bomb:** Todas las combinaciones de payloads

**Ejemplo de uso:**
Enumerar IDs de usuarios:
```
Payload: 1, 2, 3, 4, 5...
Target: /api/user?id=§payload§
```

### Decoder
Codifica y decodifica datos en múltiples formatos (Base64, URL, Hex, etc.).

**Ejemplo de uso:**
Decodificar un token JWT para analizar su contenido:
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiYWRtaW4ifQ
→ Decodificar → {"alg":"HS256","typ":"JWT"}.{"user":"admin"}
```

### Comparer
Compara dos respuestas HTTP para identificar diferencias sutiles.

**Ejemplo de uso:**
Comparar respuestas con y sin un header específico para detectar cambios en el contenido.

## Casos de Uso Comunes

### 1. Análisis de Parámetros
Interceptar peticiones para identificar parámetros ocultos o modificar existentes:
```http
POST /login HTTP/1.1
Content-Type: application/x-www-form-urlencoded

username=admin&password=§payload§
```

### 2. Pruebas de Autorización
Reenviar peticiones con diferentes cookies/headers:
```http
GET /admin/dashboard HTTP/1.1
Cookie: session=user_session  # Cambiar a admin_session
```

### 3. Fuzzing de Endpoints
Descubrir endpoints ocultos:
```
Payloads: /admin, /api, /backup, /config...
Target: https://target.com§payload§
```

### 4. Análisis de CSRF
Generar y probar tokens CSRF:
- Copiar petición del Proxy
- Generar CSRF PoC
- Probar en navegador sin autenticación

### 5. Escaneo Automatizado
Burp Scanner identifica vulnerabilidades comunes:
- XSS
- SQL Injection
- Path Traversal
- Information Disclosure

## Extensiones

Burp Suite soporta extensiones en Python, Java y Ruby para extender su funcionalidad.

**Extensiones populares:**
- **Autorize:** Pruebas de autorización automatizadas
- **Retire.js:** Detección de librerías JavaScript vulnerables
- **Wappalyzer:** Identificación de tecnologías web
- **CO2:** Análisis de cookies

## Atajos de Teclado Útiles

| Acción | Atajo |
|--------|-------|
| Forward request | Ctrl+F |
| Drop request | Ctrl+D |
| Send to Repeater | Ctrl+R |
| Send to Intruder | Ctrl+I |
| Toggle intercept | Ctrl+T |

## Notas de Seguridad

- Usar siempre en entornos autorizados
- Configurar reglas de "Scope" para limitar el alcance
- Revisar y filtrar datos sensibles antes de guardar
- Usar el modo "Do not intercept" para tráfico no relevante