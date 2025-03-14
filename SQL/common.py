import psycopg2


def execute_cmds(commands, config):
    try:
        with psycopg2.connect(**config) as conn:
            with conn.cursor() as cur:
                for command in commands:
                    print(command)
                    cur.execute(command)
    except (psycopg2.DatabaseError, Exception) as error:
        print(error)


def load_config(filename='database.ini', section='postgresql'):
    from configparser import ConfigParser
    parser = ConfigParser()
    parser.read(filename)

    db = {}
    if parser.has_section(section):
        params = parser.items(section)
        for param in params:
            db[param[0]] = param[1]
    else:
        raise Exception(f'Section {section} not found in the {filename} file')

    return db
