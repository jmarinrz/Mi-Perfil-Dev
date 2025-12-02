# Guía Rápida de Despliegue en Tomcat

## 🚀 3 Opciones de Despliegue

### ✅ Opción 1: Desarrollo Rápido (Recomendado para desarrollo)

**Windows:**
```batch
cd Mi_Perfil_Dev
build.bat
run.bat
```

**Linux/Mac:**
```bash
cd Mi_Perfil_Dev
chmod +x build.sh run.sh
./build.sh
./run.sh
```

📍 Accede a: `http://localhost:8080/mi-perfil-dev`

---

### ✅ Opción 2: Despliegue Manual en Tomcat

**Paso 1: Compilar el proyecto**
```bash
cd Mi_Perfil_Dev
mvn clean package
```

**Paso 2: Descargar Tomcat (si no lo tienes)**
- Descarga desde: https://tomcat.apache.org/download-90.cgi
- Extrae en una carpeta (ej: `C:\Tomcat9`)

**Paso 3: Copiar el WAR**
```
Windows: Copia el archivo de: Mi_Perfil_Dev\target\mi-perfil-dev.war
         A: C:\Tomcat9\webapps\mi-perfil-dev.war

Linux/Mac: cp Mi_Perfil_Dev/target/mi-perfil-dev.war ~/tomcat/webapps/
```

**Paso 4: Iniciar Tomcat**
```
Windows: C:\Tomcat9\bin\startup.bat
Linux/Mac: ~/tomcat/bin/startup.sh
```

**Paso 5: Acceder a la aplicación**
```
http://localhost:8080/mi-perfil-dev
```

---

### ✅ Opción 3: Despliegue en Servidor Remoto

**En tu máquina:**
```bash
mvn clean package
```

**Transferir el archivo:**
```bash
scp Mi_Perfil_Dev/target/mi-perfil-dev.war usuario@servidor:/ruta/tomcat/webapps/
```

**En el servidor:**
```bash
ssh usuario@servidor
sudo systemctl restart tomcat
tail -f /opt/tomcat/logs/catalina.out
```

**Acceder:**
```
http://tu-servidor.com:8080/mi-perfil-dev
```

---

## 📋 Verificación Rápida

| Aspecto | Estado |
|--------|--------|
| ✅ Proyecto Maven | Configurado |
| ✅ Estructura WAR | Creada |
| ✅ Servlets | Implementados |
| ✅ Frontend | Incluido |
| ✅ APIs REST | Funcionales |
| ✅ Persistencia JSON | Configurada |

---

## 🛠️ Comandos Maven Útiles

```bash
# Compilar
mvn clean compile

# Empaquetar (generar WAR)
mvn clean package

# Ejecutar tests
mvn test

# Ejecutar con Tomcat embebido
mvn tomcat7:run

# Ver dependencias
mvn dependency:tree

# Limpiar archivos compilados
mvn clean
```

---

## 🐛 Solución Rápida de Problemas

**Puerto 8080 ocupado:**
```bash
# Windows - Encuentra el proceso
netstat -ano | findstr :8080

# Linux/Mac - Mata el proceso
lsof -i :8080 | grep LISTEN
kill -9 <PID>
```

**Cambiar puerto en Tomcat:**
Edita `TOMCAT_HOME/conf/server.xml` y cambia:
```xml
<Connector port="8081" ... />
```

**Ver logs de Tomcat:**
```
Windows: TOMCAT_HOME\logs\catalina.out
Linux/Mac: tail -f TOMCAT_HOME/logs/catalina.out
```

---

## 📁 Ubicación de Datos

Los archivos JSON se guardan en:
```
data/perfil.json
```

Asegúrate de crear la carpeta si no existe:
```bash
mkdir data
```

---

## ✨ Endpoints Disponibles

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | `/perfil` | Obtener perfil |
| PUT | `/perfil` | Actualizar perfil |
| DELETE | `/perfil` | Eliminar perfil |
| GET | `/habilidades` | Obtener habilidades |
| POST | `/habilidades` | Crear habilidad |
| PUT | `/habilidades` | Actualizar habilidad |
| DELETE | `/habilidades?id=...` | Eliminar habilidad |

---

## 📚 Recursos Adicionales

- **Documentación de Tomcat:** https://tomcat.apache.org/tomcat-9.0-doc/
- **Maven:** https://maven.apache.org/
- **Servlets:** https://docs.oracle.com/cd/E24329_01/web.1211/e24437/toc.htm
- **GSON:** https://github.com/google/gson

---

**¿Preguntas?** Revisa `TOMCAT_DEPLOYMENT.md` para instrucciones más detalladas.
