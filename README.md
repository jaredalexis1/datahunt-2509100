# Data Hunt

App de recolección de datos del proyecto integrador de Protección de Datos.

- **Alumno:** [Jared Alexis Jacinto Hernandez] · **Matrícula:** [2509100]
- **Organización del caso:** [Hospitals] · **Servicio:** [TI]

> Todos los datos de este proyecto son ficticios.

## Requisitos

- Windows con PowerShell 7 (`pwsh`)
- Soporte de ChaCha20-Poly1305 en el sistema operativo

## Cómo ejecutarla

```powershell
.\herramientas\crear-empleado.ps1 -Rol admin   # crea la cuenta de administración
.\app.ps1                                     # abre http://localhost:5000
```

## Herramientas

| Script | Uso |
|---|---|
| `herramientas\listener.ps1` | Muestra la petición HTTP cruda |
| `herramientas\protect.ps1` | Cifra los CSV y calcula su SHA-256 |
| `herramientas\verify.ps1` | Verifica la integridad de los archivos cifrados |
| `herramientas\unprotect.ps1` | Descifra un archivo para comprobarlo |
| `herramientas\schema.ps1` | Extrae el esquema de los CSV |
| `herramientas\discover.ps1` | Busca datos personales por patrones |

## Documentación

- [Diseño de campos](docs/campos.md)
- [Línea base](docs/linea-base.md)
- [Hallazgos y controles](docs/hallazgos.md)
- [Flujo de datos](docs/flujo-datos.md)
- [Diccionario de datos](docs/diccionario.csv) · [Inventario](docs/inventario.csv)

## Versiones

| Tag | Contenido |
|---|---|
| `fase-4` | Línea base con los hallazgos H-01 a H-07 |
| `fase-6` | Aviso de privacidad y consentimiento |
| `fase-7` | Hash de contraseñas y consola limpia |
| `fase-8` | Control de acceso a `/admin` |
| `fase-9` | Cifrado en reposo e integridad |
| `v1.0` | Versión final |