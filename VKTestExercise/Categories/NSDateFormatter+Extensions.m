//
//  NSDateFormatter+EasyDateFormatting.m
//  DBMotion
//
//  Created by Andrey Kladov on 23.01.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDateFormatter+Extensions.h"
#import "NSDate+Extensions.h"

@implementation NSDateFormatter (Extensions)

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)formatString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatString;
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    return dateFormatter;
}

+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)dateFormat {
    return [[NSDateFormatter dateFormatterWithFormat:dateFormat] dateFromString:dateString];
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)dateFormat {
    return [[NSDateFormatter dateFormatterWithFormat:dateFormat] stringFromDate:date];
}

@end
