use util;
use std::collections::HashMap;
use edit_distance::edit_distance;

pub fn solution() {
    p1();
    p2();
}

fn p1() {
    let input = util::get_input(util::DAY2);
    let mut exactly2 = 0;
    let mut exactly3 = 0;
    for line in input.lines() {
        let mut counts = HashMap::<char, i64>::new();
        for character in line.chars() {
            let counter = counts.entry(character).or_insert(0);
            *counter += 1;
        }

        for key in counts.keys() {
            let count: i64 = *counts.get(key).unwrap();
            if count == 2 {
                exactly2 += 1;
                break;
            }
        }

        for key in counts.keys() {
            let count: i64 = *counts.get(key).unwrap();
            if count == 3 {
                exactly3 += 1;
                break;
            }
        }
    }

    println!("part 1: {}", exactly2 * exactly3);
}

fn p2() {
    let input: String = util::get_input(util::DAY2);
    for (index, line1) in input.lines().enumerate() {
        for line2 in input.lines().skip(index + 1) {
            if edit_distance(line1, line2) == 1 {
                let zip = line1.chars().zip(line2.chars());
                let result: String = zip.filter_map(|(c1, c2)| if c1 == c2 { Some(c1) } else { None }).collect();

                println!("part 2: {}", result);
                return
            }
        }
    }
}