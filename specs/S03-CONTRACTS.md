# S03: CONTRACTS - simple_randomizer

**BACKWASH DOCUMENT** - Generated: 2026-01-23
**Status**: Reverse-engineered from existing implementation

## 1. SIMPLE_RANDOMIZER Contracts

### 1.1 Creation Procedures

#### make_with_seed
```eiffel
require
    positive_seed: a_seed > 0
ensure
    seed_set: random_sequence.seed = a_seed
```

### 1.2 Random Numbers

#### random_integer_in_range
```eiffel
require
    valid_range: a_range.lower <= a_range.upper
ensure
    in_range: a_range.has (Result)
```

#### random_real_in_range
```eiffel
require
    valid_range: a_lower <= a_upper
ensure
    in_range: Result >= a_lower and Result <= a_upper
```

#### random_boolean_weighted
```eiffel
require
    valid_percent: a_true_percent >= 0 and a_true_percent <= 100
```

### 1.3 Unique Arrays

#### unique_integers
```eiffel
require
    valid_count: a_count > 0
    range_large_enough: (a_range.upper - a_range.lower + 1) >= a_count
ensure
    correct_count: Result.count = a_count
    all_unique: across Result as ic all Result.occurrences (ic.item) = 1 end
```

### 1.4 Random Characters

#### random_digit
```eiffel
ensure
    is_digit: Digits.has (Result)
```

#### random_letter_lower
```eiffel
ensure
    is_lower: Alphabet_lower.has (Result)
```

#### random_character_from
```eiffel
require
    not_empty: not a_characters.is_empty
ensure
    from_source: a_characters.has (Result)
```

### 1.5 Random Strings

#### random_digits
```eiffel
require
    positive_length: a_length > 0
ensure
    correct_length: Result.count = a_length
    all_digits: across Result as c all Digits.has (c.item) end
```

#### random_letters
```eiffel
require
    positive_length: a_length > 0
ensure
    correct_length: Result.count = a_length
```

#### random_word
```eiffel
ensure
    not_empty: not Result.is_empty
```

#### random_sentence
```eiffel
ensure
    ends_with_period: Result.item (Result.count) = '.'
    starts_capitalized: Result.item (1).is_upper
```

### 1.6 Random Dates

#### random_date_in_past_days
```eiffel
require
    positive_days: a_days > 0
```

#### random_date_in_range
```eiffel
require
    valid_range: a_start <= a_end
ensure
    in_range: Result >= a_start and Result <= a_end
```

### 1.7 UUID Generation

#### random_uuid
```eiffel
ensure
    valid_format: Result.occurrences ('-') = 4
    correct_length: Result.count = 36
```

#### random_uuid_compact
```eiffel
ensure
    no_hyphens: not Result.has ('-')
    correct_length: Result.count = 32
```

### 1.8 Selection

#### random_item_from_array
```eiffel
require
    not_empty: not a_array.is_empty
```

### 1.9 Class Invariant

```eiffel
invariant
    random_sequence_exists: random_sequence /= Void
```
