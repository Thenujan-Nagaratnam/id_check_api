import ballerina/io;
import ballerina/sql;

# Description.
#
# + payload - nic and name of the user
# + return - status of the id check. 0 - Rejected, 1 - Pending, 2 - Accepted, 3 - More info required.
function checkNic(Request payload) returns statusReq {

    // postgresql query to retrieve the relevant user details
    sql:ParameterizedQuery query = `SELECT * FROM "user" WHERE LOWER(id) = ${string:toLowerAscii(payload.nic)};`;

    error|sql:ExecutionResult queryRowResponse = dbQueryRow(query);

    if queryRowResponse is error {

        if (queryRowResponse.message() == "Query did not retrieve any rows.") {
            statusReq result = {
                status: 0,
                nic: payload.nic
            };
            io:println("queryRowResponse error: ", queryRowResponse.message());
            return result;
        } else {
            statusReq result = {
                status: 1,
                nic: payload.nic
            };
            io:println("queryRowResponse: ", queryRowResponse);
            return result;
        }
    } else {
        UserDetails userDetails = {
            id: queryRowResponse["id"].toString(),
            name: queryRowResponse["name"].toString(),
            address: queryRowResponse["land_id"].toString(),
            phone_no: queryRowResponse["phone_no"].toString()
            // gramadevision: queryRowResponse["gramadevision"].toString()
        };
        // return userDetails;
        io:println("queryRowResponse: ", queryRowResponse);

        if (string:toLowerAscii(userDetails.name)== string:toLowerAscii(payload.name)){
            statusReq result = {
                status: 2,
                nic: payload.nic
            };
            return result;
        } else {
            statusReq result = {
                status: 0,
                nic: payload.nic
            };
            return result;
        }
    }
}
