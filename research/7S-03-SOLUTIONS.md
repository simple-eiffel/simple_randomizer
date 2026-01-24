# 7S-03: SOLUTIONS - simple_randomizer

**BACKWASH DOCUMENT** - Generated: 2026-01-23
**Status**: Reverse-engineered from existing implementation

## 1. Existing Solutions Evaluated

### 1.1 EiffelBase RANDOM
- **Pros**: Built-in, no dependencies
- **Cons**: Only integers/reals, no string/date generation
- **Decision**: Use as underlying generator, wrap with higher-level features

### 1.2 External Libraries (Faker, etc.)
- **Pros**: Rich domain data (names, addresses)
- **Cons**: External dependencies, file-based data
- **Decision**: Out of scope for this library

### 1.3 System Random Sources
- **Pros**: Better entropy (/dev/urandom, CryptGenRandom)
- **Cons**: Platform-specific, complex integration
- **Decision**: Not needed for test data generation

## 2. Chosen Approach

### 2.1 Architecture
- Single class design (SIMPLE_RANDOMIZER)
- Wraps EiffelBase RANDOM for core generation
- Builds higher-level abstractions (strings, dates, UUIDs)

### 2.2 Key Design Decisions

1. **Time-based seeding by default**: Uses current timestamp for non-reproducible randomness
2. **Explicit seed option**: make_with_seed for reproducible test sequences
3. **Pronounceable words**: Alternating consonant/vowel patterns for readability
4. **UUID v4 compliance**: Proper version/variant bit manipulation

### 2.3 Trade-offs Accepted
- Linear congruential generator is not cryptographically secure (acceptable for test data)
- Word generation is algorithmic, not dictionary-based (simpler, no file dependencies)
- Date generation depends on simple_date_time library
