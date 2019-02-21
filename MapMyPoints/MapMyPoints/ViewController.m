//
//  ViewController.m
//  MapMyPoints
//
//  Created by Tom Belov on 20/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "Mapkit/Mapkit.h"
#import "ViewController.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) MKPointAnnotation *luciAnnotation;
@property (strong, nonatomic) MKPointAnnotation *wiclAnnotation;
@property (strong, nonatomic) MKPointAnnotation *gradientAnnotation;
@property (strong, nonatomic) MKPointAnnotation *currentAnnotation;
@property (weak, nonatomic) IBOutlet UISwitch *switchField;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL mapIsMoving;

@end

@implementation ViewController
- (IBAction)luciTapped:(id)sender {
    [self centerMap:self.luciAnnotation];
}
- (IBAction)wiclTApped:(id)sender {
    [self centerMap:self.wiclAnnotation];
}
- (IBAction)gradientTapped:(id)sender {
    [self centerMap:self.gradientAnnotation];
}
- (IBAction)switchChanged:(id)sender {
    if(self.switchField.isOn) {
        self.mapView.showsUserLocation = YES;
        [self.locationManager startUpdatingLocation];
    } else {
        self.mapView.showsUserLocation = NO;
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    self.currentAnnotation.coordinate = locations.lastObject.coordinate;
    if(self.mapIsMoving == NO) {
        [self centerMap:self.currentAnnotation];
    }
}

- (void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    self.mapIsMoving = YES;
}

- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    self.mapIsMoving = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.switchField setOn:NO];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.mapIsMoving = NO;
    [self addAnnotations];
}

- (void) centerMap:(MKPointAnnotation *)centerPoint {
    [self.mapView setCenterCoordinate:centerPoint.coordinate animated:YES];
}

- (void) addAnnotations
{
    self.luciAnnotation = [[MKPointAnnotation alloc] init];
    self.luciAnnotation.coordinate = CLLocationCoordinate2DMake(33.6432094, -117.8439953);
    self.luciAnnotation.title = @"Laboratory for Ubiquitous Computing and Interaction";
    
    self.wiclAnnotation = [[MKPointAnnotation alloc] init];
    self.wiclAnnotation.coordinate = CLLocationCoordinate2DMake(34.448795, -119.6646337);
    self.wiclAnnotation.title = @"Westmont Inspired Computing Lab";
    
    self.gradientAnnotation = [[MKPointAnnotation alloc] init];
    self.gradientAnnotation.coordinate = CLLocationCoordinate2DMake(40.677623, -77.993583);
    self.gradientAnnotation.title = @"Gradient Computing Lab";
    
    self.currentAnnotation = [[MKPointAnnotation alloc] init];
    self.currentAnnotation.coordinate = CLLocationCoordinate2DMake(0.0, 0.0);
    self.currentAnnotation.title = @"My location";
    
    
    [self.mapView addAnnotations:@[self.luciAnnotation, self.wiclAnnotation, self.gradientAnnotation]];
    
    [self centerMap:self.luciAnnotation];
}


@end
