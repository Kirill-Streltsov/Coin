//
//  DateConverter.m
//  Coin
//
//  Created by Kirill Streltsov on 01.01.24.
//

#import <Foundation/Foundation.h>
#import "DateConverter.h"


@implementation DateConverter

+ (NSString *)convertDateString:(NSString *)inputDateString shouldBeShort:(BOOL)shouldBeShort {
    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
    [inputDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'"];
    NSDate *inputDate = [inputDateFormatter dateFromString:inputDateString];
    
    NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
    if (shouldBeShort) {
        [outputDateFormatter setDateFormat:@"dd/MM/yyyy"];
    } else {
        [outputDateFormatter setDateFormat:@"MMM d, HH:mm"];
    }
    
    NSString *outputDateString = [outputDateFormatter stringFromDate:inputDate];
    return outputDateString;
}

@end
