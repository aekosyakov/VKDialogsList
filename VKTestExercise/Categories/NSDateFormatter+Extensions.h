//
//  NSDateFormatter+EasyDateFormatting.h
//  DBMotion
//
//  Created by Andrey Kladov on 23.01.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Extensions)

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)formatString;
+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)dateFormat;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)dateFormat;

@end
