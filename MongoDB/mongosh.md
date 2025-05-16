# [MONGOSH](https://www.mongodb.com/docs/mongodb-shell/) 

# Comandos más usados en `mongosh`

## Conexión
- **Conectar a una base de datos:**
  ```bash
  mongosh "mongodb+srv://<cluster_url>"
  ```

## Operaciones básicas
- **Mostrar bases de datos:**
  ```javascript
  show dbs
  ```
- **Seleccionar una base de datos:**
  ```javascript
  use <database_name>
  ```
- **Eliminar una base de datos:**
  ```javascript
  db.dropDatabase()
  ```
  
- **Mostrar colecciones:**
  ```javascript
  show collections
  ```

## Operaciones CRUD
- **Insertar un documento:**
  ```javascript
  db.<collection_name>.insertOne({ key: "value" })
  ```
- **Insertar múltiples documentos:**
  ```javascript
  db.<collection_name>.insertMany([{ key: "value1" }, { key: "value2" }])
  ```
- **Buscar documentos:**
  ```javascript
  db.<collection_name>.find({ key: "value" })
  ```
- **Actualizar un documento:**
  ```javascript
  db.<collection_name>.updateOne({ key: "value" }, { $set: { key: "new_value" } })
  ```
- **Eliminar un documento:**
  ```javascript
  db.<collection_name>.deleteOne({ key: "value" })
  ```

## Información del esquema
- **Contar documentos:**
  ```javascript
  db.<collection_name>.countDocuments()
  ```
- **Obtener estadísticas de una colección:**
  ```javascript
  db.<collection_name>.stats()
  ```

## Índices
- **Crear un índice:**
  ```javascript
  db.<collection_name>.createIndex({ key: 1 })
  ```
- **Listar índices:**
  ```javascript
  db.<collection_name>.getIndexes()
  ```

## Administración
- **Ver usuarios:**
  ```javascript
  db.getUsers()
  ```
- **Crear un usuario:**
  ```javascript
  db.createUser({
    user: "username",
    pwd: "password",
    roles: [{ role: "readWrite", db: "database_name" }]
  })
```
