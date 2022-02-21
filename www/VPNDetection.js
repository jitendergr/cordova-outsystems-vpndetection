var exec = require('cordova/exec');

exports.detectVPN = function (success, error) {
    exec(success, error, 'VPNDetectionPlugin', 'detectVPN', []);
};
