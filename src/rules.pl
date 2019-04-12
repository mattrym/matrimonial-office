% -----------------
% possible features
% -----------------

feature(age,    'Age').
feature(gender, 'Gender').

% --------------------
% features' properties
% --------------------

feature_type(age, number, [18, 99]).
feature_type(gender, atom, [male, female]).

% ------------------------
% questions about features
% ------------------------

question(age, 'What should be his/her age?').
question(gender, 'What should be his/her gender?').

% ---------------
% score functions
% ---------------

score(age, Answer, Value, Score) :-
    Score is max(0, 1 - abs(Answer - Value) / 20).

score(gender, Answer, Value, 0) :- Answer \= Value, !.
score(gender, _, _, 1).