import connect
from config import load_config

# Connect to the database
conn = connect.connect(load_config())

# Create a cursor object using the connection
cur = conn.cursor()

# Define your CREATE TABLE SQL statement for ActivityMetadata
create_activity_metadata_query = '''
CREATE TABLE ActivityMetadata (
    name VARCHAR(255),
    id UUID PRIMARY KEY,
    type VARCHAR(255),
    start TIMESTAMP(6),
    Dend TIMESTAMP(6), -- Corrected 'Dataend' to 'end'
    software_name VARCHAR(255),
    software_version VARCHAR(255)
);
'''

# Define your CREATE TABLE SQL statement for ProductMetaData
create_product_metadata_query = '''
CREATE TABLE ProductMetaData (
    description TEXT,
    creation_time TIMESTAMP(6),
    id SERIAL PRIMARY KEY,
    data_category VARCHAR(255),
    data_levels TEXT,
    data_sublevels TEXT,
    data_association TEXT,
    data_type TEXT,
    data_model_name TEXT,
    data_model_version TEXT,
    data_model_url VARCHAR(255),
    activity_id UUID, -- Foreign key to ActivityMetadata
    FOREIGN KEY (activity_id) REFERENCES ActivityMetadata(id)
);
'''

create_processmetadata_query = '''
CREATE TABLE ProcessMetadata (
    type TEXT,
    activity_id UUID, -- Foreign key to ActivityMetadata
    FOREIGN KEY (activity_id) REFERENCES ActivityMetadata(id)
);
'''
create_conetadata_query = '''
CREATE TABLE ContactMetadata (
    organization VARCHAR(255),
    name VARCHAR(255),
    email VARCHAR(255),
    product_id SERIAL PRIMARY KEY, -- Foreign key to ProductMetaData
    FOREIGN KEY (product_id) REFERENCES ProductMetaData(id)
);
'''



# Execute the CREATE TABLE statements
#cur.execute(create_activity_metadata_query)
#cur.execute(create_product_metadata_query)
cur.execute(create_processmetadata_query)

# Commit the transaction
conn.commit()

# Close the cursor and connection
cur.close()
conn.close()
