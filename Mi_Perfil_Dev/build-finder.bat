@echo off
REM Script para compilar sin necesidad de Maven en PATH
REM Intenta encontrar Maven en ubicaciones comunes

setlocal enabledelayedexpansion

echo.
echo ========================================
echo Mi Perfil Dev - Build (Maven Finder)
echo ========================================
echo.

REM Buscar Maven en ubicaciones comunes
set MAVEN_FOUND=0
set MAVEN_CMD=

REM 1. Verificar si mvn está disponible en PATH
where mvn >nul 2>nul
if !ERRORLEVEL! equ 0 (
    set MAVEN_CMD=mvn
    set MAVEN_FOUND=1
    echo [✓] Maven encontrado en PATH
)

REM 2. Buscar en Program Files
if !MAVEN_FOUND! equ 0 (
    for /d %%D in ("C:\Program Files\*maven*") do (
        if exist "%%D\bin\mvn.cmd" (
            set MAVEN_CMD="%%D\bin\mvn.cmd"
            set MAVEN_FOUND=1
            echo [✓] Maven encontrado en: %%D
        )
    )
)

REM 3. Buscar en Program Files (x86)
if !MAVEN_FOUND! equ 0 (
    for /d %%D in ("C:\Program Files (x86)\*maven*") do (
        if exist "%%D\bin\mvn.cmd" (
            set MAVEN_CMD="%%D\bin\mvn.cmd"
            set MAVEN_FOUND=1
            echo [✓] Maven encontrado en: %%D
        )
    )
)

REM 4. Buscar en Apache
if !MAVEN_FOUND! equ 0 (
    if exist "C:\Apache\maven\bin\mvn.cmd" (
        set MAVEN_CMD=C:\Apache\maven\bin\mvn.cmd
        set MAVEN_FOUND=1
        echo [✓] Maven encontrado en: C:\Apache\maven
    )
)

if !MAVEN_FOUND! equ 0 (
    echo [✗] ERROR: Maven no encontrado
    echo.
    echo Soluciones:
    echo 1. Instala Maven desde: https://maven.apache.org/download.cgi
    echo 2. Asegúrate de agregar MAVEN_HOME/bin al PATH
    echo 3. O descarga Maven Wrapper ejecutando:
    echo    mvn wrapper:wrapper
    echo.
    pause
    exit /b 1
)

echo.
echo Limpiando y compilando...
call !MAVEN_CMD! clean compile

if !ERRORLEVEL! neq 0 (
    echo Error durante la compilacion
    pause
    exit /b 1
)

echo.
echo Generando archivo WAR...
call !MAVEN_CMD! package

if !ERRORLEVEL! neq 0 (
    echo Error durante el empaquetamiento
    pause
    exit /b 1
)

echo.
echo ========================================
echo Compilacion completada exitosamente!
echo ========================================
echo.
echo El archivo WAR se encuentra en:
echo   target\mi-perfil-dev.war
echo.
pause
