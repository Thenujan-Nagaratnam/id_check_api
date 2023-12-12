import ballerina/http;
import ballerina/io;
import ballerina/sql;
import ballerinax/postgresql;
import ballerinax/postgresql.driver as _;

// Types
type User record {|
    string id;
    string name;
    string phone_no;
    string address;
|};

type statusReq record {
    int status;
    string nic;
};

// MySQL configuration parameters
configurable string host = ?;
configurable string username = ?;
configurable string password = ?;
configurable string database = ?;

type NicCheckRequest record {
    string nic;
};

service / on new http:Listener(10636) {

    resource function post nicCheck(@http:Payload NicCheckRequest payload) returns statusReq|error? {
        statusReq|error? isValidNIC = checkNic(payload.nic);
        return isValidNIC;
    }
}

function checkNic(string nic) returns statusReq|error? {

    postgresql:Client dbClient = check new (host = host, username = username, password = password, database = database, port = 10636, connectionPool = {maxOpenConnections: 5});

    string nicLower = string:toLowerAscii(nic);
    string nicUpper = string:toUpperAscii(nic);

    sql:ParameterizedQuery query = `SELECT * FROM "user" WHERE id = ${nicLower.trim()} OR id = ${nicUpper.trim()};`;
    User|error queryRowResponse = dbClient->queryRow(query);
    error? e = dbClient.close();
    io:println(e);
    io:println(queryRowResponse);
    if queryRowResponse is error {
        statusReq result = {
                status: 0,
                nic: nic
            };
        return result;
    } else {
        statusReq result = {
                        status: 2,
                        nic: nic
                    };
        return result;
    }
}

