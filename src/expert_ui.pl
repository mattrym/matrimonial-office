:- consult('database.pl').
:- consult('rules.pl').

main :-
    format('### Matrimonial office - expert interface ~n'),
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
menu_option(5, edit_person, 'Edit a person from database').
menu_option(6, remove_person, 'Remove a person from database').
menu_option(7, remove_all, 'Remove all the people from database').
menu_option(8, change_feature, 'Change feature of a person').
menu_option(9, remove_feature, 'Remove feature of a person').

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

get_all_info(Id, Name, Surname) :-
    get_field('ID', Id),
    get_field('Name', Name),
    get_field('Surname', Surname).

print_features :-
    feature(Feature, Description),
    format("~p ~\`.t~20| ~s~n", [Feature, Description]),
    fail.
print_features :- !.

print_header :-
    format('~`-t~58|~n'),
    format('|~s~t~5||~s~t~26||~s~t~57||~n', 
        ['Id', 'Name', 'Surname']),
    format('~`-t~58|~n').
    
print_people :-
    person_info(Id, Name, Surname),
    print_person(Id, Name, Surname),
    fail.
print_people :-
    format('~`-t~58|~n').

print_person(Id, Name, Surname) :-
    format('|~p~t~5||~s~t~26||~s~t~57||~n', 
        [Id, Name, Surname]).

print_person_info(Id) :-
    person_info(Id, Name, Surname),
    print_person_feature(name, Name),
    print_person_feature(surname, Surname).

print_person_features(Id) :-
    person_feature(Id, FeatureName, FeatureValue),
    print_person_feature(FeatureName, FeatureValue),
    fail.
print_person_features(_) :- !.

print_person_feature(FeatureName, FeatureValue) :-
    format('~p~t~21|~p~n', [FeatureName, FeatureValue]).

remove_feature(Id, Feature) :-
    retractall(person_feature(Id, Feature, _)), !.
remove_feature(_, _).

% ---------------------------
% actions avialable to expert
% ---------------------------

print_all :-
    format('# Printing all the people ~n'),
    print_header,
    print_people.

print_one :-
    format('# Select a person ID '), read(Id), nl,
    print_person_info(Id),
    print_person_features(Id).    

save_changes :-
    format('# Saving changes...~n'),
    tell('database.pl'),
    listing(person_info),
    listing(person_feature),
    told,
    format('# Changes saved~n').
save_changes :-
    format('# Something went wrong during saving changes~n').

add_person :-
    format('# Adding a new person ~n'),
    get_all_info(Id, Name, Surname), nl,
    not(person_info(Id, _, _)),
    assert(person_info(Id, Name, Surname)),
    format('# Successfully added person #~p~n', [Id]).
add_person :-
    format('# Something went wrong during adding a new person~n').

edit_person :-
    format('# Editing a person ~n'),
    get_all_info(Id, Name, Surname), nl,
    person_info(Id, _, _),
    retract(person_info(Id, _, _)),
    assert(person_info(Id, Name, Surname)),
    format('# Successfully edited person #~p~n', [Id]).
edit_person :-
    format('# Something went wrong during editing a person~n').

change_feature :-
    format('# Changing a feature ~n'),
    get_field('# Select person ID: ', Id), nl,
    person_info(Id, _, _),
    
    format('# Choose feature to change from the following: ~n'),
    print_features,
    get_field('# Select a feature: ', Feature), nl,

    feature_type(Feature, Type, Range),
    format('# Choose ~p from ~p~n', [Type, Range]),
    get_field('# Select value ', Value), nl,

    remove_feature(Id, Feature),
    assert(person_feature(Id, Feature, Value)),
    format('# Successfully changed feature ~p for a person #~p~n', [Feature, Id]).
change_feature :-
    format('# Something went wrong during changing a feature~n').

remove_feature :-
    format('# Removing a feature ~n'),
    get_field('Person ID', Id), nl,
    person_info(Id, _, _),

    format('Choose feature to remove from the following: ~n'),
    print_features,
    get_field('Feature ', Feature), nl,
    
    remove_feature(Id, Feature),
    format('# Successfully changed feature ~s for a person #~p~n', [Feature, Id]).
remove_feature :-
    format('# Something went wrong during changing a feature~n').

remove_person :-
    format('# Removing a person ~n'),
    get_field('Person ID', Id), nl,
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
