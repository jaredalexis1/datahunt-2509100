# Hallazgos y controles

| Hallazgo | Descripción | Escenario | Control | Tag | Antes | Después | Estado |
|---|---|---|---|---|---|---|---|
| H-01 | Contraseñas en texto plano | ESC-__ | C-__ Hash PBKDF2-SHA256 con sal | `fase-7` | ![](evidencias/H-01.png) | ![](evidencias/H-01-despues.png) | Corregido |
| H-02 | `/admin` sin autenticación | ESC-__ | C-__ Sesión, rol y enmascaramiento | `fase-8` | ![](evidencias/H-02.png) | ![](evidencias/H-02-despues.png) | Corregido |
| H-03 | Datos personales en consola | ESC-__ | C-__ Consola sin datos personales | `fase-7` | ![](evidencias/H-03.png) | ![](evidencias/H-03-despues.png) | Corregido |
| H-04 | Formulario por HTTP | ESC-__ | C-__ [HTTPS con proxy / riesgo aceptado] | — | ![](evidencias/H-04.png) | | [Mitigado / Aceptado] |
| H-05 | Recolección automática no declarada | ESC-__ | C-__ Minimización y aviso | `fase-6` | ![](evidencias/H-05.png) | | Corregido |
| H-06 | CSV sin cifrar | ESC-__ | C-__ ChaCha20-Poly1305 y SHA-256 | `fase-9` | ![](evidencias/H-01.png) | ![](evidencias/H-06-despues.png) | Mitigado parcialmente |
| H-07 | Sin aviso ni consentimiento | ESC-__ | C-__ Aviso y consentimiento | `fase-6` | ![](evidencias/H-07.png) | | Corregido |

## Decisión sobre H-04

[Opción elegida, justificación, quién la aprobó y qué control compensatorio se aplica.]

## Riesgo residual

- El archivo de trabajo `users.csv` sigue sin cifrar mientras la app funciona; se protege con los permisos del servidor (Reto 2).
- [Otros riesgos que siguen abiertos.]