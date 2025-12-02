#!/bin/bash
# Script para ejecutar Tomcat embebido - Linux/Mac

echo ""
echo "========================================"
echo "Mi Perfil Dev - Ejecutar en Tomcat"
echo "========================================"
echo ""

if [ ! -f pom.xml ]; then
    echo "Error: pom.xml no encontrado"
    echo "Ejecuta este script desde la raiz del proyecto"
    exit 1
fi

echo "Iniciando Tomcat en puerto 8080..."
echo "URL: http://localhost:8080/mi-perfil-dev"
echo ""
echo "Presiona Ctrl+C para detener el servidor"
echo ""

mvn tomcat7:run
