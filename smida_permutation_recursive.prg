' Smida's Row Insertion Permutation Algorithm
'' EViews program that generates all permutations using the row insertion method
''' Recursive version
'''' Program written by : SMIDA Houcine L. 2026
' ========================================
' Begin Smida's Recursive Row Insertion Permutation Algorithm
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
"text", "Program written by : SMIDA Houcine L. 2026")
' ------------------------------------------------------------------
' display a warning if the list is empty when OK is clicked
' ------------------------------------------------------------------
if @wcount(%list) < 1 and !result <> -1 then
	@uiprompt("The list is empty, please enter the elements to permute")
	return
endif
' ------------------------------------------------------------------
' choose distinct elements (without repetition)
' ------------------------------------------------------------------
for !i=1 to @wcount(%list)-1
	for !j=!i+1 to @wcount(%list)
		if @word(%list,!i)=@word(%list,!j) then
			@uiprompt("Please choose distinct elements (without repetition)")
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
' define the table of elements to be permuted
' ------------------------------------------------------------------
table Tab
for !i=1 to !n
	Tab(!i)=@word(%list,!i)
next
' ------------------------------------------------------------------
' sort the first permutation in ascending order ?
' ------------------------------------------------------------------
if !sort = 1 then
	Tab.sort(A1:A!n) A
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
' Begin recursive subroutine
' ========================================
subroutine Smida_Permutation(table E, scalar !g)
	if !g=1 then
		E(1,1)=Tab(1) ' base case
		return
	endif
	call Smida_Permutation(E,!g-1) ' recursive call
	table F=E
	for !i=1 to !g
		table B=F
		B.insertrow(!i) 1 ' insert an empty row at position i
		for !j=1 to @fact(!g-1)
			B(!i,!j)=Tab(!g) ' fill the inserted row with Tab(g)
		next
		tabplace(E,B,1,(@fact(!g-1))*(!i-1)+1,1,1,@fact(!g-1),@fact(!g-1))
		d B ' place the block B into E
	next
	d F
endsub
' ========================================
' End recursive subroutine
' ========================================
' define the table of generated permutations
' ------------------------------------------------------------------
table Tabperm
' ------------------------------------------------------------------
' call recursive RIPA
' ------------------------------------------------------------------
call Smida_Permutation(Tabperm,!n)
' ------------------------------------------------------------------
' display permutations
' ------------------------------------------------------------------
d Tab
Tabperm.setwidth(@all) !colwidth
show Tabperm
' ========================================
' End Smida's Recursive Row Insertion Permutation Algorithm
' ========================================


