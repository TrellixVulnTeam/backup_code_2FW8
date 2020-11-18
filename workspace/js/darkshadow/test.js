let func = runcode(`
  console.log(a);
`, {
  a: 123
})

console.log(func);
func()