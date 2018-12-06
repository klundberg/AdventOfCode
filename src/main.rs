mod aoc2018;
mod util;

extern crate edit_distance;

fn main() {
    let solutions = [
        aoc2018::day1::solution,
        aoc2018::day2::solution,
    ];
    
    // run the latest 
    let latest = solutions.last().unwrap();
    latest();
}

