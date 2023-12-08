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

type isValid record {
    boolean valid;
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

service / on new http:Listener(25416) {

    resource function post nicCheck(@http:Payload NicCheckRequest payload) returns isValid|error? {
        isValid|error? isValidNIC = checkNic(payload.nic);
        return isValidNIC;
    }
}

function checkNic(string nicOld) returns isValid|error? {

    postgresql:Client dbClient = check new (host = host, username = username, password = password, database = database, port = 25416);

    string nic = string:toLowerAscii(nicOld);
    sql:ParameterizedQuery query = `select * from "user" where id=${nic.trim()};`;
    User|error queryRowResponse = dbClient->queryRow(query);
    error? e = dbClient.close();
    io:println(e);
    io:println(queryRowResponse);
    if queryRowResponse is error {
        isValid result = {
                valid: false,
                nic: nic
            };
        return result;
    } else {
        isValid result = {
                        valid: true,
                        nic: nic
                    };
        return result;
    }
}

