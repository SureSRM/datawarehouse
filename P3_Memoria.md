---
title: P3 - Memoria
author:
  - Sergio Martín Segura
  - Samuel Salvatella Pérez
documentclass: scrartcl
toc: true
toc-title: true
toc-depth: 2
---

# Instrucciones

## Pre requisitos

- make
- python == 3.6
- pipenv

## Instalación

El entorno se ha configurado con pipenv y make de modo que la instalación se realizará con:

```
make init-p2
```

Esto iniciará pipenv e instalará todas las librerías necesarias con las versiones correctas.

**NOTA:** Si la instalación de `surprise` lanzara un error, comprobar que se tienen instaladas las cabeceras de compilación de python 3.6 `sudo apt-get install python3-dev`.

## Notebook

Para ejecutar Jupyter Notebook basta con ejecutar: `make notebook`

Esto iniciará el servidor de Jupyter y abrirá una ventana en el navegador con el token de sesión adecuado.

Una vez abierto el portal, se podrá acceder al notebook `Recomendador.ipynb`.

El notebook está preparado para funcionar si se lanzan todas sus celdas en orden secuencial. No obstante, los tiempos de entrenamiento de alguno de los algoritmos son altos.

# Diseño

El objetivo de este proyecto ha sido comparar los diversos algoritmos de recomendación de `surprise`. Ésta es una suite que implementa varios conocidos algoritmos de recomendación y facilita su uso.

Se ha implementado una función _helper_ para minimizar la duplicación de código. Esta función, entrena (_fit_) el recomendador utilizando particionado _k-fold_ dado un algoritmo seleccionado, escribe los resultados del entrenamiento por pantalla y predice la nota que el usuario `1` daría a la película `2`.

# Algoritmos

Los algoritmos están clasificados en tres tipos:

- Básicos: no muy útiles para su explotación. Sirven de línea base para comparar con otros
- Basados en KNN: Filtrado colaborativo basado en K Nearest Neighbors.
- Matriciales: Algoritmos basados en la factorización matricial.
- Otros: En estos están incluídos el SlopeOne y el CoClustering

## Básicos

El algoritmo **Normal Predictor** realiza una predicción aleatoria basada en la distribución del dataset asumiendo que sigue una distribución gausiana.
Sus resultados son muy pobres, como caría esperar, pero sirve de linea base.

| RMSE   | MAE    | Fit Time | Test Time |
| ------ | ------ | -------- | --------- |
| 1.4214 | 1.1351 | 0.11     | 0.15      |

El algoritmo **Baseline Only** se calcula respecto a la esperanza estadística ajustanda con dos sesgos: uno para el usuario y otro para el item. Sus resultados son igualmente pobres, como caría esperar, pero sirve también de linea base.

| RMSE   | MAE    | Fit Time | Test Time |
| ------ | ------ | -------- | --------- |
| 0.8724 | 0.6728 | 0.22     | 0.13      |

## Basados en KNN

El algoritmo **KNN básico** usado para calcular los vecinos cercanos y aplicar un filtrado colaborativo.

| RMSE   | MAE    | Fit Time | Test Time |
| ------ | ------ | -------- | --------- |
| 0.9459 | 0.7251 | 0.12     | 1.27      |

El algoritmo **KNN con media** tiene en cuenta, además, la nota media de cada usuario.

| RMSE   | MAE    | Fit Time | Test Time |
| ------ | ------ | -------- | --------- |
| 0.8955 | 0.6845 | 0.13     | 1.34      |

El algoritmo **KNN con z-score** tiene en cuenta, además, la normalización z-score de cada usuario.
El z-score es, básicamente, la normalización y estandarización de los valores haciendo así que su medida sea independiente de su unidad.

| RMSE   | MAE    | Fit Time | Test Time |
| ------ | ------ | -------- | --------- |
| 0.8952 | 0.6795 | 0.18     | 1.56      |

El algoritmo **KNN con baseline** tiene en cuenta, además, el rating del baseline.

| RMSE   | MAE    | Fit Time | Test Time |
| ------ | ------ | -------- | --------- |
| 0.8736 | 0.6679 | 0.32     | 1.71      |

## Matriciales

El famoso algoritmo **SVD** (Single Value Decomposition), que es un método matricial que descompone la matriz de votos original en tres matrices (U, S y V) siendo S una matriz diagonal donde sus valores no nulos son valores singulares.

| RMSE   | MAE    | Fit Time | Test Time |
| ------ | ------ | -------- | --------- |
| 0.8732 | 0.6713 | 4.02     | 0.16      |

El **SVD++** es, en teoría una extensión dle algoritmo anterior que tiene en cuenta, además, votos implícitos. No obstante no se ha podido probar al no concluir en un tiempo de ejecución razonable.

| RMSE | MAE | Fit Time | Test Time |
| ---- | --- | -------- | --------- |
| Non  | Non | Non      | Non       |

El algoritmo **NMF** (Non-negative Matrix Factorization), que es un método similar al SVD pero sin el uso de sesgos.

| RMSE   | MAE    | Fit Time | Test Time |
| ------ | ------ | -------- | --------- |
| 0.9211 | 0.7050 | 4.72     | 0.16      |

## Otros

El **Slope One** implementa el algoritmo homónimo.

| RMSE   | MAE    | Fit Time | Test Time |
| ------ | ------ | -------- | --------- |
| 0.9007 | 0.6880 | 3.85     | 5.90      |

El **Co Clustering**, que se basa en el cálculo de clusters y co-clusters. Un co-cluster es un cluster que contempla la naturaleza combinada de dos o más elementos (dualidad usuario-item) mientras un cluster normal considera sólo las propiedades intrínsecas de uno de ellos.

| RMSE   | MAE    | Fit Time | Test Time |
| ------ | ------ | -------- | --------- |
| 0.9405 | 0.7284 | 1.77     | 0.12      |
