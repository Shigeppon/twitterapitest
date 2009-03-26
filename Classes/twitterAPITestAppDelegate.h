//
//  twitterAPITestAppDelegate.h
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/03/26.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class twitterAPITestViewController;

@interface twitterAPITestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    twitterAPITestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet twitterAPITestViewController *viewController;

@end

