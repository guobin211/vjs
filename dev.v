module main

import os
import arrays

fn get_all_files(dir string) []string {
	mut res := []string{}
	files := os.ls(dir) or { panic('failed to list files at directory: ${dir}') }
	for file in files {
		file_uri := '${dir}/${file}'
		res << file_uri
		if os.is_dir(file_uri) {
			sub := get_all_files(file_uri)
			res = arrays.concat(res, ...sub)
		}
	}
	return res
}

fn sync_ts_to_v() {
	cwd := os.getwd()
	parent_dir := os.dir(cwd)
	mut target_dir := '${cwd}/src'
	mut source_src := '${parent_dir}/jsscript/src'
	files := get_all_files(source_src)
	target_files := files.map(fn (file string) string {
		return file.split('/src')[1].replace('.ts', '.v')
	})
	mut last_files := []string{}
	for file in target_files {
		v_file := '${target_dir}/${file}'
		if os.exists(v_file) {
			debug := os.getenv('DEBUG')
			if debug == 'true' {
				eprintln('file already exists: ${v_file}')
			}
		} else {
			if v_file.ends_with('.v') {
				os.create(v_file) or { last_files << v_file }
			} else {
				os.mkdir(v_file) or { panic('failed to mkdir: ${v_file}') }
			}
		}
	}

	if last_files.len > 0 {
		for file in last_files {
			os.create(file) or { panic('failed to create file: ${file}') }
		}
	}
}

fn main() {
	args := os.args
	if args.contains('--sync') {
		sync_ts_to_v()
	} else {
		println('use --sync to sync ts to v')
		sync_ts_to_v()
	}
}
