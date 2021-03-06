use std::collections::HashSet;
use util;

pub fn solution() {
    p1();
    p2();
}

pub fn p1() {
    let mut frequency: i64 = 0;
    for line in util::get_input(util::DAY1).lines() {
        frequency += line.parse::<i64>().unwrap()
    }
    println!("{} is the final frequency", frequency);
}

pub fn p2() {
    let mut frequencies = HashSet::new();
    let mut frequency: i64 = 0;
    let input = util::get_input(util::DAY1);
    loop {
        for line in input.lines() {
            frequency += line.parse::<i64>().unwrap();
            if frequencies.contains(&frequency) {
                println!("{} is the first repeating frequency", frequency);
                return;
            }
            frequencies.insert(frequency);
        }
    }   
}