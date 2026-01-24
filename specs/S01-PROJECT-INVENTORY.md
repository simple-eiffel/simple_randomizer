# S01: PROJECT INVENTORY - simple_randomizer

**BACKWASH DOCUMENT** - Generated: 2026-01-23
**Status**: Reverse-engineered from existing implementation

## 1. Project Structure

```
simple_randomizer/
  src/
    simple_randomizer.e          # Main randomizer class
  testing/
    lib_tests.e                  # Library test suite
    test_app.e                   # Test application
  research/                      # Research documents (7S series)
  specs/                         # Specification documents (S series)
  simple_randomizer.ecf          # EiffelStudio configuration
```

## 2. Source Files

| File | Purpose | Lines |
|------|---------|-------|
| simple_randomizer.e | Main randomization class | ~485 |

## 3. Test Files

| File | Purpose |
|------|---------|
| lib_tests.e | Test suite class |
| test_app.e | Test runner application |

## 4. Configuration Files

| File | Purpose |
|------|---------|
| simple_randomizer.ecf | Library and test target configuration |

## 5. Dependencies

### 5.1 External Libraries
| Library | Purpose |
|---------|---------|
| simple_date_time | Date generation and time-based seeding |

### 5.2 EiffelBase Dependencies
- RANDOM: Core random number generator
- INTEGER_INTERVAL: Range specifications
- ARRAYED_LIST: Unique value arrays
- ARRAY: Byte arrays for UUID
