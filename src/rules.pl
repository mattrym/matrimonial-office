% -----------------
% possible features
% -----------------

feature(age, 'Age').
feature(gender, 'Gender').
feature(height, 'Height').
feature((lon, lat), 'Location').
feature(attractiveness, 'Attractiveness').
feature(income, 'Income').
feature(education, 'Education').
feature(occupation, 'Occupation').
feature(religion, 'Religion').
feature(orientation, 'Sexual orientation').
feature((family, work, hobbies, travelling, wellness, spirituality, partying, development)), 'Life priorities')

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
feature_type((family, work, hobbies, travelling, wellness, spirituality, partying, development), 
(number, number, number, number, number, number, number, number), 
([1, 5], [1, 5], [1, 5], [1, 5], [1, 5], [1, 5], [1, 5], [1, 5])).

% --------------------------------------------
% questions about features and their relevance
% --------------------------------------------

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
question((family, work, hobbies, travelling, wellness, spirituality, partying, development), 
'How important (from 1 (not important) to 5 (very important) are the following life priorities to you: ' +
'family, work, hobbies, travelling, wellness, spirituality, partying, self-development').

relevance_question(age, 'How much do you care about his/her age (from 0 to 1)?').
relevance_question(gender, 'How much do you care about his/her gender (from 0 to 1)?').
relevance_question(height, 'How much do you care about his/her height (from 0 to 1)?').
relevance_question((lon, lat), 'How much do you care about his/her location (from 0 to 1)?').
relevance_question(attractiveness, 'How much do you care about his/her attractiveness level(from 0 to 1)?').
relevance_question(income, 'How much do you care about his/her income (from 0 to 1)?').
relevance_question(education, 'How much do you care about his/her level of education (from 0 to 1)?').
relevance_question(occupation, 'How much do you care about his/her occupation? (from 0 to 1)?').
relevance_question(religion, 'How much do you care about his/her religious affiliation (from 0 to 1)?').
relevance_question(orientation, 'How much do you care about his/her sexual orientation (from 0 to 1)?').
relevance_question((family, work, hobbies, travelling, wellness, spirituality, partying, development), 
'How much do you care about matching his/her life priorities (from 0 to 1)?').

% ---------------
% score functions
% ---------------

deg_to_rad(Deg, Rad) :-
    Rad is Deg * pi / 180.

score(Relevance, age, Answer, Value, Score) :-
    Relevance =:= 0
    -> Score is 1
    ;  Score is max(0, 1 - (abs(Answer - Value) / 20) * Relevance).

score(Relevance, gender, Answer, Value, Score) :- 
    Relevance =:= 0 ; Answer \= Value
    -> Score is 1
    ;  Score is 1 - Relevance.

score(Relevance, height, Answer, Value, Score) :-
    Relevance =:= 0
    -> Score is 1
    ;  Score is max(0, 1 - (abs(Answer - Value) / 40) * Relevance).

score(Relevance, (lon, lat), (LonAns, LatAns), (LonVal, LatVal), Score) :-
    Relevance =:= 0
    -> Score is 1
    ;  (LonAns =:= LonVal), (LatAns =:= LatVal)
        ->  Score is 1
        ;   deg_to_rad(LatAns, LatAnsRad), 
            deg_to_rad(LonAns, LonAnsRad),
            deg_to_rad(LatVal, LatValRad),
            deg_to_rad(LonVal, LonValRad),
            Score is
            max(0, 1 - (abs(6366 * acos(
                (cos(LatAnsRad) * cos(LonAnsRad) * cos(LatValRad) * cos(LonValRad)) + 
                (cos(LatAnsRad) * sin(LonAnsRad) * cos(LatValRad) * sin(LonValRad)) + 
                (sin(LatAnsRad) * sin(LatValRad))) / 500)
                ) * Relevance).


score(Relevance, (family, work, hobbies, travelling, wellness, spirituality, partying, development), 
(familyAns, workAns, hobbiesAns, travellingAns, wellnessAns, spiritualityAns, partyingAns, developmentAns),
(familyVal, workVal, hobbiesVal, travellingVal, wellnessVal, spiritualityVal, partyingVal, developmentVal), Score) :-
    Relevance =:= 0
    -> Score is 1
    ;  Score is max(0, 1 - ((abs(familyAns - familyVal) + 
                                abs(worksAns - worksVal) +
                                abs(familyAns - familyVal) + 
                                abs(hobbiesAns - hobbiesVal) +
                                abs(travellingAns - travellingVal) +
                                abs(wellnessAns - wellnesVal) +
                                abs(spiritualityAns - spiritualityVal) +
                                abs(partyingAns - partyingVal) +
                                abs(developmentAns - developmentVal)) / 16) * Relevance).

score(Relevance, attractiveness, Answer, Value, Score) :-
    Relevance =:= 0
    -> Score is 1
    ;  Score is max(0, 1 - (abs(Answer - Value) / 100) * Relevance).

score(Relevance, income, Answer, Value, Score) :-
    Relevance =:= 0
    -> Score is 1
    ;  Score is max(0, 1 - (abs(Answer - Value) / Answer) * Relevance).
    
score(Relevance, education, Answer, Value, Score) :-
    Relevance =:= 0 ; Answer \= Value
    -> Score is 1
    ;  Score is 1 - Relevance.

score(Relevance, religion, Answer, Value, Score) :-
    Relevance =:= 0 ; Answer \= Value
    -> Score is 1
    ;  Score is 1 - Relevance.

score(Relevance, occupation, Answer, Value, Score) :-
    Relevance =:= 0 ; Answer \= Value
    -> Score is 1
    ;  Score is 1 - Relevance.

score(Relevance, orientation, Answer, Value, Score) :-
    Relevance =:= 0 ; Answer \= Value
    -> Score is 1
    ;  Score is 1 - Relevance.