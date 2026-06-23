# Lab 2 · Calidad y preparación de datos telco

Continuación directa del Lab 1 (Tema 2). En el Lab 1 cargamos las trazas y confiamos en que estaban limpias;
no lo estaban. Aquí el alumno aprende a **perfilar, limpiar e integrar** los datos de la operadora **antes**
de aplicar cualquier técnica de IA, produciendo una capa de datos preparada y fiable (la base del Lab 3).

**Entorno:** AWS Academy Learner Lab · **Servicios:** Amazon S3 · AWS Glue Data Catalog · Amazon Athena ·
AWS Glue DataBrew (opcional) · **Duración:** 150-180 min · **Nivel:** inicial-intermedio

## Contenido de la carpeta
- `Lab_02_Calidad_Datos_Telco_AWS_Academy.pdf`  ← enunciado completo del laboratorio.
- `README.md`  ← este fichero.
- Versiones **deliberadamente "sucias"** de los datasets (con nulos, duplicados, formatos inconsistentes,
  categorías mal escritas y valores imposibles), para descubrir y corregir problemas de calidad:
  - `customers_dirty.csv`  (520 filas) — clientes con duplicados e inconsistencias.
  - `tickets_dirty.csv`  (430 filas) — tickets con campos sucios y claves que no casan.
  - `network_metrics_dirty.csv`  (1038 filas) — métricas con valores ausentes e imposibles.
  - `complaints_dirty.csv`  (128 filas) — reclamaciones de texto con etiquetas inconsistentes.

## Cómo realizar el laboratorio
1. **Start Lab** y abre la consola en **us-east-1**.
2. **Amazon S3:** sube los CSV "dirty" a una capa de aterrizaje, p. ej. `s3://<tu-bucket>/raw_dirty/<dataset>/`.
3. **AWS Glue / Athena:** cataloga los datasets. Aquí es donde se introduce el **crawler de Glue**: cuando
   más adelante recatalogues la capa curada, el crawler infiere el esquema automáticamente (motivación honesta
   que en el Lab 1 no existía).
4. **Perfilado en Athena:** cuenta nulos, duplicados, valores distintos y rangos de cada columna para
   diagnosticar los problemas de calidad.
5. **Limpieza con SQL (CTAS):** corrige los problemas y escribe una **capa curada** en
   `s3://<tu-bucket>/curated/...`, integrando las tablas en una vista de cliente (`customer_360`).
6. *(Opcional)* **AWS Glue DataBrew:** realiza parte del perfilado y la limpieza sin escribir código.
7. Entregable: informe de calidad (problemas detectados, correcciones aplicadas y reglas propuestas).

## Notas
- La capa curada (`customer_360`) que produces aquí es la **entrada del Lab 3**.
- Recuerda la máxima *garbage in, garbage out*: un modelo sobre datos sucios aprende del ruido.
- Los datos son **sintéticos**, ensuciados a propósito con fines didácticos.
- Al terminar, limpia tablas/bases de Glue, vacía el bucket si no continúas y pulsa **End Lab**.
