domains 
    list = symbol* 

% Определение предикатов
predicates
    nondeterm parent(symbol, symbol)               % Родитель
    nondeterm gender(symbol, symbol)               % Пол человека (male/female)
    nondeterm child(symbol, symbol)                % Ребенок
    nondeterm son(symbol, symbol)                  % Сын
    nondeterm daughter(symbol, symbol)             % Дочь
    nondeterm brother(symbol, symbol)              % Брат
    nondeterm sister(symbol, symbol)               % Сестра
    nondeterm uncle(symbol, symbol)                % Дядя
    nondeterm aunt(symbol, symbol)                 % Тетя
    nondeterm grandmother(symbol, symbol)          % Бабушка
    nondeterm grandson(symbol, symbol)             % Внук
    nondeterm happy(symbol)                        % Счастливый родитель
    nondeterm two_children(symbol)                 % Родитель с двумя детьми
    nondeterm unique(list, list)                   % Удаление дубликатов из списка
    nondeterm member(symbol,list)                  % Проверка наличия элемента в списке
    

clauses
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
    gender(andrey, male).
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

% Правила
% 1. Ребенок
child(X, Y) :- 
    parent(Y, X).

% 2. Сын
son(X, Y) :- 
    child(X, Y), gender(X, male).

% 3. Дочь
daughter(X, Y) :- 
    child(X, Y), gender(X, female).

% 4. Брат
brother(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    gender(X, male),
    X <> Y. % X и Y не должны быть одинаковыми

% 5. Сестра
sister(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    gender(X, female),
    X <> Y. % X и Y не должны быть одинаковыми

% 6. Дядя
uncle(X, Y) :-
    brother(X, Z),
    parent(Z, Y).
% 7. Тетя
aunt(X, Y) :-
    sister(X, Z),
    parent(Z, Y).


% 12. Бабушка
grandmother(X, Y) :-
    parent(X, Z),
    parent(Z, Y),
    gender(X, female).


% 15. Внук
grandson(X, Y) :-
    parent(Y, Z),
    parent(Z, X),
    gender(X, male).


% 19. Счастливый родитель (имеющий хотя бы одного ребенка)
happy(X) :-
    parent(X, _).

% 20. Родитель с двумя детьми
two_children(X) :-
    parent(X, Child1),
    parent(X, Child2),
    Child1 <> Child2.

% Проверка наличия элемента в списке
member(X, [X|_]).                    % Элемент находится в голове списка
member(X, [_|T]) :- member(X, T).    % Элемент находится в хвосте списка

% Удаление дубликатов из списка
unique([], []). % Пустой список остается пустым
unique([H|T], Result) :-
    member(H, T), % Если голова уже есть в хвосте
    unique(T, Result). % Пропускаем её
unique([H|T], [H|Result]) :-
    not(member(H, T)), % Если головы нет в хвосте
    unique(T, Result). % Добавляем её в результат

% Цель программы
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

    % 8. Бабушка (grandmother)
    findall(X, grandmother(X, viktor), GrandmothersViktor),
    unique(GrandmothersViktor, UniqueGrandmothersViktor),
    write("Grandmothers of 'viktor': "), write(UniqueGrandmothersViktor), nl, fail;
    
    % 8.1. Внук (grandson)
    findall(X, grandson(X, dmitriy), GrandsonsDmitriy),
    unique(GrandsonsDmitriy, UniqueGrandsonsDmitriy),
    write("Grandsons of 'dmitriy': "), write(UniqueGrandsonsDmitriy), nl, fail;

    % 9. Счастливый родитель (happy)
    findall(X, happy(X), HappyParents),
    unique(HappyParents, UniqueHappyParents),
    write("Happy parents: "), write(UniqueHappyParents), nl, fail;
    
    % 10. Родитель с двумя детьми (two_children)
    findall(X, two_children(X), ParentsTwoChildren),
    unique(ParentsTwoChildren, UniqueParentsTwoChildren),
    write("Parents with two children: "), write(UniqueParentsTwoChildren), nl, fail.
