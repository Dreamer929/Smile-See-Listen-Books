//
//  NSString+MXString.m
//  LuckProject
//
//  Created by moxi on 2017/9/7.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "NSString+MXString.h"

@implementation NSString (MXString)

+(NSString*)currtenDate{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"YYYY-MM-dd";
    
    NSString *locationString=[formatter stringFromDate:date];
    
    return locationString;
}

@end
