FTGValidator
=========
A DSL validator for Objective C

Features
--
- Create rule and configure the rule using blocks.
- Each rule validates only one thing.
- Support validation for string, number, date and any object via custom block

How to use it
--
Import `FTGValidator.h` and you're good to go

```
    BOOL (^customBlock)(NSArray *) = ^(NSArray *array) {
        if (array.count == 3) {
            return YES;
        }

        return NO;
    };

    NSArray *rules = @[REQUIRE_STRING(@"John").notEmpty.with.message(@"Value must not be empty"),
                       REQUIRE_STRING(@"90001").to.matchRegExWithPattern(@"^[0-9][0-9][0-9][0-9][0-9]$").with.message(@"Value must be US zip code format"),
                       REQUIRE_NUMBER(@(1990)).greaterThan(@(1970)).with.message(@"Must be born after 1970"),
                       REQUIRE_ANY(@[@"one", @"two", @"three"]).satisfyBlock(customBlock).with.message(@"Array must have 3 elements"),
                       ];

    FTGValidator *validator = [FTGValidator validatorWithRules:rules];

    FTGValidationResult *result = [validator validate];
    if (result.succeeded) {
        NSLog(@"All rules pass");
    } else {
        NSLog(@"Failed. Show message: %@", result.message);
    }
```


Testing
--
Use XCTest

License
--
This project is released under the MIT license. See LICENSE.md