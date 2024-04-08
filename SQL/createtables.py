import connect
from config import  load_config
conn  = connect.connect(load_config())
cur = conn.cursor()

create_tables_query= [
    '''CREATE TABLE IF NOT EXISTS InstrumentMetadata (
    class VARCHAR(255),
    type VARCHAR(255),
    subtype VARCHAR(255),
    id UUID,
    PRIMARY KEY (id)
);''',

'''CREATE TABLE IF NOT EXISTS ProcessMetadata (
    type ProcessType,
    id UUID,
    PRIMARY KEY (id),
    instrumentid UUID REFERENCES InstrumentMetadata(id)
);
''',


    '''CREATE TABLE IF NOT EXISTS ActivityMetadata (
    name VARCHAR(255),
    id UUID PRIMARY KEY ,
    type VARCHAR(255),
    start TIMESTAMP,
    "end" TIMESTAMP,
    software_name VARCHAR(255),
    software_version VARCHAR(255),
    processid UUID REFERENCES ProcessMetadata(id)
);''',

'''CREATE TABLE IF NOT EXISTS ContactMetadata (
    organization VARCHAR(255),
    name VARCHAR(255),
    email VARCHAR(255),
    id UUID PRIMARY KEY
);''',

    '''CREATE TABLE IF NOT EXISTS ProductMetadata (
    description VARCHAR(255),
    creation_time TIMESTAMP,
    id UUID PRIMARY KEY, 
    data_category DataCategory,
    data_levels DataLevel[],
    data_sublevels VARCHAR(255)[],
    data_association DataAssociation,
    data_type DataType,
    data_model_name VARCHAR(255),
    data_model_version VARCHAR(255),
    data_model_url VARCHAR(255),
    contactid UUID REFERENCES ContactMetadata(id),
    activityid UUID REFERENCES ActivityMetadata(id)

);'''    
]

for q in create_tables_query:
    cur.execute(q)
    conn.commit()


