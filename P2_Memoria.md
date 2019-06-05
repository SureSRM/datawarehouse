# P1 - Memoria

| Sergio Martín Segura    | 622612 |
| -----------------------:| ------ |
| Samuel Salvatella Pérez | 680350 |

## Instrucciones

### Pre requisitos

- make
- python == 3.6
- pipenv

### Instalación y arranque

El entorno se ha configurado con pipenv y make de modo que la instalación se realizará con:

```
make
make data
```

Esto iniciará pipenv e instalará todas las librerías necesarias con las versiones correctas

### Notebook

Para ejecutar Jupyter Notebook basta con ejecutar: `make notebook`

Esto iniciará el servidor de Jupyter y abrirá una ventana en el navegador con el token de sesión adecuado.

Una vez abierto el portal, se podrá acceder al notebook `ETL.ipynb`.

El notebook está preparado para funcionar si se lanzan todas sus celdas en orden secuencial.

## Diseño

Las decisiones tecnológicas han tenido en cuenta la portabilida del proyecto y su sencillez didáctica por encima de su eficiencia o su grado de madurez frente a la producción.

Por ello:
- La base de datos escogida es SQLite, ya que tiene soporte nativo en python y simplifica la conexión y la portabilidad.
- No se ha usado un framework ETL. Se probó y se desechó Bonobo ya que éste efectuaba optimicaciones de threads que lo hacían incompatible con el modelo de concurrencia de SQLite.

De ese modo, el resultado es un ETL sencillo donde la carga de datos de _look up_ (para las dimensiones) se hace mediante DataFrames de Pandas y la carga de los datos principales (para los hechos) se hace mediante la lectura secuencial del fichero CSV. Esto permite aprovecharse del indexado de Pandas para los accesos arbitrarios y de la rapidez del lector de python para el acceso secuencial.

El ETL se puede analizar como un pipeline de 5 pasos:

- `extract()`
- `addDate()`
- `addHour()`
- `addFilm()`
- `load()`

Mas un paso cero que sería el set up donde se inicializa el esquema de la base de datos, se configura la conexión a IMDB, etc.

### extract

Lee el fichero CSV de forma secuencial, línea a línea, y emite diccionarios con los campos extraídos asignados a sus respectivas claves.

### addDate

Lee el timestamp e invoca a `getDate()` con él. `getDate` es una función que, dado un timestamp, devuelve un mapa con diversas representaciones de la fecha del timestamp: 'anyo', 'mes', 'dia', 'mes_texto'.

A continuación utiliza el resultado para buscar por sus valores en la dimensión `Fecha` si esa fecha ya ha sido insertada. Si ya existía, obtiene su `id` y si no, la inserta y obtiene su `id` igual.

Finalmente añade del `id` de la fecha al diccionario recibido y lo devuelve.

### addHour
Lee el timestamp e invoca a `gethour()` con él. `getHour` es una función que, dado un timestamp, devuelve un mapa con diversas representaciones de la hora del timestamp: hour', 'minute', 'second.

A continuación utiliza el resultado para buscar por sus valores en la dimensión `Hora` si esa fecha ya ha sido insertada. Si ya existía, obtiene su `id` y si no, la inserta y obtiene su `id` igual.

Finalmente añade del `id` de la hora al diccionario recibido y lo devuelve.

### addFilm

Lee el "`id` de _movie lens_" de la película para buscar por él en la dimensión `Pelicula` si esa pelicula ya ha sido insertada. Si ya existía, obtiene su "`id` artificial" y si no, invoca a `getFilm()` con él.

`getFilm` es una función que, dado un "`id` de _moovie lens_", obtiene el "`id` de _imdb_" y busca información sobre esa película en su API. Una vez recibe la información, devuelve un mapa con los campos interesantes sobre la película: 'title', 'year', 'genre', '\_movieId'.

Finalmente añade del "`id` artificial" de la película al diccionario recibido y lo devuelve.

### load

El último paso, inserta el hecho usando las claves ajenas que han sid agregadas al dicionario en etapas anteriores.

## Conclusiones

Las conclusiones de esta parte del proyecto continúan en la línea de las ideas que se tenían previamente con respecto a los ETL.

Por un lado, la importancia del escalado y el rendimiento. Dado que es crucial poder operar en el mínimo tiempo posible, soluciones no escalables están abocadas a la obsolescencia. Por ello, en parte, las herramientas modernas tratan de apuntar al procesamiento distribuído y escalable. En este caso, el proceso es extremadamente lento debido a la necesidad de hacer fetching de cada película nueva de IMDB. Una posible optimización sería acceder a los datos ya descargados si estuvieran disponibles en algún repositorio.

Por otro lado, la importancia del mantenimiento de los procesos y su usabilidad. Si se ha decidido usar una lenguaje de programación de propósito general como Python por encima de una herramienta gráfica, es porque estas últimas, tienden a restringir en execeso al desarrollador experimentado, imponen trabas al trabajo colaborativo, el control de versiones y la portabilidad (vendor lock-in).
