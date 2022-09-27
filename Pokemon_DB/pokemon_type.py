from pokemon_db_access import *
from pokefields import *

def print_pokemon(pokemon):
    print(pokemon[NAME], pokemon[TYPE])
    print("Statistics")
    print("Attack: ", pokemon[ATTACK], " Defense: ", pokemon[DEFENSE])
    moves = pokemon[MOVES]
    for move in moves:
        print(move)

        
print("Retrieving Pokemons whose defense is greater than 75 and attack greater than 80")
pokemons = retrieve_by_defense_and_attack(75, 80)
for pokemon in pokemons:
    print_pokemon(pokemon)
print(len(pokemons), " pokemons were returned")

