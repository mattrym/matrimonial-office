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

get_score(OldScore, NewScore, Score) :-
    Score is (OldScore - ((1- NewScore) / 11)).
    % Score is NewScore.

calculate_score([], Score, Score).
calculate_score([{Feature, Value} | _], OldScore, 0) :-
    get_answer(Feature, Answer),
    score(Feature, Answer, Value, NewScore),
    get_score(OldScore, NewScore, TempScore),
    TempScore =< 0.5, !.
calculate_score([{Feature, Value} | Tail], OldScore, Score) :-
    get_answer(Feature, Answer),
    score(Feature, Answer, Value, NewScore),
    % TempScore is min(OldScore, NewScore),
    get_score(OldScore, NewScore, TempScore),
    calculate_score(Tail, TempScore, Score).

get_answer(Feature, Answer) :-
    progress(Feature, Answer).
get_answer(Feature, Answer) :-
    \+ progress(Feature, Answer),
    ask(Feature, Answer).

ask(Feature, Answer) :-
    question(Feature, Question),
    write(Question), write(' '), read(Answer), nl,
    assertz(progress(Feature, Answer)).

clear_reasoning :-
    retractall(progress(_, _)),
    retractall(result(_, _)), !.
clear_reasoning.
