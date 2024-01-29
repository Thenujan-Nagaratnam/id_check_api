import ballerina/http;
import ballerina/io;
import ballerina/test;

http:Client testClient = check new ("http://localhost:7070");

// Before Suite Function

@test:BeforeSuite
function beforeSuiteFunc() {
    io:println("I'm the before suite function!");
}

// Test function

@test:Config {}
function testServiceWithInvalidNIC1() returns error? {
    json payload = {"nic": "123456789", "name":"Alice"};
    http:Response response = check testClient->post("/nicCheck", payload);
    // io:println(response.statusCode);
    test:assertEquals(response.statusCode, 201);
    json errorPayload = check response.getJsonPayload();
    json expected = {"status": 0, "nic": "123456789"};
    test:assertEquals(errorPayload, expected);
}
 
@test:Config {}
function testServiceWithInvalidName() returns error? {
    json payload = {"nic": "123456789V", "name":"John"};
    http:Response response = check testClient->post("/nicCheck", payload);
    // io:println(response.statusCode);
    test:assertEquals(response.statusCode, 201);
    json errorPayload = check response.getJsonPayload();
    json expected = {"status": 0, "nic": "123456789V"};
    test:assertEquals(errorPayload, expected);
}

@test:Config {}
function testServiceWithValidNIC1() returns error? {
    json payload = {"nic": "123456789V", "name":"Alice"};
    http:Response response = check testClient->post("/nicCheck", payload);
    // io:println(response.statusCode);
    test:assertEquals(response.statusCode, 201);
    json errorPayload = check response.getJsonPayload();
    json expected = {"status": 2, "nic": "123456789V"};
    test:assertEquals(errorPayload, expected);
}

@test:Config {}
function testServiceWithValidNIC2() returns error? {
    json payload = {"nic": "123456789v", "name":"Alice"};
    http:Response response = check testClient->post("/nicCheck", payload);
    // io:println(response.statusCode);
    test:assertEquals(response.statusCode, 201);
    json errorPayload = check response.getJsonPayload();
    json expected = {"status": 2, "nic": "123456789v"};
    test:assertEquals(errorPayload, expected);
}

@test:Config {}
function testServiceWithInalidNIC2() returns error? {
    json payload = {"nic": "", "name":"Alice"};
    http:Response response = check testClient->post("/nicCheck", payload);
    // io:println(response.statusCode);
    test:assertEquals(response.statusCode, 201);
    json errorPayload = check response.getJsonPayload();
    json expected = {"status": 3, "nic": ""};
    test:assertEquals(errorPayload, expected);
}

//After Suite Function

@test:AfterSuite
function afterSuiteFunc() {
    io:println("I'm the after suite function!");
}
