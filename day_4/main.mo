import Custom "custom";
import Animal "animal";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import List "mo:base/List";
actor {

    // Challenge 1 to 2
    public type Student = Custom.Student;

    public func fun(): async Student {
        let musa : Student = {
        name = "Musa Makanjuola";
        age = 25;
        grade = "level 5";
        height = 11;
        weight = 35;
        nationality = "Nigeria";
    }; 
        return musa;
    }; 

    // Challenge 3 to 6
    public type Animal = Animal.Animal;
    let snake : Animal = {
        species = "reptile ";
        energy = 45;
    };

    public func create_animal_then_takes_a_break(species: Text, energy : Nat) : async Animal {
        let newAnimal = {
            species;
            energy;
        };
        return Animal.animal_sleep(newAnimal);
    };

    
    var animalList : List.List<Animal> = List.nil<Animal>();

    public func push_animal(animal : Animal) : async () {
        animalList := List.push(animal, animalList);
    };

    public func get_animals() : async [Animal] {
        return List.toArray(animalList);
    };
    // Challenge 7-10
};
