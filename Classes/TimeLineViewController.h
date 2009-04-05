//
//  TimeLineViewController.h
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/04/05.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TimeLineViewController : UITableViewController {
	NSMutableArray* response;
	NSString* apiUrl;
}

- (id)initWithApiUrl:(NSString*)aUrl;

@end
