//
//  ViewController.m
//  KeyboardDemo
//
//  Created by Tom Belov on 20/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(moveKeyboardInResposeToWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(moveKeyboardInResposeToWillHideNotification:) name:UIKeyboardWillShowNotification object:nil];
    
}
- (IBAction)resignTapped:(id)sender {
    [self.textField resignFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)moveKeyboardInResposeToWillHideNotification:(NSNotification *) notification {
    NSDictionary *info = [notification userInfo];
    CGRect kbRect;
    kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    // CGFloat duration
    
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    UIViewAnimationCurve curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [self.view layoutSubviews];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // Doesn't work self.bottomLayoutGuide.constant = kbRect.size.height;
    
    [self.view layoutSubviews];
    [UIView commitAnimations];
}

- (void)moveKeyboardInResposeToWillShowNotification:(NSNotification *) notification {
    NSDictionary *info = [notification userInfo];
    CGRect kbRect;
    kbRect = CGRectZero;
    // CGFloat duration
    
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    UIViewAnimationCurve curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [self.view layoutSubviews];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // Doesn't work self.bottomLayoutGuide.constant = kbRect.size.height;
    
    [self.view layoutSubviews];
    [UIView commitAnimations];
}

@end
