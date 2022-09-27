from pymongo import MongoClient
from pymongo import errors as mongoerrors



class DBConnect:
    def __init__(self, dbname):
        self.dbname = dbname

    def connect(self):
        self.client = None
        self.db = None
        try:
            self.client = MongoClient(host="localhost", port=27017)
            self.db = self.client[self.dbname]
        except mongoerrors.errors.ConnectionFailure as e:
            print(e)

        return self.db

    def close(self):
        self.client.close()


