;------------------------------------------------------------------------------
; Programa que calcula la potencia de un número.
; Este programa eleva un número (num1) a una potencia (num2) y almacena 
; el resultado en num3. Utiliza multiplicación repetida y un bucle decreciente.
;------------------------------------------------------------------------------

name "potencia"          ; Nombre del programa (máximo 8 caracteres para DOS)
org 100h                 ; Indica la dirección de inicio del código en modo real (100h)

;------------------------------------------------------------------------------
; Inicio del programa
;------------------------------------------------------------------------------
start:
    mov cx, num2         ; Carga en CX el exponente (num2). CX actuará como contador
                         ; de cuántas veces se debe multiplicar el número base.
    
    mov ax, num1         ; Carga el número base (num1) en AX.
                         ; Este es el número que se va a elevar a la potencia.

;------------------------------------------------------------------------------
; Bucle de cálculo de la potencia
;------------------------------------------------------------------------------
inicio:
    mov bx, num1         ; Carga el número base (num1) en BX. Este valor se usará para 
                         ; multiplicar AX (que contiene el resultado acumulado).

    mul bx               ; Multiplica AX por BX. El resultado se guarda en AX.
                         ; AX = AX * BX. La multiplicación es entre registros de 16 bits.

    loop inicio          ; Decrementa CX y si no es 0, repite el bucle.
                         ; Cada iteración multiplica el resultado acumulado (AX)
                         ; por el número base hasta que CX llegue a 0.

;------------------------------------------------------------------------------
; Almacenar el resultado final
;------------------------------------------------------------------------------
    mov num3, ax         ; Almacena el resultado final de la potencia en num3.
                         ; El valor en AX, que es el resultado de todas las multiplicaciones,
                         ; se guarda en la variable num3.

;------------------------------------------------------------------------------
; Fin del programa
;------------------------------------------------------------------------------
    ret                  ; Termina el programa y retorna al sistema operativo.

;------------------------------------------------------------------------------
; Definición de las variables
;------------------------------------------------------------------------------
num1 dw 0Ah              ; Definimos el número base (10 decimal o 0Ah en hexadecimal).
num2 dw 03h              ; Definimos el exponente (3 decimal). Elevamos 10^3.
num3 dw 0h               ; Espacio reservado para almacenar el resultado.
