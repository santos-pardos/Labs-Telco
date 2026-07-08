# Lab 8 · LLMs para analizar reclamaciones y tickets

Paquete autónomo para ejecutar el laboratorio en un **SageMaker Notebook** (kernel Python 3).

## Contenido
- `Lab08_LLMs_Reclamaciones_Telco.ipynb`  ← abre y ejecuta este notebook de principio a fin.
- `telco_tickets_text_lab8.csv`  (120 tickets de texto libre)
- `mi_anotacion.csv`  (10 tickets anotados a mano para validar)

## Cómo ejecutarlo
1. Sube **todos** los ficherosa la misma carpeta de tu instancia de SageMaker Notebook
   (o a tu entorno Jupyter local).
2. Abre el `.ipynb` y ejecuta las celdas en orden (Run All).
3. La primera celda de código instala las dependencias necesarias: pandas (boto3 solo si activas Bedrock).

## Lectura de datos: local o S3
Por defecto el notebook lee los CSV **locales** (variable `RUTA = '.'`) para que funcione sin montar
nada. Si prefieres seguir el flujo original del lab con Amazon S3, sube los CSV a tu bucket y cambia
`RUTA` por tu prefijo, p. ej. `RUTA = 's3://<tu-bucket>/...'` (SageMaker lee de S3 de forma transparente
si el rol `LabRole` tiene permisos).

## Notas
- El notebook incluye todo el texto explicativo del laboratorio, los comentarios del código y las
  preguntas de reflexión, por lo que es autocontenido.
- Los datos son **sintéticos** pero diseñados para reproducir los patrones pedagógicos del caso TELCO.
- Recuerda **detener la instancia de Notebook (Stop)** al terminar para no consumir crédito de AWS Academy.
