use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

fn main() -> anyhow::Result<()> {
    let filename = std::env::args().nth(1).unwrap_or("input.txt");
    let f = File::open(&filename)?;
    let reader = BufReader::new(f);
    for line in reader.lines() {
        println!("{}", line?.trim());
    }
    Ok(())
}
