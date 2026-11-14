# Perez-post1-u6
@'
# Laboratorio Unidad 6: Programación en Lenguaje Ensamblador x86 (16 bits)

Repositorio correspondiente a la práctica de **Arquitectura de Computadores**, enfocada en el uso de instrucciones básicas, control de flujo, modos de direccionamiento y depuración a nivel de registros en arquitectura x86 (modo real DOS).

---

## Estructura del Repositorio

* `lab6_instrucciones.asm`: **Parte 1** — Transferencia de datos (`MOV`, `XCHG`, `LEA`, `PUSH`/`POP`), operaciones aritméticas y lógicas (`ADD`, `SUB`, `INC`, `DEC`, `AND`, `OR`, `XOR`, `SHL`, `SHR`), comparaciones (`CMP`), saltos condicionales/incondicionales (`JG`, `JZ`, `JMP`) y bucle de suma acumulada con `LOOP` ($\sum_{i=1}^{5} i = 15 = \text{000Fh}$).
* `lab6_modos.asm`: **Parte 2** — Demostración de modos de direccionamiento (inmediato, registro, directo, indirecto por registro `[BX]`, indexado `[SI + offset]`, basado-indexado `[BX + SI]`) y cálculo iterativo del factorial de un número mediante `MUL` y `LOOP` ($5! = 120 = \text{0078h}$).
* `evidencias/`: Capturas de pantalla del proceso de ensamblado con NASM y trazado de registros/banderas en `DEBUG.COM` bajo DOSBox.
* `.gitignore`: Excluye ejecutables binarios (`.exe`, `.com`) del control de versiones.

---

## Herramientas Utilizadas

* **Ensamblador:** NASM (`nasm.exe` - Netwide Assembler, formato binario plano `-f bin`).
* **Emulador y Depurador:** DOSBox 0.74-3 y `DEBUG.COM`.
* **Control de Versiones:** Git y GitHub.

---

## Compilación y Ejecución

### 1. Ensamblado (PowerShell)
```powershell
.\nasm.exe -f bin lab6_instrucciones.asm -o lab6_instrucciones.com
.\nasm.exe -f bin lab6_modos.asm -o lab6_modos.com
2. Depuración y Verificación (DOSBox)Debido a la convención de nombres cortos 8.3 de DOS, los archivos compilados se cargan en DEBUG de la siguiente manera:Parte 1 (LAB6_I~2.COM):DOSdebug LAB6_I~2.COM
G 186
Resultado esperado en registros: AX=000F (suma acumulada de 1 a 5).Parte 2 (LAB6_M~2.COM):DOSdebug LAB6_M~2.COM
G 13E
Resultado esperado en registros: AX=0078 ($5! = 120_{10} = 78_{16}$).
