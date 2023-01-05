 org $8000
 
 ldaa #0
 ldab #$ff
 ldx #$8200 

loop
 brclr 0,x,#$01 skipincrease
 sec
 adca #0
skipincrease inx
 decb
 bne loop

end psha
 bra *  