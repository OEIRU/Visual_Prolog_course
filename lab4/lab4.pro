domains
    element = integer
    collection = element*
    pair_collection = collection*

predicates
    nondeterm merge_collections(collection, collection, collection)     % Объединение коллекций
    nondeterm find_common_elements(collection, collection, collection)  % Поиск общих элементов
    nondeterm remove_element(element, collection, collection)           % Удаление одного элемента
    nondeterm subtract_collections(collection, collection, collection)  % Вычитание коллекций
    nondeterm generate_pairs(collection, collection, pair_collection)   % Генерация пар элементов
    nondeterm pair_combinations(collection, collection, collection, pair_collection)
    nondeterm is_member(element, collection)                            % Проверка принадлежности элемента
    nondeterm add_element(element, collection, collection)              % Добавление элемента

clauses
    % Объединение двух коллекций (уже есть)
    merge_collections([], Second, Second).
    merge_collections([Head | Tail], Second, Result) :-
        not(is_member(Head, Second)), !,
        merge_collections(Tail, Second, Temp),
        Result = [Head | Temp].
    merge_collections([_ | Tail], Second, Result) :-
        merge_collections(Tail, Second, Result).

    % Поиск общих элементов (уже есть)
    find_common_elements([], _, []).
    find_common_elements([Head | Tail], Second, [Head | Common]) :-
        is_member(Head, Second), !,
        find_common_elements(Tail, Second, Common).
    find_common_elements([_ | Tail], Second, Common) :-
        find_common_elements(Tail, Second, Common).

    % Удаление элемента (уже есть)
    remove_element(Element, [Element | Rest], Rest).
    remove_element(Element, [Head | Tail], [Head | NewTail]) :-
        remove_element(Element, Tail, NewTail).

    % Вычитание коллекций (уже есть)
    subtract_collections(Collection, [], Collection).
    subtract_collections(Collection, [Element | Tail], Result) :-
        is_member(Element, Collection), !,
        remove_element(Element, Collection, Temp),
        subtract_collections(Temp, Tail, Result).
    subtract_collections(Collection, [_ | Tail], Result) :-
        subtract_collections(Collection, Tail, Result).

    % Генерация пар (уже есть)
    generate_pairs(Collection1, Collection2, Pairs) :-
        pair_combinations(Collection1, Collection2, Collection2, Pairs).

    pair_combinations([], _, _, []).
    pair_combinations(_, [], _, []).
    pair_combinations([First | Rest1], [Second | Rest2], Original, [[First, Second] | Pairs]) :-
        pair_combinations([First | Rest1], Rest2, Original, Pairs).
    pair_combinations([_ | Rest1], [], Original, Pairs) :-
        pair_combinations(Rest1, Original, Original, Pairs).

    % Проверка принадлежности (уже есть)
    is_member(Element, [Element | _]).
    is_member(Element, [_ | Tail]) :-
        is_member(Element, Tail).

    % Добавление элемента
    add_element(Element, Collection, [Element | Collection]).


goal
    % Примеры использования:
    % merge_collections([1, 3, 5], [2, 4, 6], Result).  % Результат: [1, 3, 5, 2, 4, 6]
    % find_common_elements([1, 3, 5], [3, 5, 7], Result).  % Результат: [3, 5]
    % subtract_collections([1, 2, 3, 4], [2, 4], Result).  % Результат: [1, 3]
    % generate_pairs([1, 2], [3, 4], Result).  % Результат: [[1, 3], [1, 4], [2, 3], [2, 4]]
    % defense::
    % add_element(5, [1, 2, 3], Result).
    %remove_element(2, [1, 2, 3, 2], Result).