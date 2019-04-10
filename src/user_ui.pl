:- consult('reasoning.pl').

main :-
    format('### Matrimonial office - user interface ###~n'),
    format('Choose an action: #~n'),
    list_menu_options,
    choose_menu_option.

% ------------
% menu options
% ------------

menu_option(0, quit, 'Quit program').
menu_option(1, find_people, 'Find people matching best for you').

% ----------------------------------
% manipulating the flow of interface
% ----------------------------------

list_menu_options :-
    menu_option(Index, _Action, Description),
    format('  ~p. ~s~n', [Index, Description]),
    fail.
list_menu_options :- !.

choose_menu_option :-
    write('Action '), read(Index), nl, !,
    search_action(Index, Action),
    Action,
    maybe_quit(Action).

search_action(Index, Action) :-
    menu_option(Index, Action, _), !.
search_action(_, empty) :-
    format('# Unknown option, try again...~n').

maybe_quit(quit) :- !.
maybe_quit(_) :- main.

quit.
empty.

% ------------------
% user data handling
% ------------------

field(1, id, 'ID').
field(2, name, 'Name').
field(3, surname, 'Surname').
field(4, gender, 'Gender').
field(5, age, 'Age').

get_field(FieldName, FieldValue) :-
    format('  ~s', [FieldName]), read(FieldValue).

get_all_fields(Id, Name, Surname, Gender, Age) :-
    get_field('ID', Id),
    get_field('Name', Name),
    get_field('Surname', Surname),
    get_field('Gender', Gender),
    get_field('Age', Age).

print_result :-
    print_header,
    print_fits,
    print_footer.

print_header :-
    format('~`-t~67|~n'),
    format('|~s~t~5||~s~t~26||~s~t~57||~s~t~64||~n', ['Id', 'Name', 'Surname', 'Score']),
    format('~`-t~65|~n').

print_fits :-
    fit(Id, Score),
    person(Id, Name, Surname, _, _),
    print_person(Id, Name, Surname, Score),
    fail.
print_fits :- !. 

print_footer :-
    format('~`-t~65|~n').

print_person(Id, Name, Surname, Score) :-
    format('|~p~t~5||~s~t~26||~s~t~57||~s~t~64||~n', [Id, Name, Surname, Score]).

% -------------------------
% actions avialable to user
% -------------------------

find_people :-
    start_reasoning,
    print_result,
    clear_reasoning.
