//
//  FavoriteModel+CoreDataProperties.h
//  
//
// 
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FavoriteModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoriteModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *pid;
@property (nullable, nonatomic) NSNumber *category;
@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *auther;
@property (nullable, nonatomic, retain) NSString *content;

@end

NS_ASSUME_NONNULL_END
