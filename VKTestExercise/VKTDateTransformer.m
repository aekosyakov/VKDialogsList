//
//  VKTDateTransformer.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/12/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTDateTransformer.h"
#import "NSDate+Utilities.h"

@implementation VKTDateTransformer
+ (NSString *)getTimeStringFromTimestamp:(NSNumber *)time {
  NSTimeInterval timeInterval = [time doubleValue];
  NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  NSString *dateFormat = @"HH:mm";

  if ([date isYesterday]) {
    return @"Вчера";
  }
  
  if ([date isEarlierThanDate:[NSDate dateWithDaysBeforeNow:14]]) {
    dateFormat = @"dd.MM.YY"; 
  }
  
  dateFormatter.dateFormat = dateFormat;
  dateFormatter.timeZone = [NSTimeZone systemTimeZone];
  return [dateFormatter stringFromDate:date];
}


@end
