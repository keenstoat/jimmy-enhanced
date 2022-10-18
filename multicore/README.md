# Jimmy Multicore

Este proyecto implementa un sistema multiprocesador utilizando [Jimmy](https://github.com/kuashio/jimmy) en **Verilog**.

El directorio base (`multicore/`) es un proyecto de Quartus Prime para el FPGA `EP4CE115F29C8` implementado utilizando **LabsLand** en la tarjeta de desarrollo **DE2-115**.

El proyecto es configurable para 1, 2, 4, 8, y 16 procesadores. Solamente se necesita cambiar en `multicore/multicore.sv` el valor de `CORES` y de `CORE_FINISH_MASK` y volver a compilar y sintetizar.

```verilog

`define CORES 16 // change this to a power of 2: 1,2,4,8,16
`define MEM_PAGE_SIZE 256/`CORES
`define CORE_FINISH_MASK 16'b1111_1111_1111_1111 // change this to reflect a bit per number of cores
                                                 // E.g: 16'b0000_0000_1111_1111 is for 8 cores

module multicore(
    input CLOCK_50,
    input [17:17] SW,
    output [17:2] LEDR,
```

## Video explicativo

Un video explicativo del sistema se encuentra en el siguiente enlace: (Sistema multi-procesador en Verilog)[https://www.youtube.com/watch?v=Tjz8oyrRNAQ]