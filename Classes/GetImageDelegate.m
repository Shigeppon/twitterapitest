//
//  getImageDelegate.m
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/03/31.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GetImageDelegate.h"
#import "JSON/JSON.h"


@implementation GetImageDelegate

@synthesize cell;

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response
{
	_data = [[NSMutableData data] retain];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
	
	id profileImageUrl;
	profileImageUrl = nil;
	
	if (_data == nil)
	{
		NSLog(@"error");
	} else {
		NSData* ldata = [NSData dataWithData:_data];
		NSString *jsonData = [[NSString alloc] initWithData:ldata encoding:NSUTF8StringEncoding];
		id jsonItem = [jsonData JSONValue];
		NSDictionary* data = jsonItem;
		profileImageUrl = [data objectForKey:@"profile_image_url"];
		NSLog(profileImageUrl);
	}
	
	if(profileImageUrl){
		NSURL* imageUrl = [NSURL URLWithString:profileImageUrl];
		NSData* imageData;
		NSURLResponse* imageResponse;
		NSError* imageError;
		imageData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:imageUrl] returningResponse:&imageResponse error:&imageError];
		cell.image = [UIImage imageWithData:imageData];
	}
	
	//cell.image = [UIImage imageWithData:_data];
	NSLog(@"finished");
}
@end
