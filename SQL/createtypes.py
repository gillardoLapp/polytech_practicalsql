import connect
from config import  load_config
conn  = connect.connect(load_config())
cur = conn.cursor()

create_types_query = [ 
    
    """CREATE TYPE ProcessType AS ENUM (
    'proposal_handling',
    'observation_planning',
    'acquisition',
    'observation',
    'data_processing',
    'simulation',
    'maintenance'
);""",
"CREATE TYPE DataFormat AS ENUM ('ECSV', 'FITS', 'HDF5', 'YAML');",
"CREATE TYPE DataCategory AS ENUM ('none','A','B','C');",
"CREATE TYPE DataAssociation AS ENUM ('SITE', 'SUBARRAY', 'TELESCOPE', 'TARGET');",
"CREATE TYPE DataType AS ENUM ('EVENT', 'MONITORING', 'SERVICE');",
"CREATE TYPE DataLevel AS ENUM ('DL0', 'DL1', 'DL2', 'DL3', 'DL4', 'DL5', 'DL6');"
]

"""
for dr in ['ProcessType', 'DataFormat','DataCategory', 'DataAssociation','DataType', 'DataLevel' ]:
    cur.execute(f'drop type if exists {dr}')
conn.commit()
"""

for q in create_types_query:
    cur.execute(q)
conn.commit()
