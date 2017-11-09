//
//  PoemModel.h
//  LuckProject
//
//  Created by moxi on 2017/9/6.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteModel.h"


@interface PoemModel : NSObject

@property(nonatomic)NSInteger pid;
@property(nonatomic)NSInteger category;
@property(nonatomic)NSInteger type;
@property(nonatomic)NSString * title;
@property(nonatomic)NSString * author;
@property(nonatomic)NSString * content;
- (void)setupWith:(FavoriteModel *)model;

@end
