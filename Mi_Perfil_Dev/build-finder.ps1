#!/usr/bin/env powershell

# Script para encontrar y usar Maven automáticamente
# Compatible con Windows 10/11 PowerShell

Write-Host "`n======================================" -ForegroundColor Cyan
Write-Host "Mi Perfil Dev - Build (Maven Finder)" -ForegroundColor Cyan
Write-Host "======================================`n" -ForegroundColor Cyan

$MAVEN_FOUND = $false
$MAVEN_CMD = $null

# 1. Verificar si mvn está en PATH
try {
    $result = & where.exe mvn 2>$null
    if ($LASTEXITCODE -eq 0) {
        $MAVEN_CMD = "mvn"
        $MAVEN_FOUND = $true
        Write-Host "[✓] Maven encontrado en PATH" -ForegroundColor Green
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
                    Write-Host "[✓] Maven encontrado en: $($_.FullName)" -ForegroundColor Green
                }
            }
        }
    }
}

# 3. Buscar en ruta personalizada si existe
if (-not $MAVEN_FOUND) {
    $customPaths = @("C:\maven", "D:\maven", "C:\dev\maven")
    foreach ($path in $customPaths) {
        if (Test-Path "$path\bin\mvn.cmd") {
            $MAVEN_CMD = "$path\bin\mvn.cmd"
            $MAVEN_FOUND = $true
            Write-Host "[✓] Maven encontrado en: $path" -ForegroundColor Green
            break
        }
    }
}

if (-not $MAVEN_FOUND) {
    Write-Host "[✗] ERROR: Maven no encontrado" -ForegroundColor Red
    Write-Host "`nSoluciones:" -ForegroundColor Yellow
    Write-Host "1. Instala Maven desde: https://maven.apache.org/download.cgi" -ForegroundColor White
    Write-Host "2. O usa Chocolatey: choco install maven" -ForegroundColor White
    Write-Host "3. Asegúrate de agregar MAVEN_HOME/bin al PATH" -ForegroundColor White
    Write-Host "`n"
    Read-Host "Presiona Enter para cerrar"
    exit 1
}

Write-Host "`nLimpiando y compilando..." -ForegroundColor Cyan
& $MAVEN_CMD clean compile

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error durante la compilacion" -ForegroundColor Red
    Read-Host "Presiona Enter para cerrar"
    exit 1
}

Write-Host "`nGenerando archivo WAR..." -ForegroundColor Cyan
& $MAVEN_CMD package

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error durante el empaquetamiento" -ForegroundColor Red
    Read-Host "Presiona Enter para cerrar"
    exit 1
}

Write-Host "`n======================================" -ForegroundColor Green
Write-Host "¡Compilacion completada exitosamente!" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host "`nEl archivo WAR se encuentra en:" -ForegroundColor White
Write-Host "  target\mi-perfil-dev.war`n" -ForegroundColor Cyan
Read-Host "Presiona Enter para cerrar"
