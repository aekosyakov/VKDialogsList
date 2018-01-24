//
//  VKTTableViewCell.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 05.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterCellProtocol <NSObject>
- (NSString *)reuseIdentifier;
+ (NSString *)reuseIdentifier;

+ (UINib *)nibName;
- (UINib *)nibName;
@end

@interface VKTTableViewCell : UITableViewCell <RegisterCellProtocol>

@end
