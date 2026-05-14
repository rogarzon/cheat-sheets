# mongosh - MongoDB Shell

## Conexión
```bash
mongosh                              # localhost:27017
mongosh "mongodb+srv://user@cluster/"  # MongoDB Atlas
mongosh "mongodb://host:port/db"     # Conexión directa
mongosh --host host --port port      # Host y puerto
```

### Opciones de conexión
- `--username`, `--password` - Autenticación
- `--authenticationDatabase` - Base de datos de auth
- `--ssl` / `--tls` - Conexión segura

---

## Operaciones Básicas

| Comando | Descripción |
|---------|-------------|
| `show dbs` | Listar bases de datos |
| `use <db>` | Seleccionar base de datos |
| `show collections` / `db.getCollectionNames()` | Listar colecciones |
| `db.dropDatabase()` | Eliminar base de datos |
| `db.stats()` | Estadísticas de la base de datos |

---

## Operaciones CRUD

### Insertar
```javascript
db.col.insertOne({ key: "value" })
db.col.insertMany([{ a: 1 }, { b: 2 }])
```

### Leer
```javascript
db.col.find({ field: "value" })           // Con filtro
db.col.find()                             // Todo
db.col.findOne({ field: "value" })        // Primer resultado
db.col.countDocuments({ field: "value" }) // Contar
```

### Actualizar
```javascript
db.col.updateOne({ field: "value" }, { $set: { new: "data" } })
db.col.updateMany({ field: "value" }, { $inc: { count: 1 } })
db.col.replaceOne({ field: "value" }, { new: "document" })
```

### Eliminar
```javascript
db.col.deleteOne({ field: "value" })
db.col.deleteMany({ field: "value" })
```

---

## Operadores de consulta

### Comparación
| Operador | Descripción |
|----------|-------------|
| `$eq`, `$ne` | Igual, distinto |
| `$gt`, `$gte`, `$lt`, `$lte` | Mayor, mayor/igual, menor, menor/igual |
| `$in`, `$nin` | En array, no en array |
| `$regex` | Expresión regular |

### Lógica
| Operador | Descripción |
|----------|-------------|
| `$and`, `$or`, `$nor` | Y, O, NO |
| `$not` | Negación |
| `$expr` | Usar aggregation expressions |

### Array
| Operador | Descripción |
|----------|-------------|
| `$all` | Todos los elementos |
| `$elemMatch` | Elemento que cumple condiciones |
| `$size` | Tamaño del array |

---

## Operadores de actualización

| Operador | Descripción |
|----------|-------------|
| `$set` | Establecer valor |
| `$unset` | Eliminar campo |
| `$inc` | Incrementar |
| `$push` / `$addToSet` | Añadir al array |
| `$pull` / `$pop` | Eliminar del array |
| `$currentDate` | Fecha actual |

---

## Agregaciones

### Stages principales
```javascript
db.col.aggregate([
  { $match: { field: "value" } },     // Filtro
  { $group: { _id: "$field", total: { $sum: "$amount" } } },  // Agrupar
  { $project: { name: 1, total: 1 } }, // Seleccionar campos
  { $sort: { total: -1 } },            // Ordenar
  { $limit: 10 }                       // Limitar
])
```

### Otros stages útiles
- `$unwind` - Descomponer arrays
- `$bucket` - Agrupar en rangos
- `$lookup` - Joins
- `$facet` - Múltiples pipelines

---

## Índices

```javascript
db.col.createIndex({ field: 1 })                  // Simple
db.col.createIndex({ a: 1, b: -1 })               // Compuesto
db.col.createIndex({ email: 1 }, { unique: true }) // Único

db.col.getIndexes()                               // Listar
db.col.dropIndex({ field: 1 })                    // Eliminar
```

### Opciones comunes
- `unique: true` - Valores únicos
- `sparse: true` - Solo documentos con el campo
- `expireAfterSeconds: n` - TTL
- `name: "custom_name"` - Nombre personalizado

---

## Administración

### Usuarios
```javascript
db.createUser({ user: "name", pwd: "pass", roles: ["readWrite"] })
db.dropUser("name")
db.grantRolesToUser("name", ["read", { role: "read", db: "otherdb" }])

db.getUsers()
```

### Status y operaciones
```javascript
db.serverStatus()     // Estado del servidor
db.stats()            // Estadísticas de la DB
db.currentOp()        // Operaciones activas
```

---

## Scripting

```bash
mongosh -f script.js              # Ejecutar script
mongosh --eval "db.col.find()"    # Evaluar expresión
```

```javascript
// En el shell
load("helpers.js")    // Cargar script
exit()                // Salir
```

### Funciones útiles
- `connect("mongodb://host/db")` - Conectar desde script
- `db.getSiblingDB("name")` - Cambiar de DB en script
- `printjson(obj)` - Imprimir JSON formateado

---

## Edición multilinea

- `.edit` - Abrir editor para funciones multilinea
- `.exit`, `.quit` - Salir
- `Ctrl+C` - Cancelar línea actual
