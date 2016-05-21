FTGPropertyMaestro
=========
Synthesize properties for categories

How I do it
--
- Swizzle getter and setter
- Using associated object

How to use it
--
- Import FTGPropertyMaestro and you're good to go
- Property with backing instance variable or not of object type are not supported

```
@property (nonatomic, assign) BOOL categoryBoolProperty;
```
This property is not supported because it is of type BOOL


```
@interface FTGClassA : NSObject

@property (nonatomic, strong) NSNumber *strongProperty;

@end
```
This property is not supported because it is not in category, it will be auto synthesized to have getter, setter and backing instance variable.

- Support custom getter and setter

```
@property (nonatomic, copy, setter = updateCategoryCopyProperty:) NSString *categoryCopyProperty;
```

- Set association type depends on your property attribute

```
@property (nonatomic, strong) NSNumber *categoryStrongProperty;
```
This will select ```OBJC_ASSOCIATION_RETAIN_NONATOMIC```

- Remember to use `@dynamic` to suppress warning
- FTGPropertyMaestro will synthesize getter and setter for you, using associated object (Replace implementation if they exist, or add new implementation if they do not exist)

Property Retrieval
--
```
NSArray *kClassAProperties = [FTGPropertyMaestro propertiesForClass:[FTGClassA class]];

FTGProperty *wheelNumberProperty = [FTGPropertyMaestro propertyForClass:[FTGCar class]
                                        propertyName:@"wheelNumber"];

```

Synthesize property for category
--

`FTGClassA+FTGAdditions.h`

```
@interface FTGClassA (FTGAdditions)

@property (nonatomic, assign, getter = fetchCategoryBoolProperty) BOOL categoryBoolProperty;
@property (nonatomic, strong) NSNumber *categoryStrongProperty;
@property (nonatomic, copy, setter = updateCategoryCopyProperty:) NSString *categoryCopyProperty;

@end
```

`FTGClassA+FTGAdditions.m`

```
@implementation FTGClassA (FTGAdditions)

@dynamic categoryBoolProperty;
@dynamic categoryCopyProperty;
@dynamic categoryStrongProperty;

+ (void)load
{
    [FTGPropertyMaestro synthesizeClass:self propertyNames:@[ @"categoryCopyProperty", @"categoryStrongProperty"] ];
}

@end
```


Testing
--
Use XCTest

License
--
This project is released under the MIT license. See LICENSE.md