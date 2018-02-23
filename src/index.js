"use strict";

require("bootstrap");
require("bootstrap/dist/css/bootstrap.css");
const Main = require("./Main.purs");

Main.main();

if (module.hot) {
  module.hot.accept();
}
