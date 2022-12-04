day%:
	mkdir -p $@/src/bin
	sed -i 's/#"$@"/"$@"/' Cargo.toml
	touch $@/prompt.md $@/answers.txt $@/input.txt $@/example.txt
	cp templates/Cargo.toml $@/Cargo.toml
	sed -i s/NAME/$@/ $@/Cargo.toml
	cp templates/python.py $@/part1.py
	cp templates/python.py $@/part2.py
	cp templates/rust.rs $@/src/bin/part1.rs
	cp templates/rust.rs $@/src/bin/part2.rs
