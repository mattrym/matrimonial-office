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
feature((family, work, hobbies, travelling, wellness, spirituality, partying, development), 'Life priorities').

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
feature_type(occupation, [atom], [[teacher, scientist, driver, doctor, programmer, actor, singer, cook, waiter, lawyer, sportsman, 
    comedian, writer, politician, model, architect, engineer, mechanic, designer, unemployed]]).
feature_type(religion, atom, [christian, jewish, hindu, muslim, buddhist, atheist, other]).
feature_type(orientation, atom, [heterosexual, homosexual, bisexual, asexual, pansexual]).
feature_type((family, work, hobbies, travelling, wellness, spirituality, partying, development), 
(number, number, number, number, number, number, number, number), 
([1, 5], [1, 5], [1, 5], [1, 5], [1, 5], [1, 5], [1, 5], [1, 5])).

% ------------------------
% questions about features
% ------------------------

question(age, 'What should be his/her age?').
question(gender, 'What should be his/her gender? [male, female] ').
question(height, 'What should be his/her height?').
question((lon, lat), 'What location (lon, lat) should he/she be living in? ([0, 180], [0, 90])').
question(attractiveness, 'What should be his/her attractiveness level? [0, 100]').
question(income, 'What should be his/her income (yearly)? [0, 1000000000]').
question(education, 'What level of education should he/she have? [elementary, secondary, academic]').
question(occupation, 'What occupation should he/she have? [teacher, scientist, driver, doctor, programmer, actor, singer, cook, waiter, lawyer, sportsman, comedian, writer, politician, model, architect, engineer, mechanic, designer, unemployed]').
question(religion, 'What should his/her religious affiliation be? [christian, jewish, hindu, muslim, buddhist, atheist, other]').
question(orientation, 'What should be his/her sexual orientation? [heterosexual, homosexual, bisexual, asexual, pansexual]').
question((family, work, hobbies, travelling, wellness, spirituality, partying, development), 
'How important (from 1 (not important) to 5 (very important) are the following life priorities to you: family, work, hobbies, travelling, wellness, spirituality, partying, self-development').

% ---------------
% score functions
% ---------------

deg_to_rad(Deg, Rad) :-
    Rad is Deg * pi / 180.

score(age, Answer, Value, Score) :-
    Score is max(0, 1 - abs(Answer - Value) / 20).

score(gender, Answer, Value, 1) :-
    Answer = Value.
score(gender, [], _, 0).
score(gender, [H|T], Value, Score) :-
    H = Value
    ->  Score is 1
    ;   score(gender, T, Value, Score).

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
    
score(education, Answer, Value, 1) :-
    Answer = Value.
score(education, [], _, 0).
score(education, [H|T], Value, Score) :-
    H = Value
    ->  Score is 1
    ;   score(education, T, Value, Score).

score(religion, Answer, Value, 0) :-
    Answer \= Value, !.
score(religion, _, _, 1).

score(occupation, Answer, Value, 1) :-
    Answer = Value.
score(occupation, [], _, 0).
score(occupation, [H|T], Value, Score) :-
    H = Value
    ->  Score is 1
    ;   score(occupation, T, Value, Score).

score(orientation, Answer, Value, 1) :-
    Answer = Value.
score(orientation, [], _, 0).
score(orientation, [H|T], Value, Score) :-
    H = Value
    ->  Score is 1
    ;   score(orientation, T, Value, Score).

score((family, work, hobbies, travelling, wellness, spirituality, partying, development), (FamilyAns, WorkAns, HobbiesAns, TravellingAns, WellnessAns, SpiritualityAns, PartyingAns, DevelopmentAns), (FamilyVal, WorkVal, HobbiesVal, TravellingVal, WellnessVal, SpiritualityVal, PartyingVal, DevelopmentVal), Score) :-
    Score is max(0, 1 - ((abs(FamilyAns - FamilyVal) + 
                        abs(WorkAns - WorkVal) +
                        abs(FamilyAns - FamilyVal) + 
                        abs(HobbiesAns - HobbiesVal) +
                        abs(TravellingAns - TravellingVal) +
                        abs(WellnessAns - WellnessVal) +
                        abs(SpiritualityAns - SpiritualityVal) +
                        abs(PartyingAns - PartyingVal) +
                        abs(DevelopmentAns - DevelopmentVal)) / 16)).
