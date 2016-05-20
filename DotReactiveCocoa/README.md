DotReactiveCocoa
=========
ReactiveCocoa with dot syntax

Problem when using block to gain dot syntax
--
- No code block completion suggestion
- No type check for block parameter
- Methods with many parameters (example: subscribeNext:error:completed:) are considered arguments for the block)
- Can't have the same name (See ftg_concat and ftg_concatInner)
- Can't apply to class method, as Xcode does not suggest completion for dot notation on class methods
- Can't return `instancetype` (Methods like ftg_map must return RACSignal), as block return value does not support `instancetype`

Usage
--
```
// Only logs names that starts with "j".
//
// -filter returns a new RACSignal that only sends a new value when its block
// returns YES.
RACObserve(self, username)
.ftg_filter(^(NSString *newName){
    return [newName hasPrefix:@"j"];
})
.ftg_subscribeNext(^(NSString *newName){
    NSLog(@"%@", newName);
});
```



License
--
This project is released under the MIT license. See LICENSE.md