//
//  ApplicationHelper.h
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/03/29.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ApplicationHelper : NSObject {

}

+ (NSString *)getEscapedString:(NSString *)string;
+ (void)alertMessage:(NSString *)title message:(NSString *)message;
+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
+ (NSMutableURLRequest *)setRequestHeader:(NSString *)url;


@end
