@echo off
REM Script para ejecutar Tomcat embebido - Windows

echo.
echo ========================================
echo Mi Perfil Dev - Ejecutar en Tomcat
echo ========================================
echo.

if not exist pom.xml (
    echo Error: pom.xml no encontrado
    echo Ejecuta este script desde la raiz del proyecto
    pause
    exit /b 1
)

echo Iniciando Tomcat en puerto 8080...
echo URL: http://localhost:8080/mi-perfil-dev
echo.
echo Presiona Ctrl+C para detener el servidor
echo.

call mvn tomcat7:run

pause
