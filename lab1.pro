% Predicates
predicates
    nondeterm parent(symbol, symbol)
    nondeterm lucky(symbol)
    nondeterm have2children(symbol)
    nondeterm grandson(symbol, symbol) /*1-grandparent, 2-grandson*/
    nondeterm sister(symbol, symbol) /*1-man, 2-sister*/
    nondeterm aunt(symbol, symbol) /*1-aunt, 2-person*/
    gender(symbol, symbol)

% Clauses
clauses
    % First generation
    parent(grandma1, igor).
    parent(grandpa1, igor).
    parent(grandma1, antonina).
    parent(grandpa1, antonina).

    parent(grandma2, valentina).
    parent(grandpa2, valentina).
    parent(grandma2, alexander).
    parent(grandpa2, alexander).

    % Second generation
    parent(igor, vladimir).
    parent(valentina, vladimir).
    parent(igor, maxim).
    parent(valentina, maxim).

    parent(noName, ekaterina).
    parent(antonina, ekaterina).

    % Third generation
    parent(chibz, bee1).
    parent(ekaterina, bee1).
    parent(chibz, bee2).
    parent(ekaterina, bee2).

    % Genders of individuals
    gender(grandma1, female).
    gender(grandpa1, male).
    gender(grandma2, female).
    gender(grandpa2, male).
    gender(igor, male).
    gender(antonina, female).
    gender(valentina, female).
    gender(alexander, male).
    gender(vladimir, male).
    gender(maxim, male).
    gender(noName, male).
    gender(ekaterina, female).
    gender(chibz, male).
    gender(bee1, female). % Assume Bee1 is female
    gender(bee2, male).   % Assume Bee2 is male

    % Rules
    lucky(Name) :- 
        parent(Name, _).

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

% Goal block
goal     
write("Program results:\n"),     
nl,      
% Uncomment only one query at a time to test it     
% lucky(grandma1).     
% lucky(grandpa1).     
% lucky(igor).     
% lucky(noName).      
% have2children(igor).     
% have2children(chibz).      
% grandson(vladimir, igor).     
% grandson(ekaterina, grandma1).      
% aunt(antonina, vladimir).     
aunt(grandma1, vladimir). 