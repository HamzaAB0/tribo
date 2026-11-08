use clap::{Parser, Subcommand};

#[derive(Parser)]
#[command(version, about, long_about = None, flatten_help = true)]
pub(crate) struct Args {
    /// Enable verbose output.
    #[arg(short, long, global = true)]
    pub(crate) verbose: bool,

    #[command(subcommand)]
    pub(crate) modes: Modes,
}

#[derive(Subcommand)]
pub(crate) enum Modes {
    /// Run a preset problem configuration
    #[command(disable_help_flag = true)]
    Demo {
        /// The demo problem to solve (1-2).
        #[arg(short, long, default_value_t = 1, value_parser = clap::value_parser!(i8).range(1..=2))]
        problem: i8,
    },
}

pub(crate) fn parse() -> Args {
    Args::parse()
}
