# =====================================================================
# config.ps1 - Configuración de Data Hunt
# Adapta estos valores a la organización del caso de tu salón.
# =====================================================================
 
# Organización, servicio que presta la app y departamento dueño de los datos
$Organizacion = "Aeropuerto Internacional de Mérida"
$Servicio     = "Registro de pasajeros"
$Departamento = "Atención a pasajeros"
 
# Dirección y puerto donde escucha la app.
# "localhost" = solo tu computadora. En la Fase 11 se explica cómo publicarla en la red.
$Direccion = "localhost"
$Puerto    = 5000