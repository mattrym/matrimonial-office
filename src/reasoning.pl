:- consult('database.pl').
:- consult('rules.pl').

:- dynamic(progress/2).
:- dynamic(result/2).

start_reasoning :-
    person_info(Id, _, _),
    reason_person(Id),
    fail.
start_reasoning :- !.

reason_person(Id) :-
    findall({Feature, Value}, person_feature(Id, Feature, Value), FVs),
    calculate_score(FVs, 1, Score), Score > 0,
    assertz(result(Id, Score)).

calculate_score([], Score, Score).
calculate_score([{Feature, Value} | _], _, 0) :-
    get_answer(Feature, Answer),
    score(Feature, Answer, Value, NewScore),
    NewScore =< 0, !.
calculate_score([{Feature, Value} | Tail], OldScore, Score) :-
    get_answer(Feature, Answer),
    score(Feature, Answer, Value, NewScore),
    TempScore is min(OldScore, NewScore),
    calculate_score(Tail, TempScore, Score).

get_answer(Feature, Answer) :-
    progress(Feature, Answer).
get_answer(Feature, Answer) :-
    \+ progress(Feature, Answer),
    ask(Feature, Answer).

ask(Feature, Answer) :-
    question(Feature, Question),
    writeln(Question), read(Answer), nl,
    assertz(progress(Feature, Answer)).

clear_reasoning :-
    retractall(progress(_, _)),
    retractall(result(_, _)), !.
clear_reasoning.
