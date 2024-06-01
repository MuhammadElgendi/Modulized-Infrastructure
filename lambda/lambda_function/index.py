import json
import psycopg2

def lambda_handler(event, context):
    # RDS settings
    rds_host  = "your_rds_endpoint"
    name = "your_username"
    password = "your_password"
    db_name = "your_dbname"
    
    try:
        # Establish connection to the RDS PostgreSQL database
        conn = psycopg2.connect(host=rds_host, database=db_name, user=name, password=password)
        cursor = conn.cursor()
        
        # Example query: Fetch the current time from the database
        cursor.execute("SELECT NOW()")
        rows = cursor.fetchall()
        
        # Return the current time fetched from the database
        return {
            'statusCode': 200,
            'body': json.dumps({'time': str(rows[0][0])})
        }
        
    except Exception as e:
        # Handle any errors that occur during the connection or query execution
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
    finally:
        # Ensure the database connection is closed
        if conn:
            conn.close()
