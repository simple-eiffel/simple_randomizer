# SIMPLE_RANDOMIZER Roadmap

---

## Claude: Start Here

**When starting a new conversation, read this file first.**

### Session Startup

1. **Read Eiffel reference docs**: `D:/prod/reference_docs/eiffel/claude/CONTEXT.md`
2. **Review this roadmap** for project-specific context
3. **Ask**: "What would you like to work on this session?"

### Key Reference Files

| File | Purpose |
|------|---------|
| `D:/prod/reference_docs/eiffel/claude/CONTEXT.md` | Generic Eiffel knowledge |
| `D:/prod/reference_docs/eiffel/language/gotchas.md` | Generic Eiffel gotchas |
| `D:/prod/reference_docs/eiffel/language/patterns.md` | Verified code patterns |

### Build & Test Commands

```batch
:: Set environment variable (if not already set)
set TESTING_EXT=D:\prod\testing_ext

:: Compile
ec.exe -batch -config simple_randomizer.ecf -target simple_randomizer_tests -c_compile -freeze

:: Clean compile
ec.exe -batch -config simple_randomizer.ecf -target simple_randomizer_tests -c_compile -freeze -clean

:: Run tests
ec.exe -batch -config simple_randomizer.ecf -target simple_randomizer_tests -tests
```

### Current Status

**Stable** - 27 tests passing

---

## Project Overview

SIMPLE_RANDOMIZER is a lightweight random data generation library for Eiffel. It provides essential randomization features without domain-specific data or file dependencies.

### Design Philosophy

- **No file dependencies**: All data is self-contained
- **No domain-specific data**: No job types, materials, addresses, etc.
- **Core features only**: Numbers, strings, dates, UUIDs
- **Reproducible option**: Seed-based deterministic sequences for testing

---

## Current State

### SIMPLE_RANDOMIZER Class

Single class providing all functionality:

| Category | Features |
|----------|----------|
| **Numbers** | `random_integer`, `random_integer_in_range`, `random_real`, `random_real_in_range`, `random_boolean`, `random_boolean_weighted` |
| **Characters** | `random_digit`, `random_letter_lower`, `random_letter_upper`, `random_letter`, `random_alphanumeric`, `random_character_from` |
| **Strings** | `random_digits`, `random_letters`, `random_alphanumeric_string`, `random_word`, `random_word_capitalized`, `random_words`, `random_sentence`, `random_paragraph`, `random_identifier` |
| **Dates** | `random_date_in_past_days`, `random_date_in_future_days`, `random_date_in_range`, `random_date_around_now` |
| **UUID** | `random_uuid`, `random_uuid_string`, `random_uuid_compact` |
| **Selection** | `random_item_from_array`, `random_string_from_list` |
| **Unique** | `unique_integers` |

---

## Dependencies

- `base` - Eiffel standard library
- `time` - DATE class and time-based seeding
- `uuid` - UUID generation

---

## What Was Removed (vs old RANDOMIZER)

The old `randomizer` library had many features that are no longer included:

| Removed | Reason |
|---------|--------|
| CSV file dependencies | Required external data files |
| First/last name generation | File-dependent |
| World cities data | File-dependent |
| Occupation lists | Domain-specific |
| Job type/subtype lists | Domain-specific |
| Material type lists | Domain-specific |
| UOM (unit of measure) lists | Domain-specific |
| Address generation | File-dependent |
| Complex grapheme word generation | Over-engineered |
| Money/decimal generation | Use `random_real_in_range` instead |

---

## Potential Future Work

| Feature | Description | Priority |
|---------|-------------|----------|
| **Email generation** | `random_email` -> "word@word.com" | Low |
| **Phone number format** | `random_phone` -> "(555) 555-5555" | Low |
| **Lorem ipsum** | Classic placeholder text | Low |
| **Weighted selection** | Select from array with weights | Low |
| **Shuffle array** | Randomize array order | Low |

---

## Session Notes

### 2025-12-02 (Initial Creation)

**Task**: Create lean randomizer library from old RANDOMIZER

**Motivation**: The old `randomizer` library had file dependencies and domain-specific data that wasn't generally useful. A lean version with core features only was needed.

**Implementation**:
- Created SIMPLE_RANDOMIZER with essential features
- Removed all file dependencies
- Removed all domain-specific data (jobs, materials, addresses)
- Simplified word generation to vowel/consonant patterns
- Added `make_with_seed` for reproducible sequences
- 27 comprehensive tests

**Result**: 27/27 tests passing

---

## Notes

- All development follows Eiffel Design by Contract principles
- Classes use ECMA-367 standard Eiffel
- Testing via EiffelStudio AutoTest framework with TEST_SET_BASE
- Time-based seeding by default, optional fixed seed for reproducibility
