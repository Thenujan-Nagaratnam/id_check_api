// import ballerinax/mysql.driver as _;
import ballerina/http;

// import ballerina/io;
// import ballerina/log;
// import ballerina/sql;
// import ballerinax/mysql;

service / on new http:Listener(9090) {

    isolated resource function get checkNic/[string nic]() returns boolean|error? {

        if nic.length() == 10 {
            return true;
        } else {
            return false;
        }

    }
}

// // import ballerinax/mysql.driver as _;
// import ballerina/http;
// import ballerina/io;
// import ballerina/log;
// import ballerina/sql;
// import ballerinax/mysql;

// type isValid record {
//     boolean valid;
//     string nic;
// };

// type Person record {
//     string nic;
//     @sql:Column {name: "firstname"}
//     string firstName;
//     @sql:Column {name: "lastname"}
//     string lastName;

// };

// configurable string database = "idcheck";

// configurable string username = "thenujan";

// configurable string host = "localhost";

// configurable int port = 3306;

// configurable string password = "password";

// final mysql:Client mysqlEp = check new (host = host, user = username, database = database, port = port, password = password);

// service / on new http:Listener(9090) {

//     isolated resource function get checkNic/[string nic]() returns isValid|error? {

//         Person|error queryRowResponse = mysqlEp->queryRow(`select * from nic_details where nic=${nic.trim()}`);
//         io:println(queryRowResponse);

//         if queryRowResponse is error {
//             isValid result = {
//                 valid: false,
//                 nic: nic
//             };
//             log:printInfo("Entered NIC is Invalid: ");
//             return result;
//         } else {
//             isValid result = {
//                 valid: true,
//                 nic: nic
//             };
//             log:printInfo(result.toBalString());
//             return result;
//         }

//     }
// }
