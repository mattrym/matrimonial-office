:- consult('database.pl').

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
menu_option(2, print_one, 'Print information about a single person').
menu_option(3, save_changes, 'Save changes to database').
menu_option(4, add_person, 'Add a person to database').
menu_option(5, change_feature, 'Add or edit feature of a person').
menu_option(6, remove_feature, 'Remove feature of a person').
menu_option(7, edit_person, 'Edit a person from database').
menu_option(8, remove_person, 'Remove a person from database').
menu_option(9, remove_all, 'Remove all the people from database').

% -----------------
% possible features
% -----------------

feature(1, age, fuzzy).
feature(2, gender, sharp).

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

get_field(FieldName, FieldValue) :-
    format('  ~s', [FieldName]), read(FieldValue).

get_all_fields(Id, Name, Surname) :-
    get_field('ID', Id),
    get_field('Name', Name),
    get_field('Surname', Surname).

print_header :-
    format('~`-t~70|~n'),
    format('|~s~t~5||~s~t~26||~s~t~57||~n', 
        ['Id', 'Name', 'Surname']),
    format('~`-t~70|~n').
    
print_people :-
    person_info(Id, Name, Surname),
    print_person(Id, Name, Surname),
    fail.
print_people :-
    format('~`-t~70|~n').

print_person(Id, Name, Surname) :-
    format('|~p~t~5||~s~t~26||~s~t~57||~n', 
        [Id, Name, Surname]).

% ---------------------------
% actions avialable to expert
% ---------------------------

print_all :-
    format('# Printing all the people ~n'),
    print_header,
    print_people.

save_changes :-
    format('# Saving changes...~n'),
    tell('database.pl'),
    listing(person),
    told,
    format('# Changes saved~n').
save_changes :-
    format('# Something went wrong during saving changes~n').

add_person :-
    format('# Adding a new person ~n'),
    get_all_fields(Id, Name, Surname), nl,
    not(person_info(Id, _, _)),
    assert(person_info(Id, Name, Surname)),
    format('# Successfully added person #~p~n', [Id]).
add_person :-
    format('# Something went wrong during adding a new person~n').

edit_person :-
    format('# Editing a person ~n'),
    get_all_fields(Id, Name, Surname), nl,
    person_info(Id, _, _),
    retract(person_info(Id, _, _)),
    assert(person_info(Id, Name, Surname)),
    format('# Successfully edited person #~p~n', [Id]).
edit_person :-
    format('# Something went wrong during editing a person~n').

remove_person :-
    format('# Removing a person ~n'),
    get_field('ID', Id), nl,
    person_info(Id, _, _),
    retract(person_info(Id, _, _)),
    retractall(person_feature(Id, _, _)),
    format('# Successfully removed person #~p~n', [Id]).
remove_person :-
    format('# Something went wrong during removing a person~n').

remove_all :-
    format('# Removing all people ~n'),
    retractall(person_info(_, _, _)),
    retractall(person_feature(_, _, _)),
    format('# Successfully removed all the people~n').
remove_all :-
    format('# Something went wrong during removing all the people~n').
