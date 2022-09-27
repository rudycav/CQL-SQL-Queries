from pymongo import errors as mongoerrors

from db_connect import DBConnect
from pokefields import *

def retrieve_by_name(name):
    try:
        dbconnect = DBConnect("red")
        db = dbconnect.connect()
        coll = db.pokemon
        query = {NAME: name}
        print("query is", query)
        pokemon = coll.find_one(query)
        return pokemon
    except mongoerrors.PyMongoError as e:
        print(e)
        return None
    finally:
        if dbconnect != None:
          dbconnect.close()


def retrieve_by_type(type):
    try:
        dbconnect = DBConnect("red")
        db = dbconnect.connect()
        coll = db.pokemon
        query = {TYPE: type}
        print("query is", query)
        pokemon = list(coll.find(query))
        return pokemon
    except mongoerrors.PyMongoError as e:
        print(e)
        return []
    finally:
        if dbconnect != None:
            dbconnect.close()


def retrieve_by_move_and_type(move, type):
    try:
        dbconnect = DBConnect("red")
        db = dbconnect.connect()
        coll = db.pokemon
        query = {MOVES: move, TYPE: type}
        print("query is", query)
        pokemon = list(coll.find(query))
        return pokemon
    except mongoerrors.PyMongoError as e:
        print(e)
        return []
    finally:
        if dbconnect != None:
            dbconnect.close()


def retrieve_by_defense_and_attack(defense, attack):
    try:
        dbconnect = DBConnect("red")
        db = dbconnect.connect()
        coll = db.pokemon
        query = {DEFENSE: {"$gt": defense}, ATTACK: {"$gt": attack}}
        print("query is", (query))
        pokemon = list(coll.find(query))
        return pokemon
    except mongoerrors.PyMongoError as e:
        print(e)
        return []
    finally:
        if dbconnect != None:
            dbconnect.close()