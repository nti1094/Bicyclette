//
//  MapVC.h
//  Bicyclette
//
//  Created by Nicolas on 04/12/10.
//  Copyright 2010 Nicolas Bouilleaud. All rights reserved.
//

@class VelibModel;

@interface MapVC : UIViewController 
@property (strong) VelibModel * model;

// Hook for faster animation
- (void) setAnnotationsHidden:(BOOL)hidden;
@end
