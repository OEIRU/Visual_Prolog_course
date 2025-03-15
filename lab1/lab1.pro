predicates
    nondeterm parent(symbol, symbol)
    nondeterm lucky(symbol)
    nondeterm have2children(symbol)
    nondeterm grandson(symbol, symbol) /*1-grandparent, 2-grandson*/
    nondeterm sister(symbol, symbol) /*1-man, 2-sister*/
    nondeterm aunt(symbol, symbol) /*1-aunt, 2-person*/
    nondeterm gender(symbol, symbol)


clauses
	parent(mikhail, petr).
	parent(anna, aleksey).
	parent(anna, olga).
	parent(anna, ivan).
	parent(petr, aleksey).
	parent(petr, olga).
	parent(petr, ivan).
	parent(petr, andrey).
	parent(mariya, andrey).
	parent(ivan, yelena).
	parent(ivan, anastasiya).
	parent(yelena, sofya).
	parent(sofya, polina).
	parent(viktoriya, sergey).
	parent(andrey, viktoriya).
	parent(andrey, kseniya).
	parent(kseniya, yuliya).
	parent(kseniya, dmitriy).
	parent(sergey, viktor).
	parent(yuliya, kirill).
	parent(dmitriy, kirill).
	parent(kirill, maksim).
	parent(maksim, artem).
	parent(maksim, egor).

	gender(mikhail, male).
	gender(petr, male).
	gender(aleksey, male).
	gender(ivan, male).
	gender(sergey, male).
	gender(dmitriy, male).
	gender(viktor, male).
	gender(kirill, male).
	gender(maksim, male).
	gender(artem, male).
	gender(egor, male).
	gender(viktoriya, female).
	gender(kseniya, female).
	gender(yuliya, female).
	gender(anna, female).
	gender(mariya, female).
	gender(olga, female).
	gender(yelena, female).
	gender(anastasiya, female).
	gender(sofya, female).
	gender(polina, female).
	gender(andrey, female).
	gender(alina, female).
	
    lucky(Name) :- 
        parent(Name, Child),
        !.

    have2children(Name) :-
        parent(Name, Child1),
        parent(Name, Child2),
        Child1 <> Child2.

    grandson(Gs, Gp) :-
        gender(Gs, male),
        parent(Gp, Parent),
        parent(Parent, Gs).

    sister(Men, Sis) :-
        parent(X, Men),
        parent(X, Sis),
        gender(Sis, female),
        Men <> Sis.

    aunt(Au, Pl) :-
        parent(Parent, Pl),
        sister(Parent, Au).


goal    
	write("Program results:\n"),     
        sister(aleksey, olga).
        % aunt(olga, yelena).
        %lucky(maksim).