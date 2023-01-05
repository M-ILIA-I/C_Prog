.model small
.stack 100  
.code 
       
.data
    src_string db "Enter source string: $"
    s2 db 10,13, "Enter the word you want to delete: $"
    s3 db 10,13,"Changed string: $"
    no_space db 10, 13, "We havn't keyword in string$"
    string db 50 dup ('$')
    keyword db 50 dup ('$')
    
prepair macro pr
    xor ax,ax 
    mov ax, data
    mov ds, ax
    mov dx, offset pr
endm
    
 
start:    
    prepair src_string
    mov ah, 09h
    int 21h
    
    prepair string
    mov bx, dx
    mov [bx], 50
    mov ah, 0Ah
    int 21h 
    
    prepair s2
    mov ah, 9h
    int 21h
           
           
    prepair keyword
    mov bx, dx
    mov [bx],50
    mov ah, 0Ah
    int 21h
    
      
    ;pomeschaem stroku v es:di
    mov ax, data
    mov es, ax
    lea di, string
    mov dx, [di+1]
    inc di
    inc di
    
    
    ;nahodim probel
find_space:
    xor cx,cx
    mov al, ' '
    mov cl,dl
    repne scasb
    jz compare_word
    jmp exit
    
compare_word:
    xor dx,dx
    mov dl, cl 
             
    lea si, keyword         
    mov cl, [si+1]
    inc si
    inc si
    mov ax, data
    mov ds, ax 
    
    repe cmpsb
    jnz find_space 
    
    jmp find_word    
    
find_word:
    xor cx,cx
    xor bx, bx
    lea bx, keyword
    mov cl, [bx+1]
    sub di,cx
    xor bx,bx
    mov bx, di
    dec di
    dec di
    std
    xor ax,ax
    mov al, ' '
    repne scasb
    jz replace

replace:
    cld
    xor cx,cx
    xor ax,ax
    lea si, string
    mov al, [si+1]
    add si,ax
    inc si
    inc si
    mov cx, si
    sub cx, bx
    inc cx
    inc cx
    mov si,bx
    inc di
        
loop_de:
    xor ax,ax
    mov ax, es:si
    mov es:di, ax
    inc di
    inc si
    loop loop_de
    
    prepair s3
    mov ah, 9h
    int 21h
    xor ax,ax 
    mov ax, data
    mov ds, ax
    lea dx, string
    inc dx
    inc dx
    xor ax,ax
    mov ah, 09h
    int 21h
    jmp ex   
    

exit:     
   prepair no_space
   mov ah, 09h
   int 21h
ex:
end start