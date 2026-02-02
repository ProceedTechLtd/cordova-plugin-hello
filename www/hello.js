/*global cordova, module*/

var Hello = function () {};

Hello.prototype.greet = function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "Hello", "greet", [name]);
}
 
module.exports = new Hello();
