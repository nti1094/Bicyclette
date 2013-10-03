//
//  CityOverlayRenderer.m
//  Bicyclette
//
//  Created by Nicolas on 03/10/13.
//  Copyright (c) 2013 Nicolas Bouilleaud. All rights reserved.
//

#import "CityOverlayRenderer.h"
#import "BicycletteCity.h"
#import "Station.h"
#import "Station+Update.h"
#import "Style.h"

@interface CityOverlayRenderer ()
@property (readonly) BicycletteCity * city;
@end

@implementation CityOverlayRenderer

- (BicycletteCity *)city
{
    return (BicycletteCity *)self.overlay;
}

- (BOOL)canDrawMapRect:(MKMapRect)mapRect
             zoomScale:(MKZoomScale)zoomScale
{
    return YES;
}

- (void)drawMapRect:(MKMapRect)mapRect
          zoomScale:(MKZoomScale)zoomScale
          inContext:(CGContextRef)context
{
    CGFloat roadWidth = MKRoadWidthAtZoomScale(zoomScale);
    
    NSArray * stations = [self.city stationsWithinRegion:MKCoordinateRegionForMapRect(mapRect)];
    for (Station * station in stations) {
        CGPoint point = [self pointForMapPoint:MKMapPointForCoordinate(station.coordinate)];
        
        UIColor * color;
        if(station.statusDataIsFresh && station.openValue) {
            int16_t value;
//            if(self.mode==StationAnnotationModeBikes)
                value = station.status_availableValue;
//            else
//                value = [self station].status_freeValue;
            
            if(value==0) color = kCriticalValueColor;
            else if(value<4) color = kWarningValueColor;
            else color = kGoodValueColor;
        } else {
            color = kUnknownValueColor;
        }
        CGContextSetFillColorWithColor(context, color.CGColor);
        
        CGContextFillEllipseInRect(context, CGRectIntegral(CGRectMake(point.x-roadWidth/2, point.y-roadWidth/2, point.x+roadWidth/2, point.y+roadWidth/2)));
    }
    
    
    
}

@end
