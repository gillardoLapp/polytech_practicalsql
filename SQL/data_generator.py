import psycopg2
import uuid
import random
from datetime import datetime, timedelta
import string
from config import load_config
from faker import Faker
import sys

# Initialize Faker for generating realistic data
fake = Faker()

def generate_uuid():
    """Generate a random UUID."""
    return str(uuid.uuid4())

def generate_timestamp(start_date='2020-01-01', end_date='2025-04-03'):
    """Generate a random timestamp between start_date and end_date."""
    start = datetime.strptime(start_date, '%Y-%m-%d')
    end = datetime.strptime(end_date, '%Y-%m-%d')
    time_between_dates = end - start
    days_between_dates = time_between_dates.days
    random_days = random.randrange(days_between_dates)
    random_date = start + timedelta(days=random_days)
    random_hours = random.randrange(24)
    random_minutes = random.randrange(60)
    random_seconds = random.randrange(60)
    return random_date.replace(hour=random_hours, minute=random_minutes, second=random_seconds)

def generate_contact_metadata(num_records=10):
    """Generate random data for ContactMetadata table."""
    contacts = []
    
    for _ in range(num_records):
        contact = {
            'id': generate_uuid(),
            'organization': fake.company(),
            'name': fake.name(),
            'email': fake.email()
        }
        contacts.append(contact)
    
    return contacts

def generate_activity_metadata(num_records=10):
    """Generate random data for ActivityMetadata table."""
    activities = []
    activity_types = ['Analysis', 'Collection', 'Processing', 'Validation', 'Integration']
    software_names = ['DataTool', 'AnalysisPro', 'SensorSuite', 'IntegrationTool', 'ValidationSoftware']
    
    for _ in range(num_records):
        start_time = generate_timestamp()
        # End time is between 1 hour and 24 hours after start time
        end_time = start_time + timedelta(hours=random.randint(1, 24))
        
        activity = {
            'id': generate_uuid(),
            'name': f"{random.choice(['Data', 'Sensor', 'Signal'])} {random.choice(activity_types)}",
            'type': random.choice(activity_types),
            'start': start_time,
            'end_time': end_time,
            'software_name': random.choice(software_names),
            'software_version': f"{random.randint(1, 5)}.{random.randint(0, 9)}.{random.randint(0, 9)}"
        }
        activities.append(activity)
    
    return activities

def generate_product_metadata(activity_ids, contact_ids, num_records=10):
    """Generate random data for ProductMetadata table."""
    products = []
    data_categories = ['Sensor Data', 'Telemetry', 'Analytics', 'Metadata', 'Configuration']
    data_levels = [['Level1'], ['Level1', 'Level2'], ['Level1', 'Level2', 'Level3'], ['Advanced']]
    data_sublevels = [['Sublevel1'], ['Sublevel1', 'Sublevel2'], ['DetailedA', 'DetailedB']]
    data_associations = ['Association1', 'Association2', 'DirectLink', 'IndirectLink']
    data_types = ['TypeA', 'TypeB', 'TypeC', 'Structured', 'Unstructured']
    model_names = []
    a = 0
    for a in range(num_records):
        random_name = ''.join(random.choice(string.ascii_letters) for _ in range(10))
        model_names.append(random_name)


    for i in range(num_records):
        product = {
            'id': generate_uuid(),
            'description': fake.paragraph(nb_sentences=2),
            'creation_time': generate_timestamp(),
            'data_category': random.choice(data_categories),
            'data_levels': random.choice(data_levels),
            'data_sublevels': random.choice(data_sublevels),
            'data_association': random.choice(data_associations),
            'data_type': random.choice(data_types),
            'data_model_version': f"{random.randint(1, 3)}.{random.randint(0, 9)}",
            'data_model_url': f"http://{fake.domain_name()}/models/{fake.slug()}",
            'activity_id': random.choice(activity_ids) if activity_ids else None,
            'contact_id': random.choice(contact_ids) if contact_ids else None,
            'data_model_name': model_names[i]

        }
        products.append(product)
    
    return products

def test_connection(config):
    """Test database connection and print table counts before insertion."""
    try:
        with psycopg2.connect(**config) as conn:
            with conn.cursor() as cur:
                print("Successfully connected to the database!")
                
                # Check if tables exist and get row counts
                tables = ['ContactMetadata', 'ActivityMetadata', 'ProductMetadata']
                for table in tables:
                    try:
                        cur.execute(f"SELECT COUNT(*) FROM {table}")
                        count = cur.fetchone()[0]
                        print(f"Table {table} exists with {count} rows before insertion")
                    except psycopg2.Error as e:
                        print(f"Error checking table {table}: {e}")
                
                return True
    except Exception as e:
        print(f"Connection test failed: {e}")
        return False

def insert_data(config, contacts, activities, products):
    """Insert generated data into database with detailed error handling."""
    conn = None
    try:
        conn = psycopg2.connect(**config)
        with conn.cursor() as cur:
            print("Connected to database. Starting data insertion...")
            
            # Insert contacts
            print("Inserting contacts...")
            for i, contact in enumerate(contacts):
                try:
                    cur.execute(
                        """
                        INSERT INTO ContactMetadata (id, organization, name, email)
                        VALUES (%s, %s, %s, %s)
                        """,
                        (contact['id'], contact['organization'], contact['name'], contact['email'])
                    )
                    print(f"  Contact {i+1}/{len(contacts)} inserted")
                except Exception as e:
                    print(f"  Error inserting contact {i+1}: {e}")
            
            # Insert activities
            print("Inserting activities...")
            for i, activity in enumerate(activities):
                try:
                    cur.execute(
                        """
                        INSERT INTO ActivityMetadata (id, name, type, start, end_time, software_name, software_version)
                        VALUES (%s, %s, %s, %s, %s, %s, %s)
                        """,
                        (
                            activity['id'], activity['name'], activity['type'], 
                            activity['start'], activity['end_time'], 
                            activity['software_name'], activity['software_version']
                        )
                    )
                    print(f"  Activity {i+1}/{len(activities)} inserted")
                except Exception as e:
                    print(f"  Error inserting activity {i+1}: {e}")
            
            # Insert products
            print("Inserting products...")
            for i, product in enumerate(products):
                try:
                    cur.execute(
                        """
                        INSERT INTO ProductMetadata (
                            id, description, creation_time, data_category, data_levels, 
                            data_sublevels, data_association, data_type, data_model_name, 
                            data_model_version, data_model_url, activity_id, contact_id
                        )
                        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                        """,
                        (
                            product['id'], product['description'], product['creation_time'],
                            product['data_category'], product['data_levels'], product['data_sublevels'],
                            product['data_association'], product['data_type'], product['data_model_name'],
                            product['data_model_version'], product['data_model_url'],
                            product['activity_id'], product['contact_id']
                        )
                    )
                    print(f"  Product {i+1}/{len(products)} inserted")
                except Exception as e:
                    print(f"  Error inserting product {i+1}: {e}")
            
            # Explicitly commit the transaction
            print("Committing transaction...")
            conn.commit()
            print("All data committed successfully!")
            
            # Verify the data was inserted
            print("Verifying data insertion...")
            tables = ['ContactMetadata', 'ActivityMetadata', 'ProductMetadata']
            for table in tables:
                cur.execute(f"SELECT COUNT(*) FROM {table}")
                count = cur.fetchone()[0]
                print(f"Table {table} now has {count} rows")
                
    except Exception as e:
        print(f"Database operation failed: {e}")
        if conn:
            print("Rolling back any pending transaction...")
            conn.rollback()
    finally:
        if conn:
            conn.close()
            print("Database connection closed")

def main():
    # Load database configuration
    print("Loading database configuration...")
    try:
        config = load_config()
        print(f"Configuration loaded: {config}")
    except Exception as e:
        print(f"Failed to load configuration: {e}")
        sys.exit(1)
        
    # Test database connection
    if not test_connection(config):
        print("Exiting due to connection failure")
        sys.exit(1)
    
    # Set the number of records to generate for each table
    num_contacts = 10000
    num_activities = 10000
    num_products = 10000
    
    print(f"Generating {num_contacts} contacts, {num_activities} activities, and {num_products} products...")
    
    # Generate data
    contacts = generate_contact_metadata(num_contacts)
    activities = generate_activity_metadata(num_activities)
    
    # Extract IDs for foreign key relationships
    contact_ids = [contact['id'] for contact in contacts]
    activity_ids = [activity['id'] for activity in activities]
    
    products = generate_product_metadata(activity_ids, contact_ids, num_products)
    
    # Insert data into database
    insert_data(config, contacts, activities, products)
    
if __name__ == '__main__':
    main()