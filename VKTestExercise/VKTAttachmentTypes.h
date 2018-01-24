//
//  VKTAttachmentTypes.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 11.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#ifndef VKTAttachmentTypes_h
#define VKTAttachmentTypes_h
#endif /* VKTAttachmentTypes_h */

static NSString *const kPhotoType  = @"Photo";
static NSString *const kAudioType  = @"Audio";
static NSString *const kVideoType  = @"Video";
static NSString *const kDocType    = @"Doc";
static NSString *const kLinkType   = @"Link";
static NSString *const kMarketType = @"Market";
static NSString *const kWallType   = @"Wall";
static NSString *const kShareType  = @"Share";
static NSString *const kGiftType   = @"Gift";
static NSString *const kStickerType   = @"Sticker";

typedef NS_ENUM(NSUInteger, VKTAttachmentType) {
    VKTAttachmentTypeNone = 0,
    VKTAttachmentTypePhoto,
    VKTAttachmentTypeVideo,
    VKTAttachmentTypeAudio,
    VKTAttachmentTypeDoc,
    VKTAttachmentTypeLink,
    VKTAttachmentTypeMarket,
    VKTAttachmentTypeWall,
    VKTAttachmentTypeShare,
    VKTAttachmentTypeGift,
    VKTAttachmentTypeSticker
};

__unused static VKTAttachmentType VKTAttachmentTypeFromString(NSString *string) {
    
    VKTAttachmentType type = VKTAttachmentTypeNone;
    if ([string isEqualToString:kPhotoType.lowercaseString]) {
        return VKTAttachmentTypePhoto;
    }
    
    if ([string isEqualToString:kAudioType.lowercaseString]) {
        return VKTAttachmentTypeAudio;
    }
    
    if ([string isEqualToString:kVideoType.lowercaseString]) {
        return VKTAttachmentTypeVideo;
    }
    
    if ([string isEqualToString:kDocType.lowercaseString]) {
        return VKTAttachmentTypeDoc;
    }
    
    if ([string isEqualToString:kLinkType.lowercaseString]) {
        return VKTAttachmentTypeLink;
    }
    
    if ([string isEqualToString:kMarketType.lowercaseString]) {
        return VKTAttachmentTypeMarket;
    }
    
    if ([string isEqualToString:kWallType.lowercaseString]) {
        return VKTAttachmentTypeWall;
    }
    
    if ([string isEqualToString:kShareType.lowercaseString]) {
        return VKTAttachmentTypeShare;
    }
    
    if ([string isEqualToString:kGiftType.lowercaseString]) {
        return VKTAttachmentTypeGift;
    }
  
    if ([string isEqualToString:kStickerType.lowercaseString]) {
      return VKTAttachmentTypeSticker;
    }
    return type;
}

__unused static NSString *VKTAttachmentTitleFromType(VKTAttachmentType type) {
    NSString *title = nil;
    switch (type) {
        case VKTAttachmentTypeNone: {
        } break;
        case VKTAttachmentTypePhoto: {
            title = NSLocalizedString(@"kPHOTO", nil);
        }  break;
        case VKTAttachmentTypeAudio: {
            title = NSLocalizedString(@"kAUDIO", nil);
        }  break;
        case VKTAttachmentTypeVideo: {
            title = NSLocalizedString(@"kVIDEO", nil);
        }  break;
        case VKTAttachmentTypeDoc: {
            title = NSLocalizedString(@"kDOC", nil);
        }  break;
        case VKTAttachmentTypeLink: {
            title = NSLocalizedString(@"kLINK", nil);
        }  break;
        case VKTAttachmentTypeMarket: {
            title = NSLocalizedString(@"kMARKET", nil);
        }  break;
        case VKTAttachmentTypeWall: {
            title = NSLocalizedString(@"kWALL", nil);
        }  break;
        case VKTAttachmentTypeShare: {
            title = NSLocalizedString(@"kSHARE", nil);
        }  break;
        case VKTAttachmentTypeGift: {
            title = NSLocalizedString(@"kGIFT", nil);
        }  break;
      case VKTAttachmentTypeSticker: {
            title = NSLocalizedString(@"kSTICKER", nil);
      }
    }
    return title;
}



