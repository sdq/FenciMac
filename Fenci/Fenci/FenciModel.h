//
//  FenciHelper.h
//  Fenci
//
//  Created by sdq on 9/1/16.
//  Copyright © 2016 sdq. All rights reserved.
//

#ifndef __Fenci__
#define __Fenci__

#include <stdio.h>

#include "cppjieba/MPSegment.hpp"
#include "cppjieba/HMMSegment.hpp"
#include "cppjieba/MixSegment.hpp"
#include "cppjieba/FullSegment.hpp"
#include "cppjieba/QuerySegment.hpp"
#include "cppjieba/KeywordExtractor.hpp"
#include <string>
#include <vector>

extern cppjieba::MPSegment * mpSegmentor;
extern cppjieba::HMMSegment * hmmSegmentor;
extern cppjieba::MixSegment * mixSegmentor;
extern cppjieba::FullSegment * fullSegmentor;
extern cppjieba::QuerySegment * querySegmentor;
extern cppjieba::KeywordExtractor * keywordExtractor;

void MPInit(const std::string& dictPath, const std::string& userDictPath);
void MPCut(const std::string& sentence, std::vector<std::string>& words);

void HMMInit(const std::string& hmmPath);
void HMMCut(const std::string& sentence, std::vector<std::string>& words);

void MixInit(const std::string& dictPath, const std::string& hmmPath, const std::string& userDictPath);
void MixCut(const std::string& sentence, std::vector<std::string>& words);

void FullInit(const std::string& dictPath);
void FullCut(const std::string& sentence, std::vector<std::string>& words);

void QueryInit(const std::string& dictPath, const std::string& hmmPath, const std::string& userDictPath);
void QueryCut(const std::string& sentence, std::vector<std::string>& words);

void KeywordInit(const std::string& dictPath, const std::string& hmmPath, const std::string& idfPath, const std::string& stopWordPath, const std::string& userDictPath);
void KeywordExtract(const std::string& sentence, std::vector<std::string>& words, size_t topN);

#endif /* defined(__Fenci__) */
