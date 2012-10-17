//
//  Util.m
//  novel
//
//  Created by ikeda on 09/10/08.
//  Copyright 2009 infocraft. All rights reserved.
//

#import "Util.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation Util

+(void) showAlert:(NSString*)message title:(NSString*)title {
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:title message:message
						  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
}

+(void) showAlert:(NSString*)message {
	[Util showAlert:message title:@""];
}

+(void) showErrorAlert:(NSString*)message {
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:NSLocalizedString(@"エラー",nil) message:message
						  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
}

@end
