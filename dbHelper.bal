// import ballerina/io;
import ballerina/sql;
import ballerinax/postgresql;

configurable string host = ?;
configurable string username = ?;
configurable string database = ?;
configurable string password = ?;
configurable int port = ?;

function dbQueryRow(sql:ParameterizedQuery query) returns error|sql:ExecutionResult {

    // io:println("Hello world");
    postgresql:Client dbClient = check new (host, username, password,
        database, port, connectionPool = {maxOpenConnections: 5}
    );

    sql:ExecutionResult|error result = dbClient->queryRow(query);

    check dbClient.close();

    // io:println(result);

    return result;
};
