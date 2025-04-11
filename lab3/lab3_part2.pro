domains
    name = symbol
    i = integer
    list = i*

database
    toy(name, i, i, i)

predicates
    nondeterm choice(char)
    menu
    nondeterm repeat
    nondeterm query_a(name, i, i)
    nondeterm query_b(name, i, i)
    nondeterm query_c(i)
    nondeterm query_d(name, name, i)
    nondeterm query_e(name)
    max(list, i)
    max(list, i, i)  % Добавлена объявление для 3-аргументной версии

clauses
    repeat.
    repeat :- repeat.

    toy("doll", 350, 3, 8).
    toy("blocks_blue", 200, 2, 6).
    toy("blocks_green", 150, 2, 6).
    toy("blocks_red", 210, 2, 6).
    toy("ball", 150, 4, 10).
    toy("robot", 500, 7, 12).
    toy("puzzle", 400, 5, 9).
    toy("constructor", 450, 6, 11).
    toy("car", 250, 3, 7).
    toy("pyramid", 180, 1, 4).
    toy("chess", 600, 4, 10).

 menu :-
        repeat,
        write("\n*********************************\n"),
        write("Make your choice:\n"),
        write("1 - Task 1: Toys <= price and suitable for min age\n"),
        write("2 - Task 2: Toys for age range\n"),
        write("3 - Task 3: Total price of blocks\n"),
        write("4 - Task 4: Toys combinable with another\n"),
        write("5 - Task 5: Toys near max price\n"),
        write("6 - Add toy\n"),
        write("7 - Show all toys\n"),
        write("s - Save database\n"),
        write("l - Load database\n"),
        write("0 - Exit\n"),
        write("*********************************\n"),
        readchar(Choice),
        choice(Choice),
        Choice = '0',
        !.
        
    choice('6') :-
        write("Name: "), readln(Name),
        write("Price: "), readint(Price),
        write("Min age: "), readint(MinAge),
        write("Max age: "), readint(MaxAge),
        assert(toy(Name, Price, MinAge, MaxAge)),
        write("Added.\n").

    choice('7') :-
        toy(Name, Price, MinAge, MaxAge),
        write("Name: ", Name, ", Price: ", Price, ", Ages: ", MinAge, "-", MaxAge, "\n"),
        fail.
    choice('7').

    choice('1') :-
        write("Price limit: "), readint(Price),
        write("Min age: "), readint(MinAge),
        query_a(_, Price, MinAge),
        fail.
    choice('1').

    choice('2') :-
        write("Min age: "), readint(ReqMin),
        write("Max age: "), readint(ReqMax),
        query_b(_, ReqMin, ReqMax),
        fail.
    choice('2').

    choice('3') :-
        query_c(Total),
        write("Total for blocks: ", Total, "\n").

    choice('4') :-
        write("Toy name: "), readln(ReqName),
        write("Max total price: "), readint(MaxPrice),
        query_d(_, ReqName, MaxPrice),
        fail.
    choice('4').

    choice('5') :-
        query_e(Name),
        write(Name, "\n"),
        fail.
    choice('5').

    choice('s') :-
        save("toys.dat"),
        write("Saved.\n").

    choice('l') :-
        existfile("toys.dat"),
        consult("toys.dat"),
        write("Loaded.\n").

    choice('0').

    choice(_) :- write("Invalid option.\n").

    /* Остальные предикаты */
    query_a(Name, ReqPrice, ReqMinAge) :-
        toy(Name, Price, MinAge, MaxAge),
        Price <= ReqPrice,
        MinAge <= ReqMinAge,
        MaxAge >= ReqMinAge,
        write(Name, "\n").

    query_b(Name, ReqMin, ReqMax) :-
        toy(Name, _, ToyMin, ToyMax),
        ReqMin <= ToyMax,
        ReqMax >= ToyMin,
        write(Name, "\n").

    query_c(Total) :-
        toy(blocks_red, P1, _, _),
        toy(blocks_blue, P2, _, _),
        toy(blocks_green, P3, _, _),
        Total = P1 + P2 + P3.

    query_d(Name, ReqName, MaxPrice) :-
        toy(ReqName, Price1, _, _),
        toy(Name, Price2, _, _),
        Name <> ReqName,
        Price1 + Price2 <= MaxPrice,
        write(Name, "\n").

    query_e(Name) :-
        findall(P, toy(_, P, _, _), Prices),
        max(Prices, Max),
        toy(Name, Price, _, _),
        Max - Price <= 1.

    /* Исправленная реализация max */
    max([H|T], Max) :- max(T, H, Max).
    max([], Max, Max).
    max([H|T], CurrMax, Max) :-
        H > CurrMax, !, 
        max(T, H, Max).
    max([_|T], CurrMax, Max) :- 
        max(T, CurrMax, Max).

goal
    menu.