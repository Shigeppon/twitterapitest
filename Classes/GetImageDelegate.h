//
//  getImageDelegate.h
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/03/31.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GetImageDelegate : NSObject {
	NSMutableData* _data;
	UITableViewCell* cell;
}

@property (retain) UITableViewCell* cell;

@end
