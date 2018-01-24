//
//  NSDate+Extensions.h
//  VKMessenger
//
//  Created by Andrey Kladov on 20.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UpdateNSDateComponents)(NSDateComponents *components);

@interface NSDate (Extensions)

- (NSDate *)dateAtBeginningOfDayForDate:(NSDate *)inputDate;

- (NSDate *)currentTimeZoneDateFromGMTZero;
-(NSDate *) toLocalTime;
- (NSDate*)getDateWithGMT;
- (NSString*)dateToStringWithformat:(NSString*)format;
+ (NSDate *)dateWithRFC3339:(NSString *)rffc;
- (NSString *)rfc3339String;

- (NSDate *)updateWithUpdateHandler:(UpdateNSDateComponents)updateHandler;
- (NSDateComponents *)components;

@end
