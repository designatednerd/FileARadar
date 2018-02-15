//
//  APBAppDelegate.m
//  AppearanceProxyBugProof
//
//  Created by Ellen Shapiro on 11/21/13.
//  Copyright (c) 2013 VOKAL. All rights reserved.
//

#import "APBAppDelegate.h"
#import "APBCustomNavController.h"

@import MessageUI;

@implementation APBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSDictionary *environment = [[NSProcessInfo processInfo] environment];
    
    NSString *customKey = @"CUSTOM_NAV";
    UIViewController *root;
    if ([environment[customKey] boolValue]) {
        [self styleAppWithCustomNav];
        UIStoryboard *custom = [UIStoryboard storyboardWithName:@"Main-custom" bundle:nil];
        root = [custom instantiateInitialViewController];
    } else {
        [self styleApp];
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        root = [main instantiateInitialViewController];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = root;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)styleAppWithCustomNav
{    
    [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[APBCustomNavController class]]] setTitleTextAttributes:[self fontAttributes]];
    
    [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[APBCustomNavController class]]] setBarStyle:[self barStyle]];
    
    [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[APBCustomNavController class]]] setBarTintColor:[self barTintColor]];
    [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[APBCustomNavController class]]] setTintColor:[self tintColor]];
}

- (void)styleApp
{
    // Set a custom style for navigation bars
    [[UINavigationBar appearance] setTitleTextAttributes:[self fontAttributes]];
    [[UINavigationBar appearance] setBarStyle:[self barStyle]];
    [[UINavigationBar appearance] setBarTintColor:[self barTintColor]];
    [[UINavigationBar appearance] setTintColor:[self tintColor]];
    
    //Attempt to undo that style for Message/Mail Compose View Controller
    NSArray *mailAndMessage = @[
                                [MFMailComposeViewController class],
                                [MFMessageComposeViewController class],
                                ];
    
                                
                                
    [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:mailAndMessage] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:mailAndMessage] setTintColor:nil];
    [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:mailAndMessage] setTitleTextAttributes:nil];
}

- (NSDictionary *)fontAttributes
{
    return @{
             NSFontAttributeName: [UIFont fontWithName:@"MarkerFelt-Wide" size:20.0f],
             NSForegroundColorAttributeName: [UIColor whiteColor]
             };
}

- (UIBarStyle)barStyle
{
    return UIBarStyleBlack;
}

- (UIColor *)barTintColor
{
    return [UIColor colorWithRed:226.0/255.0
                           green:83.0/255.0
                            blue:82.0/255.0
                           alpha:1];
}

- (UIColor *)tintColor
{
    return [UIColor whiteColor];
}

@end
