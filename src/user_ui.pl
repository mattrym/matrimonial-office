:- consult('reasoning.pl').

main :-
    format('### Matrimonial office - user interface ###~n'),
    start_reasoning,
    print_result,
    clear_reasoning.

% ------------------
% user data handling
% ------------------

print_result :-
    print_header,
    print_results,
    print_footer.

print_header :-
    format('~`-t~67|~n'),
    format('|~s~t~5||~s~t~26||~s~t~57||~s~t~64||~n', 
        ['Id', 'Name', 'Surname', 'Score']),
    format('~`-t~65|~n').

print_results :-
    result(Id, Score),
    person_info(Id, Name, Surname),
    print_person(Id, Name, Surname, Score),
    fail.
print_results :- !. 

print_person(Id, Name, Surname, Score) :-
    format('|~p~t~5||~s~t~26||~s~t~57||~s~t~64||~n', 
        [Id, Name, Surname, Score]).

print_footer :-
    format('~`-t~65|~n').
