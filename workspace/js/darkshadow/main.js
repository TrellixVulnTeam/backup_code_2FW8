/**
 * function() {
 *  //提供环境
 *  result = []
 *  
 *  
 *  return result
 * }
 */


/**
 * 
 * @param {String} code 
 * @param {Object} context 
 */
function runcode(code, context) {

  let contextCode = []
  for (let key in context) {
    contextCode.push(`${key} = ${context[key]};`)
  }

  let withOuterCode = `
  (function() {
    ${contextCode.join("")}
    ${code}
  }());
  `

  return new Function(withOuterCode);
}

//模板
class Template {
  constructor(tempStr, ...context) {
    
  }

  addLine() {
    
  }
}

//代码生成器

