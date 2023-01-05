 org $8000

 ldaa #$a
 staa $8100
 ldaa #$b
 staa $8101
 ldaa #$c
 staa $8102

 ldaa $8100
 ldab $8101
 
 mul
 
 std $8103   // result fir mul

 ldaa $8102

 mul

 std $8105

 ldaa $8102
 ldab $8103

 mul

 std $8107
 ldaa $8108
 adda $8105
 ldab $8106

 

   
 
 
 
 

 
 



