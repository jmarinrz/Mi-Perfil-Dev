#!/bin/bash
# Script para compilar y generar el WAR - Linux/Mac

echo ""
echo "========================================"
echo "Mi Perfil Dev - Build Script"
echo "========================================"
echo ""

if [ ! -f pom.xml ]; then
    echo "Error: pom.xml no encontrado"
    echo "Ejecuta este script desde la raiz del proyecto"
    exit 1
fi

echo "Limpiando y compilando..."
mvn clean compile

if [ $? -ne 0 ]; then
    echo "Error durante la compilacion"
    exit 1
fi

echo ""
echo "Generando archivo WAR..."
mvn package

if [ $? -ne 0 ]; then
    echo "Error durante el empaquetamiento"
    exit 1
fi

echo ""
echo "========================================"
echo "Compilacion completada exitosamente!"
echo "========================================"
echo ""
echo "El archivo WAR se encuentra en:"
echo "  target/mi-perfil-dev.war"
echo ""
echo "Para desplegar en Tomcat:"
echo "  1. Copia el archivo WAR a \$TOMCAT_HOME/webapps/"
echo "  2. Reinicia Tomcat"
echo "  3. Accede a http://localhost:8080/mi-perfil-dev"
echo ""
