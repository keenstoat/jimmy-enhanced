#!/usr/bin/env python3
import sys

sys.argv.pop(0)
filename = sys.argv[0]
with open(filename) as rom_file:
    code = rom_file.read()

line_num = 0
while "rom[]" in code:
    code = code.replace("rom[]", f"rom[{line_num}]", 1)
    line_num += 1

with open(filename, "w") as rom_file:
    rom_file.write(code)