@echo off
REM Script para compilar y generar el WAR - Windows

echo.
echo ========================================
echo Mi Perfil Dev - Build Script
echo ========================================
echo.

if not exist pom.xml (
    echo Error: pom.xml no encontrado
    echo Ejecuta este script desde la raiz del proyecto
    pause
    exit /b 1
)

echo Limpiando y compilando...
call mvn clean compile

if %ERRORLEVEL% NEQ 0 (
    echo Error durante la compilacion
    pause
    exit /b 1
)

echo.
echo Generando archivo WAR...
call mvn package

if %ERRORLEVEL% NEQ 0 (
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
echo Para desplegar en Tomcat:
echo   1. Copia el archivo WAR a %%TOMCAT_HOME%%\webapps\
echo   2. Reinicia Tomcat
echo   3. Accede a http://localhost:8080/mi-perfil-dev
echo.
pause
