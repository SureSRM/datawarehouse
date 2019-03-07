# P1 - Memoria

| Sergio Martín Segura    | 622612 |
| -----------------------:| ------ |
| Samuel Salvatella Pérez | 680350 |

## Instrucciones

### Instalación y arranque

Descargar la herramienta `DBDap.jar` desde [este enlace](http://webdiis.unizar.es/~silarri/TEACHING/TOOLS/DBDap-web.zip) y colocarla junto con el resto de sus directorios en la raíz del proyecto.

Poner en marcha la herramienta con:

```
sh runApp.sh
```

### Cargar los modelos

Desde la opción `Abrir`, cargar uno de los dos modelos propuestos: `modeloA.eee` o `modeloB.eee`.

### Exportar

El icono ![SQL Menu Icon](/home/sure/Github/datawarehouse/iconos/menus/sql.gif) permite exportar el modelo a un script ejecutable en dos dialectos: Oracle y MySQL.

**WARN:** Se ha detectado que la opción de exportación a MySQL completa el campo de longitud de cadena de texto con valor negativo: `VARCHAR(-1)`. Por ello se ha de editar el script para adjudicar a las columnas un tamaño adecuado.

## Diseño

Hemos optado por contrastar dos diseños alternativos donde poder estudiar sus principales puntos fuertes y débiles.

### Diseño A: Una tabla de hechos

La primera aproximación realizada del diseño del *data mart* en el contexto de películas de cine consiste en:

![Diseño A](/esquemaA.jpg)

**Dimensiones**

Dimensiones de `Fecha` y `Hora` con las que gestionar la temporalidad. La fecha cuenta con atributos como el día, mes, año, y otros de utilidad de cara al usuario como `esFestivo`.

Dimensiones de `Película` y `Productora` donde registrar cada película y empresa productora. Las películas cuentan con un título y una referencia a `Fecha` para especificar la fecha de lanzamiento. Las productoras tienen un atributo nombre.

Uno de los requisitos es poder consultar las películas más votaras en función de los actores participantes. Aquí es donde esta la principal dificultad para el diseño. Cada película tiene asociada una lista agregada de actores que participan en ella. Esto en el diseño se ha gestionado añadiendo una *table-bridge* llamada `Participa` que une la dimensión `Actor` con películas en una relación N-N. Para facilitar la navegación del usuario entre las dimensiones de `Película` y `Actor`, se ha añadido una tabla `Cast` que relaciona `Película` con un casting concreto de actores de la tabla `Participa`.

**Hechos**

El grano escogido para este contexto determinado es el de un voto. Un usuario realiza un `Voto` en un instante concreto a una película de una productora con una calificación en concreto. Este es el grano más fino posible en el contexto. De esta forma, la única métrica que tendremos será la calificación de las películas.

La mayor desventaja de este diseño es que no se trata de un diseño *puro* en estrella y tienda a ser lo que se conoce como un copo de nieve. El requisito de registrar los actores que participan en cada película hace que sea necesario utilizar tablas extras.

La ventaja de este diseño es que cumple con los requisitos necesarios para el usuario correctamente.

### Diseño B: Dos tablas de hechos

La otra aproximación al problema ha sido la siguiente:

![Diseño B](/esquemaB.jpg)

**Dimensiones**

Las dimensiones de temporalidad `Fecha` y `Hora` se mantienen igual que en el anterior diseño.

La dimensión de `Productora` se mantiene también igual.

Las dimensiones `Actor` y `Película` en este diseño se relacionan con la tabla de hechos `Actua`.

**Hechos**

Para este diseño, el grano escogido también ha sido el de un voto de la misma forma que se ha hecho en el diseño A.

Esta vez, se ha añadido otra tabla de hechos en donde se registra la participación de un actor en una película. De esta forma, se utiliza en el diseño otro *data mart* relacionado con el contexto de las actuaciones de un actor en una película mediante la tabla de hechos `Actua`. La tabla de hechos `Actua` contiene la métrica de `minutosEnPantalla`.

La mayor desventaja de este diseño es que junta dos procesos distintos de negocio, por un lado las actuaciones de los actores, y por otro los votos de los usuarios, con lo que puede no estar muy acotada la dimensión del contexto.

La ventaja es que permite la posibilidad de añadir más información relacionada con los papeles de los actores en las películas. Por ejemplo, saber que tipo de papel es el más común en un actor. O los papeles más comunes en la industria, etc...

## Conclusiones

Una vez especificados estos dos diseños, vemos que no existe una solución única e ideal. En los siguientes pasos del trabajo habrá que ver las fuentes de datos que hay disponibles y a que diseño se pueden adaptar mejor y si hay que realizar cambios en él. También habrá que, ver especificando las consultas que el usuario requiere hacer, con que diseño se pueden obtener mejor rendimiento. En definitiva, hay deberemos de hacer un balance entre el potencial expresivo del diseño y los requerimientos de rendimiento y de usuario.