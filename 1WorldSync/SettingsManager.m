//
//  SettingsManager.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/27/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "SettingsManager.h"
#import "LookupManager.h"

#define kSettingsApiKey @"OWSSettingsApiKey"
#define kSettingsAppId @"OWSSettingsAppId"
#define kSettingsBaseUrl @"OWSSettingsBaseUrl"
#define kSettingsHardcodedProductId @"OWSSettingsHardcodedProductId"
#define kSettingsLatitudeId @"OWSSettingsLatitudeId"
#define kSettingsLongitudeId @"OWSSettingsLongitudeId"
#define kSettingsOfflineMode @"OWSSettingsOfflineMode"
#define kSettingsLanguage @"OWSSettingsLanguage"
#define kSettingsShowAdditionalMedia @"OWSSettingsShowAdditionalMedia"
#define kSettingsEU1169Mode @"OWSSettingsEU1169Mode"


//Previous bundle preference key
#define kSettingsPreviousLogoUrlKey @"previous_home_logo_url_preference"
#define kSettingsPreviousTagUrlKey @"previous_tag_url_preference"
#define kSettingsPreviousDetailsBrandingUrlKey @"previous_details_branding_url_preference"

//Local documents file path version of the saved image
#define kSettingsLogoCacheUrlKey @"cache_home_logo_url_preference"
#define kSettingsTagCacheUrlKey @"cache_tag_url_preference"
#define kSettingsBrandingDetailsCacheUrlKey @"cache_branding_details_url_preference"

//Settings bundle preference key
#define kSettingsLogoUrlKey @"home_logo_url_preference"
#define kSettingsTagUrlKey @"tag_url_preference"
#define kSettingsWebUrlKey @"web_url_preference"
#define kSettingsDetailsBrandingUrlKey @"details_branding_url_preference"
#define kSettingsDetailsBrandingColorKey @"details_color_preference"

#define kSettingsLogoDefaultUrl @""
#define kSettingsTagDefaultUrl @"http://1worldsync.sms4me.com/images/thought_icon.png"
#define kSettingsWebDefaultUrl @"http://1worldsync.sms4me.com/app/"
#define kSettingsDefaultDetailsBrandingUrl @""
#define kSettingsDefaultBrandingColor @"7ACAF0"

@implementation SettingsManager

+ (void)registerDefaults {
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{kSettingsApiKey : @"",
                                                              kSettingsAppId : @"",
                                                              kSettingsBaseUrl : @"https://marketplace.api.1worldsync.com",
                                                              kSettingsHardcodedProductId : @"",
                                                              kSettingsLatitudeId : @40.025001,
                                                              kSettingsLongitudeId : @-76.205401,
                                                              kSettingsOfflineMode: @NO,
                                                              kSettingsLanguage: [NSNumber numberWithUnsignedInteger:OWSLanguageAll],
                                                              kSettingsShowAdditionalMedia: @NO,
                                                              kSettingsLogoUrlKey: kSettingsLogoDefaultUrl,
                                                              kSettingsWebUrlKey: kSettingsWebDefaultUrl,
                                                              kSettingsEU1169Mode: @NO,
                                                              kSettingsDetailsBrandingUrlKey: kSettingsDefaultDetailsBrandingUrl,
                                                              kSettingsDetailsBrandingColorKey: kSettingsDefaultBrandingColor
                                                              }];
}

+ (NSString *)apiKey {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsApiKey];
}

+ (NSString *)appId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsAppId];
}

+ (NSString *)baseUrl {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsBaseUrl];
}

+ (NSString *)hardcodedProductId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsHardcodedProductId];
}

+ (NSNumber *)latestLatitude {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsLatitudeId];
}

+ (NSNumber *)latestLongitude {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsLongitudeId];
}

+ (BOOL)offlineMode {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingsOfflineMode];
}

+ (BOOL)showAdditionalMedia {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingsShowAdditionalMedia];
}

+ (BOOL)eu1169Mode {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingsEU1169Mode];
}

+ (OWSLanguage)language {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kSettingsLanguage] unsignedIntegerValue];
}

+ (void)setApiKey:(NSString *)apiKey {
    if (apiKey) {
        [[NSUserDefaults standardUserDefaults] setObject:apiKey forKey:kSettingsApiKey];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSettingsApiKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setAppId:(NSString *)appId {
    if (appId) {
        [[NSUserDefaults standardUserDefaults] setObject:appId forKey:kSettingsAppId];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSettingsAppId];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setBaseUrl:(NSString *)baseUrl {
    if (baseUrl) {
        [[NSUserDefaults standardUserDefaults] setObject:baseUrl forKey:kSettingsBaseUrl];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSettingsBaseUrl];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setHardcodedProductId:(NSString *)hardcodedProductId {
    if (hardcodedProductId) {
        [[NSUserDefaults standardUserDefaults] setObject:hardcodedProductId forKey:kSettingsHardcodedProductId];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSettingsHardcodedProductId];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setLatestLocation:(CLLocation *)location {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:kSettingsLatitudeId];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:kSettingsLongitudeId];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setOfflineMode:(BOOL)offlineMode {
    [[NSUserDefaults standardUserDefaults] setBool:offlineMode forKey:kSettingsOfflineMode];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setShowAdditionalMedia:(BOOL)show {
    [[NSUserDefaults standardUserDefaults] setBool:show forKey:kSettingsShowAdditionalMedia];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setEu1169Mode:(BOOL)eu1169ModeOn {
    [[NSUserDefaults standardUserDefaults] setBool:eu1169ModeOn forKey:kSettingsEU1169Mode];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setLanguage:(OWSLanguage)language {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithUnsignedInteger:language] forKey:kSettingsLanguage];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)loadImagesIfNecessary:(void (^)(void))completion {
    BOOL loadUserImages = NO;
    BOOL loadDetailsImage = NO;
    
    NSString *userLogoPath = [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsLogoUrlKey];
    NSString *userTagPath = [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsTagUrlKey];
    NSString *userDetailsBrandingPath = [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsDetailsBrandingUrlKey];
    
    NSString *userLogoPreviousPath = [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsPreviousLogoUrlKey];
    NSString *userTagPreviousPath = [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsPreviousTagUrlKey];
    NSString *userDetailsBrandingPreviousPath = [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsPreviousDetailsBrandingUrlKey];
    
    //if there is a previous path and it's different than the new path, have to reload images. Or if there are no images, try
    //to load them
    if (userLogoPreviousPath && userTagPreviousPath && (![userLogoPreviousPath isEqualToString:userLogoPath] || ![userTagPreviousPath isEqualToString:userTagPath])) {
        loadUserImages = YES;
    } else if (![self logoImage] || ![self tagImage]) {
        loadUserImages = YES;
    }

    //same check but for details image
    if (userDetailsBrandingPreviousPath && ![userDetailsBrandingPreviousPath isEqualToString:userDetailsBrandingPath]) {
        loadDetailsImage = YES;
    } else if (![self detailsBrandingImage]) {
        loadDetailsImage = YES;
    }
    
    //update the current urls to be the previous urls
    [[NSUserDefaults standardUserDefaults] setObject:userLogoPath forKey:kSettingsPreviousLogoUrlKey];
    [[NSUserDefaults standardUserDefaults] setObject:userTagPath forKey:kSettingsPreviousTagUrlKey];
    [[NSUserDefaults standardUserDefaults] setObject:userDetailsBrandingPath forKey:kSettingsPreviousDetailsBrandingUrlKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    if (loadUserImages || loadDetailsImage) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            if (loadUserImages) {
                if (userLogoPath.length) {//if non-empty
                    UIImage *logoImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userLogoPath]]];
                    if (logoImage) {
                        [self setLogoImage:logoImage];
                    }
                }
                
                UIImage *tagImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userTagPath]]];
                if (tagImage) {
                    [self setTagImage:tagImage];
                }
            }
            
            if (loadDetailsImage) {
                UIImage *detailsImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userDetailsBrandingPath]]];
                if (detailsImage) {
                    [self setBrandingDetailsImage:detailsImage];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
               completion();
            });
        });
    } else {
        completion();
    }
}

+ (void)setLogoImage:(UIImage *)image {
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *imagePath = [self documentsPathForFileName:@"logo_image.png"];
    [imageData writeToFile:imagePath atomically:YES];
    [[NSUserDefaults standardUserDefaults] setObject:imagePath forKey:kSettingsLogoCacheUrlKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setTagImage:(UIImage *)image {
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *imagePath = [self documentsPathForFileName:@"tag_image.png"];
    [imageData writeToFile:imagePath atomically:YES];
    [[NSUserDefaults standardUserDefaults] setObject:imagePath forKey:kSettingsTagCacheUrlKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setBrandingDetailsImage:(UIImage *)image {
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *imagePath = [self documentsPathForFileName:@"details_branding_image.png"];
    [imageData writeToFile:imagePath atomically:YES];
    [[NSUserDefaults standardUserDefaults] setObject:imagePath forKey:kSettingsBrandingDetailsCacheUrlKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (UIImage *)logoImage {
    //If there is no logo path set in settings, then just return default based on EU1169 or ITI mode
    NSString *userLogoPath = [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsLogoUrlKey];
    if (!userLogoPath.length) {
        UIImage *image;
        if ([SettingsManager eu1169Mode]) {
            image = [UIImage imageNamed:@"EU1169search"];
        } else {
            image = [UIImage imageNamed:@"ITISearch"];
        }
        return image;
    }
    
    NSString *imagePath = [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsLogoCacheUrlKey];
    if (imagePath) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
        return image;
    } else {
        return nil;
    }
}

+ (UIImage *)tagImage {
    NSString *imagePath = [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsTagCacheUrlKey];
    if (imagePath) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
        return image;
    } else {
        return nil;
    }
}

+ (UIImage *)detailsBrandingImage {
    NSString *imagePath = [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsBrandingDetailsCacheUrlKey];
    if (imagePath) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
        return image;
    } else {
        return nil;
    }
}

+ (UIColor *)detailsBrandingColor {
    NSString *detailsColor = [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsDetailsBrandingColorKey];
    if (detailsColor.length) {
        return [self colorWithHexString:detailsColor];
    }
    return nil;
}

+ (NSString *)documentsPathForFileName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}

+ (NSString *)urlStringForItem:(OWSItem *)item {
    NSString *key = [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsWebUrlKey];
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@_WorldSync.html?productId=%@", key, item.itemId];
    
    //Add in the additional images param, if set to show them
    [url appendString:@"&showAdditionalMedia="];
    if ([self showAdditionalMedia]) {
        [url appendString:@"true"];
    }
    else {
        [url appendString:@"false"];
    }
    
    [url appendFormat:@"&showEU1169Mode="];
    if ([self eu1169Mode]) {
        [url appendString:@"true"];
    }
    else {
        [url appendString:@"false"];
    }
    
    NSString *detailsColorString = [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsDetailsBrandingColorKey];
    if (detailsColorString) {
        [url appendString:@"&detailsBrandingColor="];
        [url appendString:detailsColorString];
    }
    
    NSString *detailsBrandingUrl = [[NSUserDefaults standardUserDefaults] objectForKey:kSettingsDetailsBrandingUrlKey];
    if (detailsBrandingUrl.length) {
        [url appendString:@"&detailsBrandingUrl="];
        [url appendString:detailsBrandingUrl];
    }
    
    return url;
}

+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+ (CGSize)updateSizeForDisplay:(CGSize)size {
    if ([SettingsManager isThreeEx]) {
        return CGSizeMake(size.width * 3, size.height * 3);
    } else if ([SettingsManager isRetinaDisplay]) {
        return CGSizeMake(size.width * 2, size.height * 2);
    }
    return size;
}

+ (BOOL)isRetinaDisplay {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale == 2.0)) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isThreeEx {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] > 2.1) {
        return YES;
    }
    return NO;
}

@end
