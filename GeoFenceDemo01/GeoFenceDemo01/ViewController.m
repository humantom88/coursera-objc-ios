//
//  ViewController.m
//  GeoFenceDemo01
//
//  Created by Tom Belov on 13/07/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"
#import "MapKit/MapKit.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISwitch *uiSwitch;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *checkSwitchButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (assign, nonatomic) BOOL mapIsMoving;

@property (strong, nonatomic) MKPointAnnotation *currentAnnotation;

@property (strong, nonatomic) CLCircularRegion *geoRegion;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.uiSwitch.enabled = NO;
    self.checkSwitchButton.enabled = NO;
    
    self.eventLabel.text = @"";
    self.statusLabel.text = @"";
    
    self.mapIsMoving = NO;
    
    self.mapView.delegate = self;
    
    // Set up location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.allowsBackgroundLocationUpdates = YES;
    self.locationManager.pausesLocationUpdatesAutomatically = YES;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 3;
    
    // Zoom the map very close
    CLLocationCoordinate2D noLocation = [[self.locationManager location] coordinate];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 500, 500);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];
    
    // Create annotations
    [self addCurrentAnnotation];
    
    // Set up a geoRegion object
    [self setUpGeoRegion];
    
    if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]] == YES)
    {
        if (([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) || ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
            self.uiSwitch.enabled = YES;
        }
        else {
            [self.locationManager requestAlwaysAuthorization];
        }
        
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        self.statusLabel.text = @"GeoRegions not supported";
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    CLAuthorizationStatus currentStatus = [CLLocationManager authorizationStatus];
    if (currentStatus == kCLAuthorizationStatusAuthorizedWhenInUse ||
        currentStatus == kCLAuthorizationStatusAuthorizedAlways )
    {
        self.uiSwitch.enabled = YES;
    }
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    self.mapIsMoving = YES;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    self.mapIsMoving = NO;
}

- (void)setUpGeoRegion {
    // Create the geographic region to be monitored
    self.geoRegion = [[CLCircularRegion alloc]
                      initWithCenter:CLLocationCoordinate2DMake(34.448968, -119.663951)
                      radius:10
                      identifier:@"MyRegionIdentifier"];
}

- (IBAction)switchTapped:(id)sender {
    if (self.uiSwitch.isOn) {
        self.mapView.showsUserLocation = YES;
        [self.locationManager startUpdatingLocation];
        [self.locationManager startMonitoringForRegion:self.geoRegion];
        self.checkSwitchButton.enabled = YES;
    } else {
        self.checkSwitchButton.enabled = NO;
        [self.locationManager stopMonitoringForRegion:self.geoRegion];
        [self.locationManager stopUpdatingLocation];
        self.mapView.showsUserLocation = NO;
    }
}

- (IBAction)checkStatusTapped:(id)sender {
    [self.locationManager requestStateForRegion:self.geoRegion];
}

- (void)addCurrentAnnotation {
    self.currentAnnotation = [[MKPointAnnotation alloc] init];
    self.currentAnnotation.coordinate = CLLocationCoordinate2DMake(0.0, 0.0);
    self.currentAnnotation.title = @"My location";
}

- (void)centerMap:(MKPointAnnotation *)annotation {
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
}

- (void)scheduleGeoFenceNotificationWithBody:(NSString *)bodyString
{
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.fireDate = nil;
    note.repeatInterval = 0;
    note.alertTitle = @"GeoFence Alert!";
    note.alertBody = bodyString;
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}

#pragma mark - geoFence callbacks

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    if (state == CLRegionStateUnknown) {
        self.statusLabel.text = @"Unknown";
    } else if (state == CLRegionStateInside) {
        self.statusLabel.text = @"Inside";
    } else if (state == CLRegionStateOutside) {
        self.statusLabel.text = @"Outside";
    } else {
        self.statusLabel.text = @"Mystery";
    }
}


#pragma mark - CLLocationManagerDelegate conformance

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    self.currentAnnotation.coordinate = locations.lastObject.coordinate;
    if(!self.mapIsMoving) {
        [self centerMap:self.currentAnnotation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    [self scheduleGeoFenceNotificationWithBody:@"You've entered the geofence"];
    self.eventLabel.text = @"Entered";
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    [self scheduleGeoFenceNotificationWithBody:@"You've left the geofence"];
    self.eventLabel.text = @"Exited";
}

@end
