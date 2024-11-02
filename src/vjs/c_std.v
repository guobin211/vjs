module vjs

// 使用C语言宏,包含头文件
#include <stdio.h>

fn C.getpid() int

fn main() {
    pid := C.getpid()
	println(pid)
}
