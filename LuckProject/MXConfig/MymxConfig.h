//
//  MymxConfig.h
//  LuckProject
//
//  Created by moxi on 2017/9/7.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const DETIAL_FONT;
extern NSString *const TANGSHI_COUNT;
extern NSString *const SONGCI_COUNT;
extern NSString *const YUANQU_COUNT;
extern NSString *const BGIMAGE_FLAG;

@interface MymxConfig : NSObject

@property (nonatomic, assign)NSInteger detialFont;
@property (nonatomic, assign)NSInteger readTScount;
@property (nonatomic, assign)NSInteger readSCcount;
@property (nonatomic, assign)NSInteger readYQcount;
@property (nonatomic, assign)NSInteger bgImage;


+(instancetype)shareInstance;

-(void)saveDetialFont:(NSInteger)detialFont;
-(void)saveReadTSCount:(NSInteger)readCount;
-(void)saveReadSCCount:(NSInteger)readCount;
-(void)saveReadYQCount:(NSInteger)readCount;

-(void)saveBgroundImage:(NSInteger)bgImage;

@end
