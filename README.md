# Jimmy Aumentado

Este proyecto se basa en el soft processor [Jimmy](https://github.com/kuashio/jimmy) creado para el curso de Lenguajes de Descripcion de Hardware 2022.

Jimmy es un soft processor implementado en verilog con propósitos didácticos. Deliberadamente no se han implementado todas las instrucciones definidas en su set de instrucciones. 

En este proyecto se ha aumentado a Jimmy con cinco nuevas instrucciones:

- `INC`
- `DIV` con direccionamiento inmediato
- `LDR` y `STR` con direccionamiento indirecto
- `CMP` con direccionamiento de registro.

Estas instrucciones le permitirán al procesador hacer uso de la memoria RAM integrada y ejecutar el calculo de promedios y una implementacion del algoritmo de ordenamiento burbuja.

En las siguientes secciones se describe el set de instrucciones de Jimmy y se menciona las instrucciones que han sido agregadas. Luego se describe brevemente la maquina de estados del procesador y como es su funcionamiento básico. Finalmente se describen tres programas creados en verilog para Jimmy que han sido simulados utilizando EDAPlayground. Estos programas hacen uso relevante de las instrucciones agregadas a Jimmy.

# ROM, Programas, y Simulacion

A continuación se muestra tres programas implementados. Cada uno mas complejo que el anterior. Cada programa se muestra con su código en ensamblador genérico y su equivalente en instrucciones de Jimmy. Así también un análisis de la simulación mediante el gráfico de onda en EDAPlayground.

## Programa 1 - Calculo de promedio de valores inmediatos

Para este programa se introduce a Jimmy las instrucciones `INC` y `DIV` con direccionamiento inmediato.

El programa toma uno por uno 10 números de un puerto de entrada y los suma conforme son tomados. Finalmente se divide la suma para realizar el promedio y se devuelve el resultado. 

El programa en EDA Playground: [Programa Promedio de valores inmediato](https://www.edaplayground.com/x/Fk54)


## Programa 2 - Calculo de promedio de valores en memoria

Para este programa se introduce a Jimmy las instrucciones:

- `INC`
- `DIV` con direccionamiento inmediato
- `LDR` y `STR`, ambas con direccionamiento indirecto. 

El programa toma uno por uno 10 números de un puerto de entrada y los almacena en memoria. Luego realiza la suma de los 10 numeros y divide la suma para realizar el promedio. Finalmente se devuelve el resultado. 

El programa en EDA Playground: [Programa Promedio de valores en memoria](https://www.edaplayground.com/x/ngbf)

## Programa 3 - Ordenamiento burbuja

Para este programa se introduce a Jimmy las instrucciones:

- `INC`
- `LDR` y `STR`, ambas con direccionamiento indirecto.
- `CMP` con direccionamiento de registro. 

El programa toma de un puerto de entrada 10 numeros y los almacena en memoria. Luego ordena los números ascendentemente (el menor en la posición mas baja de memoria) con el algoritmo de ordenamiento burbuja. Finalmente devuelve por un puerto de salida los 10 números de menor a mayor.

El programa en EDA Playground: [Programa Ordenamiento Burbuja](https://www.edaplayground.com/x/LESk)
