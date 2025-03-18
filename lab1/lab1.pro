% ??????????? ??????????
predicates
    nondeterm parent(symbol, symbol)
    nondeterm gender(symbol, symbol)       
    nondeterm child(symbol, symbol)   
    nondeterm son(symbol, symbol)          
    nondeterm daughter(symbol, symbol)
    nondeterm brother(symbol, symbol)
    nondeterm sister(symbol, symbol)       
    nondeterm uncle(symbol, symbol)        
    nondeterm aunt(symbol, symbol)         
    nondeterm nephew(symbol, symbol)       
    nondeterm niece(symbol, symbol)        
    nondeterm cousin(symbol, symbol)       
    nondeterm grandfather(symbol, symbol)  
    nondeterm grandmother(symbol, symbol)  
    nondeterm great_grandfather(symbol, symbol)
    nondeterm great_grandmother(symbol, symbol)
    nondeterm grandson(symbol, symbol)
    nondeterm granddaughter(symbol, symbol)
    nondeterm great_grandson(symbol, symbol)
    nondeterm great_granddaughter(symbol, symbol)
    nondeterm happy(symbol)
    nondeterm two_children(symbol)

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
    parent(kseniya, yuliya).
    parent(kseniya, dmitriy).
    parent(sergey, viktor).
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
    gender(andrey, male).
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
    gender(alina, female).
    
child(X, Y) :- 
    parent(Y, X).

son(X, Y) :- 
    child(X, Y), gender(X, male).

daughter(X, Y) :- 
    child(X, Y), gender(X, female).

brother(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    gender(X, male).

sister(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    gender(X, female).

uncle(X, Y) :-
    brother(X, Z),
    parent(Z, Y).

aunt(X, Y) :-
    sister(X, Z),
    parent(Z, Y).

nephew(X, Y) :-
    son(X, Z), brother(Y, Z), not(parent(Y, X));
    son(X, Z), sister(Y, Z), not(parent(Y, X)).

niece(X, Y) :-
    daughter(X, Z), sister(Y, Z);
    daughter(X, Z), brother(Y, Z).

cousin(X, Y) :-
    child(X, Z), child(Y, W), brother(Z, W);
    child(X, Z), child(Y, W), sister(Z, W).

grandfather(X, Y) :-
    parent(X, Z),
    parent(Z, Y),
    gender(X, male).

grandmother(X, Y) :-
    parent(X, Z),
    parent(Z, Y),
    gender(X, female).

great_grandfather(X, Y) :-
    grandfather(X, Z),
    parent(Z, Y).

great_grandmother(X, Y) :-
    grandmother(X, Z),
    parent(Z, Y).

grandson(X, Y) :-
    parent(Y, Z),
    parent(Z, X),
    gender(X, male).

granddaughter(X, Y) :-
    parent(Y, Z),
    parent(Z, X),
    gender(X, female).

great_grandson(X, Y) :-
    grandson(X, Z),
    parent(Z, Y).

great_granddaughter(X, Y) :-
    granddaughter(X, Z),
    parent(Z, Y).

happy(X) :-
    parent(X, _).

two_children(X) :-
    parent(X, Child1),
    parent(X, Child2),
    Child1 <> Child2.


GOAL
    write("Program results:\n"),
    %sister(aleksey, olga),
    %aunt(olga, yelena),
    %lucky(maksim).
    %happy(X).
    nephew(Y, X).
    