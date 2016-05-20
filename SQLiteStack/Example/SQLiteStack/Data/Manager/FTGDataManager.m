//
//  FTGDataManager.m
//  SQLiteStack
//
//  Created by Khoa Pham on 12/7/15.
//  Copyright © 2015 Khoa Pham. All rights reserved.
//

#import "FTGDataManager.h"
#import "FTGSQLiteStack.h"
#import "FTGSQLiteHelper.h"
#import "ObjectiveSugar.h"

static NSString *tableCreatedKey = @"tableCreatedKey";

@interface FTGDataManager ()

@property (nonatomic) FTGSQLiteStack *stack;

@end

@implementation FTGDataManager

- (instancetype)init {
    self = [super init];

    self.stack = [[FTGSQLiteStack alloc] initWithStoreName:@"note"];

    return self;
}

- (void)setup {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:tableCreatedKey]) {
        return;
    }

    [self.stack createTables:@[@"FTGNote"]];

    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:tableCreatedKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (FTGNote *)createNoteWithContent:(NSString *)content {
    FTGNote *note = [[FTGNote alloc] init];
    note.modelID = [[NSUUID UUID] UUIDString];
    note.content = content;
    note.timeInterval = [[NSDate date] timeIntervalSince1970];

    return note;
}

- (void)saveNotes:(NSArray<FTGNote *> *)notes {
    FTGSQLiteHelper *helper = [FTGSQLiteHelper new];
    NSArray<NSString *> *modifiedStatements = [notes map:^id(FTGNote *note) {
        return [helper insertOrUpdateStatementForModel:note modelClass:[FTGNote class]];
    }];

    [self.stack executeStatements:modifiedStatements];
}

- (NSArray<FTGNote *> *)loadNotes {
    return (id)[self.stack loadAllWithModelClass:[FTGNote class]];
}

@end
