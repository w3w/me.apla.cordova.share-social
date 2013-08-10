//
//  Social.m
//
//  Ivan Baktsheev, 2013, plugin.xml, merging android and ios
//  --------------------
//  Cameron Lerch, 2013, original ios plugin
//  Sponsored by Brightflock: http://brightflock.com
//

#import "ShareSocial.h"

@interface ShareSocial ()

@end

@implementation ShareSocial

- (void)available:(CDVInvokedUrlCommand*)command {
    BOOL avail = false;
    
    if (NSClassFromString(@"UIActivityViewController")) {
        avail = true;
    }
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:avail];
    [self writeJavascript:[pluginResult toSuccessCallbackString:[command callbackId]]];
}

- (void)share:(CDVInvokedUrlCommand*)command {
    
    if (!NSClassFromString(@"UIActivityViewController")) {
        return;
    }
    
    CDVPluginResult *result;
    
    NSString *text = [command.arguments objectAtIndex:0];
    if (!text) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Text cannot be empty"];
        [self.commandDelegate sendPluginResult:result callbackId:[command callbackId]];
        return;
    }
    
    NSString *imageName = [command.arguments objectAtIndex:1];
    UIImage *image = nil;
    
    // can be NSNull or empty string
    if (imageName && [imageName isKindOfClass:[NSString class]] && [imageName length] > 0) {
        image = [UIImage imageNamed:imageName];
    }
    
    NSString *urlString = [command.arguments objectAtIndex:2];
    NSURL *url = nil;
    
    if (urlString && [urlString isKindOfClass:[NSString class]] && [urlString length] > 0) {
        url = [NSURL URLWithString:urlString];
    } else {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"URL cannot be empty"];
        [self.commandDelegate sendPluginResult:result callbackId:[command callbackId]];
        return;
    }
    
    NSArray *activityItems = [[NSArray alloc] initWithObjects:text, image, url, nil];
    
    UIActivity *activity = [[UIActivity alloc] init];
    
    NSArray *applicationActivities = [[NSArray alloc] initWithObjects:activity, nil];
    UIActivityViewController *activityVC =
    [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                      applicationActivities:applicationActivities];
    [self.viewController presentViewController:activityVC animated:YES completion:nil];
    // TODO: add controller delegation. purpose: prevent two sharing dialogs
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:[command callbackId]];
}

@end
