mod argparse;

use tribo_solver;

fn main() {
    let args = argparse::parse();

    let input = match args.modes {
        argparse::Modes::Demo { problem } => tribo_solver::get_demo_input(problem),
    };

    let solver = tribo_solver::initialise_solver(input);
    println!("{:#?}", solver);
}
