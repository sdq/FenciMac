//
//  ViewController.swift
//  Fenci
//
//  Created by sdq on 9/2/16.
//  Copyright © 2016 sdq. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var inputTextView: NSTextView!
    @IBOutlet var outputTextView: NSTextView!
    @IBOutlet weak var methodButton: NSPopUpButton!
    @IBOutlet var splitWord: NSTextField!
    
    let fenci = FenciHelper.sharedInstance()
    let methods = ["最大概率法 MPSegment","隐式马尔科夫模型 HMMSegment","混合模式 MixSegment","全模式 FullSegment","搜索模式 QuerySegment"]
    var selectedItem = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        methodButton.removeAllItems()
        methodButton.addItems(withTitles: methods)
        methodButton.selectItem(at: selectedItem)
        inputTextView.string = "在这里输入文本"
        outputTextView.isEditable = false
        outputTextView.string = " 在 这里 输入 文本"
    }

    @IBAction func chooseMethod(_ sender: NSPopUpButton) {
        selectedItem = sender.indexOfSelectedItem
    }

    @IBAction func segmentSentence(_ sender: NSButton) {
        let sentence = inputTextView.string
        if sentence == "" {
            return
        }
        let splitstr = splitWord.stringValue
        switch selectedItem {
        case 0:
            if let words = fenci?.mpSegment(sentence) {
                outputTextView.string = strarr2str(str: words, split: splitstr)
            } else {
                outputTextView.string = "分词失败，请重试！"
            }
        case 1:
            if let words = fenci?.hmmSegment(sentence) {
                outputTextView.string = strarr2str(str: words, split: splitstr)
            } else {
                outputTextView.string = "分词失败，请重试！"
            }
        case 2:
            if let words = fenci?.mixSegment(sentence) {
                outputTextView.string = strarr2str(str: words, split: splitstr)
            } else {
                outputTextView.string = "分词失败，请重试！"
            }
        case 3:
            if let words = fenci?.fullSegment(sentence) {
                outputTextView.string = strarr2str(str: words, split: splitstr)
            } else {
                outputTextView.string = "分词失败，请重试！"
            }
        case 4:
            if let words = fenci?.querySegment(sentence) {
                outputTextView.string = strarr2str(str: words, split: splitstr)
            } else {
                outputTextView.string = "分词失败，请重试！"
            }
        default:
            break
        }
    }
    
    func strarr2str(str:String, split:String) -> String {
        let start: String.Index = str.index(str.startIndex, offsetBy:1)
        let end: String.Index = str.index(str.endIndex, offsetBy:-2)
        let range = str.index(after:start)..<end
        let words_ = str[range]
        let arrat = words_.components(separatedBy: "\", \"")
        var splitstr = split
        if splitstr == "" {
            splitstr = " "
        }
        let sepstr = arrat.reduce("",{$0 + splitstr + $1})
        return sepstr
    }

    @IBAction func goToGithub(_ sender: NSButton) {
        if let checkURL = URL(string: "https://github.com/sdq/FenciMac") {
            if NSWorkspace.shared().open(checkURL) {
                print("url successfully opened")
            }
        }
    }


}

