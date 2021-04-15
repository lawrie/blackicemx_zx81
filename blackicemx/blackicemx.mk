bin/toplevel.bin : bin/toplevel.asc
	icepack bin/toplevel.asc bin/toplevel.bin

bin/toplevel.json : ${VERILOG_FILES}
	mkdir -p bin
	yosys -q -p "synth_ice40 -json bin/toplevel.json" ${VERILOG_FILES}

bin/toplevel.asc : ${PCF_FILE} bin/toplevel.json
	nextpnr-ice40 --freq 25 --hx8k --package tq144:4k --json bin/toplevel.json --pcf ${PCF_FILE} --asc bin/toplevel.asc --opt-timing --placer heap

.PHONY: time
time: bin/toplevel.bin
	icetime -tmd hx8k bin/toplevel.asc

.PHONY: upload
upload : bin/toplevel.bin
	stty -F /dev/ttyACM0 raw
	cat bin/toplevel.bin >/dev/ttyACM0

.PHONY: clean
clean :
	rm -rf bin

