
#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface QiitaAPIClient : AFHTTPClient

+ (QiitaAPIClient *)sharedClient;

@end
