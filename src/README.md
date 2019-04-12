# Matrimonial office
## project for Expert Systems course

### Introduction
Project was written in [SWI Prolog](http://www.swi-prolog.org/) and its main purpose it to present a possible way to create an expert system which would ease up a task of matching people in the matrimonial office. It uses both classical and fuzzy logic to determine which candidate is the best match. 

### Description

Files `database.pl` and `rules.pl` contain information about a domain - `database.pl` is a dynamic database of members of matrimonial office, and `rules.pl` stores information about features and predicate functions for each feature.

`reasoning.pl` is a reasoning engine which utilises combined fuzzy and classical logic reasoning. Fitting to a specific candidate is called a _score_ and it is later returned as a measurement of conformity to our client.

Modules `expert_ui.pl` and `user_ui.pl` contain interface logic for our users.

### Starting

Run expert interface (used to modify knowledge base about matrimonial office members):
```bash
$ swipl expert_ui.pl
?- main.
```

Run user interface (used to reason about the perfect match to the user):
```bash
swipl expert_ui.pl
?- main.
```
### Final notes
Project was done as a part of assignment for Expert Systems course, being a part of curriculum of Artifical Intelligence path @ Computer Science MSc studies at Faculty of Mathematics and Computer Science (Warsaw University of Technology).
