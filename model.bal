# Response for the id check api call
#
# + nic - nic of the user
# + status - status of the id check
type statusReq record {
    int status;
    string nic;
};

# Request body of the if check api.
#
# + nic - nic of the user
# + name - name of the user
public type Request record {|
    string nic;
    string name;
|};

# Gramadevision record.
#
# + gramadevision - field description
public type GramaDevision record {|
    string gramadevision;
|};

# Record of status table.
#
# + id - id of status record
# + user_id - id of the user  
# + police_check_status - status of police check
# + id_check_status - status of id check 
# + address_check_status - status of address check
public type StatusRecord record {|
    int id;
    string user_id;
    int police_check_status;
    int id_check_status;
    int address_check_status;

|};

# Record of user table.
#
# + name - user's name 
# + id - id of the user  
# + address - user's address  
# + phone_no - user's phone number  
# + gramadevision - user's grama niladhari devision
public type UserDetails record {|
    string name;
    string id;
    string address;
    string phone_no;
|};
