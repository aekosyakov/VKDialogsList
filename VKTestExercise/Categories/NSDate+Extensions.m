//
//  NSDate+Extensions.m
//  VKMessenger
//
//  Created by Andrey Kladov on 20.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDate+Extensions.h"
#import "NSDateFormatter+Extensions.h"

@implementation NSDate (Extensions)


- (NSDate *)dateAtBeginningOfDayForDate:(NSDate *)inputDate {
    
    // Use the user's current calendar and time zone
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    
    [calendar setTimeZone:timeZone];
    
    // Selectively convert the date components (year, month, day) of the input date
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:inputDate];
    
    // Set the time components manually
    [dateComps setHour:0];
    [dateComps setMinute:0];
    [dateComps setSecond:0];
    
    // Convert back       
    NSDate *beginningOfDay = [calendar dateFromComponents:dateComps];
    return beginningOfDay;
}

- (NSDate *)currentTimeZoneDateFromGMTZero {
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:self];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    return [NSDate dateWithTimeInterval:interval sinceDate:self];
}

-(NSDate *) toLocalTime
{
  NSTimeZone *tz = [NSTimeZone localTimeZone];
  NSInteger seconds = [tz secondsFromGMTForDate: self];
  return [NSDate dateWithTimeInterval: seconds sinceDate: self];
}

- (NSDate*)getDateWithGMT {
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:self];
	[components setTimeZone:[NSTimeZone localTimeZone]];
	NSDate *newDate = [[NSCalendar currentCalendar]  dateFromComponents:components];
    
	NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
	NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
	
	NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:newDate];
	NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:newDate];
	NSTimeInterval gmtInterval = currentGMTOffset - gmtOffset;
	return [[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:newDate];
}

- (NSString*)dateToStringWithformat:(NSString*)format {
  if (!self) {
      return nil;
  }
  return [NSDateFormatter stringFromDate:self withFormat:format];
}

+ (NSDate *)dateWithRFC3339:(NSString *)rffcTime {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
  NSDate *date;
  NSError *error;
  [formatter getObjectValue:&date forString:rffcTime range:nil error:&error];

  return date;
}

- (NSString *)rfc3339String {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";

  return [formatter stringFromDate:self];
}

- (NSDate *)updateWithUpdateHandler:(UpdateNSDateComponents)updateHandler {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *comps = [self components];
  [comps setCalendar:calendar];
  if(updateHandler) {
    updateHandler(comps);
  }
  return [calendar dateFromComponents:comps];
}

- (NSDateComponents *)components {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *comps = [calendar components: NSCalendarUnitEra|NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour | NSCalendarUnitWeekday| NSCalendarUnitWeekdayOrdinal fromDate:self];
  [comps setCalendar:calendar];
  return comps;
}


@end
