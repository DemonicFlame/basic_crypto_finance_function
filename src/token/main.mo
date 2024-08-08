import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";

actor Token {
    var owner : Principal = Principal.fromText("zevfl-kx5xe-75v2a-imgds-ddsfd-74u6y-46idf-jpozd-johmi-7dwiy-dqe");
    var totalSupply : Nat = 1000000000;
    var symbol : Text = "LUMI";
    var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
    balances.put(owner, totalSupply);

    public query func balanceOf(who : Principal) : async (Nat, Text) {
        let balance : Nat = switch (balances.get(who)) {
            case null 0;
            case (?result) result;
        };
        return (balance, symbol);
    };

    public shared (msg) func payOut() : async Text {
        if (balances.get(msg.caller) == null) {
            let amount : Nat = 10000;
            balances.put(msg.caller, amount);
            return "Success";
        } else {
            return "Already Claimed!";
        };
    };

    public shared (msg) func transfer(to : Principal, amount : Nat) : async Text {
        let fromBalance : Nat = switch (balances.get(msg.caller)) {
            case null 0;
            case (?result) result;
        };

        if (fromBalance > amount) {
            let newFromBalance : Nat = fromBalance - amount;
            balances.put(msg.caller, newFromBalance);

            let toBalance : Nat = switch (balances.get(to)) {
                case null 0;
                case (?result) result;
            };
            let newToBalance = toBalance + amount;
            balances.put(to, newToBalance);

            return "Success";
        } else {
            return "Insufficient funds";
        };
    };
};
