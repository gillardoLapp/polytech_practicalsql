import psycopg2
from config import load_config
import common


def drop_tables(config):
    commands = [
        """DROP TABLE activity_metadata, product_metadata"""
    ]
    common.execute_cmds(commands, config)


def create_tables(config):
    commands = [
            """
            DROP TYPE IF EXISTS data_association CASCADE;
            CREATE TYPE data_association AS ENUM ('SITE', 'SUBARRAY', 'TELESCOP', 'TARGET');
            """,
            """
            DROP TYPE IF EXISTS data_category CASCADE;
            CREATE TYPE data_category AS ENUM ('NONE', 'A', 'B', 'C');
            """,
            """
            DROP TYPE IF EXISTS data_format CASCADE;
            CREATE TYPE data_format AS ENUM ('ECSV', 'FITS', 'HDF5', 'YAML');
            """,
            """
            DROP TYPE IF EXISTS process_type CASCADE;
            CREATE TYPE process_type AS ENUM ('PROPOSAL_HANDLING', 'OBSERVATION_PLANNING', 'ACQUISITION', 'OBSERVATION', 'DATAPROCESSING','SIMULATION', 'MAINTENANCE');
            """,
            """
            DROP TYPE IF EXISTS data_level CASCADE;
            CREATE TYPE data_level AS ENUM ('DL0', 'DL1', 'DL2', 'DL3', 'DL4','DL5', 'DL6');
            """,
            """
            DROP TYPE IF EXISTS data_type CASCADE;
            CREATE TYPE data_type AS ENUM ('EVENT', 'MONITORING', 'SERVICE');
            """,
            """
            CREATE TABLE IF NOT EXISTS activity_metadata (
                activity_metadata_id SERIAL,
                activity_metadata_name VARCHAR(255) NOT NULL,
                activity_metadata_type VARCHAR(255),
                activity_metadata_start TIMESTAMP NOT NULL,
                activity_metadata_end TIMESTAMP NOT NULL,
                activity_metadata_software_name VARCHAR(255),
                activity_metadata_software_version VARCHAR(255),
                PRIMARY KEY(activity_metadata_id)
            )""",
            """
             CREATE TABLE IF NOT EXISTS product_metadata (
                product_metadata_id SERIAL,
                product_metadata_description VARCHAR(255) NOT NULL,
                product_metadata_creation_time TIMESTAMP NOT NULL,
                product_metadata_data_category data_category NOT NULL,
                product_metadata_data_levels data_level NOT NULL,
                product_metadata_data_sublevels VARCHAR(255),
                product_metadata_data_association data_association,
                product_metadata_data_type data_type NOT NULL,
                PRIMARY KEY(product_metadata_id),
                fk_activity_metadata_id SERIAL,
                CONSTRAINT fk_activity_metadata
                    FOREIGN KEY (fk_activity_metadata_id)
                        REFERENCES activity_metadata(activity_metadata_id)
                            ON UPDATE CASCADE ON DELETE CASCADE
            )"""]
    common.execute_cmds(commands, config)


def display_row(config):
    commands = [
        """
        SELECT p.product_metadata_id, p.product_metadata_description, a.activity_metadata_id, a.activity_metadata_name
        FROM product_metadata p
        JOIN activity_metadata a
        ON p.fk_activity_metadata_id = a.activity_metadata_id
        WHERE p.product_metadata_data_type='SERVICE';
        """
        ]
    try:
        with psycopg2.connect(**config) as conn:
            with conn.cursor() as cur:
                # execute the CREATE TABLE statement
                for command in commands:
                    print(command)
                    cur.execute(command)
                    for row in cur.fetchall():
                        print(row)
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
    drop_tables(config)
    create_tables(config)
    display_table(config)