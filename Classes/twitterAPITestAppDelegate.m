//
//  twitterAPITestAppDelegate.m
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/03/26.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "twitterAPITestAppDelegate.h"
#import "twitterAPITestViewController.h"

@implementation twitterAPITestAppDelegate


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch
	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	UINavigationController *nav = [[UINavigationController alloc] 
								   initWithRootViewController:[[twitterAPITestViewController alloc] init]];
	
    [window addSubview:nav.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [super dealloc];
}


@end
