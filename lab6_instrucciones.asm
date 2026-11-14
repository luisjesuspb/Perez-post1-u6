; lab6_instrucciones.asm ? Demostracion de categorias de instrucciones x86
; Compilar: nasm -f bin lab6_instrucciones.asm -o lab6_instrucciones.com

org  100h                  ; offset de inicio para archivos .COM

; ?? Datos ????????????????????????????????????????????????????????????????
jmp  inicio                ; saltar sobre los datos al codigo

valor_a   dw  45           ; primer operando (002Dh)
valor_b   dw  12           ; segundo operando (000Ch)
resultado dw  0            ; almacena resultado
contador  db  5            ; contador de bucle
mascara   db  0Fh          ; mascara de 4 bits bajos

; ?? Codigo ???????????????????????????????????????????????????????????????
inicio:

; ?? BLOQUE 1: Transferencia de datos ?????????????????????????????????????
    MOV  ax, [valor_a]     ; AX = 45 (002Dh)
    MOV  bx, [valor_b]     ; BX = 12 (000Ch)
    MOV  cx, ax            ; CX = 45
    MOV  dx, bx            ; DX = 12

    LEA  si, [valor_a]     ; SI = direccion de valor_a
    MOV  ax, [si]          ; AX = mem[SI] = 45

    XCHG cx, dx            ; CX=12, DX=45
    XCHG cx, dx            ; restaurar: CX=45, DX=12

    PUSH ax                ; guarda AX=45 en pila
    MOV  ax, 0FFFFh        ; modifica AX temporalmente
    POP  ax                ; restaura AX=45

; ?? BLOQUE 2: Operaciones aritmeticas ????????????????????????????????????
    MOV  ax, [valor_a]     ; AX = 45
    ADD  ax, [valor_b]     ; AX = 45 + 12 = 57 (0039h)
    MOV  [resultado], ax   ; guarda 57 en memoria

    MOV  ax, [valor_b]     ; AX = 12
    SUB  ax, [valor_a]     ; AX = 12 - 45 = -33 (FFDFh)

    MOV  ax, [valor_a]     ; AX = 45
    INC  ax                ; AX = 46
    DEC  ax                ; AX = 45

    MOV  al, 10            ; AL = 10
    MOV  bl, 7             ; BL = 7
    MUL  bl                ; AX = 70 (0046h)

    MOV  ax, 100           ; AX = 100
    MOV  bl, 7             ; BL = 7
    DIV  bl                ; AL = 14 (0Eh), AH = 2 (02h)

; ?? BLOQUE 3: Operaciones logicas ????????????????????????????????????????
    MOV  al, 0B7h          ; AL = 1011 0111b
    AND  al, [mascara]     ; AL = 0B7h AND 0Fh = 07h

    MOV  al, 0B7h
    OR   al, 0F0h          ; AL = 0B7h OR F0h = F7h

    MOV  al, 0AAh
    XOR  al, 0FFh          ; AL = 55h
    XOR  bx, bx            ; BX = 0

    MOV  al, 0B7h
    TEST al, 01h           ; ZF=0 (bit 0 = 1), AL sigue siendo B7h

    MOV  al, 08h           ; AL = 8
    SHL  al, 2             ; AL = 32 (20h)
    SHR  al, 1             ; AL = 16 (10h)

; ?? BLOQUE 4: Control de flujo ???????????????????????????????????????????
    MOV  ax, [valor_a]     ; AX = 45
    CMP  ax, [valor_b]     ; 45 - 12 = 33 > 0
    JG   .mayor
    JE   .igual
    XOR  cx, cx
    JMP  .fin_cmp
.mayor:
    MOV  cx, 1             ; CX = 1 (valor_a > valor_b)
    JMP  .fin_cmp
.igual:
    MOV  cx, 2
.fin_cmp:

    ; Bucle: suma acumulada de 1 a 5 (resultado esperado: 15 = 000Fh)
    XOR  ax, ax            ; AX = 0 (acumulador)
    MOV  cx, 5             ; CX = contador
    MOV  bx, 1             ; BX = valor a sumar
.bucle_suma:
    ADD  ax, bx            ; AX += BX
    INC  bx                ; BX++
    LOOP .bucle_suma       ; Al terminar: AX = 15 (000Fh)

    ; Fin del programa
    INT  20h               ; retornar a DOS
