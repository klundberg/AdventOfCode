use std::fs::File;
use std::io::Read;

pub const DAY1: &str = "res/2018/1-1.txt";
pub const DAY2: &str = "res/2018/2-1.txt";

pub fn get_input(path: &str) -> String {
    let mut f = File::open(path).unwrap();

    let mut content = String::new();
    let _ = f.read_to_string(&mut content);

    content
}