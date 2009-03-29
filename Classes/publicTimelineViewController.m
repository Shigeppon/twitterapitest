//
//  publicTimelineViewController.m
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/03/29.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "publicTimelineViewController.h"
#import "JSON/JSON.h"
#import "ApplicationHelper.h"


@implementation publicTimelineViewController

- (void)viewDidLoad
{
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
			response = [[[NSMutableArray alloc] init] retain];
			NSDictionary* userDictionary = [[NSDictionary alloc] init];
			for(NSDictionary* data in jsonItem){
				id user = [data objectForKey:@"user"];
				id description = [user objectForKey:@"description"];
				id name = [user objectForKey:@"name"];
				id profileImageUrl = [user objectForKey:@"profile_image_url"];
				if([description isKindOfClass:[NSString class]])
				{
					NSArray *values = [NSArray arrayWithObjects:description,name,profileImageUrl,nil];
					NSArray *keys = [NSArray arrayWithObjects:@"description",@"name",@"profile_image_url",nil];
					userDictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];
					[response addObject:userDictionary];
					NSLog(description);
				}
			}
		}else if([jsonItem isKindOfClass:[NSDictionary class]]){
			NSLog(@"NSDictionary");
		}else{
			NSLog(@"Other Class");
		}
	}
	
	[jsonData release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSLog(@"%d",[response count]);
	return [response count];
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"any-cell"];
	if(cell == nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"any-cell"] autorelease];
	}
	cell.text = [[response objectAtIndex:[indexPath row]] objectForKey:@"description"];
	NSURL* imageUrl = [NSURL URLWithString: [[response objectAtIndex:[indexPath row]] objectForKey:@"profile_image_url"]];
	NSData* imageData;
	NSURLResponse* imageResponse;
	NSError* imageError;
	imageData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:imageUrl] returningResponse:&imageResponse error:&imageError];
	cell.image = [UIImage imageWithData:imageData];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	/*
	NSLog(@"selected row = %d selected api = %@",[indexPath row],[apiList objectAtIndex:[indexPath row]]);
	NSString *apiName = [apiList objectAtIndex:[indexPath row]];
	if([self respondsToSelector:NSSelectorFromString(apiName)]){
		[self performSelector:NSSelectorFromString(apiName)];
	}else{
		NSLog(@"api %@ is not recognize",apiName);
	}
	 */
}


/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}







/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
	[response release];
    [super dealloc];
}


@end

