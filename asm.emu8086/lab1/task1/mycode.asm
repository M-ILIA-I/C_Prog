 .MODEL tiny
 .CODE
 org 100h
start:
 mov ah, 9
 mov dx,offset mes
 int 21h
mes db "Hello, world!$"  
End start





