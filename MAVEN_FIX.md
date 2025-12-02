# Solución: "mvn" no se reconoce como comando

## 🔍 Diagnóstico Rápido

Ejecuta esto en PowerShell o CMD:
```powershell
mvn -v
```

Si ves la versión de Maven → ✅ Maven está instalado y en PATH  
Si ves "no se reconoce" → ❌ Maven NO está en PATH

---

## ✅ Soluciones (En Orden de Facilidad)

### Solución 1: Usar Script "build-finder.bat" ⭐ (MÁS FÁCIL)

Ejecuta desde la carpeta `Mi_Perfil_Dev`:
```powershell
.\build-finder.bat
.\run-finder.bat
```

✅ Estos scripts buscan Maven automáticamente en ubicaciones comunes

---

### Solución 2: Verificar si Maven está instalado

**Windows:**
```powershell
# Buscar Maven instalado
Get-ChildItem "C:\Program Files\" -Name "*maven*"
Get-ChildItem "C:\Program Files (x86)\" -Name "*maven*"
Get-ChildItem "C:\Apache\" -Name "*maven*"
```

Si lo encuentras, anota la ubicación exacta.

---

### Solución 3: Instalar Maven (Si no está instalado)

#### Opción A: Con Chocolatey (Más fácil)
```powershell
# Si tienes Chocolatey instalado:
choco install maven
```

Luego reinicia PowerShell y prueba:
```powershell
mvn -v
```

#### Opción B: Instalación Manual

**Paso 1: Descarga Maven**
- Ve a: https://maven.apache.org/download.cgi
- Descarga: `apache-maven-3.9.0-bin.zip` (o la versión más reciente)

**Paso 2: Extrae en C:\**
```
C:\maven-3.9.0
```

**Paso 3: Agregar al PATH de Windows**

1. Presiona `⊞ Win + X`
2. Selecciona "Terminal (Administrador)" o "PowerShell (Administrador)"
3. Ejecuta:
```powershell
[Environment]::SetEnvironmentVariable("MAVEN_HOME", "C:\maven-3.9.0", "Machine")
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\maven-3.9.0\bin", "Machine")
```

**Paso 4: Reinicia PowerShell y verifica**
```powershell
mvn -v
```

---

### Solución 4: Agregar Maven al PATH Manualmente (Windows GUI)

1. Descarga Maven como en Solución 3
2. Extrae en `C:\maven-3.9.0`
3. Presiona `⊞ Win + Pausa/Interrumpir`
4. Haz clic en "Configuración avanzada del sistema"
5. Botón "Variables de entorno..."
6. Nuevo → Nombre: `MAVEN_HOME` → Valor: `C:\maven-3.9.0`
7. Selecciona `Path` → Editar → Nuevo → `%MAVEN_HOME%\bin`
8. OK → OK → OK
9. Reinicia PowerShell

---

### Solución 5: Usar Maven Wrapper

Si Maven no está disponible globalmente, puedes usar Maven Wrapper:

```powershell
# Descarga Maven Wrapper (necesita Maven una sola vez)
mvn wrapper:wrapper

# Luego puedes usar:
.\mvnw clean package
.\mvnw tomcat7:run
```

---

## 🧪 Verificar que Maven Funciona

Una vez instalado, ejecuta:
```powershell
mvn -v
```

Deberías ver algo como:
```
Apache Maven 3.9.0
Maven home: C:\maven-3.9.0
Java version: 11.0.x
```

---

## 🚀 Ahora Compila tu Proyecto

**Opción A: Con build-finder.bat (Recomendado)**
```powershell
cd Mi_Perfil_Dev
.\build-finder.bat
.\run-finder.bat
```

**Opción B: Con Maven en PATH**
```powershell
cd Mi_Perfil_Dev
mvn clean package
mvn tomcat7:run
```

---

## 📱 ¿Qué hace cada comando?

| Comando | Función |
|---------|---------|
| `mvn clean` | Limpia archivos compilados |
| `mvn compile` | Compila el código Java |
| `mvn package` | Genera el archivo WAR |
| `mvn clean package` | Limpia y genera WAR |
| `mvn tomcat7:run` | Ejecuta Tomcat embebido |
| `mvn test` | Ejecuta tests |

---

## 💡 Tips Útiles

**Para ver qué versión de Java tienes:**
```powershell
java -version
```

**Para ver rutas de Maven:**
```powershell
mvn -X -v
```

**Para ejecutar desde cualquier carpeta:**
```powershell
# Primero agrega Maven al PATH, luego:
mvn clean package
```

---

## ❓ ¿Aún no funciona?

**Opción 1: Verificar rutas**
```powershell
# Ver todas las variables de entorno
Get-ChildItem env: | grep MAVEN

# Ver PATH
$env:Path -split ';' | Where-Object { $_ -like '*maven*' }
```

**Opción 2: Reinstalar Maven**
1. Desinstala Maven completamente
2. Sigue la Solución 3 nuevamente
3. Reinicia la computadora

**Opción 3: Solicitar ayuda**
- Ejecuta `.\build-finder.bat` y copia el error
- Comparte el error en el repositorio

---

## ✅ Checklist Final

- [ ] Java 11+ instalado (`java -version`)
- [ ] Maven 3.6+ instalado (`mvn -v`)
- [ ] Maven está en PATH
- [ ] Ejecuta: `.\build-finder.bat` desde `Mi_Perfil_Dev`
- [ ] Compila sin errores
- [ ] Accede a: `http://localhost:8080/mi-perfil-dev`

¡Listo! 🎉
