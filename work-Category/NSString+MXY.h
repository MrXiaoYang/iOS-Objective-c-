//
//  NSString+MXY.h

//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (MXY)

@property (nonatomic, readonly) NSURL *yx_URL;

@property (nonatomic, readonly) NSURL *yx_fileURL;

@property (nonatomic, readonly) UIImage *yx_image;

@property (nonatomic, readonly) UIImageView *yx_imageView;

- (UIColor *) stringTOColor:(NSString *)str;

/** 生成二维码图片 */
- (UIImage *)imageForQRCode:(CGFloat)width;

-(BOOL)isChinese;

-(BOOL)isBlank;
-(BOOL)isValid;
- (NSString *)removeWhiteSpacesFromString;


- (NSUInteger)countNumberOfWords;
- (BOOL)containsString:(NSString *)subString;
- (BOOL)isBeginsWith:(NSString *)string;
- (BOOL)isEndssWith:(NSString *)string;

- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar;
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;
- (NSString *)addString:(NSString *)string;
- (NSString *)removeSubString:(NSString *)subString;

- (BOOL)containsOnlyLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)containsOnlyNumbersAndLetters;
- (BOOL)isInThisarray:(NSArray*)array;

+ (NSString *)getStringFromArray:(NSArray *)array;
- (NSArray *)getArray;

+ (NSString *)getMyApplicationVersion;
+ (NSString *)getMyApplicationName;

- (NSData *)convertToData;
+ (NSString *)getStringFromData:(NSData *)data;

- (BOOL)isValidEmail;
- (BOOL)isVAlidPhoneNumber;
- (BOOL)isValidUrl;
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
