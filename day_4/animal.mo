module {
    public type Animal = {
        species : Text;
        energy : Nat;
    };

    public func animal_sleep(animal : Animal) : Animal {
        let sleepingAnimal : Animal ={
            species = animal.species;
            energy = animal.energy + 10;
        };
        return sleepingAnimal;
    };

};