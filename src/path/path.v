module path

pub fn join(path string, other string) string {
    return "${path}/${other}"
}