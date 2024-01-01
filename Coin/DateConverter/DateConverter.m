//
//  DateConverter.m
//  Coin
//
//  Created by Kirill Streltsov on 01.01.24.
//

#import <Foundation/Foundation.h>
#import "DateConverter.h"


@implementation DateConverter

+ (NSString *)getDateString:(NSString *)dateString {
    NSDate *currentDate = [NSDate date];
    
    NSDateFormatter *isoFormatter = [[NSDateFormatter alloc] init];
    [isoFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'"];
    [isoFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
    [displayFormatter setDateFormat:@"MMM d, h:mm a"];
    NSString *displayDateString = [displayFormatter stringFromDate:currentDate];
    return displayDateString;
}

@end
