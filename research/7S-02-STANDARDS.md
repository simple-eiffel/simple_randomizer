# 7S-02: STANDARDS - simple_randomizer

**BACKWASH DOCUMENT** - Generated: 2026-01-23
**Status**: Reverse-engineered from existing implementation

## 1. Applicable Standards

### 1.1 UUID Generation
- **RFC 4122**: A Universally Unique IDentifier (UUID) URN Namespace
- Library implements UUID v4 (random-based)
- Format: xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx
- Version nibble set to 4, variant bits set to RFC 4122

### 1.2 Random Number Generation
- Uses EiffelBase RANDOM class (linear congruential generator)
- Seeding via time-based or explicit seed values

## 2. Eiffel Standards

### 2.1 Design by Contract
- Preconditions on range validity
- Postconditions on output validity
- Class invariant ensures random_sequence exists

### 2.2 Void Safety
- Full void safety compliance
- No detachable attributes in public interface

### 2.3 Naming Conventions
- Feature names follow Eiffel style guide
- Prefix `random_` for all random generation features

## 3. Simple Ecosystem Standards

### 3.1 Dependencies
- simple_date_time (for date generation and seeding)

### 3.2 Testing
- Standard lib_tests.e pattern
- test_app.e for executable testing

## 4. Compliance Notes

The implementation correctly follows UUID v4 specification:
- Byte 7: high nibble forced to 0100 (version 4)
- Byte 9: high bits forced to 10xx (RFC 4122 variant)
