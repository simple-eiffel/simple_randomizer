<p align="center">
  <img src="https://raw.githubusercontent.com/simple-eiffel/claude_eiffel_op_docs/main/artwork/LOGO.png" alt="simple_ library logo" width="400">
</p>

# SIMPLE_RANDOMIZER

**[Documentation](https://simple-eiffel.github.io/simple_randomizer/)**

Lightweight random data generation library for Eiffel testing.

## Overview

SIMPLE_RANDOMIZER provides core randomization features for generating test data without domain-specific baggage or file dependencies. It's a lean replacement for heavier randomizer libraries.

## Features

- **Random Numbers**: Integers, reals, booleans with range support
- **Random Strings**: Words, sentences, paragraphs, identifiers
- **Random Characters**: Letters, digits, alphanumeric
- **Random Dates**: Past, future, ranges
- **UUID Generation**: Full UUID, string, and compact formats
- **Reproducible Sequences**: Seed-based deterministic randomness

## Installation

1. Clone or download this repository
2. Set the ecosystem environment variable (one-time setup for all simple_* libraries):
   ```powershell
   [System.Environment]::SetEnvironmentVariable('SIMPLE_EIFFEL', 'D:\prod', 'User')
   ```
3. Add to your ECF:
   ```xml
   <library name="simple_randomizer" location="$SIMPLE_EIFFEL/simple_randomizer/simple_randomizer.ecf"/>
   ```

## Usage

```eiffel
class MY_TEST

feature
    randomizer: SIMPLE_RANDOMIZER

    generate_test_data
        local
            name: STRING
            age: INTEGER
            hire_date: DATE
            id: STRING
        do
            -- Time-based seed (non-reproducible)
            create randomizer.make

            -- Or fixed seed for reproducible tests
            -- create randomizer.make_with_seed (12345)

            name := randomizer.random_word_capitalized
            age := randomizer.random_integer_in_range (18 |..| 65)
            hire_date := randomizer.random_date_in_past_days (365)
            id := randomizer.random_uuid_compact

            print ("Name: " + name + "%N")
            print ("Age: " + age.out + "%N")
            print ("Hired: " + hire_date.out + "%N")
            print ("ID: " + id + "%N")
        end
end
```

## API Reference

### Random Numbers

| Feature | Description |
|---------|-------------|
| `random_integer` | Random integer |
| `random_integer_in_range (range)` | Integer within range |
| `random_real` | Real between 0 and 1 |
| `random_real_in_range (lower, upper)` | Real within bounds |
| `random_boolean` | 50/50 true/false |
| `random_boolean_weighted (percent)` | Weighted probability |
| `unique_integers (count, range)` | Array of unique integers |

### Random Characters

| Feature | Description |
|---------|-------------|
| `random_digit` | '0'..'9' |
| `random_letter_lower` | 'a'..'z' |
| `random_letter_upper` | 'A'..'Z' |
| `random_letter` | Any case letter |
| `random_alphanumeric` | Letter or digit |
| `random_character_from (string)` | Character from source |

### Random Strings

| Feature | Description |
|---------|-------------|
| `random_digits (length)` | String of digits |
| `random_letters (length)` | String of lowercase letters |
| `random_alphanumeric_string (length)` | Mixed string |
| `random_word` | Pronounceable word |
| `random_word_capitalized` | Capitalized word |
| `random_words (count)` | Space-separated words |
| `random_sentence` | Capitalized with period |
| `random_paragraph` | Multiple sentences |
| `random_identifier` | Code-safe identifier |

### Random Dates

| Feature | Description |
|---------|-------------|
| `random_date_in_past_days (days)` | Date within N days ago |
| `random_date_in_future_days (days)` | Date within N days ahead |
| `random_date_in_range (start, end)` | Date between bounds |
| `random_date_around_now (days)` | Date +/- N days from today |

### UUID

| Feature | Description |
|---------|-------------|
| `random_uuid` | UUID object |
| `random_uuid_string` | Hyphenated format (36 chars) |
| `random_uuid_compact` | No hyphens (32 chars) |

### Selection

| Feature | Description |
|---------|-------------|
| `random_item_from_array (array)` | Random array element |
| `random_string_from_list (list)` | Random string from array |

## Dependencies

- `base` - Eiffel standard library
- `time` - DATE and time-based seeding
- `uuid` - UUID generation

## Tests

27 tests covering all functionality.

```batch
ec.exe -batch -config simple_randomizer.ecf -target simple_randomizer_tests -tests
```

## License

MIT License - Copyright (c) 2024-2025, Larry Rix
