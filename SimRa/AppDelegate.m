//
//  AppDelegate.m
//  simra
//
//  Created by Christoph Krey on 27.03.19.
//  Copyright © 2019-2021 Mobile Cloud Computing an der Fakultät IV (Elektrotechnik und Informatik) der TU Berlin. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

+ (AppDelegate*)sharedDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.defaults = [NSUserDefaults standardUserDefaults];
    self.regions = [[Regions alloc] init];
    self.news = [[News alloc] init];
    self.lm = [[CLLocationManager alloc] init];
    [self.lm requestWhenInUseAuthorization];
    self.mm = [[CMMotionManager alloc] init];
    self.trips = [[Trips alloc] init];
    [self.trips save];

    NSURL *constantsURL = [[NSBundle mainBundle] URLForResource:@"constants" withExtension:@"plist"];
    self.constants = [NSDictionary dictionaryWithContentsOfURL:constantsURL];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self.lm requestWhenInUseAuthorization];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)openURL:(NSDictionary<NSString*, NSString*> *)dict {
    NSString* lang = [[NSBundle preferredLocalizationsFromArray:[dict allKeys]] firstObject];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: dict[lang]]
                                       options:@{}
                             completionHandler:nil];
}

- (void)showHowTo {
    [self openURL:@{
        @"en" : @"http://www.mcc.tu-berlin.de/fileadmin/fg344/simra/SimRa_Instructions_IOS.pdf",
        @"de" : @"http://www.mcc.tu-berlin.de/fileadmin/fg344/simra/SimRa_Anleitung_IOS.pdf"
    }];
}

@end
