//
//  RootService.m
//  AskBoard
//
//  Created by Khoa Pham on 5/4/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "RootService.h"
#import "AppDelegate.h"
#import "LoginVC.h"
#import "QuestionsVC.h"
#import "UserManager.h"

#import <UIViewController+MEDAdditions.h>
#import <ReactiveCocoa.h>

@implementation RootService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self appDelegate].window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIWindow *window = [self appDelegate].window;
    [window makeKeyAndVisible];

    if ([[UserManager sharedManager] isLoggedIn]) {
        [self makeVCAsRoot:[self makeQuestionsVC]];
    } else {
        [self makeVCAsRoot:[self makeLoginVC]];
    }

    return YES;
}

- (AppDelegate *)appDelegate {
    return (id)[UIApplication sharedApplication].delegate;
}

- (UIViewController *)makeRootVC {
    return [self makeLoginVC];
}

#pragma mark - Root
- (void)makeVCAsRoot:(UIViewController *)vc {
    UIWindow *window = [self appDelegate].window;
    window.rootViewController = vc;
}

#pragma mark - VC
- (UIViewController *)makeLoginVC {
    LoginVC *loginVC = [LoginVC med_instantiateFromStoryboardNamed:@"Login"];

    @weakify(self);
    [[loginVC loginDidFinishSignal] subscribeCompleted:^{
        @strongify(self);
        [self makeVCAsRoot:[self makeQuestionsVC]];
    }];

    return loginVC;
}

- (UIViewController *)makeQuestionsVC {
    QuestionsVC *questionsVC = [QuestionsVC med_instantiateFromStoryboardNamed:@"Question"];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:questionsVC];
    return navC;
}


@end
