//
//  updateViewController.m
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/03/29.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "updateViewController.h"
#import "ApplicationHelper.h"

@implementation updateViewController

@synthesize message;

- (id)init
{
	if(self = [super init]) self.title = @"update";
	return self;
}

- (IBAction)updateMessage
{
	NSLog(@"updateMessage %@",message.text);
	
	NSString* format = @"json";
	
	NSString* url = [ApplicationHelper getEscapedString:
					 [NSString stringWithFormat:@"http://twitter.com/statuses/update.%@",format]];
	
	NSMutableURLRequest* req = [ApplicationHelper setRequestHeader:url];
	
	NSString *myRequestString = [NSString stringWithFormat:@"&status=%@",message.text];
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
	
}

/*
- (void)loadView
{
	contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	contentView.backgroundColor = [UIColor orangeColor];
	self.view = contentView;
	
	UIView* myView = [[UIView alloc] initWithNibName:bundle:<#(NSBundle *)nibBundleOrNil#>
	
	UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(0.0f,0.0f, 100.0f, 30.0f)];
	[self.view addSubview:textView];
	[textView release];
	
	UIButton* submit = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 40.0f, 30.0f, 30.0f)];
	[submit setTitle:@"test" forState:UIControlStateNormal];
	[self.view addSubview:submit];
	[submit release];
	[contentView release];
}
 */
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	[contentView release];
    [super dealloc];
}


@end
