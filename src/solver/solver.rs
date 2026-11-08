use crate::input::{Domain, Moes, Tolerance};

#[derive(Clone, Debug)]
pub(crate) enum WorkspaceVariant {
    F64(Workspace<f64>),
    F32(Workspace<f32>),
}

#[derive(Clone, Debug)]
pub(crate) struct Workspace<T> {
    pub(crate) p: Vec<T>,
    pub(crate) h: Vec<T>,
    pub(crate) fb: T,
    pub(crate) dx: T,
}

#[derive(Debug)]
pub struct Solver {
    pub(crate) domain: Domain,
    pub(crate) moes: Moes,
    pub(crate) tolerance: Tolerance,
    pub(crate) workspace: Vec<WorkspaceVariant>,
}
