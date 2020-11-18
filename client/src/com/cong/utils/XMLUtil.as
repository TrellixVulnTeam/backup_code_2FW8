package com.cong.utils
{
	/**
	 * ...
	 * @author Fred
	 */
	public class XMLUtil 
	{
		public static function xmlToJsonNoRoot(xml:XmlDom):Object {		
			var len:uint = xml.childNodes.length;
			xml = xml.childNodes[len > 1 ? (len - 1):0];
			return xmlToJson(xml);
		}
		public static function xmlToJson(xml:XmlDom):Object {			 
			// Create the return object
			var obj:Object = {};
		 
			if (xml.nodeType == 1) { // element
				// do attributes
				if (xml.attributes.length > 0) {
					for (var j:int = 0; j < xml.attributes.length; j++) {
							var attribute:* = xml.attributes.item(j);
							obj[attribute.nodeName] = clean(attribute.nodeValue);
						}
				}
			} 
			else if (xml.nodeType == 3) { // text
				obj = clean(xml.nodeValue);
			}
		 
			// do children
			if (xml.hasChildNodes()) {
				for(var i:int = 0; i < xml.childNodes.length; i++) {
					var item:XmlDom = xml.childNodes.item(i);
					var nodeName:* = item.nodeName;
					if(item.nodeType == 1 || item.nodeType == 9){
						if (typeof(obj[nodeName]) == "undefined") {
							obj[nodeName] = [];
							obj[nodeName].push(xmlToJson(item));
						} else {
							if (typeof(obj[nodeName].length) == "undefined") {
								var old:* = clean(obj[nodeName]);
								obj[nodeName] = [];
								obj[nodeName].push(old);
							}
							obj[nodeName].push(xmlToJson(item));
						}
					}
				}
			}
			//trace(obj);
			return obj;
		}
		/**
		 * Parses an XmlDom object into identically-named native ActionScript Objects/Arrays. All XmlDom nodes are turned into 
		 * Arrays (each collection of identically-named nodes becomes and Array) and each Array is populated with an Object 
		 * with property names that match the XmlDom attribute names.
		 * 
		 * @param xml An XmlDom object to parse into Objects/Arrays
		 * @param keepRootNode Controls whether or not the root node of the XmlDom is ignored when parsing (doing so can make your code a bit shorter).
		 * @param parseLineBreaks If true, line breaks in XmlDom will be recognized ("\n" added in the ActionScript).
		 * @return Parsed object
		 */
		/*public static function XMLToObject(xml:XmlDom, keepRootNode:Boolean=false, parseLineBreaks:Boolean=false):Object { 
			var obj:Object = {};
			var objLookup:Array = []; //A way to keep track of each node's parent object. Tried using a Dictionary at first (which would have been easier/faster), but there was a bug that prevented it from looking XmlDom object up conistently!
			var c:XmlDom = xml.cloneNode(true);
			var lastNode:XmlDom = c;
			
			if (!keepRootNode) {
				lastNode = c.childNodes[c.childNodes.length() - 1];
				c = c.childNodes[0];
			}
			
			var o:Object, attributes:Object, attr:XmlDom, nextNode:XmlDom, po:Object, name:String, splitName:Array; //parent object
			while (c != null) {
				if (c.nodeKind() == "element") {
					
					o = {};
					if (c.text().toString() != "") {
						o.nodeValue = clean(c.text().toString(), parseLineBreaks);
					}
					attributes = c.attributes;
					for each (attr in attributes) {
						o[attr.name().toString()] = clean(attr, parseLineBreaks);
					}
					if (c.parent() == undefined) { //If it's the root node, it won't have a parent!
						po = obj;
					} else {
						po = objLookup[c.parent().@_objLookupIndex] || obj;
					}
					name = c.name().toString().split(":").pop(); //otherwise there were problems when an XmlDom document declared a namespace. 
					if (po[name] == undefined) {
						po[name] = [];
					}
					po[name].push(o);
					c.@_objLookupIndex = objLookup.length;
					objLookup.push(o);
				}
				
				if (c.childNodes.length() != 0) {
					c = c.childNodes[0];
				} else {
					nextNode = c;
					while (nextNode.parent() != undefined && nextNode.parent().childNodes.length() < nextNode.childIndex() + 2) {
						nextNode = nextNode.parent();
					}
					if (nextNode.parent() != undefined && nextNode != lastNode) {
						c = nextNode.parent().childNodes[nextNode.childIndex() + 1];
					} else {
						c = null;
					}
				}
			}
			return obj;
		}*/
		private static var _findLetters:RegExp = new RegExp("([a-zA-Z])", "");
		private static function clean(s:String, parseLineBreaks:Boolean=false):Object {
			if (!isNaN(Number(s)) && s != "" && s.charAt(0) != "0" && s.search(_findLetters) == -1) {
				return Number(s);
			} else if (s == "true") {
				return true;
			} else if (s == "false") {
				return false;
			} else if (parseLineBreaks) {
				return s.split("\\n").join("\n");
			} else {
				return s;
			}
		}
		
	}

}