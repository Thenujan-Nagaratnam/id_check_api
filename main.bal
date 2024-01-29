import ballerina/http;
// import ballerina/io;
import ballerinax/postgresql.driver as _;

service / on new http:Listener(7070) {

    # Service for checking the validity of NIC of the user
    # This service will be called automatically when user apply for the certificate.
    #
    # + payload - request payload which contains the nic number and the name of the user
    # + return - statusReq - status of the nic number(Valid or Not valid) and the nic number
    resource function post nicCheck(@http:Payload Request payload) returns statusReq {
        if (payload.nic == "") {
            statusReq result = {
                status: 3,
                nic: payload.nic
            };
            return result;
        }
        statusReq isValidNIC = checkNic(payload);
        // io:println(isValidNIC);
        return isValidNIC;
    }
}

