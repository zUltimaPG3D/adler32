module adler32

// The modulus constant used while hashing
const modulus = 65521

// Returns the hash sum (`u32`) of `[]u8`
// Example: assert adler32.hash_u8([u8(0), 255, 128, 64]) == 0x44101c0
pub fn hash_u8(data []u8) u32 {
	mut a := u32(1)
	mut b := u32(0)

	for c in data {
		a = (a + c) % modulus
		b = (b + a) % modulus
	}

	return (b << 16) | a
}

// Returns a zero-padded hexadecimal hash sum (`string`) of `[]u8`
// Example: assert adler32.hexhash_u8([u8(0), 255, 128, 64]) == '044101c0'
pub fn hexhash_u8(data []u8) string {
	return '${hash_u8(data).hex():08}'
}

// Returns the hash sum (`u32`) of `str`
// Example: assert adler32.hash_str('V') == 0x570057
pub fn hash_str(str string) u32 {
	return hash_u8(str.bytes())
}

// Returns a zero-padded hexadecimal hash sum (`string`) of `str`
// Example: assert adler32.hexhash_str('V') == '00570057'
pub fn hexhash_str(str string) string {
	return '${hash_str(str).hex():08}'
}
