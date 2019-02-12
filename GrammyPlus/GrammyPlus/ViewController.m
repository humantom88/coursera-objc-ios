//
//  ViewController.m
//  GrammyPlus
//
//  Created by Tom Belov on 07/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"
#import "NXOAuth2.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
- (IBAction)refreshButtonTapped:(id)sender {
    NSArray *instagramAccounts = [[NXOAuth2AccountStore sharedStore] accountsWithAccountType:@"Instagram"];
    if ([instagramAccounts count] == 0) {
        NSLog(@"Warning: %ld Instagram accounts logged in", (long)[instagramAccounts count]);
        return;
    }
    
    NXOAuth2Account *account = instagramAccounts[0];
    NSString *token = account.accessToken.accessToken;
    NSString *urlString = [@"https://api.instagram.com/v1/users/self/feed?access_token=" stringByAppendingString:token];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error) {
            NSLog(@"Error: Couldn't finish request: %@", error);
            return;
        }
        
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *) response;
        if(httpResp.statusCode < 200 || httpResp.statusCode >= 300) {
            NSLog(@"Error. Got status code %ld", (long) httpResp.statusCode);
            return;
        }
        
        NSError *parseError;
        id pkg = [NSJSONSerialization JSONObjectWithData:data options:0 error: &parseError];
        if (!pkg) {
            NSLog(@"Error: Couldn't parse response %@", parseError);
            return;
        }
        
        NSString *imageURLStr = pkg[@"data"][0][@"images"][@"standard_resolution"][@"url"];
        NSURL *url = [NSURL URLWithString:imageURLStr];
        
        [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(error) {
                NSLog(@"Error: Couldn't finish request: %@", error);
                return;
            }
            
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *) response;
            if(httpResp.statusCode < 200 || httpResp.statusCode >= 300) {
                NSLog(@"Error. Got status code %ld", (long) httpResp.statusCode);
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = [UIImage imageWithData:data];
            });
            
        }]resume];
        
    }]resume];
    
}
- (IBAction)loginButtonTapped:(id)sender {
    [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:@"Instagram"];
    self.logoutButton.enabled = true;
    self.refreshButton.enabled = true;
    self.loginButton.enabled = false;
}
- (IBAction)logoutButtonTapped:(id)sender {
    self.logoutButton.enabled = false;
    self.refreshButton.enabled = false;
    self.loginButton.enabled = true;
    NXOAuth2AccountStore *store = [NXOAuth2AccountStore sharedStore];
    
    NSArray *instagramAccounts = [store accountsWithAccountType:@"Instagram"];
    
    for (id acc in instagramAccounts) {
        [store removeAccount:acc];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logoutButton.enabled = false;
    self.refreshButton.enabled = false;
}


@end
