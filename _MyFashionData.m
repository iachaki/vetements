// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MyFashionData.m instead.

#import "_MyFashionData.h"

const struct MyFashionDataAttributes MyFashionDataAttributes = {
	.name = @"name",
	.picture = @"picture",
	.timestamp = @"timestamp",
	.url = @"url",
};

const struct MyFashionDataRelationships MyFashionDataRelationships = {
};

const struct MyFashionDataFetchedProperties MyFashionDataFetchedProperties = {
};

@implementation MyFashionDataID
@end

@implementation _MyFashionData

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MyFashionData" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MyFashionData";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MyFashionData" inManagedObjectContext:moc_];
}

- (MyFashionDataID*)objectID {
	return (MyFashionDataID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"timestampValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"timestamp"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic name;






@dynamic picture;






@dynamic timestamp;



- (int64_t)timestampValue {
	NSNumber *result = [self timestamp];
	return [result longLongValue];
}

- (void)setTimestampValue:(int64_t)value_ {
	[self setTimestamp:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveTimestampValue {
	NSNumber *result = [self primitiveTimestamp];
	return [result longLongValue];
}

- (void)setPrimitiveTimestampValue:(int64_t)value_ {
	[self setPrimitiveTimestamp:[NSNumber numberWithLongLong:value_]];
}





@dynamic url;











@end
