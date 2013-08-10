//
//  social.js
//
//  Ivan Baktsheev, 2013, plugin.xml, merging android and ios
//  --------------------
//  Cameron Lerch, 2013, original ios plugin
//  Sponsored by Brightflock: http://brightflock.com
//

function Social() {
};

Social.prototype.available = function(callback) {
	cordova.exec(function(avail) {
		callback(avail ? true : false);
	}, null, "Social", "available", []);
};

Social.prototype.share = function(message, url, image) {
    cordova.exec(null, null, "Social", "share", [message, image, url]);
};
    
Social.install = function() {
    if (!window.plugins) {
        window.plugins = {};	
    }

    window.plugins.social = new Social();
    return window.plugins.social;
};

cordova.addConstructor(Social.install);
