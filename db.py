import mysql.connector
from mysql.connector import Error
import config

def connect_to_database():
    try:
        connection = mysql.connector.connect(
            host=config.HOST,
            user=config.USER,
            password=config.PASSWORD,
            database=config.DATABASE
        )
        if connection.is_connected():
            return connection
    except Error as e:
        return e