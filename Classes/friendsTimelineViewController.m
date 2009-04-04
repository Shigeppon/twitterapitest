//
//  friendsTimelineViewController.m
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/04/05.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "friendsTimelineViewController.h"
#import "ApplicationHelper.h"
#import "TimeLineViewCell.h"
#import "JSON/JSON.h"


@implementation friendsTimelineViewController

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];

    NSString* format = @"json";
	
	NSString* url = [ApplicationHelper getEscapedString:
					 [NSString stringWithFormat:@"http://twitter.com/statuses/friends_timeline.%@",format]];
	
	NSLog(url);
	
	//認証が必要なリクエスト
	NSMutableURLRequest* req = [ApplicationHelper setRequestHeader:url];
	
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
				
				NSArray *values = [NSArray arrayWithObjects:text,profile_image_url,description,name,userid,nil];
				NSArray *keys = [NSArray arrayWithObjects:@"text",@"profile_image_url",@"description",@"name",@"id",nil];
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

- (void) modCell:(UITableViewCell*)aCell withText:(NSString *)text image:(UIImage *)image name:(NSString *)name
{
	//テキスト
	CGRect tRect1 = CGRectMake(58.0f, 2.0f, 320.0f, 60.0f);
	id title1 = [[UILabel alloc] initWithFrame:tRect1];
	[title1 setText:text];
	[title1 setTextAlignment:UITextAlignmentLeft];
	
	//イメージ
	CGRect tRect2 = CGRectMake(2.0f, 2.0f, 56.0f, 56.0f);
	id image1 = [[UIImageView alloc] initWithFrame:tRect2];
	[image1 setImage:image];
	
	//名前
	CGRect tRect3 = CGRectMake(58.0f, 2.0f, 320.0f, 20.0f);
	id name1 = [[UILabel alloc] initWithFrame:tRect3];
	[name1 setText:name];
	[name1 setTextAlignment:UITextAlignmentLeft];
	
	//セルに追加する
	[aCell addSubview:title1];
	[aCell addSubview:image1];
	[aCell addSubview:name1];
	
	[title1 release];
	[image release];
	[name1 release];
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
	
	
	
	
	//[cell.imageView setImageView:[[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"Argentina.gif"]]];
	
	//cell.name.text = @"test";
	
	//name = @"test";
	/*
	//cell.text = [[response objectAtIndex:[indexPath row]] objectForKey:@"text"];
	
	NSString* url = [NSString stringWithFormat:[[response objectAtIndex:[indexPath row]] objectForKey:@"profile_image_url"]];
	
	NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	NSURLResponse* urlResponse;
	NSError* error;
	NSData* data = [NSURLConnection sendSynchronousRequest:req returningResponse:&urlResponse error:&error];
	//cell.image = [UIImage imageWithData:data];
	
	
	NSString* text = [[response objectAtIndex:[indexPath row]] objectForKey:@"text"];
	NSString* name = [[response objectAtIndex:[indexPath row]] objectForKey:@"name"];
	UIImage* image = [UIImage imageWithData:data];
	
	[self modCell:cell withText:text image:image name:name];
	 */
	return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
	return 60;
}

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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
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
    [super dealloc];
}


@end

