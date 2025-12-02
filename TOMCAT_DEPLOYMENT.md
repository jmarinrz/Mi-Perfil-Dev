# Configuración y Despliegue en Tomcat - Mi Perfil Dev

## Requisitos Previos

- Java 11 o superior
- Maven 3.6.0 o superior
- Tomcat 9.0 o superior (puede descargar desde https://tomcat.apache.org/)
- Git (para control de versiones)

## Pasos de Configuración

### 1. Compilar el Proyecto

```bash
# Navega a la carpeta del proyecto
cd Mi_Perfil_Dev

# Limpia y compila el proyecto
mvn clean compile
```

### 2. Construir el Archivo WAR

```bash
# Genera el archivo WAR (Web Archive) listo para desplegar
mvn clean package
```

Este comando generará un archivo llamado `mi-perfil-dev.war` en la carpeta `target/`.

### 3. Opciones de Despliegue

#### Opción A: Despliegue Manual en Tomcat

1. **Descarga Tomcat:**
   - Descargar desde: https://tomcat.apache.org/download-90.cgi
   - Extraer en una carpeta (ej: `C:\Apache\Tomcat-9.0`)

2. **Coloca el archivo WAR:**
   ```
   TOMCAT_HOME\webapps\mi-perfil-dev.war
   ```

3. **Inicia Tomcat:**
   - Windows: `TOMCAT_HOME\bin\startup.bat`
   - Linux/Mac: `TOMCAT_HOME/bin/startup.sh`

4. **Accede a la aplicación:**
   ```
   http://localhost:8080/mi-perfil-dev
   ```

#### Opción B: Despliegue Usando Maven (Desarrollo)

```bash
# Ejecuta Tomcat 7 embebido
mvn tomcat7:run

# O si prefieres Tomcat 9
mvn tomcat9:run
```

Luego accede a: `http://localhost:8080/mi-perfil-dev`

#### Opción C: Despliegue con Manager (GUI)

1. Inicia Tomcat (si no está ya iniciado)
2. Accede a: `http://localhost:8080/manager/html`
3. (Si es la primera vez, configura usuarios en `TOMCAT_HOME\conf\tomcat-users.xml`)
4. En "Deploy", selecciona el archivo `mi-perfil-dev.war`
5. Haz clic en "Deploy"

### 4. Verificar la Instalación

- Abre tu navegador y ve a: `http://localhost:8080/mi-perfil-dev`
- Deberías ver la página de inicio de Mi Perfil Dev

## Configuración de Tomcat

### Aumentar Memoria (si es necesario)

**Windows:**
```batch
set CATALINA_OPTS=-Xms1024m -Xmx2048m
```

**Linux/Mac:**
```bash
export CATALINA_OPTS="-Xms1024m -Xmx2048m"
```

### Configurar Usuarios en `tomcat-users.xml`

Editar `TOMCAT_HOME\conf\tomcat-users.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<tomcat-users xmlns="http://tomcat.apache.org/xml"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
              version="1.0">

  <role rolename="manager-gui"/>
  <role rolename="manager-script"/>
  <user username="admin" password="admin123" roles="manager-gui,manager-script"/>

</tomcat-users>
```

## Estructura del Proyecto WAR

```
mi-perfil-dev.war
├── WEB-INF/
│   ├── web.xml              (Descriptor de despliegue)
│   ├── lib/                 (Librerías JAR)
│   │   └── gson-*.jar
│   └── classes/             (Clases compiladas)
│       └── com/mycompany/mi_perfil_dev/
├── index.html               (Página de inicio)
├── error.html               (Página de error)
├── css/
│   └── styles.css
├── js/
│   ├── api.js
│   └── main.js
└── images/
```

## Archivos de Datos (JSON)

Los archivos JSON se guardan en:
```
$TOMCAT_HOME/data/perfil.json
```

Asegúrate de que la carpeta `data/` existe y tiene permisos de escritura.

## Endpoints API Disponibles

### Perfil
- `GET /mi-perfil-dev/perfil` - Obtener perfil
- `PUT /mi-perfil-dev/perfil` - Actualizar perfil
- `DELETE /mi-perfil-dev/perfil` - Eliminar perfil

### Habilidades
- `GET /mi-perfil-dev/habilidades` - Obtener todas las habilidades
- `GET /mi-perfil-dev/habilidades?id=XXX` - Obtener habilidad específica
- `POST /mi-perfil-dev/habilidades` - Crear nueva habilidad
- `PUT /mi-perfil-dev/habilidades` - Actualizar habilidad
- `DELETE /mi-perfil-dev/habilidades?id=XXX` - Eliminar habilidad

## Solución de Problemas

### Puerto 8080 en uso

```bash
# Windows: Encuentra el proceso que usa el puerto
netstat -ano | findstr :8080

# Linux/Mac: 
lsof -i :8080
```

Cambia el puerto en `TOMCAT_HOME\conf\server.xml`:
```xml
<Connector port="8081" protocol="HTTP/1.1" ... />
```

### Archivo WAR no se despliega

1. Verifica que el nombre sea `mi-perfil-dev.war` (sin versión)
2. Reinicia Tomcat
3. Revisa los logs en `TOMCAT_HOME\logs\catalina.out`

### Error 404 en la aplicación

- Verifica que accedas a `http://localhost:8080/mi-perfil-dev`
- No olvides el nombre de la aplicación en la URL

## Comandos Útiles de Maven

```bash
# Limpiar archivos compilados
mvn clean

# Compilar
mvn compile

# Ejecutar tests
mvn test

# Empaquetar (genera WAR)
mvn package

# Limpiar y empaquetar
mvn clean package

# Ejecutar con Tomcat embebido
mvn tomcat7:run

# Desplegar en Tomcat remoto
mvn tomcat7:deploy

# Descargar todas las dependencias
mvn dependency:resolve
```

## Despliegue en Servidor de Producción

1. **Compilar:**
   ```bash
   mvn clean package
   ```

2. **Transferir el WAR:**
   - Copia `target/mi-perfil-dev.war` al servidor

3. **Copiar en Tomcat:**
   ```bash
   cp mi-perfil-dev.war /opt/tomcat/webapps/
   ```

4. **Reiniciar Tomcat:**
   ```bash
   sudo systemctl restart tomcat
   ```

5. **Verificar logs:**
   ```bash
   tail -f /opt/tomcat/logs/catalina.out
   ```

## Configuración HTTPS (SSL)

Para habilitar HTTPS, edita `TOMCAT_HOME\conf\server.xml`:

```xml
<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
           maxThreads="150" SSLEnabled="true">
    <SSLContext
        certificateKeystoreFile="conf/keystore.jks"
        certificateKeystorePassword="password" />
</Connector>
```

## Monitoreo y Logs

- **Logs de Tomcat:** `TOMCAT_HOME\logs\catalina.out`
- **Logs de la aplicación:** Los errores se registran en el archivo de logs de Tomcat
- **Manager Web:** `http://localhost:8080/manager/html`

---

**¿Necesitas ayuda adicional?** Revisa la documentación oficial de Tomcat: https://tomcat.apache.org/tomcat-9.0-doc/
