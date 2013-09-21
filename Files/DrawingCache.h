//
//  DrawingCache.h
//  Bicyclette
//
//  Created by Nicolas Bouilleaud on 24/06/12.
//  Copyright (c) 2012 Nicolas Bouilleaud. All rights reserved.
//

#import "Style.h"

// A common "Drawing" facility to reuse identical images.
@interface DrawingCache : NSObject

// Shape
typedef enum{
    BackgroundShapeRoundedRect,
    BackgroundShapeOval,
}BackgroundShape;

// returns an image drawn with the given params.
// if the method is called again with the identical values, the same object is returned.
- (CGImageRef)sharedImageWithSize:(CGSize)size
                            scale:(CGFloat)scale
                            shape:(BackgroundShape)shape
                  backgroundColor:(UIColor*)backgroundColor
                      borderColor:(UIColor*)borderColor
                            value:(NSString*)text;
@end
