//
//  JSViewController.m
//  CoreLocationDidUpdateToLocationBug
//
//  Created by Jonathan Sibley on 2/7/13.
//  Copyright (c) 2013 Jonathan SIbley. All rights reserved.
//

#import "JSViewController.h"

@interface JSViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation JSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 10000.0; // 10 km
    self.locationManager.delegate = self;
    self.locationManager.purpose = @"To show you nearby hotels.";
    [self.locationManager startUpdatingLocation];
    
    [self.locationManager startUpdatingLocation];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"New location: %@", newLocation);
    NSLog(@"Old location: %@", newLocation);
    NSLog(@"- [CLLocationManager location]: %@", manager.location);
}

#pragma mark - Notifications

- (void)appWillEnterForeground:(NSNotification *)notification
{
    [self.locationManager startUpdatingLocation];
}

- (void)appDidEnterBackground:(NSNotification *)notification
{
    [self.locationManager stopUpdatingLocation];
}

@end
