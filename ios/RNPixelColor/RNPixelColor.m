#import "RNPixelColor.h"
#import <React/RCTImageLoader.h>

@implementation RNPixelColor

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(init:(NSString *)path callback:(RCTResponseSenderBlock)callback) {
    [[_bridge moduleForClass:[RCTImageLoader class]] loadImageWithURLRequest:[RCTConvert NSURLRequest:path] callback:^(NSError *error, UIImage *image) {
        if (error || image == nil) { // if couldn't load from bridge create a new UIImage
            if ([path hasPrefix:@"data:"] || [path hasPrefix:@"file:"]) {
                NSURL *imageUrl = [[NSURL alloc] initWithString:path];
                image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
            } else {
                image = [[UIImage alloc] initWithContentsOfFile:path];
            }

            if (image == nil) {
                callback(@[@"Could not create image from given path.", @""]);
                return;
            }
        }

        // First get the image into your data buffer
        CGImageRef imageRef = [image CGImage];
        NSUInteger width = CGImageGetWidth(imageRef);
        NSUInteger height = CGImageGetHeight(imageRef);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
        NSUInteger bytesPerPixel = 4;
        NSUInteger bytesPerRow = bytesPerPixel * width;
        NSUInteger bitsPerComponent = 8;
        CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                        bitsPerComponent, bytesPerRow, colorSpace,
                        kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
        CGColorSpaceRelease(colorSpace);
        CGContextSetBlendMode(context, kCGBlendModeCopy);

        CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
        CGContextRelease(context);

        self.bytesPerPixel = bytesPerPixel;
        self.bytesPerRow = bytesPerRow;
        self.rawData = rawData;

        callback(@[[NSNull null], @true]);
    }];
}

RCT_EXPORT_METHOD(getRGB:(NSInteger)x andY:(NSInteger)y callback:(RCTResponseSenderBlock)callback) {
   if (self.rawData == nil) {
       callback(@[@"Image is not set. Please use method init method before", @""]);
       return;
    }
    NSUInteger byteIndex = (self.bytesPerRow * y) + (x * self.bytesPerPixel);
    int red   = self.rawData[byteIndex];
    int green = self.rawData[byteIndex + 1];
    int blue  = self.rawData[byteIndex + 2];

    NSArray *color = @[@(red), @(green), @(blue)];

    callback(@[[NSNull null], color]);
}

@end
