
% Факты о семье
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

% Факты о поле
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
gender(andrey, male).

% Правила
child(X, Y) :- 
    parent(Y, X).

son(X, Y) :- 
    child(X, Y), gender(X, male).

daughter(X, Y) :- 
    child(X, Y), gender(X, female).

brother(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    gender(X, male),
    X <> Y.

sister(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    gender(X, female),
    X <> Y.

uncle(X, Y) :-
    brother(X, Z),
    parent(Z, Y).

aunt(X, Y) :-
    sister(X, Z),
    parent(Z, Y).

nephew(X, Y) :-
    son(X, Z), (brother(Y, Z); sister(Y, Z)), not(parent(Y, X)).

niece(X, Y) :-
    daughter(X, Z), (brother(Y, Z); sister(Y, Z)).

cousin(X, Y) :-
    child(X, Z), child(Y, W), (brother(Z, W); sister(Z, W)).

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
    findall(Child, parent(X, Child), Children),
    unique(Children, UniqueChildren),
    length(UniqueChildren, Count),
    Count >= 2.

% Проверка наличия элемента в списке
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

% Удаление дубликатов из списка
unique([], []).
unique([H|T], Result) :-
    member(H, T),
    unique(T, Result).
unique([H|T], [H|Result]) :-
    \+ member(H, T),
    unique(T, Result).

% Подсчет длины списка
length([], 0).
length([_|T], N) :-
    length(T, N1),
    N = N1 + 1.

GOAL
    write("Program results:\n"),
    
    % 1. Ребенок (child)
    findall(X, child(X, petr), ChildrenPetr),
    unique(ChildrenPetr, UniqueChildrenPetr),
    write("Children of 'petr': "), write(UniqueChildrenPetr), nl, fail;
    
    % 2. Сын (son)
    findall(X, son(X, petr), SonsPetr),
    unique(SonsPetr, UniqueSonsPetr),
    write("Sons of 'petr': "), write(UniqueSonsPetr), nl, fail;
    
    % 3. Дочь (daughter)
    findall(X, daughter(X, anna), DaughtersAnna),
    unique(DaughtersAnna, UniqueDaughtersAnna),
    write("Daughters of 'anna': "), write(UniqueDaughtersAnna), nl, fail;
    
    % 4. Брат (brother)
    findall(X, brother(X, olga), BrothersOlga),
    unique(BrothersOlga, UniqueBrothersOlga),
    write("Brothers of 'olga': "), write(UniqueBrothersOlga), nl, fail;
    
    % 5. Сестра (sister)
    findall(X, sister(X, aleksey), SistersAleksey),
    unique(SistersAleksey, UniqueSistersAleksey),
    write("Sisters of 'aleksey': "), write(UniqueSistersAleksey), nl, fail;
    
    % 6. Дядя (uncle)
    findall(X, uncle(X, yelena), UnclesYelena),
    unique(UnclesYelena, UniqueUnclesYelena),
    write("Uncles of 'yelena': "), write(UniqueUnclesYelena), nl, fail;
    
    % 7. Тетя (aunt)
    findall(X, aunt(X, anastasiya), AuntsAnastasiya),
    unique(AuntsAnastasiya, UniqueAuntsAnastasiya),
    write("Aunts of 'anastasiya': "), write(UniqueAuntsAnastasiya), nl, fail;
    
    % 8. Племянник (nephew)
    findall(X, nephew(X, ivan), NephewsIvan),
    unique(NephewsIvan, UniqueNephewsIvan),
    write("Nephews of 'ivan': "), write(UniqueNephewsIvan), nl, fail;
    
    % 9. Племянница (niece)
    findall(X, niece(X, mikhail), NiecesMikhail),
    unique(NiecesMikhail, UniqueNiecesMikhail),
    write("Nieces of 'mikhail': "), write(UniqueNiecesMikhail), nl, fail;
    
    % 10. Двоюродный брат/сестра (cousin)
    findall(X, cousin(X, sofya), CousinsSofya),
    unique(CousinsSofya, UniqueCousinsSofya),
    write("Cousins of 'sofya': "), write(UniqueCousinsSofya), nl, fail;
    
    % 11. Дедушка (grandfather)
    findall(X, grandfather(X, polina), GrandfathersPolina),
    unique(GrandfathersPolina, UniqueGrandfathersPolina),
    write("Grandfathers of 'polina': "), write(UniqueGrandfathersPolina), nl, fail;
    
    % 12. Бабушка (grandmother)
    findall(X, grandmother(X, viktor), GrandmothersViktor),
    unique(GrandmothersViktor, UniqueGrandmothersViktor),
    write("Grandmothers of 'viktor': "), write(UniqueGrandmothersViktor), nl, fail;
    
    % 13. Прадедушка (great_grandfather)
    findall(X, great_grandfather(X, artem), GreatGrandfathersArtem),
    unique(GreatGrandfathersArtem, UniqueGreatGrandfathersArtem),
    write("Great-grandfathers of 'artem': "), write(UniqueGreatGrandfathersArtem), nl, fail;
    
    % 14. Прабабушка (great_grandmother)
    findall(X, great_grandmother(X, egor), GreatGrandmothersEgor),
    unique(GreatGrandmothersEgor, UniqueGreatGrandmothersEgor),
    write("Great-grandmothers of 'egor': "), write(UniqueGreatGrandmothersEgor), nl, fail;
    
    % 15. Внук (grandson)
    findall(X, grandson(X, anna), GrandsonsAnna),
    unique(GrandsonsAnna, UniqueGrandsonsAnna),
    write("Grandsons of 'anna': "), write(UniqueGrandsonsAnna), nl, fail;
    
    % 16. Внучка (granddaughter)
    findall(X, granddaughter(X, petr), GranddaughtersPetr),
    unique(GranddaughtersPetr, UniqueGranddaughtersPetr),
    write("Granddaughters of 'petr': "), write(UniqueGranddaughtersPetr), nl, fail;
    
    % 17. Правнук (great_grandson)
    findall(X, great_grandson(X, mikhail), GreatGrandsonsMikhail),
    unique(GreatGrandsonsMikhail, UniqueGreatGrandsonsMikhail),
    write("Great-grandsons of 'mikhail': "), write(UniqueGreatGrandsonsMikhail), nl, fail;
    
    % 18. Правнучка (great_granddaughter)
    findall(X, great_granddaughter(X, anna), GreatGranddaughtersAnna),
    unique(GreatGranddaughtersAnna, UniqueGreatGranddaughtersAnna),
    write("Great-granddaughters of 'anna': "), write(UniqueGreatGranddaughtersAnna), nl, fail;
    
    % 19. Счастливый родитель (happy)
    findall(X, happy(X), HappyParents),
    unique(HappyParents, UniqueHappyParents),
    write("Happy parents: "), write(UniqueHappyParents), nl, fail;
    
    % 20. Родитель с двумя детьми (two_children)
    findall(X, two_children(X), ParentsTwoChildren),
    unique(ParentsTwoChildren, UniqueParentsTwoChildren),
    write("Parents with two children: "), write(UniqueParentsTwoChildren), nl.

    % Example queries
% child(X, petr).         % Children of Petr
% son(X, petr).           % Sons of Petr
% daughter(X, petr).      % Daughters of Petr
% brother(X, olga).       % Brothers of Olga
% sister(X, aleksey).     % Sisters of Aleksey
% uncle(X, yelena).       % Uncles of Yelena
% aunt(X, anastasiya).    % Aunts of Anastasiya
% nephew(X, yelena).      % Nephews of Yelena
% niece(X, mikhail).      % Nieces of Mikhail
% cousin(X, sofya).       % Cousins of Sofya
% grandfather(X, polina). % Grandfathers of Polina
% grandmother(X, viktor). % Grandmothers of Viktor
% great_grandfather(X, artem). % Great-grandfathers of Artem
% great_grandmother(X, egor).  % Great-grandmothers of Egor
% grandson(X, anna).      % Grandsons of Anna
% granddaughter(X, petr). % Granddaughters of Petr
% great_grandson(X, mikhail). % Great-grandsons of Mikhail
% great_granddaughter(X, anna). % Great-granddaughters of Anna
% happy(X).               % People with children
% two_children(X).        % People with at least two children

 brother(X, olga).       % Brothers of Olga
X=aleksey
X=ivan
X=aleksey
X=ivan
X=andrey
5 Solutions
,
% Brother relationship (unique results)
brother(X, Y) :-
    setof(X, Z^(parent(Z, X), parent(Z, Y), gender(X, male), X \= Y), Brothers),
    member(X, Brothers).

brother(X, Y) :-
    parent(Z, X),       % Общий родитель Z для X и Y
    parent(Z, Y),
    gender(X, male),    % X — мужского пола
    X <> Y,             % X и Y разные люди
    !.                  % Отсечение: игнорируем другие общие родители для X и Y