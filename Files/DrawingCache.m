//
//  DrawingCache.m
//  Bicyclette
//
//  Created by Nicolas Bouilleaud on 24/06/12.
//  Copyright (c) 2012 Nicolas Bouilleaud. All rights reserved.
//

#import "DrawingCache.h"
#import "Style.h"

#import "UIColor+hsb.h"

@implementation DrawingCache
{
    NSCache * _cache;
}

- (id)init
{
    self = [super init];
    if (self) {
        _cache = [NSCache new];
    }
    return self;
}

- (CGImageRef)sharedImageWithSize:(CGSize)size
                            scale:(CGFloat)scale
                            shape:(BackgroundShape)shape
                  backgroundColor:(UIColor*)backgroundColor
                      borderColor:(UIColor*)borderColor
                            value:(NSString*)text
{
    NSParameterAssert(backgroundColor);
    NSParameterAssert(borderColor);
    NSParameterAssert([NSThread currentThread]==[NSThread mainThread]);
    
    NSString * key = [NSString stringWithFormat:@"image%d_%d_%f_%d_%@_%@_%@",
                      (int)size.width, (int)size.height, (float)scale, (int)shape,
                      [backgroundColor hsbString], [borderColor hsbString],
                      text];
    
    CGImageRef result = (__bridge CGImageRef)[_cache objectForKey:key];
    if(result) {
        return result;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef c = CGBitmapContextCreate(NULL, size.width*scale, size.height*scale, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    
    CGContextTranslateCTM(c, 0, size.height*scale);
    CGContextScaleCTM(c, 1.0, -1.0);
    
    CGContextScaleCTM(c, scale, scale);
    
    CGRect rect = (CGRect){CGPointZero, size};
    
    // Draw background
    CGContextSaveGState(c);
    
    CGFloat clipMargin = 2.5/scale;
    CGPathRef backgroundPath = [self newPathWithShape:shape inRect:CGRectInset(rect, clipMargin, clipMargin)];
    CGContextAddPath(c, backgroundPath);
    CGContextClip(c);
    CGPathRelease(backgroundPath);
    CGContextSetFillColorWithColor(c, backgroundColor.CGColor);
    CGContextFillRect(c, rect);
    
    CGContextRestoreGState(c);
    
    // Draw border
    CGContextSaveGState(c);
    
    CGContextSetLineWidth(c, 3/scale);
    CGContextSetStrokeColorWithColor(c, borderColor.CGColor);
    CGPathRef borderPath = [self newPathWithShape:shape inRect:CGRectInset(rect, clipMargin, clipMargin)];
    CGContextAddPath(c, borderPath);
    CGContextStrokePath(c);
    CGPathRelease(borderPath);
    
    CGContextRestoreGState(c);
    
    
    UIGraphicsPushContext(c); // Make c the current UIKit drawing context
    // Draw text
    if([text length])
    {
        NSDictionary * attributes = @{NSFontAttributeName:kAnnotationValueFont, NSForegroundColorAttributeName:kAnnotationFrame1Color};
        CGSize textSize = [text sizeWithAttributes:attributes];
        CGPoint point = CGPointMake(CGRectGetMidX(rect)-textSize.width/2, CGRectGetMidY(rect)-textSize.height/2);
        [text drawAtPoint:point withAttributes:attributes];
    }
    UIGraphicsPopContext();
    
    
    CGImageRef image = CGBitmapContextCreateImage(c);
    [_cache setObject:CFBridgingRelease(image) forKey:key];
    CGContextRelease(c);

    return image;
}

// Create a path
- (CGPathRef) newPathWithShape:(BackgroundShape)shape inRect:(CGRect)rect
{
	CGPathRef path;
    switch (shape) {
        case BackgroundShapeRoundedRect: path = [self newPath:rect cornerRadius:4]; break;
        case BackgroundShapeOval: path = CGPathCreateWithEllipseInRect(rect, &CGAffineTransformIdentity); break;
    }
    return path;
}

// Create a path for a rect with rounded corners
- (CGPathRef) newPath:(CGRect)rect cornerRadius:(CGFloat)cornerRadius
{
    CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, minx, midy);
    
    CGPathAddArcToPoint(path, NULL, minx, miny, midx, miny, cornerRadius);
    CGPathAddArcToPoint(path, NULL, maxx, miny, maxx, midy, cornerRadius);
    CGPathAddArcToPoint(path, NULL, maxx, maxy, midx, maxy, cornerRadius);
    CGPathAddArcToPoint(path, NULL, minx, maxy, minx, midy, cornerRadius);
    
    CGPathCloseSubpath(path);
    
    return path;
}

@end
