;------------------------------------------------------------------------------
; Programa que muestra el uso de la instrucción AAA (ASCII Adjust after Addition)
; Esta instrucción convierte el contenido del registro AL en un número decimal
; ASCII desempaquetado después de una instrucción de suma. 
; Se utiliza cuando se trabaja con números decimales en formato ASCII, 
; asegurándose de que el resultado sea válido para representar un dígito decimal.
; Este programa suma varios números y ajusta el resultado con AAA.
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; Definición del segmento de pila
; Un segmento de pila es necesario para manejar las llamadas y 
; almacenamiento temporal. Aquí reservamos 40h (64 bytes) para la pila.
;------------------------------------------------------------------------------
PILA SEGMENT STACK
    db 40h dup(0)        ; Reserva 64 bytes inicializados a 0 para la pila
PILA ENDS

;------------------------------------------------------------------------------
; Definición del segmento de código
; Aquí definimos el segmento donde colocaremos las instrucciones del programa.
;------------------------------------------------------------------------------
CODE SEGMENT
    assume CS:CODE, SS:PILA  ; Asocia el segmento de código y el de pila

;------------------------------------------------------------------------------
; Inicio del programa
;------------------------------------------------------------------------------
START PROC
    ;--------------------------------------------------------------------------
    ; Inicializa el segmento de pila
    ;--------------------------------------------------------------------------
    mov ax, pila          ; Carga la dirección del segmento de pila en AX
    mov ss, ax            ; Mueve la dirección del segmento de pila a SS (Stack Segment)
    mov sp, 40h           ; Inicializa el puntero de pila (SP) al tope (40h)

    ;--------------------------------------------------------------------------
    ; Ejemplo 1: Suma de un número decimal ASCII
    ;--------------------------------------------------------------------------
    mov ax, 0008h         ; Carga el valor '8' en AL (representado como 08h en ASCII)
                          ; AH se inicializa a 00h (parte alta de AX)
    add al, 1             ; Suma 1 a AL ('8' + 1 = '9')
                          ; AL ahora contiene el valor 09h ('9' en ASCII)
    aaa                   ; Ajusta AL para asegurar que es un número ASCII válido
                          ; AAA ajusta el resultado si es necesario
    ; Ahora AX = 0009h, donde AL contiene '9' en formato ASCII

    ;--------------------------------------------------------------------------
    ; Ejemplo 2: Suma que provoca un ajuste
    ;--------------------------------------------------------------------------
    mov ax, 0008h         ; Carga '8' en AL
    add al, 2             ; Suma 2 a AL ('8' + 2 = 10 decimal)
                          ; El valor 10 (Ah en hexadecimal) no es válido como ASCII decimal
    aaa                   ; AAA ajusta el valor para mantener la coherencia con ASCII
                          ; Ahora AX = 0100h (AH=01, AL=00), que representa '10' en ASCII decimal
                          ; AL = '0' y AH = '1'

    ;--------------------------------------------------------------------------
    ; Ejemplo 3: Suma de otro número que requiere ajuste
    ;--------------------------------------------------------------------------
    mov ax, 0007h         ; Carga '7' en AL (07h en ASCII)
    add al, 7             ; Suma 7 a AL ('7' + '7' = 14 decimal)
                          ; AL contiene el valor 0Eh, que no es válido como ASCII decimal
    aaa                   ; AAA ajusta el valor: AH = 01, AL = 04
                          ; AX = 0105h (AL = '4', AH = '1')

    ;--------------------------------------------------------------------------
    ; Finalizar el programa
    ;--------------------------------------------------------------------------
    mov ax, 4C00h         ; Código de terminación para DOS
    int 21h               ; Interrupción de DOS para terminar el programa

START ENDP                ; Fin del procedimiento START
CODE ENDS                 ; Fin del segmento de código
END START                 ; Indica el punto de entrada del programa
