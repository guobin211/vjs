module main_test

import os

fn test_add() {
	mut a := 'a'
	a += 'b'
	assert a == ('ab')
	a = 'a'
	for i := 1; i < 1000; i++ {
		a += 'b'
	}
	assert a.len == 1000
	assert a.ends_with('bbbbb')
	a += '123'
	assert a.ends_with('3')
}

pub fn find_tsx_files(dir string) []string {
	mut ts_files := []string{}
	files := os.ls(dir) or {
		eprint('Failed to list files in ${dir}')
		return []
	}
	if files.len == 0 {
		eprint('No files found in ${dir}')
		return []
	}
	for file in files {
		if os.is_dir(file) {
			ts_files << find_tsx_files(file)
		} else if file.ends_with('.tsx') {
			ts_files << file
		}
	}
	return []
}

fn test_find_tsx_files() {
	mut ts_files := find_tsx_files('/path/to/directory')
	assert ts_files == ['file1.tsx', 'file2.tsx', 'file3.tsx']
}

fn test_find_tsx_files_empty_dir() {
	mut ts_files := find_tsx_files('/path/to/empty_directory')
	assert ts_files == []
}

fn test_find_tsx_files_nested_dirs() {
	mut ts_files := find_tsx_files('/path/to/nested_directory')
	assert ts_files == ['file1.tsx', 'file2.tsx', 'file3.tsx', 'nested/file4.tsx']
}

fn test_find_tsx_files_no_tsx_files() {
	mut ts_files := find_tsx_files('/path/to/no_tsx_files')
	assert ts_files == []
}
