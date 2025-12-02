@echo off
REM Script para ejecutar sin necesidad de Maven en PATH

setlocal enabledelayedexpansion

echo.
echo ========================================
echo Mi Perfil Dev - Ejecutar en Tomcat
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
)

REM 2. Buscar en Program Files
if !MAVEN_FOUND! equ 0 (
    for /d %%D in ("C:\Program Files\*maven*") do (
        if exist "%%D\bin\mvn.cmd" (
            set MAVEN_CMD="%%D\bin\mvn.cmd"
            set MAVEN_FOUND=1
        )
    )
)

REM 3. Buscar en Apache
if !MAVEN_FOUND! equ 0 (
    if exist "C:\Apache\maven\bin\mvn.cmd" (
        set MAVEN_CMD=C:\Apache\maven\bin\mvn.cmd
        set MAVEN_FOUND=1
    )
)

if !MAVEN_FOUND! equ 0 (
    echo [✗] ERROR: Maven no encontrado
    echo.
    echo Por favor instala Maven o agregalo al PATH
    echo Descarga desde: https://maven.apache.org/download.cgi
    echo.
    pause
    exit /b 1
)

echo Iniciando Tomcat en puerto 8080...
echo URL: http://localhost:8080/mi-perfil-dev
echo.
echo Presiona Ctrl+C para detener el servidor
echo.

call !MAVEN_CMD! tomcat7:run

pause
