//
//  RootNavC.h
//  Bicyclette
//
//  Created by Nicolas Bouilleaud on 29/09/12.
//  Copyright (c) 2012 Nicolas Bouilleaud. All rights reserved.
//

#import "FanContainerViewController.h"
#import "HelpVC.h"

@class Station;
@class CitiesController;

@interface RootVC : FanContainerViewController  <HelpVCDelegate>

// Make outlets public, because they are set in MainWindow.nib
@property IBOutlet HelpVC *helpVC;
@property IBOutlet UIToolbar *infoToolbar;
@property IBOutlet UIButton *infoButton;

@property (nonatomic) CitiesController * citiesController;

- (IBAction)showHelp; // Sent to the first responder from a Pref button

@end
