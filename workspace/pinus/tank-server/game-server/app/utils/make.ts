export function make500Error(msg:string = "") {
    return {
        code: 500,
        msg: msg,
    }; 
}