.model small
.data
    Filename db dup 80 ($);filename
    errmes db "Error",'$'                                          ;error message
    
    Buffer db "$$$$$"                                             ;buffer for reading
    str_number_mes db "Number : " , '$'                ;output message
    dsk dw 0                                                       
    str_number dw 0
.code
start:
    mov es:[str_number],0
    xor ax,ax
    mov ax, @data
    mov es,ax
    xor cx,cx
    mov cx, 80
    xor ax, ax
    mov al, 13
    mov si, 82h
    lea di, Filename
    
write_file_path:
    cmp ds:[si], 13
    je rem_adress
    xor ax,ax
    mov al,ds:[si]
    mov ds:[di],al
    inc di
    inc si
    loop write_file_path
        
rem_adress:  
    mov ah, 3dh                  ;open existing file
    mov al, 0                       ;for reading
    lea dx, Filename           ;filename to dx
    int 21h
    jc error                          ;CF == 0 - error 
    mov dsk, ax              
LP:
    mov ah, 3Fh                  ;read from file
    lea dx, Buffer                ;buffer for reading
    mov cx, 1
    mov bx, dsk              
    int 21h
    jc error                          ;CF == 0 - error
    cmp ax, cx                   ;if num of readed bytes != 1 - end of file
    jne EOF
    push dx                        ;save dx
    mov dl, Buffer       
    cmp dl , 10                  ;if Buffer == '\n' - one more string      
    je one_more_str
    LP2:
    mov ah, 02h                ;output symbol
    int 21h
    pop dx                         ;restore dx
    jmp LP
EOF:                                ;end of file
    mov bx, dsk            
    mov ah, 3Eh                ;close file
    int 21h                              
    inc str_number            ;if end of file - one more string
    jnc quit
one_more_str:
    xor ax,ax
    mov ax, es:[str_number] 
    inc ax
    mov es:[str_number],ax
    jmp LP2
error:                      ;out error message
    mov ah, 9h
    mov dx, OFFSET errmes
    int 21h
quit:
    mov bx, @data
    mov ds, bx
          
    mov ah , 2h              ;translation to a new line
    mov dx , 10
    int 21h
    mov ah , 09h            ;output string message
    mov dx , offset str_number_mes
    int 21h

    xor dx,dx
    mov dl,es:[str_number]
    inc dx
    xor ax,ax
    mov ax, dx
    mov bx,10
    xor cx,cx
ASCII:   
    xor dx,dx               ;dx = 0
    div bx                    ;divide on 10
    add dl,'0'                ;number to  symbol
    push dx                 ;save dx to stack
    inc cx
    test ax,ax              ;(ax == 0)? 
    jnz ASCII
recordRezult:               ;pop symbols from stack
    pop dx                      ;pop symbol to dx 
    mov ah , 2h                ;output symbol
    int 21h
    loop recordRezult         
                 
  
             
end start
