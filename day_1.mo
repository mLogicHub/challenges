import Array "mo:base/Array"; 
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
actor {
    var counter_value = 0;
    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };
    // Challenge 1
    public func add(n : Nat, m : Nat) : async Nat {
        return n+m;
    };
    // Challenge 2
    public func square(n : Nat) : async Nat {
        return n*n;
    };
    // Challenge 3
    public func days_to_second(n : Nat) : async Nat {
        return n*24*60*60;
    };
    // Challenge 4
    public func increment_counter(n : Nat) : async Nat {
        counter_value += n;
        return counter_value;
    };
    public func clear_counter() : async Nat {
        counter_value := 0;
        return counter_value;
    };
    // Challenge 5
    public func divide(n: Nat, m: Nat) : async Bool {
        return (m!=0) and (n%m==0);
    };
    // Challenge 6
    public func is_even(n: Nat) : async Bool {
        return (n!=0) and (n%2==0);
    };
    // Challenge 7
    public func sum_of_array(array : [Nat] ) : async Nat {
        if (array.size()==0) {
            return 0
        } else{
            var sum : Nat = 0;
            for (value in array.vals()){
                sum+=value;
            };
            return sum;
        }; 
    };
    // Challenge 8
    public func maximum(array : [Nat]) : async Nat {
      if (array.size()==0) {
            return 0
        } else{
            var max_value: Nat = 0;
            for (value in array.vals()){
              if (value > max_value){
                max_value := value
              };
            };
            return max_value;
        }; 

    };
    // Challenge 9
    public func remove_from_array(array : [Nat], n : Nat) : async [Nat] {
      if (array.size()==0) {
            return array
        } else{
            var updated_array :[Nat] = [];
            for (value in array.vals()){
              if (value!= n){
                updated_array := Array.append(updated_array,[value]);
              };
            };
            return updated_array;
        }; 
    }; 

    // Challenge 10
    public func selection_sort(arr : [Nat]) : async [Nat] {
        var sorted_array : [Nat] = Array.sort(arr, Nat.compare);
        return sorted_array;
    };
};