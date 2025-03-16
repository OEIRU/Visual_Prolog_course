% TODO
% 1. Проверка на пустой ввод (и некорректный ввод)
% 2. Проверка на корректность ответа (yes/no)
% 3. Проверка на дубликат (людей/языка)
% 4. Проверка на существование файла 
% 5. Проверка на пустую базу данных 

database
    language(symbol).
    know_language(symbol, symbol).

predicates
    nondeterm choice(char).
    menu.
    nondeterm repeat.

clauses

    % Main menu
    menu :-
        repeat,
        write("------------------------------------\n"),
        write("1 - Add a person\n"),
        write("2 - Add a language\n"),
        write("3 - Show all people\n"),
        write("4 - Show all languages\n"),
        write("s - Save the database\n"),
        write("l - Load the database\n"),
        write("0 - Exit\n"),
        readchar(Choice),
        choice(Choice),
        Choice = '0',
        !.
        
    % Add a person
    choice('1') :-
        write("Enter your name:\n"),
        readln(Name),
        language(Lang),
        write("Do you know ", Lang, "? (yes/no):\n"),
        readln(Answer),
        Answer = "yes",
        assertz(know_language(Name, Lang)), % Add the fact to the database
        fail.

    % Add a new language
    choice('2') :-
        write("Enter a new language:\n"),
        readln(Line),
        assertz(language(Line)). % Add the language to the database

    % Show all people
    choice('3') :-
        know_language(Name, Lang),
        write(Name, " knows ", Lang), nl,
        fail.

    % Show all languages
    choice('4') :-
        language(Lang),
        write(Lang), nl,
        fail.

    % Save the database
    choice('s') :-
        write("Enter the filename to save:\n"),
        readln(Filename),
        save(Filename),
        write("Database saved.\n").

    % Load the database
    choice('l') :-
        write("Enter the filename to load:\n"),
        readln(Filename),
        existfile(Filename), !,
        consult(Filename),
        write("Database loaded.\n");
        write("File not found.\n").

    % Exit
    choice('0') :-
        !.
        

    % Infinite loop
    repeat.
    repeat :- repeat.

goal
    menu.
