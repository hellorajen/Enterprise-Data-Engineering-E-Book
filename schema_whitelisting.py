Python
import sqlglot

def validate_ai_generated_sql(raw_ai_sql):
    allowed_tables = ["gold.dim_customer", "gold.dim_date", "gold.fact_policy_transactions"]
    
    try:
        # Parse and break down the AI-generated SQL query text completely
        parsed_query = sqlglot.parse_one(raw_ai_sql)
        
        # Extract and verify every table target referenced in the query
        for table in parsed_query.find_all(sqlglot.exp.Table):
            table_identifier = f"{table.db}.{table.name}" if table.db else table.name
            if table_identifier not in allowed_tables:
                raise ViolationException(
                    f"Security Block: AI query attempted to access unverified table: {table_identifier}"
                )
    except Exception as e:
        raise SecurityBlockException(f"SQL Validation Engine failed: {str(e)}")
        
    return True
