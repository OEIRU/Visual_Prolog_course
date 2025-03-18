% TODO
% [x] 1. Переработать domains
% [ ] 2. Добавить проверки на некорректный ввод
% [ ] 3. Проверка пустоты
% [ ] 4. Проверка на логику возвраста

domains
	name = symbol
	i = integer
	list = i*
database
	toy_name(name)
	toy(name,integer,integer,integer)
	price(integer)
	minage(integer)
	maxage(integer)

predicates
	nondeterm choice(integer)
	menu
	nondeterm repeat
	nondeterm query_a(name,integer,integer)
	nondeterm query_b(name,integer,integer)
	nondeterm query_c(integer) 	
	nondeterm query_d(name,symbol,integer)		
	nondeterm query_e(name)
	nondeterm max(list,integer)

clauses

	menu :-		
		repeat,		
		write(" ********************************* "),nl,
		write("Make your choice:\n"),
		write("1 - task 1\n"),
		write("2 - task 2\n"),
		write("3 - task 3\n"),
		write("4 - task 4\n"),
		write("5 - task 5\n"),
		write("6 - add information about toy\n"),
		write("7 - show all toys\n"),
		write("s - save database in file\n"),
		write("l - load database from file\n"),
		write("0 - exit\n"),
		write(" ********************************* "),nl,
		readchar(Choice),
		choice(Choice),
		Choice='0',
		!.
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

	choice('6'):-		% Добавление человека
		write("Name of adding toy: "),
		readln(Name),
		write("Price: "),
		readint(Price),
		write("Minimum age: "),
		readint(MinAge),
		write("Miximum age: "),
		readint(MaxAge),
		assert(toy(Name, Price, MinAge, MaxAge)),
		fail.

	choice('7'):-
		write("The presence of toys in the database:\n"),
		toy(Name,Price,MinAge,MaxAge),
		write("Name : ",Name, ";   Price : ",Price,";   Minimum age : ", MinAge,";   Maximum age : ",MaxAge),nl.
	choice('1'):-
		write("Enter price: "),
		readint(Price),
		write("Enter minimum age: "),
		readint(MinAge),
		query_a(_,Price,MinAge).
	choice('2'):-
		write("Enter minimum age: "),
		readint(ReqMinAge),
		write("Enter maximum age: "),
		readint(ReqMaxAge),
		query_b(_,ReqMinAge,ReqMaxAge).
	choice('3'):-
		query_c(_).
	choice('4'):-
		write("Enter name: "),
		readln(ReqName),
		write("Enter price: "),
		readint(ReqPrice),
		query_d(_,ReqName,ReqPrice).
	choice('5'):-
		query_e(_).
	choice('s'):-		% Сохранение базы в файл
		save("C:\base"),
		write("Information saved successfully\n").

	choice('l'):-		% Загрузка базы из файла 
		existfile("E:\base"),!,
		consult("E:\base").

		choice('0') :-
		!.
	
	query_a(Name,ReqPrice,ReqMinAge):-
        	toy(Name,Price,Minage,_), 
		Price <= ReqPrice,
		Minage <= ReqMinAge,
		write(Name),nl.

	query_b(Name,ReqAge1,ReqAge2):-
		toy(Name,_,Minage,MaxAge),
		ReqAge1 >= MinAge,
		ReqAge2 <= MaxAge,
		write(Name),nl.

	query_c(Price):-
		toy(red_blocks,Price1, _, _),  
		toy(blue_blocks,Price2, _, _),
		toy(pink_blocks,Price3, _, _),
		toy(yellow_blocks,Price4, _, _),
		Price=(Price1+Price2+Price3+Price4),
		write(Price),nl.

	query_d(Name,ReqName, ReqPrice):-
		findall(N,toy(ReqName,N,_,_),L),
		L=[H|_],
		toy(Name,Price,_,_),
		H+Price <= ReqPrice,
		"ball"<>Name,
		write(Name),nl.

	query_e(Name):-
		findall(Price, toy(_,Price,_,_), L),
		max(L,Max),
		toy(Name,Price,_,_),
		(Max-Price) <= 1,
		write(Name),nl.
        
	max([Head|Tail],Result):-
        	max(Tail,Result), Result > Head,!.
    	max([Head|_],Head).	
	
goal
    menu.
