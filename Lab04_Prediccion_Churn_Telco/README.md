# Lab 4 · Predicción de churn (abandono de clientes)

Continuación natural del Lab 3 (Tema 4). Aquí se **entrena el modelo a fondo**: se evalúa con rigor, se
comparan versiones, se ajusta el umbral de decisión, se interpreta qué variables pesan más y, finalmente, se
**aplica a una lista de clientes activos** para proponer una acción de retención concreta.

**Entorno:** AWS Academy Learner Lab · **Servicios:** Amazon S3 · Amazon Athena · SageMaker Canvas /
SageMaker Notebook · **Duración:** 180 min · **Nivel:** intermedio

## Contenido de la carpeta
- `Lab_04_Prediccion_Churn_Telco_AWS_Academy.pdf`  ← enunciado completo del laboratorio.
- `README.md`  ← este fichero.
- `telco_churn_train.csv`  (900 filas) — datos de **entrenamiento/validación**; incluye la etiqueta `churn`.
- `telco_churn_score.csv`  (150 filas) — clientes **activos a puntuar** (sin `churn`): sobre ellos se aplica
  el modelo entrenado para proponer retención.

## Dos caminos equivalentes
- **Camino A · SageMaker Canvas (no-code):** ideal para entender el ciclo sin escribir código.
- **Camino B · SageMaker Notebook (Python + scikit-learn):** control total del proceso y experimentos que
  Canvas no facilita. Puedes recorrer uno o ambos; la evaluación y la aplicación son comunes.

## Cómo realizar el laboratorio
1. **Start Lab** y abre la consola en **us-east-1**.
2. **Amazon S3:** sube `telco_churn_train.csv` y `telco_churn_score.csv` a tu bucket.
3. **Entrena** por el camino elegido:
   - *Camino A:* importa el train en **Canvas**, construye el modelo, evalúa métricas y haz **Predict (Batch)**
     sobre el dataset de score.
   - *Camino B:* en un **Notebook**, carga los CSV con `pandas`, separa train/validación, entrena con
     `scikit-learn`, evalúa, ajusta el umbral, mira la importancia de variables y aplica el modelo al score.
4. **Evalúa e interpreta:** matriz de confusión, precisión/recall, umbral de decisión y variables más
   influyentes. Discute la **fuga de información**, el desequilibrio de clases y la diferencia entre predicción
   y causa.
5. **Aplica y recomienda:** sobre `telco_churn_score.csv`, identifica los clientes en riesgo y propón una
   acción de retención concreta.

## Notas
- **SageMaker Canvas en AWS Academy:** la predicción **por lotes (Batch)** funciona; la **individual (Single)**
  suele dar error. Usa Batch.
- En el **Camino B (Notebook)**, los CSV pueden leerse en **local** o desde **S3** (`s3://<tu-bucket>/...`);
  SageMaker lee de S3 con el rol `LabRole`.
- Este modelo de churn y sus predicciones se retoman conceptualmente en los Labs 5, 9 y 10 de la serie.
- Detén la instancia/sesión, **Stop**, vacía el bucket si no continúas y pulsa **End Lab**.
