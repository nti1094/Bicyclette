//
//  UIViewController+Banner.m
//  Bicyclette
//
//  Created by Nicolas on 18/12/12.
//  Copyright (c) 2012 Nicolas Bouilleaud. All rights reserved.
//

#import "UIViewController+Banner.h"
#import "Style.h"

@implementation UIViewController (Banner)

- (void) displayBannerTitle:(NSString*)title subtitle:(NSString*)subtitle sticky:(BOOL)sticky
{
    self.navigationItem.title = title;
    self.navigationItem.prompt = subtitle;

    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissBanner) object:nil];

#if ! SCREENSHOTS
    if(!sticky)
        [self performSelector:@selector(dismissBanner) withObject:nil afterDelay:3];
#endif
}

- (void) dismissBanner
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:_cmd object:nil];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

@end
