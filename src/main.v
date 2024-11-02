module main

import os
import vjs

fn main() {
    cwd := os.getwd()
    println('cwd: ${cwd}')
    vjs.self_log('cwd: ${cwd}')
}
