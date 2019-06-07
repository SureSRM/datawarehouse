---
title: P5 - Memoria
author:
  - Sergio Martín Segura
  - Samuel Salvatella Pérez
documentclass: scrartcl
toc: true
toc-title: true
toc-depth: 2
---

# Introducción

En la siguiente práctica se han aplicados los conceptos de visualización estudiados en clase para diseñar e implementar un _dashboard_ en Power BI que permita visualizar de forma clara y efectiva los datos del almacén de datos implementado anteriormente.

El resultado final del _dashboard_ puede consultarse en el siguiente enlace:

[Dashboard - Práctica 5](https://app.powerbi.com/view?r=eyJrIjoiZWUzNWEwZTUtMGRjZC00MTI0LTllZWMtNjQ0ZWEyZWU5NjgxIiwidCI6IjNmMjI3ZGJhLWYzZjQtNDU0NC1iMzE0LWM2ZWZkMzBlMGQwMCIsImMiOjh9)

# Diseño

El **mapa intuitivo** seguido para el diseño del panel de control se ha hecho centrándolo en el contexto de un usuario que quiere obtener información sobre las películas de la fuente de datos. Concretamente, se ha puesto énfasis en el año de lanzamiento, el género y la nota de cada película. La escala y el atributo gráfico se han escogido en base a estas tres dimensiones de una película.

El número de votos se ha asociado con magnitudes gráficas (barras), la nota media con una escala de colores, los géneros se han asignado a categorías y los años de lanzamiento como categorías temporales (eje X).

Los **métodos** escogidos para interactuar con la vista son el control del rango de los datos en el tiempo, la selección para obtener más detalles (_drill down_) y la búsqueda de películas por texto.

# Principios

Para la implementación del _dashboard_ se han seguido los principios de **Tufte**.

Se ha respetado la integridad gráfica. Los datos del mismo tipo se han representado siempre con las mismas etiquetas y características como el color. Las cantidad siempre se han representado de forma proporcional a la magnitud. No se deduce ningún tipo de conclusión errónea con el diseño realizado. La gran parte de la "tinta" de los gráficos son para representar datos. Se ha apostado por la simplicidad gráfica utilizando diseños de gráficos lo más minimalistas posibles y sencillos.
También se ha hecho uso de los principios de **William**.

Se ha aplicado un contraste claro en el diseño de los gráficos para mostrar información distinta. Por ejemplo, el recuento del número de votos se muestra siempre con el color gris a lo largo del informe, pero la suma de los valores de los votos se ha utilizado un color distinto y contrastado como el violeta para no dar lugar a confusión y que este claro que se trata información distinta.

El principio de repetición se ha respetado en el diseño. Por ejemplo, los géneros de las películas se representan con los mismos colores a lo largo de los distintos gráficos. También se han respetado los colores de las magnitudes.

El principio de alineación se ha seguido también construyendo el _dashboard_ colocando cada elemento siempre relacionándolo con el resto de elementos, mostrando la información ordenada y acorde a la finalidad del usuario.
