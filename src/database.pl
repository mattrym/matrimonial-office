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

person_feature(1, height, 170).
person_feature(2, height, 159).
person_feature(3, height, 185).
person_feature(4, height, 184).
person_feature(5, height, 171).

person_feature(1, (lon, lat), (51, 19)).
person_feature(2, (lon, lat), (51, 19)).
person_feature(3, (lon, lat), (51, 19)).
person_feature(4, (lon, lat), (51, 19)).
person_feature(5, (lon, lat), (37, 95)).

person_feature(1, attractiveness, 60).
person_feature(2, attractiveness, 86).
person_feature(3, attractiveness, 70).
person_feature(4, attractiveness, 45).
person_feature(5, attractiveness, 70).

person_feature(1, income, 4470000).
person_feature(2, income, 1650000).
person_feature(3, income, 1000000).
person_feature(4, income, 19300000).
person_feature(5, income, 300000000).

person_feature(1, education, secondary).
person_feature(2, education, secondary).
person_feature(3, education, academic).
person_feature(4, education, secondary).
person_feature(5, education, academic).

person_feature(1, occupation, sportsman).
person_feature(2, occupation, singer).
person_feature(3, occupation, actor).
person_feature(4, occupation, sportsman).
person_feature(5, occupation, comedian).

person_feature(1, religion, christian).
person_feature(2, religion, atheist).
person_feature(3, religion, christian).
person_feature(4, religion, christian).
person_feature(5, religion, atheist).

person_feature(1, orientation, heterosexual).
person_feature(2, orientation, heterosexual).
person_feature(3, orientation, heterosexual).
person_feature(4, orientation, heterosexual).
person_feature(5, orientation, homosexual).

person_feature(1, (family, work, hobbies, travelling, wellness, spirituality, partying, development), (5, 5, 5, 1, 3, 3, 1, 4)).
person_feature(2, (family, work, hobbies, travelling, wellness, spirituality, partying, development), (3, 5, 3, 4, 5, 1, 5, 5)).
person_feature(3, (family, work, hobbies, travelling, wellness, spirituality, partying, development), (4, 4, 2, 2, 2, 4, 4, 3)).
person_feature(4, (family, work, hobbies, travelling, wellness, spirituality, partying, development), (1, 2, 3, 1, 4, 1, 5, 1)).
person_feature(5, (family, work, hobbies, travelling, wellness, spirituality, partying, development), (4, 5, 2, 2, 5, 3, 3, 4)).