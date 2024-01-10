//
//  DateConverter.h
//  Coin
//
//  Created by Kirill Streltsov on 01.01.24.
//

#ifndef DateConverter_h
#define DateConverter_h
#import <Foundation/Foundation.h>

@interface DateConverter : NSObject

+ (NSString *)convertDateString:(NSString *)inputDateString shouldBeShort:(BOOL)shouldBeShort;

@end

#endif /* DateConverter_h */
