/*global cordova, module*/

module.exports = {

    alert("before...");
    greet: function (name, successCallback, errorCallback) {
            alert("greet...");

        cordova.exec(successCallback, errorCallback, "Hello", "greet", [name]);
    }
};
