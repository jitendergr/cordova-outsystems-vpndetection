/********* VPNDetectionPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface VPNDetectionPlugin : CDVPlugin {
  // Member variables go here.
}

- (void)detectVPN:(CDVInvokedUrlCommand*)command;
@end

@implementation VPNDetectionPlugin

- (void)detectVPN:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:[self checkForVPNConnectivity]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (BOOL)checkForVPNConnectivity
{
    NSDictionary *dict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
    NSDictionary *keys = dict[@"__SCOPED__"];
    NSArray *vpns = @[@"tap",@"tun",@"ppp",@"ipsec",@"utun"];
    
    for (NSString* key in keys.allKeys){
      for(NSString* vpn in vpns){
        if([key containsString:vpn]){
          return true;
        }
      }
       /* if ([key isEqualToString: @"tap"] || [key isEqualToString:@"tun"] || [key isEqualToString: @"ppp"] || [key isEqualToString: @"ipsec"] || [key isEqualToString: @"ipsec0"] || [key isEqualToString: @"utun1"] || [key isEqualToString: @"utun2"] || [key isEqualToString:  @"utun3"]) {
            return true;
          }*/
    }
    return false;
}

@end
