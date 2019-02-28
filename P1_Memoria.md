# P1 - Memoria

| Sergio Martín Segura | 622612 |
| -------------------: | ------ |
|               Samuel |        |

## Instrucciones

### Instalación y arranque

Descargar la herramienta `DBDap.jar` desde [Moodle](https://moodle2.unizar.es) y colocarla junto con el resto de sus directorios en la raíz del proyecto.

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

### Diseño B: Dos tablas de hechos

## Conclusiones