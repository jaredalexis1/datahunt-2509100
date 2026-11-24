# Flujo de datos de Data Hunt

```mermaid
flowchart LR
    A["Navegador del cliente"] -- "Tránsito: HTTP (H-04)" --> B["app.ps1"]
    B -- "Procesamiento" --> C["Consola sin datos personales"]
    B -- "Reposo" --> D[("datos/users.csv")]
    B -- "Reposo" --> E[("datos/access_log.csv")]
    F["Empleado admin o dpo"] -- "Sesión y rol" --> G["Página /admin enmascarada"]
    G --> B
    D -- "protect.ps1" --> H[("protegido/*.enc + .sha256")]
    E -- "protect.ps1" --> H
    H -- "Tránsito: SMB cifrado (Reto 2)" --> I["Carpeta del departamento"]
    H -- "Tránsito: AWS CLI (Reto 3)" --> J[("Bucket S3")]
    I -- "verify.ps1" --> K["Integridad comprobada"]
    J -- "verify.ps1" --> K
```

| Estado | Dónde | Control |
|---|---|---|
| Tránsito | Navegador → app | [HTTPS o riesgo aceptado] |
| Tránsito | Servidor → carpeta del departamento | SMB cifrado |
| Tránsito | Servidor → S3 | AWS CLI (TLS) |
| Reposo | `datos/`, `protegido/`, S3 | Permisos, ChaCha20-Poly1305, SHA-256 |
| Procesamiento | Consola, `/admin` | Consola sin datos, sesión, rol, enmascaramiento, bitácora |