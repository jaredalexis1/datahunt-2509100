# =====================================================================
# discover.ps1 - Descubrimiento por patrones: busca datos personales
# en todos los archivos de una carpeta, incluidos los que no deberían tenerlos.
# Uso:  .\herramientas\discover.ps1
#       .\herramientas\discover.ps1 -Carpeta C:\otra\carpeta
# Resultado: docs\descubrimiento.csv (valores enmascarados)
# =====================================================================
param(
    [string]$Carpeta = (Split-Path $PSScriptRoot -Parent),
    [string]$Salida  = (Join-Path (Split-Path $PSScriptRoot -Parent) "docs/descubrimiento.csv")
)
$ErrorActionPreference = "Stop"
$Carpeta = (Resolve-Path $Carpeta).Path

# Patrones de datos personales (expresiones regulares)
$Patrones = [ordered]@{
    "Correo electrónico"     = '[\w.+-]+@[\w-]+\.[\w.-]+'
    "CURP"                   = '\b[A-Z]{4}\d{6}[HM][A-Z]{5}[A-Z\d]\d\b'
    "Teléfono (10 dígitos)"  = '\b\d{10}\b'
    "Tarjeta de pago"        = '\b(?:\d[ -]?){15}\d\b'
    "Dirección IP"           = '\b(?:\d{1,3}\.){3}\d{1,3}\b'
    "Contraseña en texto"    = '(?i)password=[^&\s|"]+'
    "Hash de contraseña"     = 'pbkdf2-sha256:\d+:\S+'
}

# Muestra solo el inicio y el final de un valor encontrado
function Enmascarar([string]$valor) {
    if ($valor.Length -le 6) { return "***" }
    return $valor.Substring(0, 2) + "***" + $valor.Substring($valor.Length - 2)
}

$archivos = Get-ChildItem -Path $Carpeta -Recurse -File |
    Where-Object { $_.FullName -notmatch '[\\/]\.git[\\/]' -and
                   $_.FullName -ne $Salida -and
                   $_.Extension -notin ".png", ".jpg", ".jpeg", ".gif", ".pdf", ".key" }

$hallazgos = @()
foreach ($archivo in $archivos) {
    $relativo = [System.IO.Path]::GetRelativePath($Carpeta, $archivo.FullName)
    foreach ($tipo in $Patrones.Keys) {
        $coincidencias = Select-String -Path $archivo.FullName -Pattern $Patrones[$tipo] -AllMatches -CaseSensitive
        foreach ($c in $coincidencias) {
            foreach ($m in $c.Matches) {
                $hallazgos += [PSCustomObject][ordered]@{
                    archivo = $relativo
                    linea   = $c.LineNumber
                    tipo    = $tipo
                    valor   = Enmascarar $m.Value
                }
            }
        }
    }
}

# Resumen en pantalla: cuántos datos de cada tipo hay en cada archivo
Write-Host ""
Write-Host "Archivos revisados: $(@($archivos).Count)   Coincidencias: $($hallazgos.Count)" -ForegroundColor Cyan
$hallazgos | Group-Object archivo, tipo | Sort-Object Name |
    Select-Object @{ n = "Archivo y tipo de dato"; e = { $_.Name } }, @{ n = "Coincidencias"; e = { $_.Count } } |
    Format-Table -AutoSize | Out-Host

$hallazgos | Export-Csv -Path $Salida -NoTypeInformation -Encoding UTF8
Write-Host "Detalle guardado en $Salida" -ForegroundColor Green