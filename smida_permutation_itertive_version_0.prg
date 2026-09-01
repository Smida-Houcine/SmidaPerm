' Smida's Row Insertion Permutation Algorithm (RIPA)
' Recursive version
' Written by: SMIDA Houcine L. (2025)
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
!n=4
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
workfile permutation u 1 !n
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
table Tab
for !i=1 to !n
    Tab(!i)=@str(!i)
next
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Begin Recursive Subroutine RIPA
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
subroutine Smida_Permutation(table E, scalar !g)
    if !g=1 then
        E(1,1)=Tab(1)
        return
    endif
    call Smida_Permutation(E,!g-1)
    table F=E
    for !i=1 to !g
        table B=F
        B.insertrow(!i) 1
        for !j=1 to @fact(!g-1)
            B(!i,!j)=Tab(!g)
        next
        tabplace(E,B,1,@fact(!g-1)*(!i-1)+1,1,1,@fact(!g-1),@fact(!g-1))
	   d B
    next
	d F
endsub
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' End Recursive Subroutine  RIPA
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
table TabPerm
call Smida_Permutation(TabPerm,!n)
TabPerm.setwidth(@all) 3
show TabPerm ' display permutations
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' End
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
