//自定义模板解析语法

function templateEngine(html, data) {
    //匹配语法单位
    let re = /<%([^%>]+)?%>/g
    //匹配关键字单位
    let regExp = /(^( )?(if|for|else|switch|case|break|{|}))(.*)?/g
    code = 'var r=[];\n'
    cursor = 0

    let add = function(line, js) {
        //js flag标志当前解析的字符串是否为js代码段
        //line.match(reExp)寻找可以解析的
        //第一行的r.push是针对非语法结构的js代码解析
        js ? (code += line.match(regExp) ? line + '\n' : 'r.push(' + line + ');\n') :
            (code += line != '' ? 'r.push("' + line.replace(/"/g, '\\"') + '");\n' : '');
        return add;
    }

    let match
    while (match = re.exec(html)) {

        //match[1]代第一个捕获组
        add(html.slice(cursor, match.index))(match[1], true)
        cursor = match.index + match[0].length
    }

    add(html.substr(cursor, html.length - cursor));
    code += 'return r.join("");';

    //直接执行这个用构造函数实例化的函数
    return new Function(code.replace(/[\r\t\n]/g, '')).apply(data);
}

function parseTpl(tmpId, data) {
    var tplStr = document.querySelector(tmpId)
    let result = templateEngine(tplStr.innerHTML.trim(), data)
    console.log(result)
}

function _parseToDom(str) { // 将字符串转为dom
    var div = document.createElement('div');
    if(typeof str == 'string') {
        div.innerHTML = str;
    }
    return div.childNodes;
}