' Smida's Row Insertion Permutation Algorithm
'' EViews program that generates all permutations using the row insertion method
''' Iterative version
'''' Program written by : SMIDA Houcine L. 2025
' ========================================
' Begin Smida's Iterative Row Insertion Permutation Algorithm
' ========================================
' dialog box options 
' ------------------------------------------------------------------
%list = "1 2 3 4"
!sort = 1
%sortlist = " "" a. Yes (sort the first permutation) ""  "" b. No (do not sort the first permutation)   "" "
!result = @uidialog("caption", "Smida's Permutation", _
"edit", %list, "Enter the elements to permute, separated by spaces (e.g., 1 2 3 4, A B C D, Blue Green Red Yellow)", 100000, _
"text", "If sentences must be swapped, they should be placed in double quotes “ ” ", _
"radio", !sort, "Sort the first permutation ?", %sortlist, _ 
"text", "EViews program that generates all permutations", _
 "text", "Program written by : SMIDA Houcine L. 2025") 
' ------------------------------------------------------------------
' display a warning if the list is empty when OK is clicked 
' ------------------------------------------------------------------
if @wcount(%list) < 1 and !result <> -1 then
	@uiprompt("The list is empty, please enter the elements to permute")
	return
endif
' ------------------------------------------------------------------
' choose different elements (without repetition)
' ------------------------------------------------------------------
for !i= 1 to @wcount(%list) -1
	for !j= !i+1 to @wcount(%list)
		if @word(%list,!i)=@word(%list,!j) then
			@uiprompt("Please choose different elements (without repetition)")
			return
		endif
	next
next
' ------------------------------------------------------------------
' maximum number of elements that can be permuted
' ------------------------------------------------------------------
if @wcount(%list) > 10 and !result <> -1 then
	@uiprompt("The maximum number of elements to permute is limited to 10")
	return
endif
' ------------------------------------------------------------------
' stop if the Cancel button is clicked 
' ------------------------------------------------------------------
if !result = -1 then
	stop
endif
' ------------------------------------------------------------------
' create workfile  
' ------------------------------------------------------------------
!n=@wcount(%list)
workfile permutation u 1 !n
' ------------------------------------------------------------------
' define the table to be permuted
' ------------------------------------------------------------------
table Tab
for !i=1 to !n
	Tab(!i)=@word(%list,!i)
next
' ------------------------------------------------------------------
' sorte the first permutation in ascending order ?
' ------------------------------------------------------------------
if !sort = 1 then
	Tab.sort(A1:A!n) A ' returns sorted elements in ascending order
endif
' ------------------------------------------------------------------
' set width of table column
' ------------------------------------------------------------------
for !i=1 to !n  
	!colwidthi=@length(Tab(!i))
!maxcolwidth=@length(Tab(1))
	if !colwidthi>!maxcolwidth then
		!maxcolwidth=!colwidthi
	endif
next
!colwidth=!maxcolwidth+2
' ========================================
' Begin iterative subroutine
' ========================================
subroutine Smida_Permutation(table E, scalar !g) 
	if !g=1 then
		return
	endif
	!g=2
	while !g<=!n
		table F=E
		for !i=1 to !g  
			table B!i=F
			B!i.insertrow(!i) 1		
			for !j=1 to @fact(!g-1)  
				B!i(!i,!j)=Tab(!g)  
			next
			tabplace(E,B!i, 1, (@fact(!g-1))*(!i-1)+1, 1, 1, @fact(!g-1),@fact(!g-1))
			d B!i
		next
		d F
		!g=!g+1
	wend
endsub
' ========================================
' End iterative subroutine
' ========================================
' define the table of generated permutations
' ------------------------------------------------------------------
table Tabperm
Tabperm(1)=Tab(1)
' ------------------------------------------------------------------
' call recursive RIPA
' ------------------------------------------------------------------
call Smida_Permutation(Tabperm, !n+1)
' ------------------------------------------------------------------
' display permutations
' ------------------------------------------------------------------
d Tab
Tabperm.setwidth(@all) !colwidth
show Tabperm
' ========================================
' End Smida's Iterative Row Insertion Permutation Algorithm
' ========================================

