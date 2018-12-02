use std::fs::File;
use std::io::Read;
use std::collections::HashSet;

const FILE_1P1: &str = "res/1-1.txt";

pub fn solution() {
    p1();
    p2();
}

fn get_input() -> String {
    let mut f = File::open(FILE_1P1).unwrap();

    let mut content = String::new();
    let _ = f.read_to_string(&mut content);

    content
}

pub fn p1() {
    let mut frequency: i64 = 0;
    for line in get_input().lines() {
        frequency += line.parse::<i64>().unwrap()
    }
    println!("{} is the final frequency", frequency);
}

pub fn p2() {
    let mut frequencies = HashSet::new();
    let mut frequency: i64 = 0;
    let input = get_input();
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