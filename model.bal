// response record
type statusReq record {
    int status;
    string nic;
};

public type Nic record {|
    string nic;
|};

# Description.
#
# + gramadevision - field description
public type GramaDevision record {|
    string gramadevision;
|};

public type StatusRecord record {|
    int id;
    string user_id;
    int police_check_status;
    int id_check_status;
    int address_check_status;

|};

public type UserDetails record {|
    string name;
    string id;
    string address;
    string phone_no;
    string gramadevision;
|};
