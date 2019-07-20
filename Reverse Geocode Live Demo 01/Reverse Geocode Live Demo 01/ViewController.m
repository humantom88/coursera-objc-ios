//
//  ViewController.m
//  Reverse Geocode Live Demo 01
//
//  Created by Tom Belov on 22/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

@import CoreLocation;
@import MapKit;
#import "ViewController.h"

@interface ViewController () <MKMapViewDelegate>

@property (strong, nonatomic) CLGeocoder *geocoder;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *mapLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pinIcon;
@property (assign, nonatomic) BOOL lookUp;

@end

@implementation ViewController

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self executeReverseGeocodeCall];
}

- (void)executeReverseGeocodeCall {
    if (self.lookUp == NO) {
        self.lookUp = YES;
        CLLocationCoordinate2D coord = [self locationAtTheCenterOfMapView];
        CLLocation *loc = [[CLLocation alloc]initWithLatitude:coord.latitude longitude:coord.longitude];
        [self startReverseGeocodeLocation: loc];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.geocoder = [CLGeocoder new];
    self.mapLabel.text = nil;
    self.mapLabel.alpha = 0.5;
    self.lookUp = NO;
}

- (CLLocationCoordinate2D)locationAtTheCenterOfMapView {
    CGPoint centerOfPin = CGPointMake(
                                      CGRectGetMinX(self.pinIcon.bounds), CGRectGetMinY(self.pinIcon.bounds)
                                      );
    return [self.mapView convertPoint:centerOfPin toCoordinateFromView:self.pinIcon];
}

- (void)startReverseGeocodeLocation:(CLLocation *)location {
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"There was a problem." message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:ac animated:YES completion:nil];
            return;
        }
        
        NSMutableSet *mappedPlaceDescriptions = [NSMutableSet new];
        
        for (CLPlacemark *p in placemarks) {
            if (p.name != nil)
                [mappedPlaceDescriptions addObject:p.name];
            if (p.administrativeArea != nil)
                [mappedPlaceDescriptions addObject:p.administrativeArea];
            if (p.country != nil)
                [mappedPlaceDescriptions addObject:p.country];
            [mappedPlaceDescriptions addObjectsFromArray:p.areasOfInterest];
        }
        
        self.mapLabel.text = [[mappedPlaceDescriptions allObjects] componentsJoinedByString:@"\n"];
        self.mapLabel.alpha = 1.0;
        self.lookUp = NO;
    }];
}

@end
