//
//  twitterAPITestViewController.m
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/03/26.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "twitterAPITestViewController.h"
#import "JSON/JSON.h"

@implementation twitterAPITestViewController

- (NSString *)getEscapedString:(NSString *)string
{
	CFStringRef tmp = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
																			  kCFAllocatorDefault,
																			  (CFStringRef)string,
																			  CFSTR(""),
																			  kCFStringEncodingUTF8);
	
	// 通常文字列 → %エスケープ (decode)
	CFStringRef escapedStr = CFURLCreateStringByAddingPercentEscapes(
																	 kCFAllocatorDefault,
																	 tmp,
																	 nil,
																	 nil,
																	 kCFStringEncodingUTF8);
	return (NSString *)escapedStr;
}

- (IBAction)publicTimeline
{
	NSLog(@"public_timeline");
	
	NSString* format = @"json";
	
	NSString* url = [self getEscapedString:
					 [NSString stringWithFormat:@"http://twitter.com/statuses/public_timeline.%@",format]];
	
	NSLog(url);
	// 検索処理
	NSString *jsonData = [[NSString alloc]  
						  initWithContentsOfURL:[NSURL URLWithString:url]  
						  encoding:NSUTF8StringEncoding error:nil];  
	
	if (jsonData == nil)
	{
		NSLog(@"error");
		return;
	} else {  
		NSDictionary* jsonItem = [jsonData JSONValue]; 
	}
	
	[jsonData release];
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
    [super dealloc];
}

@end
