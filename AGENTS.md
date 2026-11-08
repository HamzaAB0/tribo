# Repository guidance

This project is a Rust solver for one-dimensional ball-on-flat elastohydrodynamic lubrication (EHL). The solver is under `src/solver` and the command-line interface is under `src/cli`. The implementation is still being developed; do not assume that a complete EHL solve or multigrid algorithm already exists.

## Implementation

- Prefer simple, readable numerical code that the compiler can auto-vectorize. Use contiguous arrays, straightforward loops and predictable memory access. Keep allocations, unnecessary branches and dynamic dispatch out of hot loops where practical.
- Preserve numerical dependencies: do not reorder updates, parallelize or otherwise change an algorithm merely to encourage vectorization. Measure performance before adding complexity, intrinsics or unsafe code.
- Keep binaries such as the CLI as thin wrappers. Put shared functionality under `src/solver` so multiple frontends can reuse it, and keep frontend-specific concerns out of the solver. Follow existing Rust module and visibility conventions, and avoid new dependencies unless they provide a clear benefit.
- Be explicit about physical and dimensionless quantities, units, precision, boundary conditions and convergence criteria when introducing or changing them. Preserve the distinction between storage and compute precision; do not silently lose precision.
- Validate numerical changes with meaningful cases and tolerances, including relevant boundary conditions and convergence or physical consistency checks. Document assumptions and references for formulas or benchmark values where possible.

## Build and verification

- Use Cargo: `cargo build --locked` and `cargo test --locked`. CI runs both with `--profile lto` on Linux, Windows and macOS; use that profile when validating changes that may affect release behavior.
- Run `cargo fmt --check` for formatting changes and use `cargo run --bin tribo-cli -- demo --problem 1` or `--problem 2` to exercise the CLI when relevant.
