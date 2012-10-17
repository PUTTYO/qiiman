//
//  Util.h
//  chat
//
//  Created by ikeda on 09/10/08.
//  Copyright 2009 infocraft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Util : NSObject {
}

+(void) showAlert:(NSString*)message title:(NSString*)title;
+(void) showAlert:(NSString*)message;
+(void) showErrorAlert:(NSString*)message;

@end
