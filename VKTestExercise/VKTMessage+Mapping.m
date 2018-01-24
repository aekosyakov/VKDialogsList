//
//  VKTMessage+Mapping.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 04.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTMessage+Mapping.h"
#import "VKTObject+JSONMapping.h"

#import "VKTAttachment+CoreDataClass.h"
#import "VKTGeo+CoreDataClass.h"
#import "NSNumber+PositiveValue.h"
#import "VKTAttachmentTypes.h"
#import "VKTMessage+Extensions.h"

@implementation VKTMessage (Mapping)

- (void)updateDataFromJSONDict:(NSDictionary *)dict
          managedObjectContext:(NSManagedObjectContext *)context {
    if (![dict respondsToSelector:@selector(objectForKey:)]) {
        return;
    }

    NSDictionary *messageDict = dict[@"message"];
  
    [super updateDataFromJSONDict:dict[@"message"] managedObjectContext:context];
    self.unread_count     = [self numberOrNilFromValue:dict[@"unread"]];
    self.body             = [self stringOrNilFromValue:messageDict[@"body"]];
    self.chat_photo_url   = [self stringOrNilFromValue:messageDict[@"photo_100"]];
    
    self.chat_id          = [[self numberOrNilFromValue:messageDict[@"chat_id"]] makePositiveIfNeeded];
    self.user_id          = [[self numberOrNilFromValue:messageDict[@"user_id"]] makePositiveIfNeeded];
    self.users_count      = [self numberOrNilFromValue:messageDict[@"users_count"]];
    self.read_state       = [self numberOrNilFromValue:messageDict[@"read_state"]];
    self.date             = [self numberOrNilFromValue:messageDict[@"date"]];
    self.chat_id          = [self numberOrNilFromValue:messageDict[@"chat_id"]];
    self.isOut            = [self numberOrNilFromValue:messageDict[@"out"]];
  
  if (!self.users_count) {
    self.users_count = @1;
  }
  
    NSDictionary *pushSettings = messageDict[@"push_settings"];
    self.muted = [self numberOrNilFromValue:pushSettings[@"disabled_until"]];
  

    self.peer_id = [self getPeerID];
    
    [self updateDataForAttachmentsFromJSONDict:messageDict context:context];
    
    [self updateDataForGeoFromJSONDict:messageDict context:context];
}

#pragma VKTAttachment

- (void)updateDataForAttachmentsFromJSONDict:(NSDictionary *)dict context:(NSManagedObjectContext *)context {
    
    NSArray *attachments = dict[@"attachments"];

    for (NSDictionary *attachDict in attachments) {
        NSString *attachType = [self stringOrNilFromValue:attachDict[@"type"]];
        if (!attachType.length) {
            continue;
        }
        
        NSDictionary *attachTypeDict = attachDict[attachType];
        NSNumber *attachID = [self numberOrNilFromValue:attachTypeDict[@"id"]];
        
        BOOL dataNotReady = !attachTypeDict || !attachID
        || ![attachTypeDict respondsToSelector:@selector(objectForKey:)];
        
        if (dataNotReady) {
            continue;
        }
        
        
        NSPredicate *searchInMessagePredicate = [NSPredicate predicateWithFormat:@"(root_id == %@) AND (uid == %@)", self.peer_id, attachID];

        if (!self.attachment) {
            VKTAttachment *attachment = [VKTAttachment findFirstOneWithPredicate:searchInMessagePredicate inContext:context];
            if (!attachment) {
                attachment = [VKTAttachment createEntityInContext:context];
                attachment.root_id = self.peer_id;
            }
            self.attachment = attachment;
        }
        VKTAttachmentType type = VKTAttachmentTypeFromString(attachType);
        self.attachment.type = @(type);
        [self.attachment updateDataFromJSONDict:attachTypeDict managedObjectContext:context];
        
    }
}

#pragma mark VKTGeo

- (void)updateDataForGeoFromJSONDict:(NSDictionary *)dict context:(NSManagedObjectContext *)context {
    NSDictionary *geoDict = dict[@"geo"];
    
    if ([geoDict respondsToSelector:@selector(objectForKey:)]) {
        if (!self.geo) {
            VKTGeo *geo = [VKTGeo createEntityInContext:context];
            self.geo = geo;
        }
        [self.geo updateDataFromJSONDict:geoDict managedObjectContext:context];
        self.geo.title = NSLocalizedString(@"GEO", nil);
    }
}


+ (instancetype)createNewOrUpdateExistedFromDict:(NSDictionary *)dict context:(NSManagedObjectContext *)context {
    VKTMessage *message = [VKTMessage findFirstOneWithPredicate:[self comparePredicateFromDict:dict] inContext:context];
    if (!message) {
        message = [VKTMessage createEntityInContext:context];
    }
    [message updateDataFromJSONDict:dict managedObjectContext:context];
    return message;
}


+ (NSPredicate *)comparePredicateFromDict:(NSDictionary *)dict {
    NSDictionary *messageDict = dict[@"message"];
    NSNumber *user_id          = [[self numberOrNilFromValue:messageDict[@"user_id"]] makePositiveIfNeeded];
    NSNumber *chat_id          = [[self numberOrNilFromValue:messageDict[@"chat_id"]] makePositiveIfNeeded];
    if (!user_id && !chat_id) {
        return [[NSPredicate alloc] init];
    }
    NSNumber *peer_id = [NSNumber createPeerIDFromChatID:chat_id userID:user_id];
    NSPredicate *comparePredicate = [NSPredicate predicateWithFormat:@"peer_id == %@", peer_id];
    return comparePredicate;
}
@end
