//
//  twitterAPITestViewController.h
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/03/26.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Base64EncDec.h"

@interface twitterAPITestViewController : UITableViewController {
	NSMutableArray *apiList;
}

@property (nonatomic,retain) NSMutableArray *apiList;


- (IBAction)publicTimeline;

@end

