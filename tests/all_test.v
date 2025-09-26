import adler32

fn do_str(str string, check u32) {
	assert adler32.hash_str(str) == check
	assert adler32.hexhash_str(str) == '${check.hex():08}'
}

fn do_hex(data []u8, check u32) {
	assert adler32.hash_u8(data) == check
	assert adler32.hexhash_u8(data) == '${check.hex():08}'
}

fn test_basic() {
	do_str('Hello World!', 0x1c49043e)

	do_str('a', 0x620062)
	do_str('A', 0x420042)

	do_hex('abC'.bytes(), 0x22d0107)
}

fn test_extra() {
	do_str('', 0x1)
	do_str('M'.repeat(100000), 0xfaca84fc)

	do_hex([u8(0), 255, 128, 64], 0x44101c0)
}
