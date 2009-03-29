//
//  twitterAPITestViewController.m
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/03/26.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "twitterAPITestViewController.h"
#import "publicTimelineViewController.h"
#import "updateViewController.h"
#import "JSON/JSON.h"

@implementation twitterAPITestViewController

@synthesize apiList;

//#define API_ARRAY [NSArray arrayWithObjects:@"public_timelines",nil]

- (twitterAPITestViewController *) init
{
	if(self = [super init]) self.title = @"Twitter API's";
	return self;
}
 
- (void) viewDidLoad
{
	[super viewDidLoad];
	apiList = [NSMutableArray arrayWithObjects:
			   @"public_timeline",
			   @"friends_timeline",
			   @"user_timeline",
			   @"show", 
			   @"update", 
			   @"replies", 
			   @"destroy",
			   @"hoge",
			   @"fuga",
			   nil];
	[apiList retain];
}

#pragma mark UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//return 1;
	//[UIApplication sharedApplication]
	return [apiList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"any-cell"];
	if(cell == nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"any-cell"] autorelease];
	}
	//cell.text = @"test";
	cell.text = [apiList objectAtIndex:[indexPath row]];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"selected row = %d selected api = %@",[indexPath row],[apiList objectAtIndex:[indexPath row]]);
	NSString *apiName = [apiList objectAtIndex:[indexPath row]];
	if([self respondsToSelector:NSSelectorFromString(apiName)]){
		[self performSelector:NSSelectorFromString(apiName)];
	}else{
		NSLog(@"api %@ is not recognize",apiName);
	}
}



- (void)update
{
	[[self navigationController] pushViewController:[[updateViewController alloc] init] animated:YES];
}


- (void)friends_timeline
{
	NSString* format = @"json";
	
	NSString* url = [ApplicationHelper getEscapedString:
					 [NSString stringWithFormat:@"http://twitter.com/statuses/friends_timeline.%@",format]];
	
	NSMutableURLRequest* req = [ApplicationHelper setRequestHeader:url];
	
	NSURLResponse* response;
	NSError* error;
	NSData* data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
	
	//NSLog([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
	
	// 検索処理
	NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
	NSLog(jsonData);
}

- (void)public_timeline
{
	NSLog(@"public_timeline");
	[[self navigationController] pushViewController:[[publicTimelineViewController alloc] init] animated:YES];
	
	/*
	NSString* format = @"json";
	
	NSString* url = [ApplicationHelper getEscapedString:
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
		id jsonItem = [jsonData JSONValue];
		
		if([jsonItem isKindOfClass:[NSArray class]])
		{
			NSLog(@"NSArray");
			NSLog(@"count=%d",[jsonItem count]);
			for(NSDictionary* data in jsonItem){
				id user = [data objectForKey:@"user"];
				id description = [user objectForKey:@"description"];
				if([description isKindOfClass:[NSString class]])
					NSLog(description);
			}
		}else if([jsonItem isKindOfClass:[NSDictionary class]]){
			NSLog(@"NSDictionary");
		}else{
			NSLog(@"Other Class");
		}
	}
	
	[jsonData release];
	 */
}


/*
- (void)loadView
{
	apiArray = [NSArray arrayWithObjects:@"public_timelines",nil];
	NSLog(@"loadView count=%d",[apiArray count]);
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
	NSLog(@"apiList retain count = %d",[apiList retainCount]);
	[apiList release];
    [super dealloc];
}

@end
