//
//  FTGDetailVC.m
//  SQLiteStack
//
//  Created by Khoa Pham on 12/7/15.
//  Copyright © 2015 Khoa Pham. All rights reserved.
//

#import "FTGDetailVC.h"

@interface FTGDetailVC ()

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation FTGDetailVC

- (void)updateWithNote:(FTGNote *)note {
    self.contentLabel.text = note.content;
}

@end
