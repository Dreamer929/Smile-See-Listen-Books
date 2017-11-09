//
//  FavoriteModel.m
//  
//
//  
//
//

#import "FavoriteModel.h"

#import "PoemModel.h"

@implementation FavoriteModel

- (void)setUpWith:(PoemModel *)model{
       self.pid =@(model.pid);
        self.category = [NSNumber numberWithInteger:model.category];
        self.type = @(model.type);
        self.title = model.title;
        self.auther = model.author;
        self.content = model.content;
}



@end
