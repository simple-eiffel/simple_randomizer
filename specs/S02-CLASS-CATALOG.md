# S02: CLASS CATALOG - simple_randomizer

**BACKWASH DOCUMENT** - Generated: 2026-01-23
**Status**: Reverse-engineered from existing implementation

## 1. Class Overview

| Class | Type | Purpose |
|-------|------|---------|
| SIMPLE_RANDOMIZER | Effective | Main randomization facade |

## 2. Class Details

### 2.1 SIMPLE_RANDOMIZER

**Purpose**: Lightweight random data generation for testing.

**Inheritance**: None (standalone class)

**Creation Procedures**:
- `make` - Create with time-based seed
- `make_with_seed (a_seed: INTEGER)` - Create with explicit seed

**Feature Groups**:
1. Initialization
2. Random Numbers
3. Unique Arrays
4. Random Characters
5. Random Strings
6. Random Dates
7. UUID Generation
8. Selection
9. Constants

**Dependencies**:
- RANDOM (EiffelBase)
- SIMPLE_DATE_TIME (simple_date_time)
- SIMPLE_DATE (simple_date_time)

**Invariants**:
- `random_sequence_exists: random_sequence /= Void`
