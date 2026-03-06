# 🗄️ Métodos de Backup para PostgreSQL (Base de datos de 60 GB)

Para una base de datos de **60 GB**, la elección del método de backup es crucial. Aquí te presento las opciones más recomendadas:

---

## 1. ✅ `pg_basebackup` — **RECOMENDADO PRINCIPAL**

```bash
pg_basebackup -h localhost -U postgres -D /ruta/backup/ -Ft -z -P
```

### ¿Por qué?
- Hace una copia **física** del clúster completo.
- Soporta **compresión** (`-z`) directamente.
- Permite **streaming** en tiempo real, sin bloquear la base de datos.
- Ideal para bases de datos grandes (>10 GB).
- Se puede combinar con **WAL archiving** para Point-in-Time Recovery (PITR).
- Velocidad muy alta comparada con métodos lógicos.

### Opciones clave:
| Opción | Descripción |
|--------|-------------|
| `-Ft`  | Formato tar |
| `-z`   | Compresión gzip |
| `-Fp`  | Formato plano (plain), sin comprimir |
| `-P`   | Muestra progreso |
| `-R`   | Genera `recovery.conf` para réplica |

---

## 2. ✅ `pg_dump` con compresión — **RECOMENDADO PARA SELECTIVIDAD**

```bash
pg_dump -h localhost -U postgres -Fc -f /ruta/backup/mi_bd.dump nombre_bd
```

### ¿Por qué?
- Permite **restaurar tablas específicas** o partes del esquema.
- El formato `-Fc` (custom) aplica **compresión automática**.
- Compatible entre diferentes versiones de PostgreSQL.
- Ideal si necesitas portabilidad o backups parciales.

### Restauración:
```bash
pg_restore -h localhost -U postgres -d nombre_bd /ruta/backup/mi_bd.dump
```

### Opciones clave:
| Opción | Descripción |
|--------|-------------|
| `-Fc`  | Formato custom (comprimido, recomendado) |
| `-Fd`  | Formato directorio (paralelizable) |
| `-j 4` | Usa 4 workers en paralelo (más rápido) |
| `-Ft`  | Formato tar |

### 🚀 Con paralelismo (mucho más rápido en 60 GB):
```bash
pg_dump -h localhost -U postgres -Fd -j 4 -f /ruta/backup/dir_backup/ nombre_bd
```

---

## 3. ✅ WAL Archiving + PITR — **RECOMENDADO PARA PRODUCCIÓN CRÍTICA**

Configurar en `postgresql.conf`:
```
wal_level = replica
archive_mode = on
archive_command = 'cp %p /ruta/wal_archive/%f'
```

### ¿Por qué?
- Permite recuperar la base de datos en **cualquier punto en el tiempo**.
- Pérdida de datos **casi cero** (RPO muy bajo).
- Se combina con `pg_basebackup` para backups base.
- Ideal si el negocio no puede permitirse perder transacciones.

---

## 4. 🔧 `pg_dumpall` — Para backups globales

```bash
pg_dumpall -h localhost -U postgres > /ruta/backup/all_databases.sql
```

### ¿Cuándo usarlo?
- Solo si necesitas incluir **roles, tablespaces y configuraciones globales**.
- NO recomendado como único método para 60 GB (sin compresión nativa, muy lento).

---

## 5. 🔧 Herramientas de terceros

| Herramienta | Descripción |
|-------------|-------------|
| **pgBackRest** | Muy poderosa, compresión, incremental, PITR, cifrado |
| **Barman** | Backup y recuperación administrado, ideal para producción |
| **WAL-G** | Rápido, soporte para cloud (S3, GCS, Azure) |

### Ejemplo con WAL-G:
```bash
WALG_FILE_PREFIX=/ruta/backup wal-g backup-push /var/lib/postgresql/data
```

---

## 📊 Comparativa para 60 GB

| Método | Velocidad | Compresión | PITR | Selectividad | Recomendado para 60 GB |
|--------|-----------|------------|------|--------------|------------------------|
| `pg_basebackup` | ⭐⭐⭐⭐⭐ | ✅ | ✅ (con WAL) | ❌ | ✅ Sí |
| `pg_dump -Fc` | ⭐⭐⭐ | ✅ | ❌ | ✅ | ✅ Sí |
| `pg_dump -Fd -j N` | ⭐⭐⭐⭐ | ✅ | ❌ | ✅ | ✅ Sí |
| WAL Archiving + PITR | ⭐⭐⭐⭐⭐ | ✅ | ✅ | ❌ | ✅ Sí (producción) |
| `pg_dumpall` | ⭐⭐ | ❌ | ❌ | ❌ | ⚠️ Solo para globals |
| pgBackRest / WAL-G | ⭐⭐⭐⭐⭐ | ✅ | ✅ | ✅ | ✅ Altamente recomendado |

---

## 🏆 Mi Recomendación Final para 60 GB

### Entorno de **Desarrollo / Staging**:
```bash
pg_dump -h localhost -U postgres -Fd -j 4 -f /ruta/backup/backup_dir/ nombre_bd
```
> Rápido, comprimido y con paralelismo.

### Entorno de **Producción**:
1. Configura **WAL Archiving** para PITR.
2. Usa `pg_basebackup` para backups base periódicos.
3. O mejor aún, usa **pgBackRest** o **WAL-G** para una solución robusta con incrementales y cifrado.

---

## ⚠️ Consideraciones Importantes

- **Almacenamiento**: 60 GB comprimidos suelen ocupar entre **10–25 GB** dependiendo del tipo de datos.
- **Tiempo estimado**: Con `pg_dump -Fd -j 4`, espera entre **10–30 minutos** para 60 GB.
- **Prueba la restauración**: Un backup que nunca se prueba no es confiable.
- **Automatización**: Usa `cron` o `pg_agent` para programar backups automáticos.
- **Cifrado**: Si los datos son sensibles, usa `gpg` o las opciones de cifrado de `pgBackRest`.
