#import <React/RCTBridgeModule.h>

@interface RNPixelColor : NSObject <RCTBridgeModule>
@property NSUInteger bytesPerPixel;
@property NSUInteger bytesPerRow;
@property unsigned char *rawData;

@end
