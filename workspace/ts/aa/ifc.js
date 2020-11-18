function greeter(person) {
    return "Hello, " + person.firstName + " " + person.lastName;
}
console.log(greeter({
    firstName: "linda",
    lastName: "karp"
}));
