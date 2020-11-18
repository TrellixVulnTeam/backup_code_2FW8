"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = Flag;

var _react = require("react");

var _react2 = _interopRequireDefault(_react);

require("./index.scss");

var _flag = require("./flag.jpg");

var _flag2 = _interopRequireDefault(_flag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function Flag() {
  return _react2.default.createElement(
    "div",
    { className: "box" },
    _react2.default.createElement("img", { src: _flag2.default })
  );
}