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
