# =====================================================================
# schema.ps1 - Extracción de esquema: lista las columnas de cada CSV
# Uso:  .\herramientas\schema.ps1
# Resultado: docs\diccionario-borrador.csv (una fila por columna encontrada)
# =====================================================================
param(
    [string]$Carpeta = (Join-Path (Split-Path $PSScriptRoot -Parent) "datos"),
    [string]$Salida  = (Join-Path (Split-Path $PSScriptRoot -Parent) "docs/diccionario-borrador.csv")
)
$ErrorActionPreference = "Stop"

$filas = @()
$numero = 1
foreach ($archivo in Get-ChildItem -Path $Carpeta -Filter *.csv) {
    $registros = @(Import-Csv -Path $archivo.FullName -Encoding UTF8)
    # Los nombres de las columnas salen de la primera línea del archivo
    $columnas = (Get-Content -Path $archivo.FullName -TotalCount 1 -Encoding UTF8) -replace '"', '' -split ","

    Write-Host ""
    Write-Host "$($archivo.Name)  ($($registros.Count) registros)" -ForegroundColor Cyan
    foreach ($columna in $columnas) {
        # Cuántos registros tienen un valor en esta columna (sin mostrar el valor)
        $conValor = @($registros | Where-Object { $_.$columna -ne "" }).Count
        Write-Host ("  {0,-25} {1} con valor" -f $columna, $conValor)

        $filas += [PSCustomObject][ordered]@{
            id            = "D-{0:D2}" -f $numero
            archivo       = $archivo.Name
            columna       = $columna
            con_valor     = $conValor
            descripcion   = ""
            origen        = ""
            tipo_dato     = ""
            clasificacion = ""
            finalidad     = ""
            base_legal    = ""
            conservacion  = ""
            dueno         = ""
        }
        $numero++
    }
}

$filas | Export-Csv -Path $Salida -NoTypeInformation -Encoding UTF8
Write-Host ""
Write-Host "Borrador guardado en $Salida ($($filas.Count) columnas)" -ForegroundColor Green