//
//  PrefsVC.h
//  Bicyclette
//
//  Created by Nicolas Bouilleaud on 14/07/12.
//  Copyright (c) 2012 Nicolas Bouilleaud. All rights reserved.
//

@class CitiesController;
@interface PrefsVC : UITableViewController
+ (instancetype) prefsVC;

@property (nonatomic) CitiesController * controller;
@end
