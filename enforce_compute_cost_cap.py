Python
# Execution Interceptor Guarding Against High-Cost AI Queries
def enforce_ai_query_runtime_limits(predicted_query_plan):
    # Analyze the engine's query plan before allowing execution
    max_allowed_scanned_bytes = 1099511627776  # Hard limit of 1 Terabyte per AI call
    estimated_bytes_scanned = predicted_query_plan.get("EstimatedBytesScanned", 0)
    
    if estimated_bytes_scanned > max_allowed_scanned_bytes:
        raise CloudComputeCapException(
            f"Query Execution Aborted: Estimated data scan ({estimated_bytes_scanned} bytes) "
            "exceeds corporate AI compute allocation safety caps. Optimize filter partitions."
        )
    return True
