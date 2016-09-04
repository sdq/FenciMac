//
//  FenciHelper.h
//  Fenci
//
//  Created by sdq on 9/1/16.
//  Copyright © 2016 sdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FenciHelper : NSObject

+ (FenciHelper *)sharedInstance;

- (NSString *)mpSegment:(NSString *)inputSentence;
- (NSString *)hmmSegment:(NSString *)inputSentence;
- (NSString *)mixSegment:(NSString *)inputSentence;
- (NSString *)fullSegment:(NSString *)inputSentence;
- (NSString *)querySegment:(NSString *)inputSentence;

@end
