//
//  VKTMessageViewProtocol.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 06.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString * _Nonnull const kVKTAvatarTypeSingleNibName  = @"VKTSingleAvatar";
static NSString * _Nonnull const kVKTAvatarTypeDoubleNibName  = @"VKTDoubleAvatar";
static NSString * _Nonnull const kVKTAvatarTypeTripleNibName  = @"VKTTripleAvatar";
static NSString * _Nonnull const kVKTAvatarTypeQuarterNibName = @"VKTQuarterAvatar";

typedef NS_ENUM(NSUInteger, VKTAvatarType){
    VKTAvatarTypeNone = 0,
    VKTAvatarTypeSingle,
    VKTAvatarTypeDouble,
    VKTAvatarTypeTriple,
    VKTAvatarTypeQuarter
};

__unused static NSString * _Nonnull VKTAvatarNibNameByType(VKTAvatarType type) {
    switch (type) {
        case VKTAvatarTypeNone:
        case VKTAvatarTypeSingle:  return kVKTAvatarTypeSingleNibName;  break;
        case VKTAvatarTypeDouble:  return kVKTAvatarTypeDoubleNibName;  break;
        case VKTAvatarTypeTriple:  return kVKTAvatarTypeTripleNibName;  break;
        case VKTAvatarTypeQuarter: return kVKTAvatarTypeQuarterNibName; break;
    }
    return kVKTAvatarTypeSingleNibName;
}

@protocol VKTAvatarViewModelProtocol
@property (strong, nonatomic) NSArray <NSURL *> * _Nullable urls;
@property (assign, nonatomic) BOOL userDeleted;
@property (strong, nonatomic) NSNumber * _Nonnull messageID;
@property (strong, nonatomic) NSNumber * _Nonnull userCount;
@end


@protocol VKTAvatarViewProtocol
@property (assign, nonatomic) VKTAvatarType type;
- (void)reloadWithModel:(id <VKTAvatarViewModelProtocol > _Nonnull)model;
@end


@class VKTMessage;

#import "VKTUserTypes.h"
@protocol VKTMessageAvatarViewModelProtocol
@property (strong, nonatomic) VKTMessage * _Nullable message;
- (VKTUserOnlineStatus )onlineStatus;
- (NSArray <NSURL *> * _Nullable )photoURLs;
@end

@protocol VKTMessageAvatarViewProtocol
- (void)reloadWithModel:(id <VKTMessageAvatarViewModelProtocol > _Nonnull)model;
@end

@protocol VKTMessageViewOnlineStatusProtocol
@property (assign, nonatomic) VKTUserOnlineStatus onlineStatus;
@end

@protocol VKTMessageStatusViewProtocol
@property (strong, nonatomic) NSNumber * _Nullable unread_out;
@property (strong, nonatomic) NSNumber * _Nullable unread_in;
@property (strong, nonatomic) NSNumber * _Nullable unread_count;
@property (strong, nonatomic) NSNumber * _Nullable muted;
@end


@protocol VKTMessageContentViewModelProtocol <VKTMessageStatusViewProtocol>
@property (strong, nonatomic) VKTMessage * _Nullable message;
@property (strong, nonatomic) NSURL * _Nullable photoURL;
@property (strong, nonatomic) NSNumber * _Nullable messageID;
@end

@protocol VKTMessageContentViewProtocol
- (void)reloadWithModel:(_Nonnull id <VKTMessageContentViewModelProtocol > )model;
@end


@protocol VKTMessageTitleProtocol
@property (strong, nonatomic) NSNumber * _Nullable time;
@property (copy,   nonatomic) NSString * _Nullable titleText;
@property (strong, nonatomic) NSNumber * _Nullable verified;
@property (strong, nonatomic) NSNumber * _Nullable muted;
@end

@protocol VKTMessageViewProtocol <NSObject>
@end


@class NSManagedObject;
@protocol VKTMessageObjectProvider <NSObject>
- (void)reloadWithMessage:(NSManagedObject *_Nonnull)object;
@end;
