module main

import os

fn main() {
	cwd := os.getwd()
	println('Current working directory: ${cwd}')

	files := os.ls(cwd) or { panic('Failed to list files in ${cwd}') }

	println('Files in current directory: ${files}')

	for file in files {
		println('Read File: ${file}')
		if os.is_dir(file) {
			println('Skipping directory ${file}')
			continue
		}
		content := os.read_file(file) or { panic('Failed to read file ${file}') }
		println('Content: ${content}')
	}

	mut ts_files := []string{}

	ts_files << 'a.ts'

	println('${ts_files}')
}
