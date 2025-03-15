domains
    toy_name = string.
    price = integer.
    age = integer.

predicates
    nondeterm toy(toy_name, price, age, age).
    nondeterm query_a(toy_name).
    nondeterm query_b(toy_name).
    nondeterm query_c(price).
    nondeterm query_d(toy_name, toy_name).
    nondeterm query_e(toy_name).
    nondeterm is_max_price(price).
    nondeterm has_higher_price(price). 

clauses
    % Toy database: name, price, min_age, max_age
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

% Query a: Toys with price <= 400 and suitable for 5-year-olds
query_a(Toy) :-
toy(Toy, Price, MinAge, MaxAge),
    Price <= 400,
    MinAge <= 5,
    MaxAge >= 5.

% Query b: Toys suitable for both 4-year-olds and 10-year-olds
query_b(Toy) :-
    toy(Toy, _, MinAge, MaxAge),
    MinAge <= 4, MaxAge >= 4,
    MinAge <= 10, MaxAge >= 10.

% Query c: Prices of all "blocks"
query_c(Price) :-
    toy(blocks_blue, Price, _, _); 
    toy(blocks_green, Price, _, _);
    toy(blocks_red, Price, _, _).

% Query d: Can a grandfather buy a toy (not a ball) for a 3-year-old
% and a ball, with the total cost not exceeding 500 rubles?
query_d(Toy1, Toy2) :-
    toy(Toy1, Price1, MinAge1, MaxAge1),
    toy(Toy2, Price2, _, _),
    Toy1 <> "ball",
    Toy2 = "ball",
    MinAge1 <= 3, MaxAge1 >= 3,
    Price1 + Price2 <= 500.

% Query e: Names of the most expensive toys (price differs from the max by no more than 100)
query_e(Toy) :-
    is_max_price(MaxPrice),         
    toy(Toy, Price, _, _),          
    Price >= MaxPrice - 100.

% check max price
is_max_price(MaxPrice) :-
    toy(_, MaxPrice, _, _),
    not(has_higher_price(MaxPrice)).

% check better high price
has_higher_price(MaxPrice) :-
    toy(_, Price, _, _),
    Price > MaxPrice.
        
goal
    %query_a(Toy).
    %query_b(Toy).
    %query_c(Price).
    %query_d(Toy1, Toy2).
    %query_e(Toy).