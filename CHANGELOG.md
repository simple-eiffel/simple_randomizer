# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- SIMPLE_PHILOX (1.2.0): the Philox4x32-10 counter-based generator (Salmon et al., SC'11; Random123). Word n of a stream is computed directly, so a GPU kernel can produce the same values; period 2^64 blocks per stream, 2^64 streams per key (gap G-6 for simple_tensor: the Lehmer sequence's 2^31 period would be spent in about 9 RixGPT dropout steps). Tests: the three Random123 known-answer vectors, counter layout, `forth`/`go_to` against `word`, stream independence, and the mean of 100,000 unit reals.
- `random_gaussian (mean, std)`: Box-Muller normal draws (gap G-2 for simple_tensor weight initialization). Test checks mean/std over 100,000 draws, determinism by seed, and zero spread. Dependents type-check clean (simple_web; its 40 obsolete-call warnings are pre-existing EWF/OAuth code).

### Changed
- Testing config updates, AutoTest fixes, .gitignore cleanup
- Migrate to simple_testing library
- Add GitHub Pages documentation
- Fix README.md formatting
- Add SIMPLE_RANDOMIZER library implementation
- first commit

## [1.0.0] - 2025-12-08

### Added
- Initial release
- Core functionality implemented
- Test suite with comprehensive coverage
- Documentation and examples

[Unreleased]: https://github.com/simple-eiffel/simple_randomizer/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/simple-eiffel/simple_randomizer/releases/tag/v1.0.0
