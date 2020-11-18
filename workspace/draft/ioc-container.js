const container = (function() {
    let binds = new Map()
    /**
     * @param {Class} abstract 需要DI的类
     * @param {Function} callback DI回调
     */
    function bind(abstract, callback) {
        binds.set(abstract, callback)
    }

    /**
     * @param {Class} abstract 需要DI的类 
     * @param {options} callback 创建该类的参数
     */
    function make(abstract, options = []) {
        if (!binds.has(abstract)) {
            return null
        }
        console.log(options)
        return binds.get(abstract)(...options)
    }

    return {
        bind,
        make
    }
}())

class Car {
    constructor() {
        this.name = "tesla!"
    }
}

class BomaCar {
    constructor() {
        this.name = "boma!"
    }
}

class AweCar {
    constructor() {
        this.name = "awe!"
    }
}

class Person {
    constructor(car) {
        this._car = car
    }

    get car() {
        return "my car name is " + this._car.name
    }
}

container.bind(Car, function() {
    return new Car()
})

container.bind(AweCar, function() {
    return new AweCar()
})

container.bind(BomaCar, function() {
    return new BomaCar()
})

container.bind(Person, function(carName) {
    return new Person(container.make(carName))
})

const p1 = container.make(Person, [AweCar])
console.log(p1.car)