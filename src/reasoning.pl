:- consult('database.pl').

:- dynamic(result/2).
:- dynamic(progress/2).

start_reasoning.

clear_reasoning :-
    retractall(fit(_, _)),
    retractall(progress(_, _)).