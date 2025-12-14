note
	description: "[
		Simple Randomizer - Lightweight random data generation for testing.

		Provides core randomization features without domain-specific data or file dependencies.

		Features:
		- Random numbers (integers, reals, booleans) with range support
		- Random strings (words, sentences, paragraphs, identifiers)
		- Random characters (letters, digits)
		- Random dates (past, future, ranges)
		- UUID generation
		- Unique value arrays

		Usage:
			create randomizer.make
			name := randomizer.random_word
			age := randomizer.random_integer_in_range (18 |..| 65)
			date := randomizer.random_date_in_past_days (30)
	]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	SIMPLE_RANDOMIZER

create
	make,
	make_with_seed

feature {NONE} -- Initialization

	make
			-- Create with time-based seed for non-reproducible randomness.
		local
			l_dt: SIMPLE_DATE_TIME
			l_seed: INTEGER
		do
			create l_dt.make_now
			l_seed := (l_dt.to_timestamp \\ 1000000).as_integer_32
			create random_sequence.set_seed (l_seed)
		end

	make_with_seed (a_seed: INTEGER)
			-- Create with specific `a_seed' for reproducible randomness.
		require
			positive_seed: a_seed > 0
		do
			create random_sequence.set_seed (a_seed)
		ensure
			seed_set: random_sequence.seed = a_seed
		end

feature -- Random Numbers

	random_integer: INTEGER
			-- A random integer.
		do
			random_sequence.forth
			Result := random_sequence.item
		end

	random_integer_in_range (a_range: INTEGER_INTERVAL): INTEGER
			-- A random integer within `a_range'.
		require
			valid_range: a_range.lower <= a_range.upper
		do
			Result := (random_integer.abs \\ (a_range.upper - a_range.lower + 1)) + a_range.lower
		ensure
			in_range: a_range.has (Result)
		end

	random_real: REAL_64
			-- A random real between 0 and 1.
		do
			random_sequence.forth
			Result := random_sequence.double_item
		end

	random_real_in_range (a_lower, a_upper: REAL_64): REAL_64
			-- A random real between `a_lower' and `a_upper'.
		require
			valid_range: a_lower <= a_upper
		do
			Result := random_real * (a_upper - a_lower) + a_lower
		ensure
			in_range: Result >= a_lower and Result <= a_upper
		end

	random_boolean: BOOLEAN
			-- A random boolean (approximately 50/50).
		do
			Result := random_integer_in_range (1 |..| 100) > 50
		end

	random_boolean_weighted (a_true_percent: INTEGER): BOOLEAN
			-- A random boolean with `a_true_percent' chance of True.
		require
			valid_percent: a_true_percent >= 0 and a_true_percent <= 100
		do
			Result := random_integer_in_range (1 |..| 100) <= a_true_percent
		end

feature -- Unique Arrays

	unique_integers (a_count: INTEGER; a_range: INTEGER_INTERVAL): ARRAYED_LIST [INTEGER]
			-- Array of `a_count' unique random integers from `a_range'.
		require
			valid_count: a_count > 0
			range_large_enough: (a_range.upper - a_range.lower + 1) >= a_count
		local
			l_number, l_attempts: INTEGER
		do
			create Result.make (a_count)
			across 1 |..| a_count as ic loop
				from
					l_attempts := a_count * 100
					l_number := random_integer_in_range (a_range)
				until
					not Result.has (l_number)
				loop
					l_number := random_integer_in_range (a_range)
					l_attempts := l_attempts - 1
				variant
					l_attempts
				end
				Result.force (l_number)
			end
		ensure
			correct_count: Result.count = a_count
			all_unique: across Result as ic all Result.occurrences (ic.item) = 1 end
		end

feature -- Random Characters

	random_digit: CHARACTER
			-- A random digit '0'..'9'.
		do
			Result := Digits [random_integer_in_range (1 |..| Digits.count)]
		ensure
			is_digit: Digits.has (Result)
		end

	random_letter_lower: CHARACTER
			-- A random lowercase letter 'a'..'z'.
		do
			Result := Alphabet_lower [random_integer_in_range (1 |..| Alphabet_lower.count)]
		ensure
			is_lower: Alphabet_lower.has (Result)
		end

	random_letter_upper: CHARACTER
			-- A random uppercase letter 'A'..'Z'.
		do
			Result := random_letter_lower.as_upper
		ensure
			is_upper: Alphabet_lower.has (Result.as_lower)
		end

	random_letter: CHARACTER
			-- A random letter (upper or lower case).
		do
			if random_boolean then
				Result := random_letter_upper
			else
				Result := random_letter_lower
			end
		end

	random_alphanumeric: CHARACTER
			-- A random letter or digit.
		do
			if random_boolean_weighted (30) then
				Result := random_digit
			else
				Result := random_letter
			end
		end

	random_character_from (a_characters: STRING): CHARACTER
			-- A random character from `a_characters'.
		require
			not_empty: not a_characters.is_empty
		do
			Result := a_characters [random_integer_in_range (1 |..| a_characters.count)]
		ensure
			from_source: a_characters.has (Result)
		end

feature -- Random Strings

	random_digits (a_length: INTEGER): STRING
			-- A string of `a_length' random digits.
		require
			positive_length: a_length > 0
		do
			create Result.make (a_length)
			across 1 |..| a_length as ic loop
				Result.append_character (random_digit)
			end
		ensure
			correct_length: Result.count = a_length
			all_digits: across Result as c all Digits.has (c.item) end
		end

	random_letters (a_length: INTEGER): STRING
			-- A string of `a_length' random lowercase letters.
		require
			positive_length: a_length > 0
		do
			create Result.make (a_length)
			across 1 |..| a_length as ic loop
				Result.append_character (random_letter_lower)
			end
		ensure
			correct_length: Result.count = a_length
		end

	random_alphanumeric_string (a_length: INTEGER): STRING
			-- A string of `a_length' random alphanumeric characters.
		require
			positive_length: a_length > 0
		do
			create Result.make (a_length)
			across 1 |..| a_length as ic loop
				Result.append_character (random_alphanumeric)
			end
		ensure
			correct_length: Result.count = a_length
		end

	random_word: STRING
			-- A pronounceable random word (2-3 syllables).
		do
			create Result.make_empty
			across 1 |..| random_integer_in_range (2 |..| 3) as ic loop
				if random_boolean then
					-- Vowel + consonant pattern (like "em", "at")
					Result.append_character (random_character_from (Vowels))
					Result.append_character (random_character_from (Consonants))
				else
					-- Consonant + vowel pattern (like "me", "ta")
					Result.append_character (random_character_from (Consonants))
					Result.append_character (random_character_from (Vowels))
				end
			end
		ensure
			not_empty: not Result.is_empty
		end

	random_word_capitalized: STRING
			-- A pronounceable random word with first letter capitalized.
		do
			Result := random_word
			Result.put (Result.item (1).as_upper, 1)
		ensure
			not_empty: not Result.is_empty
			capitalized: Result.item (1).is_upper
		end

	random_words (a_count: INTEGER): STRING
			-- A string of `a_count' random words separated by spaces.
		require
			positive_count: a_count > 0
		do
			create Result.make (a_count * 6)
			across 1 |..| a_count as ic loop
				if ic.item > 1 then
					Result.append_character (' ')
				end
				Result.append_string (random_word)
			end
		ensure
			not_empty: not Result.is_empty
		end

	random_sentence: STRING
			-- A random sentence (3-8 words, capitalized, with period).
		local
			l_word_count: INTEGER
		do
			l_word_count := random_integer_in_range (3 |..| 8)
			Result := random_words (l_word_count)
			Result.put (Result.item (1).as_upper, 1)
			Result.append_character ('.')
		ensure
			ends_with_period: Result.item (Result.count) = '.'
			starts_capitalized: Result.item (1).is_upper
		end

	random_paragraph: STRING
			-- A random paragraph (3-6 sentences).
		local
			l_sentence_count: INTEGER
		do
			l_sentence_count := random_integer_in_range (3 |..| 6)
			create Result.make (l_sentence_count * 50)
			across 1 |..| l_sentence_count as ic loop
				if ic.item > 1 then
					Result.append_character (' ')
				end
				Result.append_string (random_sentence)
			end
		ensure
			not_empty: not Result.is_empty
		end

	random_identifier: STRING
			-- A random identifier suitable for code (letters + numbers, no spaces).
		do
			Result := random_word
			Result.append_character ('_')
			Result.append_string (random_integer_in_range (100 |..| 999).out)
		ensure
			not_empty: not Result.is_empty
			no_spaces: not Result.has (' ')
		end

feature -- Random Dates

	random_date_in_past_days (a_days: INTEGER): SIMPLE_DATE
			-- A random date within `a_days' ago.
		require
			positive_days: a_days > 0
		local
			l_now: SIMPLE_DATE
		do
			create l_now.make_now
			Result := l_now.minus_days (random_integer_in_range (1 |..| a_days))
		end

	random_date_in_future_days (a_days: INTEGER): SIMPLE_DATE
			-- A random date within `a_days' from now.
		require
			positive_days: a_days > 0
		local
			l_now: SIMPLE_DATE
		do
			create l_now.make_now
			Result := l_now.plus_days (random_integer_in_range (1 |..| a_days))
		end

	random_date_in_range (a_start, a_end: SIMPLE_DATE): SIMPLE_DATE
			-- A random date between `a_start' and `a_end'.
		require
			valid_range: a_start <= a_end
		local
			l_days: INTEGER
		do
			l_days := a_start.days_between (a_end)
			Result := a_start.plus_days (random_integer_in_range (0 |..| l_days))
		ensure
			in_range: Result >= a_start and Result <= a_end
		end

	random_date_around_now (a_days_range: INTEGER): SIMPLE_DATE
			-- A random date within +/- `a_days_range' from today.
		require
			positive_range: a_days_range > 0
		local
			l_now: SIMPLE_DATE
			l_offset: INTEGER
		do
			l_offset := random_integer_in_range (-a_days_range |..| a_days_range)
			create l_now.make_now
			Result := l_now.plus_days (l_offset)
		end

feature -- UUID Generation

	random_uuid: UUID
			-- A random UUID.
		do
			create Result.make (
				random_integer.to_natural_32,
				random_integer.to_natural_16,
				random_integer.to_natural_16,
				random_integer.to_natural_16,
				random_integer.to_natural_64
			)
		end

	random_uuid_string: STRING
			-- A random UUID as hyphenated string.
		do
			Result := random_uuid.out
		ensure
			valid_format: Result.occurrences ('-') = 4
		end

	random_uuid_compact: STRING
			-- A random UUID as string without hyphens.
		do
			Result := random_uuid_string
			Result.replace_substring_all ("-", "")
		ensure
			no_hyphens: not Result.has ('-')
			correct_length: Result.count = 32
		end

feature -- Selection

	random_item_from_array (a_array: ARRAY [ANY]): ANY
			-- A random item from `a_array'.
		require
			not_empty: not a_array.is_empty
		do
			Result := a_array [random_integer_in_range (a_array.lower |..| a_array.upper)]
		end

	random_string_from_list (a_list: ARRAY [STRING]): STRING
			-- A random string from `a_list'.
		require
			not_empty: not a_list.is_empty
		do
			Result := a_list [random_integer_in_range (a_list.lower |..| a_list.upper)]
		end

feature {NONE} -- Implementation

	random_sequence: RANDOM
			-- Underlying random number generator.

feature -- Constants

	Alphabet_lower: STRING = "abcdefghijklmnopqrstuvwxyz"
			-- Lowercase alphabet.

	Vowels: STRING = "aeiou"
			-- Vowels for word generation.

	Consonants: STRING = "bcdfghjklmnpqrstvwxyz"
			-- Consonants for word generation.

	Digits: STRING = "0123456789"
			-- Decimal digits.

invariant
	random_sequence_exists: random_sequence /= Void

note
	copyright: "Copyright (c) 2024-2025, Larry Rix"
	license: "MIT License"
	source: "[
		SIMPLE_RANDOMIZER - Lightweight random data generation
		No file dependencies, no domain-specific data
	]"

end
