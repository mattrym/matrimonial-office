n = 5
import random


def read_names():
    names = []
    with open('names.txt', 'r') as f:
        for line in f.readlines():
            name, surname = line.split(sep=' ')
            names.append((name, surname.strip()))
    return names


def get_age():
    return random.randint(18, 99)


def get_gender():
    genders = ['male', 'female']
    return random.choice(genders)


def get_height():
    return random.randint(130, 250)


def get_lon_lat():
    lon, lat = random.randint(0, 180), random.randint(0, 90)
    return '(' + str(lon) + ', ' + str(lat) + ')'


def get_attractiveness():
    return random.randint(0, 100)


def get_income():
    return random.randint(0, 1000000000)


def get_education():
    education_types = ['elementary', 'secondary', 'academic']
    return random.choice(education_types)


def get_occupation():
    occupation_types = ['teacher', 'scientist', 'driver', 'doctor', 'programmer', 'actor', 'singer', 'cook', 'waiter',
                        'lawyer', 'sportsman',
                        'comedian', 'writer', 'politician', 'model', 'architect', 'engineer', 'mechanic', 'designer',
                        'unemployed']
    return random.choice(occupation_types)


def get_religion():
    religions = ['christian', 'jewish', 'hindu', 'muslim', 'buddhist', 'atheist', 'other']
    return random.choice(religions)


def get_orientation():
    orientations = ['heterosexual', 'homosexual', 'bisexual', 'asexual', 'pansexual']
    return random.choice(orientations)


def get_priorities():
    priorities = ', '.join([str(random.randint(1, 5)) for _ in range(8)])
    return '(' + priorities + ')'


feature_f = [('age', get_age), ('gender', get_gender), ('height', get_height), ('(lon, lat)', get_lon_lat),
             ('attractiveness', get_attractiveness), ('income', get_income), ('education', get_education),
             ('occupation', get_occupation), ('religion', get_religion), ('orientation', get_orientation),
             ('(family, work, hobbies, travelling, wellness, spirituality, partying, development)', get_priorities)]


def write_features_to_file():
    with open('file.txt', 'w') as f:
        names = read_names()
        num_of_ppl = len(names)
        for i, (name, surname) in enumerate(names):
            id = 6 + i
            f.write('person_info(' + str(id) + ', \'' + name + '\', \'' + surname + '\').\n')
        f.write('\n')

        for feature, fun in feature_f:
            for i in range(num_of_ppl):
                id = 6 + i
                f.write('person_feature(' + str(id) + ', ' + feature + ', ' + str(fun()) + ').\n')
            f.write('\n')


if __name__ == '__main__':
    write_features_to_file()
