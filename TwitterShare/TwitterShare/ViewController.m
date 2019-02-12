//
//  ViewController.m
//  TwitterShare
//
//  Created by Tom Belov on 07/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

- (void) configureTweetTextView;
- (void) showAlertMessage:(NSString *)myMessage;

@end

@implementation ViewController

- (void) showAlertMessage:(NSString *)myMessage {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Social Share" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)showShareTapped:(id)sender {
    [self configureTweetTextView];
    
    if (![self.tweetTextView isFirstResponder]) {
        [self.tweetTextView resignFirstResponder];
    }
    
    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"Share" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *tweetAction = [UIAlertAction actionWithTitle:@"Tweet" style:UIAlertActionStyleDefault handler:
                                  ^(UIAlertAction *action) {
                                      if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                                          
                                          SLComposeViewController *twitterViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                                          
                                          // Tweet out a tweet
                                          if([self.tweetTextView.text length] < 140) {
                                              [twitterViewController setInitialText:self.tweetTextView.text];
                                          } else {
                                              NSString *shortText = [self.tweetTextView.text substringToIndex:140];
                                              [twitterViewController setInitialText:shortText];
                                          }
                                          
                                          [self presentViewController:twitterViewController animated:YES completion:nil];
                                      } else {
                                          // Raise error
                                          [self showAlertMessage:@"You are not signed in to twitter"];
                                      }
                                  }];
    UIAlertAction *facebookAction = [UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewController *facebookViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [facebookViewController setInitialText:self.tweetTextView.text];
            [self presentViewController:facebookViewController animated:YES completion:nil];
        } else {
            [self showAlertMessage:@"Please sign in to Facebook"];
        }
    }];
    
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"More" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIActivityViewController *moreViewController = [[UIActivityViewController alloc]
                                                        initWithActivityItems:@[self.tweetTextView.text]
                                                        applicationActivities:nil];
        [self presentViewController:moreViewController animated:YES completion:nil];
    }];
    
    [actionController addAction:moreAction];
    [actionController addAction:facebookAction];
    [actionController addAction:tweetAction];
    [actionController addAction:alertAction];
    
    [self presentViewController:actionController animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTweetTextView];
}

- (void) configureTweetTextView {
    self.tweetTextView.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;
    self.tweetTextView.layer.cornerRadius = 10.0;
    self.tweetTextView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.tweetTextView.layer.borderWidth = 2.0;
}

@end
