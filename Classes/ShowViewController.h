//
//  ShowViewController.h
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/04/05.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShowViewController : UIViewController {
	IBOutlet UILabel* nameLabel;
	IBOutlet UILabel* textLabel;
	IBOutlet UIImageView* profileImageView;
	NSString* name;
	NSString* text;
	UIImage* image;
	NSInteger statusId;
}

- (id)initWithName:(NSString*)name Text:(NSString*)text ProfileImage:(UIImage*)image StatusId:(NSInteger)statusId; 

@end
