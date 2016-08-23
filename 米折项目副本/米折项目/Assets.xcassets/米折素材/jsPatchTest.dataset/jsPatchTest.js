//JS
defineClass('MIProductViewController', {
            goShop: function() {
            if (self.model().martOverseaShowId()) {
            var dict = require('NSMutableDictionary').alloc().initWithCapacity(3);
            dict.setValue_forKey('oversea_martshow', 'target');
            dict.setValue_forKey(self.model().martOverseaShowId(), 'eId');
            require('MINavigator').instance().pushViewControllerByDict_animated(dict, true);
            } else {
                self.ORIGgoShop();
            } 
    },
});
