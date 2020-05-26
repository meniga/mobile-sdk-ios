#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFRealmAccountParameter : MNFObject

@property (nonatomic, copy, readonly) NSString *key;
@property (nonatomic, copy, readonly) NSString *value;

@end

NS_ASSUME_NONNULL_END
