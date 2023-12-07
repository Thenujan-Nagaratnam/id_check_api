import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/sql;
import ballerinax/postgresql;
import ballerinax/postgresql.driver as _;

type isValid record {
    boolean valid;
    string nic;
};

type User record {
    @sql:Column {name: "id"}
    string nic;
    @sql:Column {name: "name"}
    string name;
    @sql:Column {name: "address"}
    string address;
    @sql:Column {name: "phone_no"}
    string phone_no;
};

// // postgresql 

// configurable string database = "GramaUsers";
// configurable string username = "avnadmin";
// configurable string host = "pg-7902e7c7-f73b-401f-a1db-07c524deb30a-gramadb1489369037-chore.a.aivencloud.com";
// configurable int port = 25416;
// configurable string password = "AVNS_lqxqkt40klzjrbSwnDJ";

//mysql

// configurable string database = "GramaUsers";
// configurable string username = "avnadmin";
// configurable string host = "mysql-ffb6f33b-fdfb-491b-9aaa-8f6bb5d666dd-gramause3466168786-c.a.aivencloud.com";
// configurable int port = 14194;
// configurable string password = "AVNS_cpMUvXO1gSRD0kG8din";

type DatabaseConfig record {
    string database;
    string username;
    string host;
    int port;
    string password;
};

configurable DatabaseConfig databaseConfig = ?;

// configurable string database = ?;
// configurable string username = ?;
// configurable string host = ?;
// configurable int port = ?;
// configurable string password = ?;

final postgresql:Client dbClient = check new (host = databaseConfig.host, database = databaseConfig.database, username = databaseConfig.username,
    password = databaseConfig.password, port = databaseConfig.port
);

type NicCheckRequest record {
    string nic;
};

service / on new http:Listener(14194) {

    resource function post nicCheck(@http:Payload NicCheckRequest payload) returns isValid|error? {
        isValid isValidNIC = checkNic(payload.nic);
        return isValidNIC;
    }
}

function checkNic(string nic) returns isValid {
    sql:ParameterizedQuery query = `select * from "user" where id=${nic.trim()};`;
    User|error queryRowResponse = dbClient->queryRow(query);
    io:println(queryRowResponse);
    if queryRowResponse is error {
        isValid result = {
                valid: false,
                nic: nic
            };
        log:printInfo("Entered NIC  is Invalid: ");
        return result;
    } else {
        isValid result = {
                        valid: true,
                        nic: nic
                    };
        return result;
    }
}
