module main

import os

// 使用C语言宏,包含头文件
#include <stdio.h>

fn C.getpid() int

fn main() {
    cwd := os.getwd()
    println('cwd: ${cwd}')
    pid := C.getpid()
    println(pid)
}
