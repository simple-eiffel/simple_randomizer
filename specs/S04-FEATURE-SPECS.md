# S04: FEATURE SPECS - simple_randomizer

**BACKWASH DOCUMENT** - Generated: 2026-01-23
**Status**: Reverse-engineered from existing implementation

## 1. SIMPLE_RANDOMIZER Features

### 1.1 Initialization

| Feature | Signature | Description |
|---------|-----------|-------------|
| make | `make` | Create with time-based seed |
| make_with_seed | `make_with_seed (a_seed: INTEGER)` | Create with explicit seed |

### 1.2 Random Numbers

| Feature | Signature | Description |
|---------|-----------|-------------|
| random_integer | `: INTEGER` | Random integer |
| random_integer_in_range | `(a_range: INTEGER_INTERVAL): INTEGER` | Random integer in range |
| random_real | `: REAL_64` | Random real [0, 1] |
| random_real_in_range | `(a_lower, a_upper: REAL_64): REAL_64` | Random real in range |
| random_boolean | `: BOOLEAN` | Random boolean (50/50) |
| random_boolean_weighted | `(a_true_percent: INTEGER): BOOLEAN` | Weighted random boolean |

### 1.3 Unique Arrays

| Feature | Signature | Description |
|---------|-----------|-------------|
| unique_integers | `(a_count: INTEGER; a_range: INTEGER_INTERVAL): ARRAYED_LIST [INTEGER]` | Array of unique integers |

### 1.4 Random Characters

| Feature | Signature | Description |
|---------|-----------|-------------|
| random_digit | `: CHARACTER` | Random '0'..'9' |
| random_letter_lower | `: CHARACTER` | Random 'a'..'z' |
| random_letter_upper | `: CHARACTER` | Random 'A'..'Z' |
| random_letter | `: CHARACTER` | Random letter (any case) |
| random_alphanumeric | `: CHARACTER` | Random letter or digit |
| random_character_from | `(a_characters: STRING): CHARACTER` | Random from set |

### 1.5 Random Strings

| Feature | Signature | Description |
|---------|-----------|-------------|
| random_digits | `(a_length: INTEGER): STRING` | String of digits |
| random_letters | `(a_length: INTEGER): STRING` | String of lowercase letters |
| random_alphanumeric_string | `(a_length: INTEGER): STRING` | Alphanumeric string |
| random_word | `: STRING` | Pronounceable word (2-3 syllables) |
| random_word_capitalized | `: STRING` | Capitalized pronounceable word |
| random_words | `(a_count: INTEGER): STRING` | Space-separated words |
| random_sentence | `: STRING` | Sentence (3-8 words) |
| random_paragraph | `: STRING` | Paragraph (3-6 sentences) |
| random_identifier | `: STRING` | Code-safe identifier |

### 1.6 Random Dates

| Feature | Signature | Description |
|---------|-----------|-------------|
| random_date_in_past_days | `(a_days: INTEGER): SIMPLE_DATE` | Date within N days ago |
| random_date_in_future_days | `(a_days: INTEGER): SIMPLE_DATE` | Date within N days ahead |
| random_date_in_range | `(a_start, a_end: SIMPLE_DATE): SIMPLE_DATE` | Date in range |
| random_date_around_now | `(a_days_range: INTEGER): SIMPLE_DATE` | Date +/- N days |

### 1.7 UUID Generation

| Feature | Signature | Description |
|---------|-----------|-------------|
| random_uuid | `: STRING` | UUID v4 (hyphenated) |
| random_uuid_string | `: STRING` | Alias for random_uuid |
| random_uuid_compact | `: STRING` | UUID v4 (no hyphens) |

### 1.8 Selection

| Feature | Signature | Description |
|---------|-----------|-------------|
| random_item_from_array | `(a_array: ARRAY [ANY]): ANY` | Random array element |
| random_string_from_list | `(a_list: ARRAY [STRING]): STRING` | Random string from list |

### 1.9 Constants

| Constant | Value | Description |
|----------|-------|-------------|
| Alphabet_lower | "abcdefghijklmnopqrstuvwxyz" | Lowercase alphabet |
| Vowels | "aeiou" | Vowels for word generation |
| Consonants | "bcdfghjklmnpqrstvwxyz" | Consonants for word generation |
| Digits | "0123456789" | Decimal digits |
