//
//  ViewController.m
//  SocialShare
//
//  Created by Tom Belov on 07/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (void) showAlertMessage:(NSString *)myMessage;
- (NSString *) getInitialText;
- (void) checkFirstResponder;

@end

@implementation ViewController

- (void) showAlertMessage:(NSString *)myMessage {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Social Share" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (NSString *) getInitialText {
    return [self.textView.text length] < 140
        ? self.textView.text
        : [self.textView.text substringToIndex:140];
}

- (void) checkFirstResponder {
    if (![self.textView isFirstResponder]) {
        [self.textView resignFirstResponder];
    }
}

- (IBAction)twitterButtonTapped:(id)sender {
    [self checkFirstResponder];
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *twitterController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [twitterController setInitialText:[self getInitialText]];

        [self presentViewController:twitterController animated:YES completion:nil];
    } else {
        [self showAlertMessage:@"You are not signed to twitter"];
    }
}
- (IBAction)facebookButtonTapped:(id)sender {
    [self checkFirstResponder];
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *facebookController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebookController setInitialText:[self getInitialText]];
        
        [self presentViewController:facebookController animated:YES completion:nil];
    } else {
        // Raise error
        [self showAlertMessage:@"You are not signed in to facebook"];
    }
}
- (IBAction)moreButtonTapped:(id)sender {
    [self checkFirstResponder];
    UIActivityViewController *moreController = [[UIActivityViewController alloc]
                                                initWithActivityItems:@[self.textView.text]
                                                applicationActivities:nil];
    [self presentViewController:moreController animated:YES completion:nil];
}
- (IBAction)popupButtonTapped:(id)sender {
    [self showAlertMessage:@"Popup works"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


@end
