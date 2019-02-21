//
//  ViewController.m
//  ConstraintLayouts
//
//  Created by Tom Belov on 18/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize the webView
    NSString *webURL = @"https://www.facebook.com/westmontinspiredcomputinglab";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:webURL]];
    [self.webView loadRequest:request];
    
    // Center the map
    double latitude = 34.448795;
    double longitude = -119.6646337;
    
    MKPointAnnotation *wiclAnno = [[MKPointAnnotation alloc] init];
    wiclAnno.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    wiclAnno.title = @"Westmont Inspired Computing Lab";
    
    [self.mapView addAnnotation:wiclAnno];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(wiclAnno.coordinate, 10000, 10000);
    MKCoordinateRegion adjusted = [self.mapView regionThatFits:region];
    [self.mapView setRegion:adjusted animated:YES];
}


@end
