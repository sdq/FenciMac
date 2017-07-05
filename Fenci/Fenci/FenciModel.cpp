//
//  FenciHelper.m
//  Fenci
//
//  Created by sdq on 9/1/16.
//  Copyright © 2016 sdq. All rights reserved.
//

#import "FenciModel.h"
#include <iostream>

using namespace cppjieba;

cppjieba::MPSegment * mpSegmentor;
cppjieba::HMMSegment * hmmSegmentor;
cppjieba::MixSegment * mixSegmentor;
cppjieba::FullSegment * fullSegmentor;
cppjieba::QuerySegment * querySegmentor;
cppjieba::KeywordExtractor * keywordExtractor;

void MPInit(const std::string& dictPath, const std::string& userDictPath) {
    if(mpSegmentor == NULL) {
        mpSegmentor = new MPSegment(dictPath, userDictPath);
    }
}

void MPCut(const std::string& sentence, std::vector<std::string>& words) {
    assert(mpSegmentor);
    mpSegmentor->Cut(sentence, words);
}

void HMMInit(const std::string& hmmPath) {
    if(hmmSegmentor == NULL) {
        hmmSegmentor = new HMMSegment(hmmPath);
    }
}

void HMMCut(const std::string& sentence, std::vector<std::string>& words) {
    assert(hmmSegmentor);
    hmmSegmentor->Cut(sentence, words);
}

void MixInit(const std::string& dictPath, const std::string& hmmPath, const std::string& userDictPath) {
    if(mixSegmentor == NULL) {
        mixSegmentor = new MixSegment(dictPath, hmmPath, userDictPath);
    }
//    cout << __FILE__ << __LINE__ << endl;
}

void MixCut(const std::string& sentence, std::vector<std::string>& words) {
    assert(mixSegmentor);
    mixSegmentor->Cut(sentence, words);
//    cout << __FILE__ << __LINE__ << endl;
//    cout << words << endl;
}

void FullInit(const std::string& dictPath) {
    if(fullSegmentor == NULL) {
        fullSegmentor = new FullSegment(dictPath);
    }
}

void FullCut(const std::string& sentence, std::vector<std::string>& words) {
    assert(fullSegmentor);
    fullSegmentor->Cut(sentence, words);
}

void QueryInit(const std::string& dictPath, const std::string& hmmPath, const std::string& userDictPath) {
    if(querySegmentor == NULL) {
        querySegmentor = new QuerySegment(dictPath, hmmPath, userDictPath);
    }
}

void QueryCut(const std::string& sentence, std::vector<std::string>& words) {
    assert(querySegmentor);
    querySegmentor->Cut(sentence, words);
}

void KeywordInit(const std::string& dictPath, const std::string& hmmPath, const std::string& idfPath, const std::string& stopWordPath, const std::string& userDictPath) {
    if(keywordExtractor == NULL) {
        keywordExtractor = new KeywordExtractor(dictPath, hmmPath, idfPath, stopWordPath, userDictPath);
    }
}

void KeywordExtract(const std::string& sentence, std::vector<std::string>& words, size_t topN) {
    assert(keywordExtractor);
    keywordExtractor->Extract(sentence, words, topN);
}
