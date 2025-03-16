domains
    type = integer
    list = type*
    listlist = list*

predicates
    nondeterm unionset(list, list, list)      % Объединение двух списков
    nondeterm intersect(list, list, list)     % Пересечение двух списков
    nondeterm del(type, list, list)           % Удаление одного элемента из списка
    nondeterm dellist(list, list, list)       % Вычитание списков
    nondeterm decart(list, list, listlist)    % Декартово произведение
    nondeterm member(type, list)              % Проверка принадлежности элемента списку
    nondeterm cart(list,list,list,listlist)
clauses
    % Объединение двух списков
    unionset([], List, List).  % Если первый список пуст, результат — второй список
    unionset([Head | Tail], List2, Result) :-
        member(Head, List2), !,               % Если элемент уже есть во втором списке, пропускаем его
        unionset(Tail, List2, Result).
    unionset([Head | Tail], List2, [Head | Result]) :-
        unionset(Tail, List2, Result).        % Иначе добавляем элемент в результат

    % Пересечение двух списков
    intersect([], _, []).                     % Если первый список пуст, пересечение пустое
    intersect([Head | Tail], List2, [Head | Result]) :-
        member(Head, List2), !,               % Если элемент есть во втором списке, добавляем его
        intersect(Tail, List2, Result).
    intersect([_ | Tail], List2, Result) :-
        intersect(Tail, List2, Result).       % Иначе продолжаем проверку

    % Удаление элемента из списка
    del(Element, [Element | Tail], Tail).     % Если элемент найден, удаляем его
    del(Element, [Head | Tail], [Head | Result]) :-
        del(Element, Tail, Result).           % Иначе продолжаем поиск

    % Вычитание списков
    dellist(List, [], List).                  % Если второй список пуст, результат — первый список
    dellist(List1, [Head | Tail], Result) :-
        member(Head, List1),                  % Если элемент есть в первом списке
        del(Head, List1, Temp),               % Удаляем его из первого списка
        dellist(Temp, Tail, Result).          % Продолжаем вычитание
    dellist(List1, [_ | Tail], Result) :-
        dellist(List1, Tail, Result).         % Иначе игнорируем элемент

    % Декартово произведение
    decart(List1, List2, Result) :-
        cart(List1, List2, List2, Result).    % Запускаем вспомогательный предикат

    cart([], _, _, []).                       % Если первый список пуст, результат пустой
    cart(_, [], _, []).                       % Если второй список пуст, результат пустой
    cart([Head1 | Tail1], [Head2 | Tail2], OriginalList2, [[Head1, Head2] | Result]) :-
        cart([Head1 | Tail1], Tail2, OriginalList2, Result). % Формируем пары
    cart([Head1 | Tail1], [], OriginalList2, Result) :-
        cart(Tail1, OriginalList2, OriginalList2, Result).   % Переходим к следующему элементу первого списка

    % Проверка принадлежности элемента списку
    member(Element, [Element | _]).           % Элемент найден
    member(Element, [_ | Tail]) :-
        member(Element, Tail).                % Продолжаем поиск в хвосте

goal
    % Тестовые запросы
    % unionset([1, 3, 5, 7, 9], [2, 4, 6, 8, 0], L).
    % intersect([1, 3, 4, 6, 7, 8, 9], [9, 2, 5, 1, 7, 0], L).
    % dellist([1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 3, 5, 7, 9, 0], L).
    % decart([1, 2, 3], [9, 8, 7], L).