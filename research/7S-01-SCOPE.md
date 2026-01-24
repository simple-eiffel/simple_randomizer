# 7S-01: SCOPE - simple_randomizer


**Date**: 2026-01-23

**BACKWASH DOCUMENT** - Generated: 2026-01-23
**Status**: Reverse-engineered from existing implementation

## 1. Problem Domain

### 1.1 What Problem Does This Library Solve?
SIMPLE_RANDOMIZER provides lightweight random data generation for testing and prototyping purposes in Eiffel applications. It addresses the need for generating random test data without external file dependencies or domain-specific data sets.

### 1.2 Who Needs This?
- Eiffel developers writing unit tests
- Applications needing random test data generation
- Prototyping scenarios requiring mock data
- Testing frameworks needing deterministic or non-deterministic random values

### 1.3 What Exists Already?
- EiffelBase RANDOM class (basic integer/real generation)
- No built-in support for strings, dates, UUIDs, or structured random data

## 2. Scope Definition

### 2.1 IN Scope
- Random number generation (integers, reals, booleans)
- Random string generation (words, sentences, paragraphs, identifiers)
- Random character generation (letters, digits, alphanumeric)
- Random date generation (past, future, ranges)
- UUID v4 generation
- Unique value arrays
- Reproducible randomness via seed control

### 2.2 OUT of Scope
- Domain-specific fake data (names, addresses, emails)
- File-based data sources
- Cryptographic randomness
- Distribution control (normal, exponential, etc.)

## 3. Success Criteria

- Compile cleanly with EiffelStudio 25.02
- All random generators produce valid output within specified ranges
- Seeded randomizer produces reproducible sequences
- UUID format conforms to RFC 4122 v4
- No external dependencies beyond simple_date_time
