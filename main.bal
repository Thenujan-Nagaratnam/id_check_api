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

// configurable string database = "GramaUsers";
// configurable string username = "avnadmin";
// configurable string host = "pg-7902e7c7-f73b-401f-a1db-07c524deb30a-gramadb1489369037-chore.a.aivencloud.com";
// configurable int port = 25416;
// configurable string password = "AVNS_lqxqkt40klzjrbSwnDJ";

configurable string database = ?;
configurable string username = ?;
configurable string host = ?;
configurable int port = ?;
configurable string password = ?;

final postgresql:Client dbClient = check new (username = username, password = password, host = host, port = port, database = database);

type NicCheckRequest record {
    string nic;
};

service / on new http:Listener(25416) {
    // isolated resource function get checkNic/[string nic]() returns isValid|error? {
    //     // string id = nic.trim();
    //     // if id.length() == 10 {
    //     //     string strID = id.substring(0, 10);
    //     //     int|error intValue = int:fromString(strID);
    //     //     if !((intValue is int) && (id.substring(10, 11) == "V" || id.substring(10, 11) == "v")) {
    //     //         isValid result = {
    //     //                 valid: false,
    //     //                 nic: nic
    //     //             };
    //     //         log:printInfo("Entered NIC is Invalid: ");
    //     //         return result;
    //     //     }
    //     // } else if id.length() == 12 {
    //     //     int|error intValue = int:fromString(id);
    //     //     if !(intValue is int) {
    //     //         isValid result = {
    //     //                 valid: false,
    //     //                 nic: nic
    //     //             };
    //     //         log:printInfo("Entered NIC is Invalid: ");
    //     //         return result;
    //     //     }
    //     // }
    //     // else {
    //     //     isValid result = {
    //     //             valid: false,
    //     //             nic: nic
    //     //         };
    //     //     log:printInfo("Entered NIC is Invalid: ");
    //     //     return result;
    //     // }
    //     sql:ParameterizedQuery query = `select * from "user" where id=${nic.trim()};`;
    //     User|error queryRowResponse = dbClient->queryRow(query);
    //     io:println(queryRowResponse);
    //     if queryRowResponse is error {
    //         isValid result = {
    //             valid: false,
    //             nic: nic
    //         };
    //         log:printInfo("Entered NIC  is Invalid: ");
    //         return result;
    //     } else {
    //         isValid result = {
    //                     valid: true,
    //                     nic: nic
    //                 };
    //         return result;
    //     }
    // }
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

