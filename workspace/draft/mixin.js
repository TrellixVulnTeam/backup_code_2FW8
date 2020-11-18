let myMixin = {
    sayHello() {
        console.log("hello!")
    }
}

class Person {
    
}

Object.assign(Person.prototype, myMixin)

const p1 = new Person()
p1.sayHello()