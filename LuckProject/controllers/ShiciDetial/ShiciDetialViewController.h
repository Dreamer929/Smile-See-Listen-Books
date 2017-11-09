//
//  ShiciDetialViewController.h
//  LuckProject
//
//  Created by moxi on 2017/9/6.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "BaseViewController.h"
#import "PoemModel.h"

@interface ShiciDetialViewController : BaseViewController

@property (nonatomic, strong)PoemModel *poemModle;
@property (nonatomic, assign)NSInteger flag;//诗词曲的区分1，2，3，收藏4
@property (nonatomic, strong)FavoriteModel *favoModel;

@end
