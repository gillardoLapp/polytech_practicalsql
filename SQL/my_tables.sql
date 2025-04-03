-- Create ContactMetadata table
/*CREATE TABLE ContactMetadata (
    id UUID PRIMARY KEY,
    organization VARCHAR(255),
    name VARCHAR(255),
    email VARCHAR(255)
);

-- Create ProductMetadata table  
CREATE TABLE ProductMetadata (
    id UUID PRIMARY KEY,
    description VARCHAR(255),
    creation_time TIMESTAMP,
    data_category VARCHAR(255),
    data_levels TEXT[], -- Using array type for List[DataLevel]
    data_sublevels TEXT[], -- Using array type for List[string]
    data_association VARCHAR(255), -- DataAssociation type
    data_type VARCHAR(255), -- DataType enum
    data_model_name VARCHAR(255),
    data_model_version VARCHAR(255),
    data_model_url VARCHAR(255),
    contact_id UUID,
    FOREIGN KEY (product_id) REFERENCES ContactMetadata(id)
);

-- Create ActivityMetadata table
CREATE TABLE ActivityMetadata (
    id UUID PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(255), -- ActivityType enum
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    software_name VARCHAR(255),
    software_version VARCHAR(255),
    product_id UUID,
    FOREIGN KEY (contact_id) REFERENCES ProductMetadata(id)
); */
CREATE TABLE ActivityMetadata (
    id UUID PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(50),
    start TIMESTAMP,
    end_time TIMESTAMP,
    software_name VARCHAR(255),
    software_version VARCHAR(50)
);

CREATE TABLE ContactMetadata (
    id UUID PRIMARY KEY,
    organization VARCHAR(255),
    name VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE ProductMetadata (
    id UUID PRIMARY KEY,
    description TEXT,
    creation_time TIMESTAMP,
    data_category VARCHAR(50),
    data_levels TEXT[],  -- Array in PostgreSQL or JSON in MySQL
    data_sublevels TEXT[], 
    data_association VARCHAR(50),
    data_type VARCHAR(50),
    data_model_name VARCHAR(255),
    data_model_version VARCHAR(50),
    data_model_url TEXT,
    activity_id UUID REFERENCES ActivityMetadata(id) ON DELETE SET NULL,
    contact_id UUID REFERENCES ContactMetadata(id) ON DELETE SET NULL
);
