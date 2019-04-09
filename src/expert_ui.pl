:- consult('user_database.pl').

main :-
    format('### Matrimonial office - expert interface ###~n'),
    format(' Choose an action: ~n'),
    list_menu_options,
    choose_menu_option.

% ------------
% menu options
% ------------

menu_option(0, quit, 'Quit program').
menu_option(1, print_all, 'Print all people from database').
menu_option(2, save_people, 'Save changes to database').
menu_option(3, add_person, 'Add a person to database').
menu_option(4, edit_person, 'Edit a person from database').
menu_option(5, remove_person, 'Remove a person from database').
menu_option(6, remove_all, 'Remove all the people from database').

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

print_header :-
    format('~`-t~70|~n'),
    format('|~s~t~5||~s~t~26||~s~t~57||~s~t~64||~s~t~69||~n', ['Id', 'Name', 'Surname', 'Gender', 'Age']),
    format('~`-t~70|~n').
    
print_people :-
    person(Id, Name, Surname, Gender, Age),
    print_person(Id, Name, Surname, Gender, Age),
    fail.
print_people :-
    format('~`-t~70|~n').

print_person(Id, Name, Surname, Gender, Age) :-
    format('|~p~t~5||~s~t~26||~s~t~57||~s~t~64||~p~t~69||~n', [Id, Name, Surname, Gender, Age]).

% ---------------------------
% actions avialable to expert
% ---------------------------

print_all :-
    format('# Printing all the people ~n'),
    print_header,
    print_people.

save_people :-
    format('# Saving changes...~n'),
    tell('user_database.pl'),
    listing(person),
    told,
    format('# Changes saved~n').
save_people :-
    format('# Something went wrong during saving changes~n').

add_person :-
    format('# Adding a new person ~n'),
    get_all_fields(Id, Name, Surname, Gender, Age), nl,
    not(person(Id, _, _, _, _)),
    assert(person(Id, Name, Surname, Gender, Age)),
    format('# Successfully added person #~p~n', [Id]).
add_person :-
    format('# Something went wrong during adding a new person~n').

edit_person :-
    format('# Editing a person ~n'),
    get_all_fields(Id, Name, Surname, Gender, Age), nl,
    person(Id, _, _, _, _),
    retract(person(Id, _, _, _, _)),
    assert(person(Id, Name, Surname, Gender, Age)),
    format('# Successfully edited person #~p~n', [Id]).
edit_person :-
    format('# Something went wrong during editing a person~n').

remove_person :-
    format('# Removing a person ~n'),
    get_field('ID', Id), nl,
    person(Id, _, _, _, _),
    retract(person(Id, _, _, _, _)),
    format('# Successfully removed person #~p~n', [Id]).
remove_person :-
    format('# Something went wrong during removing a person~n').

remove_all :-
    format('# Removing all people ~n'),
    retractall(person(_, _, _, _, _)),
    format('# Successfully removed all the people~n').
