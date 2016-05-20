//
//  FTGDataManager.h
//  SQLiteStack
//
//  Created by Khoa Pham on 12/7/15.
//  Copyright © 2015 Khoa Pham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTGNote.h"

@interface FTGDataManager : NSObject

- (void)setup;

- (FTGNote *)createNoteWithContent:(NSString *)content;
- (NSArray<FTGNote *> *)loadNotes;
- (void)saveNotes:(NSArray<FTGNote *> *)notes;

@end
