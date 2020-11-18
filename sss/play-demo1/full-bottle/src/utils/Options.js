export default {
 width: 800,
 height: 600,
 load(options) {
   for (let key in options) {
     this[key] = options[key]
   }
 } 
}