domains
    bl = true; false; var(string); diz(bl, bl); con(bl, bl)

predicates
    nondeterm simplify(bl, bl)  % Преобразование формулы

clauses
    % Базовые случаи: если формула уже упрощена, возвращаем её как есть
    simplify(true, true).
    simplify(false, false).
    simplify(var(X), var(X)).

    % Применение аксиомы true V F = true
    simplify(diz(true, _), true).       % true V F = true
    simplify(diz(_, true), true).       % F V true = true

    % Применение аксиомы false & F = false
    simplify(con(false, _), false).     % false & F = false
    simplify(con(_, false), false).     % F & false = false

    % Обработка дизъюнкции (V)
    simplify(diz(X, Y), diz(SX, SY)) :-
        simplify(X, SX),                % Упрощаем первый аргумент
        simplify(Y, SY).                % Упрощаем второй аргумент

    % Обработка конъюнкции (&)
    simplify(con(X, Y), con(SX, SY)) :-
        simplify(X, SX),                % Упрощаем первый аргумент
        simplify(Y, SY).                % Упрощаем второй аргумент

% Тестовые запросы
goal
    simplify(diz(true, var("A")), Result1), !, % true V A -> true
    write("Result1: ", Result1), nl,
    simplify(con(false, var("B")), Result2), !, % false & B -> false
    write("Result2: ", Result2), nl,
    simplify(diz(var("C"), true), Result3), !, % C V true -> true
    write("Result3: ", Result3), nl,
    simplify(con(var("D"), false), Result4), !, % D & false -> false
    write("Result4: ", Result4), nl.