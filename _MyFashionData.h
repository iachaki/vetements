// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MyFashionData.h instead.

#import <CoreData/CoreData.h>


extern const struct MyFashionDataAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *picture;
	__unsafe_unretained NSString *timestamp;
	__unsafe_unretained NSString *url;
} MyFashionDataAttributes;

extern const struct MyFashionDataRelationships {
} MyFashionDataRelationships;

extern const struct MyFashionDataFetchedProperties {
} MyFashionDataFetchedProperties;







@interface MyFashionDataID : NSManagedObjectID {}
@end

@interface _MyFashionData : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MyFashionDataID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* picture;



//- (BOOL)validatePicture:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* timestamp;



@property int64_t timestampValue;
- (int64_t)timestampValue;
- (void)setTimestampValue:(int64_t)value_;

//- (BOOL)validateTimestamp:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* url;



//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;






@end

@interface _MyFashionData (CoreDataGeneratedAccessors)

@end

@interface _MyFashionData (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitivePicture;
- (void)setPrimitivePicture:(NSString*)value;




- (NSNumber*)primitiveTimestamp;
- (void)setPrimitiveTimestamp:(NSNumber*)value;

- (int64_t)primitiveTimestampValue;
- (void)setPrimitiveTimestampValue:(int64_t)value_;




- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;




@end
