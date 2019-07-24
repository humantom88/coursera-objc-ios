//
//  ViewController.m
//  Geo Fence Peer Review
//
//  Created by Tom Belov on 21/07/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"
#import "MapKit/MapKit.h"
#import "UserNotifications/UserNotifications.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (assign, nonatomic) BOOL isLocationManagerAuthorized;
@property (assign, nonatomic) BOOL mapIsMoving;

@property (strong, nonatomic) MKPointAnnotation *currentAnnotation;
@property (strong, nonatomic) MKPointAnnotation *businessAnnotation;

@property (strong, nonatomic) CLCircularRegion *geoRegion;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [self addBusinessAnnotation];
    
    // Set up a geoRegion object
    [self setUpBusinessRegion];
    
    if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]] == YES)
    {
        if (([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) || ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
            self.isLocationManagerAuthorized = YES;
        }
        else {
            [self.locationManager requestAlwaysAuthorization];
        }
        
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        NSLog(@"GeoRegions not supported");
    }
}

- (void)turnOnTheRegion {
    self.mapView.showsUserLocation = YES;
    [self.locationManager startUpdatingLocation];
    [self.locationManager startMonitoringForRegion:self.geoRegion];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    CLAuthorizationStatus currentStatus = [CLLocationManager authorizationStatus];
    if (currentStatus == kCLAuthorizationStatusAuthorizedWhenInUse ||
        currentStatus == kCLAuthorizationStatusAuthorizedAlways )
    {
        self.isLocationManagerAuthorized = YES;
        [self turnOnTheRegion];
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

- (void)setUpBusinessRegion {
    // Create the geographic region to be monitored
    self.geoRegion = [[CLCircularRegion alloc]
                      initWithCenter:CLLocationCoordinate2DMake(59.197168, 39.859624)
                      radius:10
                      identifier:@"MyCinema"];
}

- (void)addBusinessAnnotation {
    self.businessAnnotation = [[MKPointAnnotation alloc] init];
    self.businessAnnotation.coordinate = CLLocationCoordinate2DMake(59.197168, 39.859624);
    self.businessAnnotation.title = @"Cinema Park";
    [self.mapView addAnnotations:@[self.businessAnnotation]];
}

- (void)addCurrentAnnotation {
    self.currentAnnotation = [[MKPointAnnotation alloc] init];
    self.currentAnnotation.coordinate = CLLocationCoordinate2DMake(0.0, 0.0);
    self.currentAnnotation.title = @"My location";
}

- (void)centerMap:(MKPointAnnotation *)annotation {
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
}

- (void)scheduleGeoFenceNotificationWithBody:(NSString *)bodyString {
    UILocalNotification *note = [[UILocalNotification alloc] init];

    note.fireDate = nil;
    note.repeatInterval = 0;
    note.alertTitle = @"GeoFence Alert!";
    note.alertBody = bodyString;
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:note];
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
    [self scheduleGeoFenceNotificationWithBody:@"10%% discount for movie. Movie starts in 10 minutes. Coupon code: ZXC1ASD2QWE."];
}

@end
