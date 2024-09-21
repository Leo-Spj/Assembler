;------------------------------------------------------------------------------
; Programa que dibuja una línea diagonal en la pantalla en modo gráfico.
; Utiliza la interrupción 10h para configurar el modo gráfico y cambiar 
; los píxeles uno por uno, creando un efecto de diagonal con colores cambiantes.
; La diagonal se dibuja desde la posición (1,1) hasta (100,100).
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; Inicio del programa
;------------------------------------------------------------------------------

start:
    ;--------------------------------------------------------------------------
    ; Configurar el modo gráfico
    ;--------------------------------------------------------------------------
    mov cx, 1           ; Inicializa CX en 1. CX representa la posición x e y, 
                        ; ya que la diagonal tiene la misma posición en ambos ejes.
    mov al, 13h         ; AL = 13h indica que vamos a usar el modo gráfico 320x200,
                        ; con 256 colores. Este es un modo de gráficos común.
    mov ah, 0           ; AH = 0 para la función de cambio de modo de video
    int 10h             ; Interrupción 10h: Cambiar al modo gráfico 13h (320x200, 256 colores)

    ;--------------------------------------------------------------------------
    ; Bucle para dibujar la diagonal
    ;--------------------------------------------------------------------------
bucle1:
    mov dx, cx          ; DX = CX. Usamos el valor de CX para las coordenadas X e Y
                        ; porque estamos dibujando en diagonal (X = Y).
    
    mov al, color       ; AL = color del píxel. Cargamos el color que cambia en cada iteración.
    mov ah, 0ch         ; AH = 0Ch. Función de la interrupción 10h para dibujar un píxel en
                        ; modo gráfico. Esta función pone un píxel en la pantalla con 
                        ; las coordenadas en CX (X) y DX (Y).

    int 10h             ; Interrupción 10h: Dibuja el píxel en la posición (CX, DX)
    
    ;--------------------------------------------------------------------------
    ; Comprobar si hemos llegado al límite de 100 píxeles en diagonal
    ;--------------------------------------------------------------------------
    cmp cx, 101         ; Compara CX con 101. Queremos dibujar hasta (100,100).
    jz fin              ; Si CX es igual a 101, saltamos a la etiqueta "fin" para terminar.

    ;--------------------------------------------------------------------------
    ; Incrementar la posición y cambiar el color del píxel
    ;--------------------------------------------------------------------------
    inc cx              ; Incrementa CX para moverse al siguiente píxel en la diagonal (X = Y).
    add color, 2        ; Cambia el color del píxel sumando 2 al valor actual de "color".
                        ; Esto crea un efecto visual de cambio de color en la diagonal.

    jmp bucle1          ; Salta de nuevo al principio del bucle para dibujar el siguiente píxel.

;--------------------------------------------------------------------------
; Fin del programa
;--------------------------------------------------------------------------
fin:
    ret                 ; Finaliza el programa y retorna al sistema operativo.

;------------------------------------------------------------------------------
; Definir el color inicial
;------------------------------------------------------------------------------
color db 1              ; Definimos el color inicial en 1 (color base).
