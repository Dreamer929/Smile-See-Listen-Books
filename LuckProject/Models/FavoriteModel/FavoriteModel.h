//
//  FavoriteModel.h
//  
//
//  
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN
@class PoemModel ;
@interface FavoriteModel : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

- (void)setUpWith:(PoemModel *)model;
@end

NS_ASSUME_NONNULL_END

#import "FavoriteModel+CoreDataProperties.h"
