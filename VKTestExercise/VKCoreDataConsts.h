//
//  VKCoreDataConsts.h
//  MobiGenie
//
//  Created by iFreeman on 03.12.12.
//  Copyright (c) 2012 Moche Apps Limited. All rights reserved.
//

typedef enum {
    VKCoreDataManagedObjectContextIDUnknown = 0,
    VKCoreDataManagedObjectContextIDMainThread,
    VKCoreDataManagedObjectContextIDTempMainThread,
    VKCoreDataManagedObjectContextIDTempBackground,
    VKCoreDataManagedObjectContextIDBackgroundRoot
} VKCoreDataManagedObjectContextID;

/*
 * Debug logs context names
 */
static NSString *const kVKCoreDataManagedObjectContextBackgroundRoot = @"BACKGROUND ROOT";
static NSString *const kVKCoreDataManagedObjectContextMainThread     = @"MAIN THREAD";
static NSString *const kVKCoreDataManagedObjectContextMainThreadTemp = @"TEMPOLORARY MAIN THREAD";
static NSString *const kVKCoreDataManagedObjectContextBackgroundTemp = @"TEMPOLORARY BACKGROUND";
