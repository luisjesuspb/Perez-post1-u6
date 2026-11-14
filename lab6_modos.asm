org 100h

section .text
    jmp inicio

; --- SECCION DE DATOS ---
numero      db 5            ; Numero para calcular el factorial (5! = 120 = 0078h)
resultado   dw 0            ; Aqui se guardara el resultado final
arreglo     dw 10h, 20h, 30h, 40h

inicio:
    ; =========================================================
    ; 1. MODOS DE DIRECCIONAMIENTO
    ; =========================================================
    
    ; Modo Inmediato: el dato viene en la instruccion
    mov ax, 0005h

    ; Modo Registro: transferencia entre registros internos
    mov bx, ax

    ; Modo Directo: acceso directo a una etiqueta/direccion de memoria
    mov cx, [arreglo]       ; Carga 0010h en CX

    ; Modo Indirecto por Registro: BX apunta a la direccion en memoria
    mov bx, arreglo
    mov dx, [bx]            ; Carga 0010h en DX

    ; Modo Indexado: registro indice + desplazamiento fijo
    mov si, 2               ; Desplazamiento de 2 bytes (segundo elemento)
    mov ax, [arreglo + si]  ; Carga 0020h en AX

    ; Modo Basado-Indexado: base (BX) + indice (SI)
    mov bx, arreglo
    mov si, 4               ; Tercer elemento (offset 4)
    mov dx, [bx + si]       ; Carga 0030h en DX

    ; =========================================================
    ; 2. CALCULO DE FACTORIAL (N!)
    ; =========================================================
    xor cx, cx
    mov cl, [numero]        ; CX = 5 (contador del bucle)
    mov ax, 1               ; AX = 1 (acumulador del factorial)
    mov bx, 1               ; BX = 1 (multiplicador actual)

bucle_factorial:
    mul bx                  ; AX = AX * BX (resultado de 16 bits en DX:AX)
    inc bx                  ; Siguiente numero (2, 3, 4, 5)
    loop bucle_factorial    ; Decrementa CX y repite hasta que CX = 0

    ; Guardar el resultado final (5! = 120 = 0078h) en memoria
    mov [resultado], ax

    ; Finalizar programa en DOS
    int 20h
