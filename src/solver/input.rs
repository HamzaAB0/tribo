use crate::input::Datatype::F64;

#[derive(Debug)]
pub(crate) struct Domain {
    pub(crate) nx: usize,
    pub(crate) xin: f64,
    pub(crate) xout: f64,
}

#[derive(Debug)]
pub(crate) struct Moes {
    pub(crate) m: f64,
    pub(crate) l: f64,
}

#[derive(Debug)]
pub(crate) struct Tolerance {
    pub(crate) p: f64,
    pub(crate) h: f64,
    pub(crate) fb: f64,
}

#[derive(Clone, Debug)]
pub(crate) enum Datatype {
    F64,
    F32,
}

#[derive(Clone, Debug)]
pub(crate) struct Grid {
    pub(crate) compute_dt: Datatype,
    pub(crate) storage_dt: Datatype,
}

#[derive(Debug)]
pub struct Input {
    pub(crate) domain: Domain,
    pub(crate) moes: Moes,
    pub(crate) tolerance: Tolerance,
    pub(crate) multigrid: Vec<Grid>,
}

impl Default for Tolerance {
    fn default() -> Self {
        Tolerance {
            p: 1e-5,
            h: 1e-5,
            fb: 1e-5,
        }
    }
}

impl Default for Grid {
    fn default() -> Self {
        Grid {
            compute_dt: F64,
            storage_dt: F64,
        }
    }
}
