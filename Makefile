BASE_URL = https://adventofcode.com/2022
SIMPLE_NUM_PAT = $(shell sed 's/^0\+//' <<< '$*')

day%: day%/input.txt day%/README.md
	test -d $@ && exit 1 # guard overwriting
	mkdir -p $@/src/bin
	sed -i 's/#"$@"/"$@"/' Cargo.toml
	touch $@/answers.txt $@/example.txt
	cp templates/Cargo.toml $@/Cargo.toml
	sed -i s/NAME/$@/ $@/Cargo.toml
	cp templates/python.py $@/d${SIMPLE_NUM_PAT}p1.py
	cp templates/python.py $@/d${SIMPLE_NUM_PAT}p2.py
	cp templates/rust.rs $@/src/bin/d${SIMPLE_NUM_PAT}p1.rs
	cp templates/rust.rs $@/src/bin/d${SIMPLE_NUM_PAT}p2.rs

day%/input.txt:
	curl ${BASE_URL}/day/${SIMPLE_NUM_PAT}/input -H "Cookie: ${COOKIE}" --fail > $@ \
		|| rm -f $@

day%/README.md: tmp/day%.html
	echo hq 'h2:contains(Day)' text < $< \
		| sed 's/^ ---/\#/' \
		| sed 's/ ---\$$//' \
		>> $@
	echo >> $@
	hq .day-desc data < $< \
		| pandoc -f html -t gfm \
		| sed '/# --- Day/d' \
		| sed '/Part Two/s/ ---//g' \
		| tee -a $@

tmp:
	mkdir -p tmp

tmp/day%.html: tmp
	curl ${BASE_URL}/day/${SIMPLE_NUM_PAT} -H "Cookie: ${COOKIE}" --fail > $@ \
		|| rm -f $@
