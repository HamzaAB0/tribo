use crate::input::{Datatype, Domain, Input};
use crate::solver::{Solver, Workspace, WorkspaceVariant};
use num_traits::{Float, FromPrimitive};

fn initialise_workspace_memory<T>(domain: &Domain) -> Workspace<T>
where
    T: FromPrimitive + Default + Clone + Float,
{
    assert!(domain.nx >= 2, "Domain requires at least two grid points");
    let n: T = T::from_usize(domain.nx - 1).unwrap();
    let x: T = T::from_f64(domain.xout - domain.xin).unwrap();
    Workspace {
        p: vec![T::default(); domain.nx],
        h: vec![T::default(); domain.nx],
        fb: T::default(),
        dx: x / n,
    }
}

pub fn initialise_solver(input: Input) -> Solver {
    let workspace = input
        .multigrid
        .iter()
        .map(|grid| match grid.storage_dt {
            Datatype::F64 => WorkspaceVariant::F64(initialise_workspace_memory(&input.domain)),
            Datatype::F32 => WorkspaceVariant::F32(initialise_workspace_memory(&input.domain)),
        })
        .collect();

    Solver {
        domain: input.domain,
        moes: input.moes,
        tolerance: input.tolerance,
        workspace: workspace,
    }
}
