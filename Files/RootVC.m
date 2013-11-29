 //
//  RootNavC.m
//  Bicyclette
//
//  Created by Nicolas Bouilleaud on 29/09/12.
//  Copyright (c) 2012 Nicolas Bouilleaud. All rights reserved.
//

#import "RootVC.h"
#import "MapVC.h"
#import "BicycletteCity.h"
#import "CitiesController.h"
#import "UIApplication+LocalAlerts.h"

@interface RootVC ()
@end

#pragma mark -

@implementation RootVC
{
    MapVC * _mapVC;
}

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notifyCanRequestLocation) name:UIApplicationDidFinishLaunchingNotification
                                                   object:nil];

        _mapVC = [MapVC new];
        self.viewControllers = @[_mapVC];
    }
    return self;
}

- (void) notifyCanRequestLocation
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BicycletteCityNotifications.canRequestLocation object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/****************************************************************************/
#pragma mark -

- (void) setCitiesController:(CitiesController *)citiesController
{
    _citiesController = citiesController;
    _mapVC.controller = self.citiesController;
    citiesController.delegate = _mapVC;
}

@end
