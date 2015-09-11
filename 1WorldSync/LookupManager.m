//
//  LookupManager.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "LookupManager.h"
#import "OWSItem.h"
#import <RestKit/RestKit.h>
#import "OWSSearchResult.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#import "OWSRKDynamicMapping.h"
#import "SettingsManager.h"

#define kHardcodedNoNetworkCode @"0000"

static NSString *mostRecentSearch;

@implementation LookupManager

+ (LookupManager *)sharedInstance {
    static LookupManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LookupManager alloc] init];
        
        NSURL *baseURL = [NSURL URLWithString:[SettingsManager baseUrl]];
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
        
        // initialize RestKit
        RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
        
        //Create the response descriptor with the search result mapping
        RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[OWSSearchResult mappingForClass]
                                                                                                method:RKRequestMethodAny
                                                                                           pathPattern:nil
                                                                                               keyPath:@"searchResults"
                                                                                           statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

        //Product details mapping
        RKResponseDescriptor *detailsDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[OWSItem mappingForClass]
                                                                                             method:RKRequestMethodAny
                                                                                        pathPattern:nil
                                                                                            keyPath:@"productDetails.item"
                                                                                        statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

        
        //Error mapping
        RKObjectMapping *errorMapping = [RKObjectMapping mappingForClass:[RKErrorMessage class]];
        [errorMapping addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"responseMessage" toKeyPath:@"errorMessage"]];
        
        NSMutableIndexSet *errorSets = RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError).mutableCopy;
        [errorSets addIndexes:RKStatusCodeIndexSetForClass(RKStatusCodeClassServerError)];
        RKResponseDescriptor *errorDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:errorMapping
                                                                                             method:RKRequestMethodAny
                                                                                        pathPattern:nil
                                                                                            keyPath:nil
                                                                                        statusCodes:errorSets];
        
        [objectManager addResponseDescriptorsFromArray:@[responseDescriptor, detailsDescriptor, errorDescriptor]];
    });
    return sharedInstance;
}

- (void)search:(NSString*)searchTerm completion:(LookupResponseBlock)completion {
    
    //need to use the full path manually because it needs to be hashed
    if ([SettingsManager offlineMode]) {
        NSString *MIMEType = @"application/json";
        NSError *error = nil;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"searchresults" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        id parsedData = [RKMIMETypeSerialization objectFromData:data MIMEType:MIMEType error:&error];
        if (parsedData == nil && error) {
            // Parser error...
        }
        
        RKObjectMapping *mapping = [OWSSearchResult mappingForClass];
        NSDictionary *mappingsDictionary = @{ @"searchResults": mapping };
        RKMapperOperation *mapper = [[RKMapperOperation alloc] initWithRepresentation:parsedData mappingsDictionary:mappingsDictionary];
        NSError *mappingError = nil;
        BOOL isMapped = [mapper execute:&mappingError];
        if (isMapped && !mappingError) {
            completion([mapper mappingResult].array, nil);
        }
    }
    else {
        NSMutableString *url = [NSMutableString stringWithFormat:@"/V1/products?searchType=freeTextSearch&query=%@*&geo_loc_access_latd=%f&geo_loc_access_long=%f&rows=500&access_mdm=SMART_PHONE&app_id=%@", searchTerm, [[SettingsManager latestLatitude] doubleValue], [[SettingsManager latestLongitude] doubleValue], [SettingsManager appId]];
        [url appendString:@"&TIMESTAMP="];
        [url appendString:[LookupManager currentDateString]];
        NSString *hash = [LookupManager hashForURL:url];
        [url appendString:@"&hash_code="];
        [url appendString:hash];
        
        //after the hash, can now url encode the search term
        [url replaceOccurrencesOfString:searchTerm withString:[searchTerm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] options:0 range:NSMakeRange(0, url.length)];
        
        [url insertString:[SettingsManager baseUrl] atIndex:0];
        RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] objectRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]
                                                                   success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                                       if (completion) {
                                                                           completion(mappingResult.array, nil);
                                                                       }
                                                  }
                                                                   failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                                       if (completion) {
                                                                           completion(nil, error);
                                                                       }
                                                                   }];

       [operation start];
    }
    
}


- (void)lookupCode:(NSString *)codeString completion:(LookupResponseBlock)completion {
    //Don't do the request if offline mode
    if ([SettingsManager offlineMode]) {
        //all that is used is the item id so just pass that through
        OWSSearchResult *result = [OWSSearchResult new];
        result.item = [OWSItem new];
        result.item.itemIdentificationInformation = [OWSItemIdentificationInformation new];
        result.item.itemIdentificationInformation.itemReferenceIdInformation = [OWSItemReferenceIdInformation new];
        result.item.itemIdentificationInformation.itemReferenceIdInformation.itemReferenceId = @"xau1xo";
        completion(@[result], nil);
    }
    else {
        NSMutableString *url = [NSMutableString stringWithFormat:@"/V1/products?searchType=advancedSearch&query=itemId:%@&geo_loc_access_latd=%f&geo_loc_access_long=%f&rows=500&access_mdm=SMART_PHONE&app_id=%@", codeString, [[SettingsManager latestLatitude] doubleValue], [[SettingsManager latestLongitude] doubleValue], [SettingsManager appId]];
        [url appendString:@"&TIMESTAMP="];
        [url appendString:[LookupManager currentDateString]];
        NSString *hash = [LookupManager hashForURL:url];
        [url appendString:@"&hash_code="];
        [url appendString:hash];
        
        [url insertString:[SettingsManager baseUrl] atIndex:0];
        RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] objectRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]
                                                                                                         success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                                                                             if (completion) {
                                                                                                                 completion(mappingResult.array, nil);
                                                                                                             }
                                                                                                         }
                                                                                                         failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                                                                             if (completion) {
                                                                                                                 completion(nil, error);
                                                                                                             }
                                                                                                         }];
        
        [operation start];
    }
}

- (void)getDetails:(NSString*)itemId completion:(LookupResponseBlock)completion {
    //Don't do the request if offline mode
    if ([SettingsManager offlineMode]) {
        NSString *MIMEType = @"application/json";
        NSError *error = nil;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"sanpelligrinodetails" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        id parsedData = [RKMIMETypeSerialization objectFromData:data MIMEType:MIMEType error:&error];
        if (parsedData == nil && error) {
            // Parser error...
        }
        
        RKObjectMapping *mapping = [OWSItem mappingForClass];
        NSDictionary *mappingsDictionary = @{ @"productDetails.item": mapping };
        RKMapperOperation *mapper = [[RKMapperOperation alloc] initWithRepresentation:parsedData mappingsDictionary:mappingsDictionary];
        NSError *mappingError = nil;
        BOOL isMapped = [mapper execute:&mappingError];
        if (isMapped && !mappingError) {
            completion([mapper mappingResult].array, nil);
        }
    }
    else {
        //need to use the full path manually because it needs to be hashed
        NSMutableString *url = [NSMutableString stringWithFormat:@"/V1/products/%@?attrset=all&geo_loc_access_latd=%f&geo_loc_access_long=%f&rows=500&access_mdm=SMART_PHONE&app_id=%@", itemId, [[SettingsManager latestLatitude] doubleValue], [[SettingsManager latestLongitude] doubleValue], [SettingsManager appId]];
        [url appendString:@"&TIMESTAMP="];
        [url appendString:[LookupManager currentDateString]];
        NSString *hash = [LookupManager hashForURL:url];
        [url appendString:@"&hash_code="];
        [url appendString:hash];
        
        [url insertString:[SettingsManager baseUrl] atIndex:0];
        RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] objectRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]
                                                                                                         success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                                                                             if (completion) {
                                                                                                                 completion(mappingResult.array, nil);
                                                                                                             }
                                                                                                         }
                                                                                                         failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                                                                             if (completion) {
                                                                                                                 completion(nil, error);
                                                                                                             }
                                                                                                         }];
        
        [operation start];
    }
    
}

/**
 * Returns sha 256 encoded hash turned into base 64 encoded string. Also url encodes it then returns it
 */
+ (NSString *)hashForURL:(NSString *)url {
    NSString *key = [SettingsManager apiKey];
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [url cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *hash = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    return [LookupManager base64forData:hash];
}

+ (NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        NSInteger theIndex = (i / 3) * 4;  output[theIndex + 0] = table[(value >> 18) & 0x3F];
        output[theIndex + 1] = table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6) & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0) & 0x3F] : '=';
    }
    
    
    return [self URLEncodeStringFromString:[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]];

}

+ (NSString *)URLEncodeStringFromString:(NSString *)string
{
    static CFStringRef charset = CFSTR("!@#$%&*()+'\";:=,/?[] ");
    CFStringRef str = (__bridge CFStringRef)string;
    CFStringEncoding encoding = kCFStringEncodingUTF8;
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, str, NULL, charset, encoding));
}



+(NSString *)currentDateString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormat setTimeZone:timeZone];
    [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    return [dateFormat stringFromDate:[NSDate date]];
    
}

+ (void)showError:(NSError *)error {
    NSString *message = error.localizedDescription;
    [[[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

+ (NSString *)mostRecentSearchString {
    return mostRecentSearch;
}

+ (void)setMostRecentSearchString:(NSString *)string {
    mostRecentSearch = string;
}

@end
