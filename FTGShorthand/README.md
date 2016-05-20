FTGShorthand
=========
Allows your category methods to be in shorthand form, like MagicalRecord MR_SHORTHAND

How I do it
--
Learn code from MagicalRecord short hand, and make it easier to use

How to use it
--
For example, I have a category on NSString

`NSString+FTGAdditions.h`
```
@interface NSString (FTGAdditions)

- (void)ftg_doSomething1;
- (void)ftg_doSomething2;

@end
```


`NSString+FTGShorthandAdditions.h`

Declare your shorthand methods here to make the compiler happy
```
@interface NSString (FTGShorthandAdditions)

- (void)doSomething1;
- (void)doSomething2;

@end
```

`NSString+FTGAdditions.h`

Configure FTGShorthand in ```load``` method
```
@implementation NSString (FTGAdditions)

- (void)ftg_doSomething1
{
    NSLog(@"doSomething1 on %@", self);
}

- (void)ftg_doSomething2
{
    NSLog(@"doSomething2 on %@", self);
}

#pragma mark - FTGShorthand
+ (void)load
{
    [FTGShorthand setPrefix:@"ftg_"];
    [FTGShorthand supportShorthandMethodsForClass:self];
}

@end
```

Note
--
- You should configure the prefix once. Be careful that it must have a trailing underscore. This needs to be done in one of your categories
- Call ```supportShorthandMethodsForClass``` in each of your category

License
--
FTGShorthand is released under the MIT license. See [LICENSE](https://github.com/onmyway133/FTGShorthand/blob/master/LICENSE)