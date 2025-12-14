note
	description: "Test root class for SIMPLE_RANDOMIZER tests"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_APP

create
	make

feature {NONE} -- Initialization

	make
			-- Run all tests.
		local
			tests: LIB_TESTS
		do
			create tests
			tests.on_prepare

			print ("simple_randomizer test runner%N")
			print ("==============================%N%N")

			passed := 0
			failed := 0

			-- Random Numbers
			run_test (agent tests.test_random_integer, "test_random_integer")
			run_test (agent tests.test_random_integer_in_range, "test_random_integer_in_range")
			run_test (agent tests.test_random_real, "test_random_real")
			run_test (agent tests.test_random_real_in_range, "test_random_real_in_range")
			run_test (agent tests.test_random_boolean, "test_random_boolean")
			run_test (agent tests.test_random_boolean_weighted, "test_random_boolean_weighted")
			run_test (agent tests.test_unique_integers, "test_unique_integers")

			-- Random Characters
			run_test (agent tests.test_random_digit, "test_random_digit")
			run_test (agent tests.test_random_letter_lower, "test_random_letter_lower")
			run_test (agent tests.test_random_letter_upper, "test_random_letter_upper")
			run_test (agent tests.test_random_character_from, "test_random_character_from")

			-- Random Strings
			run_test (agent tests.test_random_digits, "test_random_digits")
			run_test (agent tests.test_random_letters, "test_random_letters")
			run_test (agent tests.test_random_alphanumeric_string, "test_random_alphanumeric_string")
			run_test (agent tests.test_random_word, "test_random_word")
			run_test (agent tests.test_random_word_capitalized, "test_random_word_capitalized")
			run_test (agent tests.test_random_sentence, "test_random_sentence")
			run_test (agent tests.test_random_paragraph, "test_random_paragraph")
			run_test (agent tests.test_random_identifier, "test_random_identifier")

			-- Random Dates
			run_test (agent tests.test_random_date_in_past_days, "test_random_date_in_past_days")
			run_test (agent tests.test_random_date_in_future_days, "test_random_date_in_future_days")
			run_test (agent tests.test_random_date_in_range, "test_random_date_in_range")

			-- UUID
			run_test (agent tests.test_random_uuid, "test_random_uuid")
			run_test (agent tests.test_random_uuid_string, "test_random_uuid_string")
			run_test (agent tests.test_random_uuid_compact, "test_random_uuid_compact")

			-- Selection
			run_test (agent tests.test_random_string_from_list, "test_random_string_from_list")

			-- Reproducibility
			run_test (agent tests.test_seeded_reproducibility, "test_seeded_reproducibility")

			print ("%N==============================%N")
			print ("Results: " + passed.out + " passed, " + failed.out + " failed%N")

			if failed > 0 then
				print ("TESTS FAILED%N")
			else
				print ("ALL TESTS PASSED%N")
			end
		end

feature {NONE} -- Implementation

	passed: INTEGER
	failed: INTEGER

	run_test (a_test: PROCEDURE; a_name: STRING)
			-- Run a single test and update counters.
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				a_test.call (Void)
				print ("  PASS: " + a_name + "%N")
				passed := passed + 1
			end
		rescue
			print ("  FAIL: " + a_name + "%N")
			failed := failed + 1
			l_retried := True
			retry
		end

end
