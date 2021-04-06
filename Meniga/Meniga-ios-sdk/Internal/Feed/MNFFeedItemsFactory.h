#import "MNFObject.h"
#import "MNFResponse.h"

@interface MNFFeedItemsFactory : NSObject

+ (NSArray *)createFeedItemsWithModelFromResponse:(MNFResponse *)response;

@end
