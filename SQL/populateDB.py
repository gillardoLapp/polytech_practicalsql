import psycopg2
from config import load_config
from datetime import datetime
import common
import time


def get_activity_metadata(config):
    try:
        with psycopg2.connect(**config) as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT * FROM activity_metadata")
                print("The number of parts: ", cur.rowcount)
                row = cur.fetchone()

                while row is not None:
                    print(row)
                    row = cur.fetchone()

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)


def get_product_metadata(config):
    try:
        with psycopg2.connect(**config) as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT * FROM product_metadata")
                print("The number of parts: ", cur.rowcount)
                row = cur.fetchone()

                while row is not None:
                    print(row)
                    row = cur.fetchone()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)


def insert_activity_metadata(config, name):
    sql = """INSERT INTO activity_metadata(
                activity_metadata_name,
                activity_metadata_type,
                activity_metadata_start,
                activity_metadata_end,
                activity_metadata_software_name,
                activity_metadata_software_version)
             VALUES(%s,%s,%s,%s,%s,%s) RETURNING activity_metadata_id;"""
   
    try:
        with psycopg2.connect(**config) as conn:
            with conn.cursor() as cur:
                # execute the INSERT statement
                cur.execute(sql, (name, 'type', datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S.%f')[:-3], datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S.%f')[:-3], 'calibPipe', 1))

                # get the generated id back                
                rows = cur.fetchone()
                if rows:
                    activity_metadata_id = rows[0]

                # commit the changes to the database
                conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        return activity_metadata_id


def insert_product_metadata(config, description, dataCat, dataLevel, dataSubLevel, fk_activity_metadata_id):
    sql = """INSERT INTO product_metadata(
                product_metadata_description,
                product_metadata_creation_time,
                product_metadata_data_category,
                product_metadata_data_levels,
                product_metadata_data_sublevels,
                product_metadata_data_association,
                product_metadata_data_type,
                fk_activity_metadata_id)
             VALUES(%s,%s,%s,%s,%s,%s,%s,%s) RETURNING product_metadata_id;"""

    try:
        with psycopg2.connect(**config) as conn:
            with conn.cursor() as cur:
                # execute the INSERT statement
                cur.execute(sql, (description, datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S.%f')[:-3], dataCat, 'DL0', 'DL0A', 'SITE', 'SERVICE',  fk_activity_metadata_id))

                # get the generated id back                
                rows = cur.fetchone()
                if rows:
                    product_metadata_id = rows[0]

                # commit the changes to the database
                conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        return product_metadata_id

def display_row(config):
    commands = [
        """
        SELECT p.product_metadata_id, p.product_metadata_description, a.activity_metadata_id, a.activity_metadata_name, p.product_metadata_creation_time
        FROM product_metadata p
        JOIN activity_metadata a
        ON p.fk_activity_metadata_id = a.activity_metadata_id
        WHERE p.product_metadata_data_type='SERVICE' and   p.product_metadata_creation_time > %s - interval '1 minutes';
        """
        ]
    try:
        with psycopg2.connect(**config) as conn:
            with conn.cursor() as cur:
                # execute the CREATE TABLE statement
                for command in commands:
                    print(command)
                    cur.execute(command, (datetime.utcnow(),))
                    for row in cur.fetchall():
                        print(row)
    except (psycopg2.DatabaseError, Exception) as error:
        print(error)


if __name__ == '__main__':
    config = load_config()
    
    for x in range(6000):
        print(x)
        start = time.time()
        fk_activity_metadata_id = insert_activity_metadata(config, "a nice name " + str(x))
        #get_activity_metadata(config)
        insert_product_metadata(config, "a nice desc" + str(x), "A", "DL0", "DL0A", fk_activity_metadata_id)
        #get_product_metadata(config)
    
    # display_row(config)
    end = time.time()
    print(end - start)
    display_row(config)