//
//  ShowViewController.m
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/04/05.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ShowViewController.h"
#import "ApplicationHelper.h"


@implementation ShowViewController

- (id)initWithName:(NSString*)aName Text:(NSString*)aText ProfileImage:(UIImage*)aImage StatusId:(NSInteger)aId
{
	if(self = [super init])
	{
		name = aName;
		text = aText;
		image = aImage;
		statusId = aId;
	}
	return self;
}
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[nameLabel setText:name];
	[textLabel setText:text];
	
	CGSize newSize = CGSizeMake(100.0f,100.0f);
	UIGraphicsBeginImageContext(newSize);
	[image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	[profileImageView setImage:newImage];
	
	UIBarButtonItem *button = [[[UIBarButtonItem alloc]
							   initWithTitle:@"Delete" 
							   style:UIBarButtonItemStylePlain 
							   target:self 
								action:@selector(destroy)] autorelease];
	self.navigationItem.rightBarButtonItem = button;
}

- (void)destroy
{
	
	NSString* url = [ApplicationHelper getEscapedString:
					 [NSString stringWithFormat:@"http://twitter.com/statuses/destroy/%d.json",statusId]];
	
	
	NSMutableURLRequest* req = [ApplicationHelper setRequestHeader:url];
	
	NSString *myRequestString = [NSString stringWithFormat:@"&status=%@",@""];
	NSData *myRequestData = [NSData dataWithBytes:[myRequestString UTF8String] length:[myRequestString length]];
	[req setHTTPMethod:@"POST"];
	[req setHTTPBody:myRequestData];
	
	NSURLResponse* response;
	NSError* error;
	NSData* data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
	
	//NSLog([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
	
	// 検索処理
	NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
	NSLog(jsonData);
	
	[ApplicationHelper alertMessage:@"Message Send" message:@"Success"];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
