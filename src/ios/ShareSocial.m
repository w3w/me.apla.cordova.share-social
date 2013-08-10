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
    [self writeJavascript:[pluginResult toSuccessCallbackString:[command callbackId]]]];
}

- (void)share:(CDVInvokedUrlCommand*)command {
    
    if (!NSClassFromString(@"UIActivityViewController")) {
        return;
    }
    
    NSString *text = [command.arguments objectAtIndex:1];
    
    NSString *imageName = [command.arguments objectAtIndex:2];
    UIImage *image = nil;
    
    if (imageName) {
        image = [UIImage imageNamed:imageName];
    }
    
    NSString *urlString = [command.arguments objectAtIndex:3];
    NSURL *url = nil;
    
    if (urlString) {
        url = [NSURL URLWithString:urlString];
    }
    
    NSArray *activityItems = [[NSArray alloc] initWithObjects:text, image, url, nil];
    
    UIActivity *activity = [[UIActivity alloc] init];
    
    NSArray *applicationActivities = [[NSArray alloc] initWithObjects:activity, nil];
    UIActivityViewController *activityVC =
    [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                      applicationActivities:applicationActivities];
    [self.viewController presentViewController:activityVC animated:YES completion:nil];
    // TODO: add controller delegation. purpose: prevent two sharing dialogs
    [self.commandDelegate sendPluginResult:pluginResult callbackId:[command callbackId]];
}

@end
