domains
    file = inpfile; outfile
    line = string

predicates
    nondeterm mmm(integer)                        % Основной предикат
    nondeterm one(integer)                        % Обработка строк
    nondeterm blink(integer, symbol, string)      % Создание строки пробелов
    nondeterm numword(string, integer)            % Подсчет количества слов
    nondeterm numblink(string, integer, integer, integer, integer) % Вычисление пробелов
    nondeterm vstavka(string, integer, string, string) % Вставка пробелов
    nondeterm newform(string, integer, integer, string) % Формирование новой строки
    nondeterm vir(string, integer, string)        % Выравнивание строки
    nondeterm check_pr2(integer, string, integer, integer, string) % Проверка значения Pr2 
clauses
    % Основной предикат
    mmm(Newd) :-
        openmodify(inpfile, "E://text.txt"), % Открываем входной файл
        openwrite(outfile, "E://out.txt"),  % Открываем выходной файл
        readdevice(inpfile),            % Устанавливаем устройство ввода
        writedevice(outfile),           % Устанавливаем устройство вывода
        one(Newd),                      % Обрабатываем строки
        closefile(inpfile),             % Закрываем входной файл
        closefile(outfile).             % Закрываем выходной файл

    % Обработка строк
    one(_) :- eof(inpfile).             % Если конец файла, завершаем
    one(Newd) :-
        readln(S),                      % Читаем строку
        vir(S, Newd, NS),               % Выравниваем строку
        write(NS), nl,                  % Записываем результат
        one(Newd).                      % Переходим к следующей строке

    % Создание строки пробелов
    blink(1, B, B) :- !.                % Базовый случай: один символ
    blink(N, B, S) :-
        N1 = N - 1,
        blink(N1, B, S1),
        concat(B, S1, S).

    % Подсчет количества слов
    numword("", 1) :- !.                % Пустая строка считается одним словом
    numword(S, N) :-
        frontchar(S, Sym1, NS1),         % Первый символ
        frontchar(NS1, Sym2, _),         % Второй символ
        Sym1 = ' ',                     % Если пробел
        Sym2 <> ' ',                    % И следующий символ не пробел
        numword(NS1, N1),               % Рекурсивно считаем дальше
        N = N1 + 1, !.
    numword(S, N) :-
        frontchar(S, _, S1),             % Пропускаем символ
        numword(S1, N), !.              % Рекурсивно считаем дальше

    % Вычисление пробелов
    numblink(S, Newd, Kols, Pr1, Pr2) :-
        str_len(S, Dlina),               % Длина строки
        Razn = Newd - Dlina,             % Разница между целевой и текущей длиной
        Pr1 = Razn div Kols,             % Основное количество пробелов
        Pr2 = Razn mod Kols.             % Остаток пробелов

    % Вставка пробелов
    vstavka(S, 0, _, S) :- !.           % Если больше нет пробелов, завершаем
    vstavka(S, Kr, V, NS) :-
        frontstr(1, S, Sym1, S1),        % Первый символ
        frontstr(1, S1, Sym2, S2),       % Второй символ
        Sym1 = " ",                     % Если пробел
        Sym2 <> " ",                    % И следующий символ не пробел
        concat(Sym1, V, S3),            % Добавляем пробел
        concat(S3, Sym2, S4),           % Формируем новую строку
        Kr1 = Kr - 1,                   % Уменьшаем счетчик
        vstavka(S2, Kr1, V, S5),        % Рекурсивно продолжаем
        concat(S4, S5, NS), !.
    vstavka(S, Kr, V, NS) :-
        frontstr(1, S, Sym1, S1),        % Пропускаем символ
        vstavka(S1, Kr, V, S2),         % Рекурсивно продолжаем
        concat(Sym1, S2, NS), !.

    % Формирование новой строки
    newform(S, Pr1, Kols, NS) :-
        Ksl = Kols - 1,                 % Количество слов минус один
        blink(Pr1, " ", V),             % Создаем строку пробелов
        vstavka(S, Ksl, V, NS1),        % Вставляем пробелы
        concat(V, NS1, NS).             % Добавляем пробелы в начало

    % Выравнивание строки
    vir(S, Newd, NS) :-
        numword(S, Kols),               % Считаем количество слов
        numblink(S, Newd, Kols, Pr1, Pr2), % Вычисляем пробелы
        check_pr2(Pr2, S, Pr1, Kols, NS). % Обрабатываем значение Pr2

    % Проверка значения Pr2
    check_pr2(0, S, Pr1, Kols, NS) :-   % Если Pr2 = 0
        newform(S, Pr1, Kols, NS).      % Формируем строку без дополнительных пробелов

    check_pr2(Pr2, S, Pr1, Kols, NS) :- % Если Pr2 > 0
        Pr2 > 0,
        newform(S, Pr1, Kols, NS1),     % Формируем строку
        concat(" ", NS1, NS).           % Добавляем дополнительный пробел

% Точка входа в программу
goal
    mmm(50).                            %  длина строки = 50