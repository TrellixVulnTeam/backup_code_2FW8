import _ from 'lodash';

function hello() {
    document.write("hello!")
    throw new Error()
}

console.log(
    _.join(['Another', 'module', 'loaded!'], ' ')
);

hello()