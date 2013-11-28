 //
//  RootNavC.m
//  Bicyclette
//
//  Created by Nicolas Bouilleaud on 29/09/12.
//  Copyright (c) 2012 Nicolas Bouilleaud. All rights reserved.
//

#import "RootVC.h"
#import "MapVC.h"
#import "PrefsVC.h"
#import "BicycletteCity.h"
#import "CitiesController.h"
#import "UIApplication+LocalAlerts.h"

@interface RootVC () <UINavigationControllerDelegate>
@end

#pragma mark -

@implementation RootVC
{
    MapVC * _mapVC;
    PrefsVC * _prefsVC;
}

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notifyCanRequestLocation) name:UIApplicationDidFinishLaunchingNotification
                                                   object:nil];

        _mapVC = [MapVC new];
        _prefsVC = [PrefsVC prefsVC];
        
        self.delegate = self;
        
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
#pragma mark UINavigationControllerDelegate

- (void) showPrefsVC
{
    [self pushViewController:_prefsVC animated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(viewController==_mapVC) {
        [self setNavigationBarHidden:YES animated:YES];
    } else {
        [self setNavigationBarHidden:NO animated:YES];
    }
}


/****************************************************************************/
#pragma mark -

- (void) setCitiesController:(CitiesController *)citiesController
{
    _citiesController = citiesController;
    _mapVC.controller = self.citiesController;
    citiesController.delegate = _mapVC;
    _prefsVC.controller = self.citiesController;
}

@end
