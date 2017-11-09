//
//  PoemModel.m
//  LuckProject
//
//  Created by moxi on 2017/9/6.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "PoemModel.h"

@implementation PoemModel

- (void)setupWith:(FavoriteModel *)model{
    
    self.pid = (NSInteger)model.pid;
    self.category = [model.category integerValue];
    self.type = (NSInteger)model.type;
    self.title = model.title;
    self.author = model.auther;
    self.content = model.content;
    
}

@end
