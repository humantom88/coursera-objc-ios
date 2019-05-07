//
//  ViewController+VCCategory.m
//  GrammyPlus
//
//  Created by Tom Belov on 24/04/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController+VCCategory.h"

@implementation ViewController (VCCategory)

- (IBAction)refreshButtonTapped:(id)sender {
    self.imageView.image = [UIImage imageNamed:@"response"];
}

@end
