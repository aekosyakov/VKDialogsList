//
// UIColor (Utils)
// EE Utilities
//
// Copyright (c) 2013 Eugene Egorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)

- (NSString *)hexString;
+ (UIColor *)colorFromHexString:(NSString *)hexString;

+ (UIColor *)colorWithIntegerRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(NSInteger)alpha;

UIColor *RGBA(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha);
UIColor *SingleRGBA(CGFloat redGreenBlue, CGFloat alpha);

@end
