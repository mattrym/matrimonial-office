% -----------------
% possible features
% -----------------

feature(age,    'Age').
feature(gender, 'Gender').
feature(height, 'Height').
feature((lon, lat), 'Location').
feature(attractiveness, 'Attractiveness').
feature(income, 'Income').
feature(education, 'Education').
feature(occupation, 'Occupation').
feature(religion, 'Religion').
feature(orientation, 'Sexual orientation').

% --------------------
% features' properties
% --------------------

feature_type(age, number, [18, 99]).
feature_type(gender, atom, [male, female]).
feature_type(height, number, [130, 250]).
feature_type((lon, lat), (number, number), ([0, 180], [0, 90])).
feature_type(attractiveness, number, [0, 100]).
feature_type(income, number, [0, 1000000000]).
feature_type(education, atom, [elementary, secondary, academic]).
feature_type(occupation, atom, [teacher, scientist, driver, doctor, programmer, actor, singer, cook, waiter, lawyer, sportsman, 
    comedian, writer, politician, model, architect, engineer, mechanic, designer, unemployed]).
feature_type(religion, atom, [christian, jewish, hindu, muslim, buddhist, atheist, other]).
feature_type(orientation, atom, [heterosexual, homosexual, bisexual, asexual, pansexual]).

% ------------------------
% questions about features
% ------------------------

question(age, 'What should be his/her age?').
question(gender, 'What should be his/her gender?').
question(height, 'What should be his/her height?').
question((lon, lat), 'What location (lon, lat) should he/she be living in').
question(attractiveness, 'What should be his/her attractiveness level?').
question(income, 'What should be his/her income (yearly)?').
question(education, 'What level of education should he/she have?').
question(occupation, 'What occupation should he/she have?').
question(religion, 'What should his/her religious affiliation be?').
question(orientation, 'What should be his/her sexual orientation').

% ---------------
% score functions
% ---------------

deg_to_rad(Deg, Rad) :-
    Rad is Deg * pi / 180.

score(age, Answer, Value, Score) :-
    Score is max(0, 1 - abs(Answer - Value) / 20).

score(gender, Answer, Value, 0) :- 
    Answer \= Value, !.
score(gender, _, _, 1).

score(height, Answer, Value, Score) :-
    Score is max(0, 1 - abs(Answer - Value) / 40).

score((lon, lat), (LonAns, LatAns), (LonVal, LatVal), Score) :-
    (LonAns =:= LonVal ), (LatAns =:= LatVal)
    ->  Score is 1
    ;   deg_to_rad(LatAns, LatAnsRad), 
        deg_to_rad(LonAns, LonAnsRad),
        deg_to_rad(LatVal, LatValRad),
        deg_to_rad(LonVal, LonValRad),
        Score is
        max(0, 1 - abs(6366 * acos(
            (cos(LatAnsRad) * cos(LonAnsRad) * cos(LatValRad) * cos(LonValRad)) + 
            (cos(LatAnsRad) * sin(LonAnsRad) * cos(LatValRad) * sin(LonValRad)) + 
            (sin(LatAnsRad) * sin(LatValRad))) / 500)
            ).

score(attractiveness, Answer, Value, Score) :-
    Score is max(0, 1 - abs(Answer - Value) / 100).

score(income, Answer, Value, Score) :-
    Score is max(0, 1 - abs(Answer - Value) / Answer).
    
score(education, Answer, Value, 0) :-
    Answer \= Value, !.
score(education, _, _, 1).

score(religion, Answer, Value, 0) :-
    Answer \= Value, !.
score(religion, _, _, 1).

score(occupation, Answer, Value, 0) :-
    Answer \= Value, !.
score(occupation, _, _, 1).

score(orientation, Answer, Value, 0) :-
    Answer \= Value, !.
score(orientation, _, _, 1).