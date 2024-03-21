
pub type State(a, s) = fn(s) -> #(a, s)

pub fn step(s1: State(a, s), f: fn(a) -> State(b, s)) -> State(b, s) {
  fn(s) {
    let #(a, s) = s1(s)
    f(a)(s)
  }
}

pub fn gets(lookup: fn(s) -> a, n: fn(a) -> State(b, s)) -> State(b, s) {
  step(fn(s) {
    #(lookup(s), s)
  }, n)
}

pub fn get(n: fn(s) -> State(b, s)) -> State(b, s) {
  step(fn(s) {
    #(s, s)
  }, n)
}

pub fn set(upd: s, n: fn(Nil) -> State(b, s)) -> State(b, s) {
  step(fn(_s) {
    #(Nil, upd)
  }, n)
}

pub fn return(a: a) -> State(a, s) {
  fn(s){ #(a, s) }
}

pub fn modify(f: fn(s) -> s) -> State(Nil, s) {
  fn(s) {
    #(Nil, f(s))
  }
}

pub fn run_state(s: State(a, s), init: s) -> #(a, s) {
  s(init)
}

pub fn eval_state(s: State(a, s), init: s) -> a {
  s(init).0
}

pub fn exec_state(s: State(a, s), init: s) -> s {
  s(init).1
}
