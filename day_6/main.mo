import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import HTTP "http";
import Text "mo:base/Text";



actor {

    // challenge 1
    type TokenIndex = Nat;

    type Error = {
        #firstType;
        #secondType;
    };

    // challenge 2
    func equal(n: TokenIndex, m: TokenIndex) : Bool{ 
        if (n==m) {return true;} 
        else {return false;}; 
        };

    let registry : HashMap.HashMap<TokenIndex, Principal> = HashMap.HashMap<TokenIndex,Principal>(0, equal, Hash.hash);

    // challenge 3
    var nextTokenIndex : Nat = 0;

    //type Result<(), Text> = Result.Result<(),Text>;

    public shared ({caller}) func mint(): async Result.Result<(), Text>{
        if (Principal.toText(caller) == "2vxsx-fae"){
            return #err("Authetication required!");
        }
        else{
            registry.put(nextTokenIndex, caller);
            nextTokenIndex += 1;
            #ok;
        };
    };

    //challenge 4
    public shared ({caller}) func transfer(to : Principal, tokenIndex : Nat) : async Result.Result<(), Text>{
        let tokenOwner = registry.get(tokenIndex);
        switch(tokenOwner){
            case(null){
                return #err("Token does not exist");
            };
            case(?x){
                if (x==caller){
                    registry.delete(tokenIndex);
                    registry.put(tokenIndex, to);
                    return #ok
                } else {
                    return #err("You do not own this token");
                };
            };
        };

    };
    // challenge 5
    public shared ({caller}) func balance() : async List.List<TokenIndex>{
        let tokenPrincipalPair : Iter.Iter<(TokenIndex, Principal)> = Iter.filter(registry.entries(), func(item: (TokenIndex, Principal) ): Bool{
            if (item.1== caller){
                return true;
            } else {
                return false;
            };
        });
        let tokens : Iter.Iter<TokenIndex> = Iter.map<(TokenIndex, Principal), TokenIndex>(tokenPrincipalPair,func(item: (TokenIndex, Principal)): TokenIndex{
            return item.0;
        });

        Iter.toList(tokens);
    };
    public query func http_request(request : HTTP.Request) : async HTTP.Response {
        let latestMinter = registry.get(nextTokenIndex);
        var latestMinterPrincipal : Text = "";
        switch(latestMinter){
            case(null){

            };
            case(?x){
                latestMinterPrincipal := Principal.toText(x);                
            };
        };
        let totalNFT: Text = Nat.toText(nextTokenIndex);
        let response = {
        body = Text.encodeUtf8("Latest Minter ID is " #latestMinterPrincipal # "and total NFT minted is " #totalNFT);
        headers = [("Content-Type", "text/html; charset=UTF-8")];
        status_code = 200 : Nat16;
        streaming_strategy = null
        };
        return(response)
    };

    stable var registryArray = [];

    system func preupgrade(){
        registryArray := Iter.toArray(registry.entries());
    };


    

};