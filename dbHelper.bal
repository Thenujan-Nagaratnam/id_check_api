// import ballerina/io;
import ballerina/sql;
import ballerinax/postgresql;

configurable string host = ?;
configurable string username = ?;
configurable string database = ?;
configurable string password = ?;
configurable int port = ?;


# Executes the query, which is expected to return at most one row of the result.
# 
# + query - The query to execute.
# + return - The result of the query or error if any error occurred.
function dbQueryRow(sql:ParameterizedQuery query) returns error|sql:ExecutionResult {

    postgresql:Client dbClient = check new (host, username, password,
        database, port, connectionPool = {maxOpenConnections: 5}
    );

    sql:ExecutionResult|error result = dbClient->queryRow(query);

    check dbClient.close();

    // io:println(result);

    return result;
};
