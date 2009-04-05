//
//  TimeLineViewController.m
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/04/05.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TimeLineViewController.h"
#import "ApplicationHelper.h"
#import "TimeLineViewCell.h"
#import "ShowViewController.h"
#import "JSON/JSON.h"

@implementation TimeLineViewController

- (id)initWithApiUrl:(NSString*)aUrl
{
	if(self = [super init])
	{
		apiUrl = aUrl;
		[apiUrl retain];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//認証が必要なリクエスト
	NSMutableURLRequest* req = [ApplicationHelper setRequestHeader:apiUrl];
	
	NSURLResponse* urlResponse;
	NSError* error;
	NSData* data = [NSURLConnection sendSynchronousRequest:req returningResponse:&urlResponse error:&error];
	
	// 検索処理
	NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
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
				id statusId = [data objectForKey:@"id"];
				id text = [data objectForKey:@"text"];
				id user = [data objectForKey:@"user"];
				id profile_image_url = [user objectForKey:@"profile_image_url"];
				id description = [user objectForKey:@"description"];
				id name = [user objectForKey:@"name"];
				id userid = [user objectForKey:@"id"];
				if(![description isKindOfClass:[NSString class]])
				{
					description = [NSString stringWithFormat:@""];
				}
				
				NSArray *values = [NSArray arrayWithObjects:statusId,text,profile_image_url,description,name,userid,nil];
				NSArray *keys = [NSArray arrayWithObjects:@"statusId",@"text",@"profile_image_url",@"description",@"name",@"id",nil];
				userDictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];
				[response addObject:userDictionary];
				
			}
		}else if([jsonItem isKindOfClass:[NSDictionary class]]){
			NSLog(@"NSDictionary");
		}else{
			NSLog(@"Other Class");
		}
	}
	
	[jsonData release];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	TimeLineViewCell* cell = (TimeLineViewCell*)[tableView dequeueReusableCellWithIdentifier:@"any-cell"];
	if(cell == nil)
	{
		UIViewController* viewController;
		viewController = [[UIViewController alloc] initWithNibName:@"TimeLineViewCell" bundle:nil];
		cell = (TimeLineViewCell*)viewController.view;
		[viewController release];
	}
	
	NSString* url = [NSString stringWithFormat:[[response objectAtIndex:[indexPath row]] objectForKey:@"profile_image_url"]];
	
	NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	NSURLResponse* urlResponse;
	NSError* error;
	NSData* data = [NSURLConnection sendSynchronousRequest:req returningResponse:&urlResponse error:&error];
	
	[cell.nameLabel setText:[[response objectAtIndex:[indexPath row]] objectForKey:@"name"]];
	[cell.textLabel setText:[[response objectAtIndex:[indexPath row]] objectForKey:@"text"]];
	[cell.imageView setImage:[UIImage imageWithData:data]];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	TimeLineViewCell* cell = (TimeLineViewCell*)[tableView cellForRowAtIndexPath:indexPath];
	
	/*
	[[self navigationController] pushViewController:[[ShowViewController alloc] 
													 initWithName:[[response objectAtIndex:[indexPath row]] objectForKey:@"name"]
													 Text:[[response objectAtIndex:[indexPath row]] objectForKey:@"text"]
													 ProfileImage:[UIImage imageNamed:@"Argentina.gif"]]
										   animated:YES];
	 */
	[[self navigationController] pushViewController:[[ShowViewController alloc]
													 initWithName:[cell.nameLabel text]
													 Text:[cell.textLabel text]
													 ProfileImage:[cell.imageView image]
													 StatusId:[[[response objectAtIndex:[indexPath row]] objectForKey:@"statusId"] intValue]]
													 animated:YES];
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
	return 60;
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

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [response count];
}

/*
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...

    return cell;
}
*/




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
    [super dealloc];
}


@end

