//
//  FenciHelper.m
//  Fenci
//
//  Created by sdq on 9/1/16.
//  Copyright © 2016 sdq. All rights reserved.
//

#import "FenciHelper.h"
#import "FenciModel.h"

@implementation FenciHelper

+ (FenciHelper *)sharedInstance {
    static FenciHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FenciHelper alloc] initFenciModel];
    });
    
    return sharedInstance;
}

- (id)initFenciModel {
    self = [super init];
    if (!self) return nil;
    
    NSString *dictPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Fenci.bundle/jieba.dict.utf8"];
    NSString *hmmPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Fenci.bundle/hmm_model.utf8"];
    NSString *idfPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Fenci.bundle/idf.utf8"];
    NSString *stopWordPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Fenci.bundle/stop_words.utf8"];
    NSString *userDictPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Fenci.bundle/user.dict.utf8"];
    
    const char *cDictPath = [dictPath UTF8String];
    const char *cHmmPath = [hmmPath UTF8String];
    const char *cIdfPath = [idfPath UTF8String];
    const char *cStopWordPath = [stopWordPath UTF8String];
    const char *cUserDictPath = [userDictPath UTF8String];
    
    MPInit(cDictPath, cUserDictPath);
    HMMInit(cHmmPath);
    MixInit(cDictPath, cHmmPath, cUserDictPath);
    FullInit(cDictPath);
    QueryInit(cDictPath, cHmmPath, cUserDictPath);
    KeywordInit(cDictPath, cHmmPath, cIdfPath, cStopWordPath, cUserDictPath);
    
    return self;
}

- (NSString *)mixSegment:(NSString *)inputSentence {
    const char* sentence = [inputSentence UTF8String];
    std::vector<std::string> words;
    MPCut(sentence, words);
    std::string result;
    result << words;
    return [NSString stringWithUTF8String:result.c_str()];
}

- (NSString *)mpSegment:(NSString *)inputSentence {
    const char* sentence = [inputSentence UTF8String];
    std::vector<std::string> words;
    HMMCut(sentence, words);
    std::string result;
    result << words;
    return [NSString stringWithUTF8String:result.c_str()];
}

- (NSString *)hmmSegment:(NSString *)inputSentence {
    const char* sentence = [inputSentence UTF8String];
    std::vector<std::string> words;
    MixCut(sentence, words);
    std::string result;
    result << words;
    return [NSString stringWithUTF8String:result.c_str()];
}

- (NSString *)fullSegment:(NSString *)inputSentence {
    const char* sentence = [inputSentence UTF8String];
    std::vector<std::string> words;
    FullCut(sentence, words);
    std::string result;
    result << words;
    return [NSString stringWithUTF8String:result.c_str()];
}

- (NSString *)querySegment:(NSString *)inputSentence {
    const char* sentence = [inputSentence UTF8String];
    std::vector<std::string> words;
    QueryCut(sentence, words);
    std::string result;
    result << words;
    return [NSString stringWithUTF8String:result.c_str()];
}

- (NSString *)keywordExtract:(NSString *)inputSentence Count:(int)count {
    const char* sentence = [inputSentence UTF8String];
    std::vector<std::string> words;
    KeywordExtract(sentence, words, count);
    std::string result;
    result << words;
    return [NSString stringWithUTF8String:result.c_str()];
}


@end
