import ballerina/io;
import ballerina/sql;

function checkNic(string nic) returns statusReq {

    // to remove the case sensitivity
    string nicLower = string:toLowerAscii(nic);
    string nicUpper = string:toUpperAscii(nic);

    // postgresql query to retrieve the relevant user details
    sql:ParameterizedQuery query = `SELECT * FROM "user" WHERE id = ${nicLower.trim()} OR id = ${nicUpper.trim()};`;

    error|sql:ExecutionResult queryRowResponse = dbQueryRow(query);

    if queryRowResponse is error {
        statusReq result = {
            status: 0,
            nic: nic
        };
        io:println("queryRowResponse error: ", queryRowResponse);
        return result;
    } else {
        statusReq result = {
            status: 2,
            nic: nic
        };
        io:println("queryRowResponse: ", queryRowResponse);
        return result;
    }
}
