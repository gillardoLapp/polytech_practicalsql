import psycopg2
from config import load_config


def connect(config):
    """ Connect to the PostgreSQL database server """
    try:
        # connecting to the PostgreSQL server
        with psycopg2.connect(**config) as conn:
            print('Connected to the PostgreSQL server.')
            return conn
    except (psycopg2.DatabaseError, Exception) as error:
        print(error)


def display_table(config):
    commands = [
        """
        SELECT table_name FROM information_schema.tables
        WHERE table_schema = 'public'
        """
        ]
    try:
        with psycopg2.connect(**config) as conn:
            with conn.cursor() as cur:
                # execute the CREATE TABLE statement
                for command in commands:
                    print(command)
                    cur.execute(command)
                    for table in cur.fetchall():
                        print(table)
    except (psycopg2.DatabaseError, Exception) as error:
        print(error)


if __name__ == '__main__':
    config = load_config()
    connect(config)
    display_table(config)
