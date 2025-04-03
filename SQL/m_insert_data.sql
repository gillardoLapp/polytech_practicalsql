INSERT INTO ActivityMetadata (id, name, type, start, end_time, software_name, software_version) 
VALUES ('550e8400-e29b-41d4-a716-446655440000', 'Data Processing', 'Analysis', '2025-04-03 10:00:00', '2025-04-03 12:00:00', 'AnalysisTool', '1.0');


INSERT INTO ContactMetadata (id, organization, name, email) 
VALUES ('660e8400-e29b-41d4-a716-446655440000', 'Tech Corp', 'John Doe', 'johndoe@example.com');

INSERT INTO ProductMetadata (id, description, creation_time, data_category, data_levels, data_sublevels, data_association, data_type, data_model_name, data_model_version, data_model_url, activity_id, contact_id) 
VALUES (
    '770e8400-e29b-41d4-a716-446655440000', 
    'Sample product metadata', 
    '2025-04-03 12:30:00', 
    'Sensor Data', 
    ARRAY['Level1'],  -- PostgreSQL format, use JSON for MySQL
    ARRAY['Sublevel1'], 
    'Association1', 
    'TypeA', 
    'Model-X', 
    '1.2', 
    'http://example.com/model-x', 
    '550e8400-e29b-41d4-a716-446655440000', -- Matches ActivityMetadata.id
    '660e8400-e29b-41d4-a716-446655440000'  -- Matches ContactMetadata.id
);
