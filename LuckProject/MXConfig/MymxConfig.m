//
//  MymxConfig.m
//  LuckProject
//
//  Created by moxi on 2017/9/7.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "MymxConfig.h"

NSString *const DETIAL_FONT   = @"detial_font";
NSString *const TANGSHI_COUNT = @"readTS_c";
NSString *const SONGCI_COUNT  = @"readSC_c";
NSString *const YUANQU_COUNT  = @"readYQ_c";
NSString *const BGIMAGE_FLAG  = @"bg_flag";



@implementation MymxConfig


+(instancetype)shareInstance{
    
    static id  shareInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[MymxConfig alloc]init];
    });
    
    [shareInstance loadData];
    return shareInstance;
}

-(void)loadData{
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:DETIAL_FONT]!=nil) {
        self.detialFont = [defaults integerForKey:DETIAL_FONT];
    }else{
        self.detialFont = 13;
    }
    if ([defaults objectForKey:TANGSHI_COUNT]!=nil) {
        self.readTScount = [defaults integerForKey:TANGSHI_COUNT];
    }else{
        self.readTScount = 0;
    }
    if ([defaults objectForKey:SONGCI_COUNT]!=nil) {
        self.readSCcount = [defaults integerForKey:SONGCI_COUNT];
    }else{
        self.readSCcount = 0;
    }
    if ([defaults objectForKey:YUANQU_COUNT]!= nil) {
        self.readYQcount = [defaults integerForKey:YUANQU_COUNT];
    }else{
        self.readYQcount = 0;
    }
    if ([defaults objectForKey:BGIMAGE_FLAG]!= nil) {
        self.bgImage = [defaults integerForKey:BGIMAGE_FLAG];
    }else{
        self.bgImage = 5;
    }
}

-(void)saveInfo{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setInteger:self.detialFont forKey:DETIAL_FONT];
    [defaults setInteger:self.readTScount forKey:TANGSHI_COUNT];
    [defaults setInteger:self.readSCcount forKey:SONGCI_COUNT];
    [defaults setInteger:self.readYQcount forKey:YUANQU_COUNT];
    [defaults setInteger:self.bgImage forKey:BGIMAGE_FLAG];
    
    [defaults synchronize];
}

-(void)saveDetialFont:(NSInteger)detialFont{
    
    self.detialFont = detialFont;
    
    [self saveInfo];
}

-(void)saveReadTSCount:(NSInteger)readCount{
    self.readTScount = readCount;
    [self saveInfo];
}

-(void)saveReadSCCount:(NSInteger)readCount{
    self.readSCcount = readCount;
    [self saveInfo];
}

-(void)saveReadYQCount:(NSInteger)readCount{
    
    self.readYQcount = readCount;
    [self saveInfo];
}

-(void)saveBgroundImage:(NSInteger)bgImage{

    self.bgImage = bgImage;
    [self saveInfo];
}


@end
