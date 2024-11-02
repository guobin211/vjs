module main

import os
import net.http
import x.json2
import json
import time

struct Post {
	id      u32
	title   string
	body    string
	user_id u32 @[json: userId]
}

fn fetch_any_data() !map[string]json2.Any {
	resp := http.get('http://jsonplaceholder.typicode.com/posts/1')!
	any_data := json2.raw_decode(resp.body)!
	data := any_data as map[string]json2.Any
	return data
}

fn fetch_option_data() ?Post {
	resp := http.get('http://jsonplaceholder.typicode.com/posts/1') or { return none }
	post := json2.decode[Post](resp.body) or { return none }
	return post
}

fn fetch_typed_data() !Post {
	resp := http.get('http://jsonplaceholder.typicode.com/posts/1')!
	post := json.decode(Post, resp.body)!
	return post
}

fn safe_fetch_any_data() {
	fetch_any_data() or { panic('Failed to fetch_any_data') }
}

fn safe_fetch_typed_data() {
	fetch_typed_data() or { panic('Failed fetch_typed_data') }
}

fn safe_fetch_option_data() {
	fetch_option_data()
}

fn main() {
	cwd := os.getwd()
	println('cwd: ${cwd}')

	start := time.now().unix_milli()
	post1 := fetch_any_data() or { panic('Failed to fetch_any_data') }
	post2 := fetch_typed_data() or { panic('Failed fetch_typed_data') }
	post3 := fetch_option_data()
	end := time.now().unix_milli()
	println('Time taken: ${end - start}')

	assert post1['id']!.int() == 1
	assert post2.id == 1
	assert post3?.id == 1

	mut threads := []thread{}
	start1 := time.now().unix_milli()
	threads << spawn safe_fetch_any_data()
	threads << spawn safe_fetch_typed_data()
	threads << spawn safe_fetch_option_data()
	threads.wait()
	end1 := time.now().unix_milli()
	println('Time taken: ${end1 - start1}')
}
