module main

import crypto.rand

enum Gender {
	man
	women
	unkonwn
}

struct Person {
	id string
mut:
	married bool
pub:
	name   string
	gender Gender
pub mut:
	age u16
}

fn (mut p Person) change_married(merried bool) {
	p.married = merried
}

fn main() {
	eprintln('some error')

	name := 'jack'

	if isnil(&name) {
		println('name is nil')
	} else {
		println('name is ${name}')
	}

	id := rand.bytes(16) or { panic('failed to generate random bytes') }
	mut jack := Person{
		id:      id.hex()
		married: false
		name:    'jack'
		gender:  Gender.man
		age:     18
	}

	println(jack)
	jack.change_married(true)
	println(jack)

	mut users := []Person{}
	users << jack
	println(users)

	mut user_map := map[string]Person{}
	user_map['jack'] = jack
	println(user_map)
	// bug: cannot use mut for params
	changed_users := users.map(fn (u Person) Person {
		return Person{
			id:      u.id
			married: u.married
			name:    u.name
			gender:  u.gender
			age:     u.age + 1
		}
	})
	println(changed_users)

	for mut user in users {
		if user.name == 'jack' {
			user.age += 1
		}
	}
	println(users)
	some_user := user_map['jack']
	println(some_user)
}
