use crate::input::{Domain, Grid, Input, Moes, Tolerance};

fn get_problem_1() -> Input {
    Input {
        domain: Domain {
            nx: 32,
            xin: -3.0,
            xout: 3.0,
        },
        moes: Moes { m: 10.0, l: 0.0 },
        tolerance: Tolerance::default(),
        multigrid: vec![Grid::default()],
    }
}

fn get_problem_2() -> Input {
    Input {
        domain: Domain {
            nx: 64,
            xin: -3.0,
            xout: 3.0,
        },
        moes: Moes { m: 8.0, l: 4.0 },
        tolerance: Tolerance::default(),
        multigrid: vec![Grid::default(), Grid::default()],
    }
}

pub fn get_demo_input(problem: i8) -> Input {
    return match problem {
        1 => get_problem_1(),
        2 => get_problem_2(),
        _ => unreachable!("Should not exceed maxmimum number of demos."),
    };
}
