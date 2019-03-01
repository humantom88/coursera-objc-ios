//
//  ViewController.m
//  Playground
//
//  Created by Tom Belov on 27/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"
#import "Stuff.h"
#import "Foo.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) NSString *str1;
@property (weak, nonatomic) NSString *str2;
@end

@implementation ViewController

- (int) getFive {
    return 5;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    __block int i = 50;
//
//    void (^myCustomBlock)(void) = ^{
//        NSLog(@"%d", i);
//        i /= 2;
//    };
//
//    i += 9;
//
//    myCustomBlock();
//    NSLog(@"%d", i);
//
//    Stuff *stuff = [[Stuff alloc] init];
//
//    [stuff setValue:@12 forKey:@"number"];
//
//    NSNumber *value = [stuff valueForKey:@"number"];
//    NSLog(@"%@", value);
    
    
//    int i = 10;
//    void (^block) (int) = ^(int x){
//        NSLog(@"%d", i);
//    };
//    i++;
//    block (i);
    
    // NSComparisonResult (^) (id obj1, id obj2);
//    NSArray* arr1 = @[@"One", @"Two", @"Three"];
//    NSArray* arr2 = [arr1 sortedArrayUsingComparator: ^(id objl, id obj2) {
//        NSString* sl = objl;
//        NSString* s2 = obj2;
//
//        NSString* stringlend = [sl substringFromindex: [sl length] - 1];
//        NSString* string2end = [s2 substringFromindex: [s2 length] - 1];
//
//        return [stringlend compare:string2end];
//    }];
//
//    // ===
//    UIView *v = [[UIView alloc]init];
//    CGPoint p = [v center];
//    CGPoint pOrig = p;
//    p.x += 100 ;
//    void (^anim) (void) = ^ {
//        [v setCenter: p];
//    };
//    void (^after) (BOOL) = ^(BOOL f) {
//        [v setCenter: pOrig];
//    };
//    NSUInteger opts = UIViewAnimationOptionAutoreverse;
//    [UIView animateWithDuration:1 delay: 0 options:opts animations:anim completion:after];
//
//    CGPoint р;
//    void (^aBlосk) (void) = ^{
//        p = CGPointMake(1, 2); //Ошибка
//    };
//
//    NSDictionary *dict = [[NSDictionary alloc] init];
//    NSString *str = @"Str";
//    [dict setValue:str forKey:str];
//    NSLog(@"%@", dict);
//    Foo * foo = [[Foo alloc] init];
//    [foo performSelector:<#(nonnull SEL)#> withObject:<#(nullable id)#> afterDelay:<#(NSTimeInterval)#>]
    
    self.str1 = @"Dude";
    self.str2 = self.str1;
    self.str1 = nil;
    self.str2 = nil;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@", self.str2);
    });
    
}


@end
