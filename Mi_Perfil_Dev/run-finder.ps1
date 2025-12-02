#!/usr/bin/env powershell

# Script para ejecutar Tomcat sin necesidad de Maven en PATH
# Compatible con Windows 10/11 PowerShell

Write-Host "`n======================================" -ForegroundColor Cyan
Write-Host "Mi Perfil Dev - Ejecutar en Tomcat" -ForegroundColor Cyan
Write-Host "======================================`n" -ForegroundColor Cyan

$MAVEN_FOUND = $false
$MAVEN_CMD = $null

# 1. Verificar si mvn está en PATH
try {
    $result = & where.exe mvn 2>$null
    if ($LASTEXITCODE -eq 0) {
        $MAVEN_CMD = "mvn"
        $MAVEN_FOUND = $true
    }
} catch {}

# 2. Buscar en Program Files
if (-not $MAVEN_FOUND) {
    $programFiles = @("C:\Program Files", "C:\Program Files (x86)", "C:\Apache")
    
    foreach ($dir in $programFiles) {
        if (Test-Path $dir) {
            Get-ChildItem -Path $dir -Filter "*maven*" -Directory -ErrorAction SilentlyContinue | ForEach-Object {
                $mvnPath = Join-Path $_.FullName "bin\mvn.cmd"
                if (Test-Path $mvnPath) {
                    $MAVEN_CMD = $mvnPath
                    $MAVEN_FOUND = $true
                }
            }
        }
    }
}

if (-not $MAVEN_FOUND) {
    Write-Host "[✗] ERROR: Maven no encontrado" -ForegroundColor Red
    Write-Host "`nPor favor instala Maven o agregalo al PATH" -ForegroundColor Yellow
    Write-Host "Descarga desde: https://maven.apache.org/download.cgi`n" -ForegroundColor White
    Read-Host "Presiona Enter para cerrar"
    exit 1
}

Write-Host "Iniciando Tomcat en puerto 8080..." -ForegroundColor Cyan
Write-Host "URL: http://localhost:8080/mi-perfil-dev" -ForegroundColor Green
Write-Host "`nPresiona Ctrl+C para detener el servidor`n" -ForegroundColor Yellow

& $MAVEN_CMD tomcat7:run

Read-Host "Presiona Enter para cerrar"
