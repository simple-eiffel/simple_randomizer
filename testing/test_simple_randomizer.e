note
	description: "Tests for SIMPLE_RANDOMIZER"
	testing: "type/manual"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SIMPLE_RANDOMIZER

inherit
	TEST_SET_BASE
		redefine
			on_prepare
		end

feature {NONE} -- Initialization

	on_prepare
			-- Called before tests.
		do
			create randomizer.make
		end

feature -- Test: Random Numbers

	test_random_integer
			-- Test random_integer produces values.
		note
			testing: "execution/isolated"
		local
			i, v1, v2: INTEGER
			l_different: BOOLEAN
		do
			-- Generate several values and verify at least some are different
			v1 := randomizer.random_integer
			from i := 1 until i > 10 or l_different loop
				v2 := randomizer.random_integer
				l_different := v1 /= v2
				i := i + 1
			end
			assert ("produces varying values", l_different)
		end

	test_random_integer_in_range
			-- Test random_integer_in_range respects bounds.
		note
			testing: "execution/isolated"
		local
			v: INTEGER
		do
			across 1 |..| 100 as ic loop
				v := randomizer.random_integer_in_range (10 |..| 20)
				assert ("in range " + ic.item.out, v >= 10 and v <= 20)
			end
		end

	test_random_real
			-- Test random_real produces values between 0 and 1.
		note
			testing: "execution/isolated"
		local
			v: REAL_64
		do
			across 1 |..| 50 as ic loop
				v := randomizer.random_real
				assert ("in 0..1 range " + ic.item.out, v >= 0.0 and v <= 1.0)
			end
		end

	test_random_real_in_range
			-- Test random_real_in_range respects bounds.
		note
			testing: "execution/isolated"
		local
			v: REAL_64
		do
			across 1 |..| 50 as ic loop
				v := randomizer.random_real_in_range (5.0, 10.0)
				assert ("in range " + ic.item.out, v >= 5.0 and v <= 10.0)
			end
		end

	test_random_boolean
			-- Test random_boolean produces both values.
		note
			testing: "execution/isolated"
		local
			l_true_count, l_false_count: INTEGER
		do
			across 1 |..| 100 as ic loop
				if randomizer.random_boolean then
					l_true_count := l_true_count + 1
				else
					l_false_count := l_false_count + 1
				end
			end
			-- Should have at least some of each (very unlikely to get 100 of same)
			assert ("has true values", l_true_count > 0)
			assert ("has false values", l_false_count > 0)
		end

	test_random_boolean_weighted
			-- Test weighted boolean respects weight.
		note
			testing: "execution/isolated"
		local
			l_true_count: INTEGER
		do
			-- 90% true weight - should get mostly trues
			across 1 |..| 100 as ic loop
				if randomizer.random_boolean_weighted (90) then
					l_true_count := l_true_count + 1
				end
			end
			-- Should be heavily biased toward true
			assert ("mostly true", l_true_count > 70)
		end

feature -- Test: Unique Arrays

	test_unique_integers
			-- Test unique_integers produces unique values.
		note
			testing: "execution/isolated"
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_list := randomizer.unique_integers (10, 1 |..| 100)
			assert ("correct count", l_list.count = 10)
			-- Verify uniqueness
			across l_list as ic loop
				assert ("unique " + ic.item.out, l_list.occurrences (ic.item) = 1)
			end
		end

feature -- Test: Random Characters

	test_random_digit
			-- Test random_digit produces valid digits.
		note
			testing: "execution/isolated"
		local
			c: CHARACTER
		do
			across 1 |..| 20 as ic loop
				c := randomizer.random_digit
				assert ("is digit " + ic.item.out, c >= '0' and c <= '9')
			end
		end

	test_random_letter_lower
			-- Test random_letter_lower produces lowercase letters.
		note
			testing: "execution/isolated"
		local
			c: CHARACTER
		do
			across 1 |..| 20 as ic loop
				c := randomizer.random_letter_lower
				assert ("is lowercase " + ic.item.out, c >= 'a' and c <= 'z')
			end
		end

	test_random_letter_upper
			-- Test random_letter_upper produces uppercase letters.
		note
			testing: "execution/isolated"
		local
			c: CHARACTER
		do
			across 1 |..| 20 as ic loop
				c := randomizer.random_letter_upper
				assert ("is uppercase " + ic.item.out, c >= 'A' and c <= 'Z')
			end
		end

	test_random_character_from
			-- Test random_character_from selects from source.
		note
			testing: "execution/isolated"
		local
			c: CHARACTER
			l_source: STRING
		do
			l_source := "XYZ123"
			across 1 |..| 20 as ic loop
				c := randomizer.random_character_from (l_source)
				assert ("from source " + ic.item.out, l_source.has (c))
			end
		end

feature -- Test: Random Strings

	test_random_digits
			-- Test random_digits produces correct length digit strings.
		note
			testing: "execution/isolated"
		local
			s: STRING
		do
			s := randomizer.random_digits (8)
			assert ("correct length", s.count = 8)
			across s as c loop
				assert ("all digits", c.item >= '0' and c.item <= '9')
			end
		end

	test_random_letters
			-- Test random_letters produces correct length letter strings.
		note
			testing: "execution/isolated"
		local
			s: STRING
		do
			s := randomizer.random_letters (10)
			assert ("correct length", s.count = 10)
			across s as c loop
				assert ("all letters", c.item >= 'a' and c.item <= 'z')
			end
		end

	test_random_alphanumeric_string
			-- Test random_alphanumeric_string produces correct length.
		note
			testing: "execution/isolated"
		local
			s: STRING
		do
			s := randomizer.random_alphanumeric_string (12)
			assert ("correct length", s.count = 12)
		end

	test_random_word
			-- Test random_word produces pronounceable words.
		note
			testing: "execution/isolated"
		local
			s: STRING
		do
			across 1 |..| 10 as ic loop
				s := randomizer.random_word
				assert ("not empty " + ic.item.out, not s.is_empty)
				assert ("reasonable length " + ic.item.out, s.count >= 4 and s.count <= 12)
			end
		end

	test_random_word_capitalized
			-- Test random_word_capitalized has capital first letter.
		note
			testing: "execution/isolated"
		local
			s: STRING
		do
			s := randomizer.random_word_capitalized
			assert ("not empty", not s.is_empty)
			assert ("capitalized", s.item (1).is_upper)
		end

	test_random_sentence
			-- Test random_sentence is properly formatted.
		note
			testing: "execution/isolated"
		local
			s: STRING
		do
			s := randomizer.random_sentence
			assert ("not empty", not s.is_empty)
			assert ("ends with period", s.item (s.count) = '.')
			assert ("starts capitalized", s.item (1).is_upper)
		end

	test_random_paragraph
			-- Test random_paragraph produces multiple sentences.
		note
			testing: "execution/isolated"
		local
			s: STRING
		do
			s := randomizer.random_paragraph
			assert ("not empty", not s.is_empty)
			assert ("has multiple periods", s.occurrences ('.') >= 3)
		end

	test_random_identifier
			-- Test random_identifier is valid identifier format.
		note
			testing: "execution/isolated"
		local
			s: STRING
		do
			s := randomizer.random_identifier
			assert ("not empty", not s.is_empty)
			assert ("no spaces", not s.has (' '))
			assert ("has underscore", s.has ('_'))
		end

feature -- Test: Random Dates

	test_random_date_in_past_days
			-- Test random_date_in_past_days produces past dates.
		note
			testing: "execution/isolated"
		local
			d, today: DATE
		do
			create today.make_now
			across 1 |..| 10 as ic loop
				d := randomizer.random_date_in_past_days (30)
				assert ("in past " + ic.item.out, d < today)
				assert ("within 30 days " + ic.item.out, today.days - d.days <= 30)
			end
		end

	test_random_date_in_future_days
			-- Test random_date_in_future_days produces future dates.
		note
			testing: "execution/isolated"
		local
			d, today: DATE
		do
			create today.make_now
			across 1 |..| 10 as ic loop
				d := randomizer.random_date_in_future_days (30)
				assert ("in future " + ic.item.out, d > today)
				assert ("within 30 days " + ic.item.out, d.days - today.days <= 30)
			end
		end

	test_random_date_in_range
			-- Test random_date_in_range respects bounds.
		note
			testing: "execution/isolated"
		local
			d, start_date, end_date: DATE
		do
			create start_date.make (2024, 1, 1)
			create end_date.make (2024, 12, 31)
			across 1 |..| 10 as ic loop
				d := randomizer.random_date_in_range (start_date, end_date)
				assert ("after start " + ic.item.out, d >= start_date)
				assert ("before end " + ic.item.out, d <= end_date)
			end
		end

feature -- Test: UUID

	test_random_uuid
			-- Test random_uuid produces valid UUIDs.
		note
			testing: "execution/isolated"
		local
			u1, u2: UUID
		do
			u1 := randomizer.random_uuid
			u2 := randomizer.random_uuid
			assert ("uuid created", u1 /= Void)
			assert ("different uuids", not u1.is_equal (u2))
		end

	test_random_uuid_string
			-- Test random_uuid_string has correct format.
		note
			testing: "execution/isolated"
		local
			s: STRING
		do
			s := randomizer.random_uuid_string
			assert ("has 4 hyphens", s.occurrences ('-') = 4)
			assert ("correct length", s.count = 36)
		end

	test_random_uuid_compact
			-- Test random_uuid_compact has no hyphens.
		note
			testing: "execution/isolated"
		local
			s: STRING
		do
			s := randomizer.random_uuid_compact
			assert ("no hyphens", not s.has ('-'))
			assert ("correct length", s.count = 32)
		end

feature -- Test: Selection

	test_random_string_from_list
			-- Test random_string_from_list selects from list.
		note
			testing: "execution/isolated"
		local
			l_list: ARRAY [STRING]
			s: STRING
		do
			l_list := <<"apple", "banana", "cherry">>
			across 1 |..| 20 as ic loop
				s := randomizer.random_string_from_list (l_list)
				assert ("from list " + ic.item.out,
					s.same_string ("apple") or s.same_string ("banana") or s.same_string ("cherry"))
			end
		end

feature -- Test: Reproducibility

	test_seeded_reproducibility
			-- Test that same seed produces same sequence.
		note
			testing: "execution/isolated"
		local
			r1, r2: SIMPLE_RANDOMIZER
			v1, v2: INTEGER
			l_same: BOOLEAN
		do
			create r1.make_with_seed (12345)
			create r2.make_with_seed (12345)

			l_same := True
			across 1 |..| 10 as ic loop
				v1 := r1.random_integer
				v2 := r2.random_integer
				l_same := l_same and (v1 = v2)
			end
			assert ("same sequence with same seed", l_same)
		end

feature {NONE} -- Implementation

	randomizer: SIMPLE_RANDOMIZER
			-- Randomizer under test

end
