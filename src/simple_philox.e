note
	description: "[
		Philox4x32-10: a counter-based random number generator (Salmon, Moraes, Dror,
		Shaw, "Parallel Random Numbers: As Easy as 1, 2, 3", SC'11; reference code
		Random123, D. E. Shaw Research). Each 128-bit counter maps to four 32-bit words
		through ten rounds keyed by a 64-bit key, so word n of the stream is computed
		directly, without generating words 0 .. n-1: a GPU kernel and this class
		produce identical values for the same (key, stream, index).
		Period 2^64 blocks per stream, 2^64 streams per key.

		Stream layout (as curand_init (seed, subsequence, offset)):
			word n of stream s = block (n // 4, s) [n \\ 4],
			counter = <low 32 of n // 4, high 32 of n // 4, low 32 of s, high 32 of s>.
	]"
	author: "Larry Rix"

class
	SIMPLE_PHILOX

create
	make,
	make_with_key

feature {NONE} -- Initialization

	make (a_seed: NATURAL_64; a_stream: NATURAL_64)
			-- Generator keyed by `a_seed', reading stream `a_stream' from position 0.
		do
			make_with_key (a_seed.as_natural_32, (a_seed |>> 32).as_natural_32, a_stream)
		ensure
			seed_kept: seed = a_seed
			stream_set: stream = a_stream
			at_start: position = 0
		end

	make_with_key (a_key_0, a_key_1: NATURAL_32; a_stream: NATURAL_64)
			-- Generator with the raw 64-bit key <`a_key_0', `a_key_1'>.
		do
			key_0 := a_key_0
			key_1 := a_key_1
			stream := a_stream
			position := 0
		ensure
			key_set: key_0 = a_key_0 and key_1 = a_key_1
			stream_set: stream = a_stream
			at_start: position = 0
		end

feature -- Access

	key_0, key_1: NATURAL_32
			-- The 64-bit key, low word first.

	seed: NATURAL_64
			-- The key as one number.
		do
			Result := key_0.to_natural_64 | (key_1.to_natural_64 |<< 32)
		end

	stream: NATURAL_64
			-- Stream (subsequence) read by `item' and `forth'.

	position: NATURAL_64
			-- Index of the word `item' returns.

	item: NATURAL_32
			-- Word `position' of `stream'.
		do
			Result := word (position)
		ensure
			definition: Result = word (position)
		end

	unit_item: REAL_64
			-- `item' as a real in [0, 1): item / 2^32.
		do
			Result := unit_of (item)
		ensure
			in_range: 0.0 <= Result and Result < 1.0
		end

feature -- Counter-based queries (pure: no state changes)

	word (n: NATURAL_64): NATURAL_32
			-- Word `n' of `stream'.
		local
			l_block: NATURAL_64
			l_out: SPECIAL [NATURAL_32]
		do
			l_block := n |>> 2
			l_out := block (l_block.as_natural_32, (l_block |>> 32).as_natural_32, stream.as_natural_32, (stream |>> 32).as_natural_32)
			Result := l_out [(n & 3).to_integer_32]
		end

	block (c0, c1, c2, c3: NATURAL_32): SPECIAL [NATURAL_32]
			-- Philox4x32-10 of counter <c0, c1, c2, c3> under the key: four words.
		local
			x0, x1, x2, x3, k0, k1, y0, y2: NATURAL_32
			p0, p1: NATURAL_64
			r: INTEGER
		do
			x0 := c0; x1 := c1; x2 := c2; x3 := c3
			k0 := key_0; k1 := key_1
			from r := 1 until r > 10 loop
				if r > 1 then
					k0 := k0 + W0
					k1 := k1 + W1
				end
				p0 := M0.to_natural_64 * x0.to_natural_64
				p1 := M1.to_natural_64 * x2.to_natural_64
				y0 := (p1 |>> 32).as_natural_32.bit_xor (x1).bit_xor (k0)
				y2 := (p0 |>> 32).as_natural_32.bit_xor (x3).bit_xor (k1)
				x1 := p1.as_natural_32
				x3 := p0.as_natural_32
				x0 := y0
				x2 := y2
				r := r + 1
			end
			create Result.make_filled (0, 4)
			Result [0] := x0
			Result [1] := x1
			Result [2] := x2
			Result [3] := x3
		ensure
			four_words: Result.count = 4
		end

	unit_of (w: NATURAL_32): REAL_64
			-- `w' / 2^32, in [0, 1).
		do
			Result := w.to_real_64 / 4294967296.0
		ensure
			in_range: 0.0 <= Result and Result < 1.0
		end

feature -- Cursor movement

	forth
			-- Advance to the next word.
		do
			position := position + 1
		ensure
			advanced: position = old position + 1
		end

	go_to (n: NATURAL_64)
			-- Jump to word `n' (constant time: counter-based).
		do
			position := n
		ensure
			moved: position = n
		end

	set_stream (a_stream: NATURAL_64)
			-- Read stream `a_stream' from position 0.
		do
			stream := a_stream
			position := 0
		ensure
			stream_set: stream = a_stream
			at_start: position = 0
		end

feature -- Constants (Random123 philox.h)

	M0: NATURAL_32 = 0xD2511F53
	M1: NATURAL_32 = 0xCD9E8D57
	W0: NATURAL_32 = 0x9E3779B9
	W1: NATURAL_32 = 0xBB67AE85

end
