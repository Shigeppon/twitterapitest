//
//  updateViewController.h
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/03/29.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface updateViewController : UIViewController {
	UIImageView* contentView;
	IBOutlet UITextField* message;
}

- (IBAction)updateMessage;

@property (nonatomic,retain) IBOutlet UITextField* message;

@end
