# S06: BOUNDARIES - simple_randomizer

**BACKWASH DOCUMENT** - Generated: 2026-01-23
**Status**: Reverse-engineered from existing implementation

## 1. API Boundaries

### 1.1 Public Interface
All features in SIMPLE_RANDOMIZER are publicly accessible:
- Creation procedures
- All random generation features
- Constants

### 1.2 Private Features
| Feature | Visibility | Purpose |
|---------|------------|---------|
| random_sequence | {NONE} | Internal RANDOM generator |
| byte_to_hex | {NONE} | UUID helper |

## 2. Input Boundaries

### 2.1 Numeric Inputs
| Parameter | Minimum | Maximum | Notes |
|-----------|---------|---------|-------|
| seed | 1 | MAX_INTEGER | Must be positive |
| range.lower | MIN_INTEGER | range.upper | Lower must not exceed upper |
| range.upper | range.lower | MAX_INTEGER | Upper must not precede lower |
| percent | 0 | 100 | Percentage value |
| length/count | 1 | Unlimited | Must be positive |
| days | 1 | Unlimited | Must be positive |

### 2.2 String Inputs
| Parameter | Constraints |
|-----------|-------------|
| a_characters | Not empty |
| a_array | Not empty |
| a_list | Not empty |

## 3. Output Boundaries

### 3.1 Numeric Outputs
| Feature | Minimum | Maximum |
|---------|---------|---------|
| random_integer | MIN_INTEGER | MAX_INTEGER |
| random_integer_in_range | range.lower | range.upper |
| random_real | 0.0 | < 1.0 |
| random_real_in_range | a_lower | a_upper |

### 3.2 String Outputs
| Feature | Min Length | Max Length |
|---------|------------|------------|
| random_digits | a_length | a_length |
| random_word | 4 | 6 |
| random_sentence | ~15 | ~60 |
| random_uuid | 36 | 36 |
| random_uuid_compact | 32 | 32 |

## 4. Error Boundaries

### 4.1 Precondition Violations
All constraint violations are handled via preconditions:
- Invalid ranges: Precondition violation
- Empty inputs: Precondition violation
- Non-positive lengths: Precondition violation

### 4.2 No Runtime Exceptions
Library does not raise runtime exceptions if contracts are satisfied.
