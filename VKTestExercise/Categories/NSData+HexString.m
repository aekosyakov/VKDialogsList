//
// Created by aleksey kosylo on 12/02/16.
// Copyright (c) 2016 Cube Innovations, Inc. All rights reserved.
//

#import "NSData+HexString.h"


@implementation NSData (HexString)

- (NSString *)hexString
{
  NSUInteger length = self.length;
  const unsigned char *bytes = self.bytes;

  if(!bytes)
    return @"";

  NSMutableString *hex = [NSMutableString stringWithCapacity:length * 2];
  for(NSUInteger i = 0; i < length; ++i)
    [hex appendString:[NSString stringWithFormat:@"%02x", bytes[i]]];

  return hex;
}

@end