# Lab 3 · Formulación de casos de IA en una operadora

Primera práctica que se asoma a la IA (Tema 3), pero **sin entrenar todavía**. El objetivo, anterior y más
importante, es **formular bien los casos de IA**: distinguir una necesidad de negocio de un problema de IA,
definir tipo de problema, variable objetivo, datos, métrica de éxito y riesgos, y **priorizar** una cartera
de casos. Opcionalmente, un primer prototipo no-code de churn en SageMaker Canvas.

**Entorno:** AWS Academy Learner Lab · **Servicios:** Amazon S3 · Amazon Athena · Amazon SageMaker Canvas
**Duración:** 150-180 min · **Nivel:** inicial-intermedio

## Contenido de la carpeta
- `Lab_03_Formulacion_IA_Telco_AWS_Academy.pdf`  ← enunciado completo del laboratorio.
- `README.md`  ← este fichero.
- `telco_ai_cases_lab3.csv`  (800 filas) — tabla de clientes **heredera de `customer_360`** (Lab 2),
  enriquecida con variables objetivo (`churn`, `high_priority_ticket`, `network_anomaly`), métricas de
  servicio (interrupciones, tickets, reclamaciones, resolución, satisfacción) y el **texto del último ticket**
  (`last_ticket_text`). Es la tabla para explorar en Athena y formular los casos.
- `telco_churn_canvas_data_sin_satisfaction.csv`  (800 filas) — dataset preparado para **SageMaker Canvas**
  con la variable `churn` y `speed_gap`. Excluye `satisfaction_score` a propósito (ver notas).

## Cómo realizar el laboratorio
1. **Start Lab** y abre la consola en **us-east-1**.
2. **Amazon S3 + Athena:** sube `telco_ai_cases_lab3.csv`, catalógalo y **explóralo** con SQL (distribución de
   churn por región/contrato, relación con interrupciones, tickets, etc.).
3. **Formula cinco casos de IA** distintos. Para cada uno: tipo de problema (clasificación, regresión,
   clustering, detección de anomalías, NLP), variable objetivo, datos de entrada, métrica de éxito y riesgos.
4. **Prioriza** los casos con una matriz (impacto × viabilidad × riesgo).
5. *(Opcional)* **SageMaker Canvas:** importa `telco_churn_canvas_data_sin_satisfaction.csv`, construye un
   modelo de predicción de `churn` y recorre el ciclo completo (no para el mejor modelo, sino para discutir
   sus límites).

## Notas
- **Por qué el dataset de Canvas excluye `satisfaction_score`:** esa variable se mide *después* de que ocurra
  el abandono, así que incluirla provocaría **fuga de información** (el modelo "haría trampa"). Es un punto de
  reflexión del laboratorio.
- **SageMaker Canvas en AWS Academy:** la predicción **por lotes (Batch)** funciona; la predicción **individual
  (Single)** suele dar error. Usa Batch.
- La formulación y priorización de casos preparan el **Lab 4** (entrenamiento a fondo del churn).
- Detén/elimina el modelo y la sesión de Canvas al terminar, vacía el bucket y pulsa **End Lab**.
