



//! State machine for detecting a sequence of 1010


use std::collections::VecDeque;



#[derive(Clone, Copy, Debug)]
enum Bit {
    Zero,
    One
}


impl Into<char> for Bit {
    fn into(self) -> char {
        match self {
            Bit::Zero => '0',
            Bit::One  => '1'
        }
    }
}


#[derive(Clone, Copy, Debug)]
enum MealyMachine {
    NoMatched,
    OneMatched,
    OneZeroMatched,
    OneZeroOneMatched
}



impl MealyMachine {
    fn transition(self, input: Bit) -> (Self, Bit) {
        match (self, input) {
            (MealyMachine::NoMatched,         Bit::Zero) => (MealyMachine::NoMatched,         Bit::Zero),
            (MealyMachine::NoMatched,         Bit::One ) => (MealyMachine::OneMatched,        Bit::Zero),
            (MealyMachine::OneMatched,        Bit::Zero) => (MealyMachine::OneZeroMatched,    Bit::Zero),
            (MealyMachine::OneMatched,        Bit::One ) => (MealyMachine::OneMatched,        Bit::Zero),
            (MealyMachine::OneZeroMatched,    Bit::Zero) => (MealyMachine::NoMatched,         Bit::Zero),
            (MealyMachine::OneZeroMatched,    Bit::One ) => (MealyMachine::OneZeroOneMatched, Bit::Zero),
            (MealyMachine::OneZeroOneMatched, Bit::Zero) => (MealyMachine::OneZeroMatched,    Bit::One),
            (MealyMachine::OneZeroOneMatched, Bit::One ) => (MealyMachine::NoMatched,         Bit::Zero),
        }
    }
}


impl Into<char> for MealyMachine {
    fn into(self) -> char {
        match self {
            MealyMachine::NoMatched         => 'A',
            MealyMachine::OneMatched        => 'B',
            MealyMachine::OneZeroMatched    => 'C',
            MealyMachine::OneZeroOneMatched => 'D'
        }
    }
}



enum MooreMachine {

}



fn main() {

    let mut window = VecDeque::new();
    for _ in 0..4 {
        window.push_back('0');
    }


    let mut inputs  = "".to_string();
    let mut states  = "".to_string();
    let mut outputs = "".to_string();


    let mut mealy = MealyMachine::NoMatched;


    for _ in 0..128 {

        let input = if rand::random() {
            inputs.push('1');
            Bit::One
        }

        else {
            inputs.push('0');
            Bit::Zero
        };


        let (new_mealy, output) = mealy.transition(input);

        states.push(new_mealy.into());

        mealy = new_mealy;

        outputs.push(output.into());
        
    }


    println!("Mealy:");
    println!("  Input     | {}", inputs);
    println!("  Output    | {}", outputs.replace("0", " "));
    println!("  New state | {}", states);
}
