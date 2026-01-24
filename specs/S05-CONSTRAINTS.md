# S05: CONSTRAINTS - simple_randomizer

**BACKWASH DOCUMENT** - Generated: 2026-01-23
**Status**: Reverse-engineered from existing implementation

## 1. Technical Constraints

### 1.1 Platform Constraints
- **EiffelStudio**: Requires EiffelStudio 25.02 or compatible
- **Platform**: Cross-platform (no platform-specific code)

### 1.2 Dependency Constraints
- Requires simple_date_time library for date features
- Uses EiffelBase RANDOM class

### 1.3 Thread Safety Constraints
- **NOT thread-safe**: RANDOM state is mutable
- Concurrent access requires external synchronization
- For SCOOP: Create separate SIMPLE_RANDOMIZER per processor

## 2. Design Constraints

### 2.1 Algorithm Constraints
- Uses linear congruential generator (LCG)
- Period: 2^31 - 1 (from EiffelBase RANDOM)
- Distribution: Uniform only

### 2.2 Range Constraints
| Feature | Minimum | Maximum |
|---------|---------|---------|
| random_integer | INTEGER_32_MIN | INTEGER_32_MAX |
| random_real | 0.0 | 1.0 (exclusive) |
| seed | 1 | INTEGER_32_MAX |
| unique_integers count | 1 | range size |

### 2.3 String Generation Constraints
- Word length: 4-6 characters (2-3 syllables x 2 chars)
- Sentence length: 3-8 words
- Paragraph length: 3-6 sentences

## 3. Security Constraints

### 3.1 CRITICAL: Not Cryptographically Secure
- LCG is predictable given sufficient samples
- NOT suitable for security tokens, passwords, keys
- Use platform crypto APIs for security-sensitive randomness

### 3.2 UUID Uniqueness
- Statistical uniqueness only (not guaranteed)
- Not suitable for security-critical unique identifiers

## 4. Performance Constraints

### 4.1 Time Complexity
- All operations O(1) or O(n) where n is output length
- unique_integers may require multiple attempts (worst case O(k*range) for k items)

### 4.2 Memory Constraints
- Minimal memory footprint
- No caching or persistent state beyond RANDOM sequence
