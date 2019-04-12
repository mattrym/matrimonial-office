:- dynamic person_info/3.

person_info(1, 'Adam', 'Malysz').
person_info(2, 'Beata', 'Kozidrak').
person_info(3, 'Cezary', 'Pazura').
person_info(4, 'Dariusz', 'Michalczewski').
person_info(5, 'Ellen', 'Degeneres').

:- dynamic person_feature/3.

person_feature(1, age, 41).
person_feature(2, age, 58).
person_feature(3, age, 56).
person_feature(4, age, 50).
person_feature(5, age, 61).
person_feature(1, gender, male).
person_feature(2, gender, female).
person_feature(3, gender, male).
person_feature(4, gender, male).
person_feature(5, gender, female).

