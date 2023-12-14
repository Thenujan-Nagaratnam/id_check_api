import ballerina/http;
// import ballerina/io;
import ballerinax/postgresql.driver as _;

service / on new http:Listener(7070) {

    resource function post nicCheck(@http:Payload Nic payload) returns statusReq {
        if (payload.nic == "") {
            statusReq result = {
                status: 3,
                nic: ""
            };
            return result;
        }
        statusReq isValidNIC = checkNic(payload.nic);
        // io:println(isValidNIC);
        return isValidNIC;
    }
}

