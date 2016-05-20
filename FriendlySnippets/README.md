FriendlySnippets
==
Use and share snippets the easy way

Inspiration
--
I found Mattt Xcode snippets arsenal very useful and I want to easily import them into Xcode. Here I use Mattt raw snippets as an example, but we can create our own raw snippets, convert them and share them easily

How I do it
--
- Download [Xcode-Snippets](https://github.com/mattt/Xcode-Snippets)
- Use [NameChanger](http://mrrsoftware.com/namechanger/) to change the file extension from .m to .rs (for raw snippets :D )
- I saw that Mattt has a very good convention in his files. But unfortunately, some files don't follow this, so I have to modify some .rs files. I think other raw snippet should follow this convention, too. Here it is, for example

```
// dispatch_async Pattern for Background Processing
// Dispatch to do work in the background, and then to the main queue with the results
// 
// Platform: All
// Language: Objective-C
// Completion Scope: Function or Method

dispatch_async(dispatch_get_global_queue(<#dispatch_queue_priority_t priority#>, <#unsigned long flags#>), ^(void) {
    <#code#>
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        <#code#>
    });
});
```
 - Write code to convert .rs files to .codesnippet file that Xcode can understand. Remember to name the files using UUID, so that Xcode can recognize. You can take a look at my code to see how I do it. Basically, it is
```
- (void)performParsing
{
    // Read files from bundle
    FTGSnippetReader *reader = [[FTGSnippetReader alloc] init];
    NSArray *rawSnippetFilePaths = [reader rawSnippetFilePaths];

    // Parse to Snippet
    FTGSnippetsParser *parser = [[FTGSnippetsParser alloc] init];
    NSMutableArray *snippets = [@[] mutableCopy];
    for (NSString *rawSnippetFilePath in rawSnippetFilePaths) {
        FTGSnippet *snippet = [parser snippetFromRawSnippetFilePath:rawSnippetFilePath];
        [snippets addObject:snippet];
    }

    // Save to document directory
    FTGSnippetSaver *saver = [[FTGSnippetSaver alloc] init];
    [snippets enumerateObjectsUsingBlock:^(FTGSnippet *snippet, NSUInteger idx, BOOL *stop) {
        [saver saveSnippet:snippet];
    }];
}
```
 - Use [xcodesnippets](https://github.com/lukeredpath/xcodesnippets) to convert all theses UUID named codesnippets to friendly names. Read [How xcodesnippets works](https://github.com/lukeredpath/xcodesnippets#how-xcodesnippets-works) to understand how it works
 - The output is Default.snippetbundle folder, which you can share it to your friends. I ship Default.snippetbundle (which is the result of my code) as well, you can see it in the Output folder.

How to use it
--
 - Now when you receive Default.snippetbundle, all you have to do is to run this
```
xcodesnippets install-bundle [path-to-snippet-bundle]
```
then restart Xcode and see all those snippets appeared in your Code Snippet Library 

Licence
--
This project is released under the MIT license. See LICENSE.md.

Reference
--
1. [Code Snippets](http://nsscreencast.com/episodes/48-code-snippets)
2. [Xcode-Snippets](https://github.com/mattt/Xcode-Snippets)
3. [xcodesnippets](https://github.com/lukeredpath/xcodesnippets)

Feedback
--
There must be some better way to do it, if you know, please tell me [onmyway133](https://twitter.com/onmyway133)