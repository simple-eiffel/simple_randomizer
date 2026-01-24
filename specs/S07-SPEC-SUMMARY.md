# S07: SPEC SUMMARY - simple_randomizer

**BACKWASH DOCUMENT** - Generated: 2026-01-23
**Status**: Reverse-engineered from existing implementation

## 1. Library Overview

**Name**: simple_randomizer
**Purpose**: Lightweight random data generation for testing
**Status**: Production ready

## 2. Quick Reference

### 2.1 Creation
```eiffel
-- Time-based seed (non-reproducible)
create randomizer.make

-- Explicit seed (reproducible)
create randomizer.make_with_seed (42)
```

### 2.2 Common Operations
```eiffel
-- Numbers
i := randomizer.random_integer_in_range (1 |..| 100)
r := randomizer.random_real_in_range (0.0, 1.0)
b := randomizer.random_boolean

-- Strings
word := randomizer.random_word
sentence := randomizer.random_sentence
id := randomizer.random_identifier

-- Dates
past := randomizer.random_date_in_past_days (30)
future := randomizer.random_date_in_future_days (7)

-- UUIDs
uuid := randomizer.random_uuid
```

## 3. Key Specifications

| Aspect | Specification |
|--------|---------------|
| Classes | 1 (SIMPLE_RANDOMIZER) |
| Dependencies | simple_date_time |
| Thread Safety | No |
| Crypto Safe | No |
| Void Safe | Yes |

## 4. Contracts Summary

### 4.1 Key Preconditions
- Ranges must be valid (lower <= upper)
- Lengths must be positive
- Collections must not be empty
- Seed must be positive

### 4.2 Key Postconditions
- Results within specified ranges
- Strings have correct lengths
- UUIDs have correct format

### 4.3 Invariants
- random_sequence always exists

## 5. Warnings

1. **NOT cryptographically secure** - Do not use for security purposes
2. **NOT thread-safe** - Use external synchronization for concurrent access
3. **UUID uniqueness not guaranteed** - Statistical uniqueness only
