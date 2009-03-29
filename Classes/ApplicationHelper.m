//
//  ApplicationHelper.m
//  twitterAPITest
//
//  Created by Shigeo Sakamoto on 09/03/29.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ApplicationHelper.h"
#import "Base64EncDec.h"

@implementation ApplicationHelper

+ (NSString *)getEscapedString:(NSString *)string
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

+ (void)alertMessage:(NSString *)title message:(NSString *)message
{
	//usage
	//[self alertMessage:@"タイトル" message:@"アラートのテスト"];
	UIAlertView* baseAlert = [[UIAlertView alloc] initWithTitle:title
														message:message 
													   delegate:self 
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
	[baseAlert show];
	
}

+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSLog(@"pushed %d",buttonIndex);
	[alertView release];
}

+ (NSMutableURLRequest *)setRequestHeader:(NSString *)url
{
	//認証用IDとパスワードをBase64でエンコードしてHttpHeaderに格納する
	//plistからIDとパスワードを取得する
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];  
	NSString* username = [userDefaults stringForKey:@"twitterUserID"];
	NSString* password = [userDefaults stringForKey:@"twitterPassword"];
	NSLog(@"id = %@ password = %@",username,password);
	
	NSData* data = [[NSString stringWithFormat:@"%@:%@", username, password]
					dataUsingEncoding:NSASCIIStringEncoding];
	NSString* base64Str = [data stringEncodedWithBase64];
	NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	[req setValue:[NSString stringWithFormat:@"Basic %@", base64Str] forHTTPHeaderField:@"Authorization"];
	
	return req;
}

@end
