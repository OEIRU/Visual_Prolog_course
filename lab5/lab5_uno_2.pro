domains
	exe=tree(symbol,exe,exe);nil
	list=symbol*
predicates
	nondeterm append(list,list,list)
	nondeterm pre_order(exe,list)
	nondeterm in_order(exe,list)
	nondeterm post_order(exe,list)
clauses		
	append([],Ys,Ys).
	append([X|Xs],Ys,[X|Zs]):-append(Xs,Ys,Zs).
	
	%pre_order(Tree,Pre) //up to down
	pre_order(tree(X,L,R),Xs):-
		pre_order(L,Ls),
		pre_order(R,Rs),
		append([X|Ls],Rs,Xs),
		!.
	pre_order(_,[]).
	
	%in_order(Tree,In) //left to right
	in_order(tree(X,L,R),Xs):-
		in_order(L,Ls),
		in_order(R,Rs),
		append(Ls,[X|Rs],Xs),
		!.
	in_order(_,[]).
	
	%post_order(Tree,Post) //down to up
	post_order(tree(X,L,R),Xs):-
		post_order(L,Ls),
		post_order(R,Rs),
		append(RS,[X],Rsl),
		append(Ls,Rsl,Xs),
		!.
	post_order(_,[]).
 
