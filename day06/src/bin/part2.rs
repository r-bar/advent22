use std::collections::HashSet;
use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

fn find_start_of_packet(data: &str) -> Option<usize> {
    let mut ptr = 0;
    while ptr + 4 < data.len() {
        let packet = &data[ptr..ptr + 4];
        let uniq: HashSet<char> = packet.chars().collect();
        if packet.len() == uniq.len() {
            return Some(ptr);
        }
        ptr += 1;
    }
    None
}

fn find_start_of_message(data: &str) -> Option<usize> {
    let mut ptr = 0;
    while ptr + 14 < data.len() {
        let packet = &data[ptr..ptr + 14];
        let uniq: HashSet<char> = packet.chars().collect();
        if packet.len() == uniq.len() {
            return Some(ptr);
        }
        ptr += 1;
    }
    None
}

fn main() -> anyhow::Result<()> {
    let filename = std::env::args()
        .nth(1)
        .unwrap_or_else(|| "input.txt".to_string());
    let data = String::from_utf8(std::fs::read(&filename)?)?;
    if let Some(packet) = find_start_of_packet(&data) {
        println!("Start of packet: {}", packet + 4);
    }
    if let Some(message) = find_start_of_message(&data) {
        println!("Start of message: {}", message + 14);
    }
    Ok(())
}
