day%:
	mkdir -p $@/src/bin
	sed -i 's/#"$@"/"$@"/' Cargo.toml
	touch $@/part1.py $@/part2.py $@/prompt.md $@/answers.txt $@/input.txt $@/example.txt
	cp templates/Cargo.toml $@/Cargo.toml
	sed -i s/NAME/$@/ $@/Cargo.toml
	cp templates/rust.rs $@/src/bin/part1.rs
	cp templates/rust.rs $@/src/bin/part2.rs
