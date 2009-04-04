//
//  TimeLineViewCell.h
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/04/05.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TimeLineViewCell : UITableViewCell {
	IBOutlet UILabel* nameLabel;
	IBOutlet UILabel* textLabel;
	IBOutlet UIImageView* imageView;
}

@property (nonatomic,retain) UILabel* nameLabel;
@property (nonatomic,retain) UILabel* textLabel;
@property (nonatomic,retain) UIImageView* imageView;

@end
