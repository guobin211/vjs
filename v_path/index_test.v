import os
import v_path

fn test_join() {
    cwd := os.getwd()
    parent := v_path.join(cwd, "..")
    assert parent.len > cwd.len
}
