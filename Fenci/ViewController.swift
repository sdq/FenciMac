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
    @IBOutlet var keywordTextView: NSTextView!
    @IBOutlet weak var methodButton: NSPopUpButton!
    @IBOutlet var splitWord: NSTextField!
    @IBOutlet weak var keywordCount: NSPopUpButton!
    @IBOutlet weak var keywordButton: NSButton!
    @IBOutlet weak var segmentButton: NSButton!
    
    let fenci = FenciHelper.sharedInstance()
    let methods = ["最大概率法","","混合模式","全模式","搜索模式"]
    let keywordCounts = ["5", "10", "15", "20", "25", "30"]
    var selectedItem = 2
    var selectKeywordCount = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        methodButton.removeAllItems()
        methodButton.addItems(withTitles: methods)
        methodButton.selectItem(at: selectedItem)
        keywordCount.removeAllItems()
        keywordCount.addItems(withTitles: keywordCounts)
        keywordCount.selectItem(at: 0)
        inputTextView.string = "在这里输入文本"
        keywordTextView.isEditable = false
        keywordTextView.string = "这里会输出输入文本的关键词，默认词数为5。"
        outputTextView.isEditable = false
        outputTextView.string = "这里会输出分词后的文本，以给定的分隔符划分（默认为空格）。"
    }

    @IBAction func chooseMethod(_ sender: NSPopUpButton) {
        selectedItem = sender.indexOfSelectedItem
    }

    @IBAction func chooseKeywordCount(_ sender: NSPopUpButton) {
        selectKeywordCount = 5 + 5 * sender.indexOfSelectedItem
    }

    @IBAction func segmentSentence(_ sender: NSButton) {
        self.segmentButton.isEnabled = false
        self.outputTextView.string = "分词中，请稍等..........."
        let queue = DispatchQueue(label: "fenci.segmentqueue")
        queue.async {
            let sentence = self.inputTextView.string
            if sentence == "" {
                return
            }
            let splitstr = self.splitWord.stringValue
            switch self.selectedItem {
            case 0:
                if let words = self.fenci?.mpSegment(sentence) {
                    let outputString = self.strarr2str(str: words, split: splitstr)
                    DispatchQueue.main.async {
                        self.outputTextView.string = outputString
                        self.segmentButton.isEnabled = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.outputTextView.string = "分词失败，请重试！"
                        self.segmentButton.isEnabled = true
                    }
                }
            case 1:
                if let words = self.fenci?.hmmSegment(sentence) {
                    let outputString = self.strarr2str(str: words, split: splitstr)
                    DispatchQueue.main.async {
                        self.outputTextView.string = outputString
                        self.segmentButton.isEnabled = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.outputTextView.string = "分词失败，请重试！"
                        self.segmentButton.isEnabled = true
                    }
                }
            case 2:
                if let words = self.fenci?.mixSegment(sentence) {
                    let outputString = self.strarr2str(str: words, split: splitstr)
                    DispatchQueue.main.async {
                        self.outputTextView.string = outputString
                        self.segmentButton.isEnabled = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.outputTextView.string = "分词失败，请重试！"
                        self.segmentButton.isEnabled = true
                    }
                }
            case 3:
                if let words = self.fenci?.fullSegment(sentence) {
                    let outputString = self.strarr2str(str: words, split: splitstr)
                    DispatchQueue.main.async {
                        self.outputTextView.string = outputString
                        self.segmentButton.isEnabled = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.outputTextView.string = "分词失败，请重试！"
                        self.segmentButton.isEnabled = true
                    }
                }
            case 4:
                if let words = self.fenci?.querySegment(sentence) {
                    let outputString = self.strarr2str(str: words, split: splitstr)
                    DispatchQueue.main.async {
                        self.outputTextView.string = outputString
                    }
                } else {
                    DispatchQueue.main.async {
                        self.outputTextView.string = "分词失败，请重试！"
                        self.segmentButton.isEnabled = true
                    }
                }
            default:
                break
            }
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

    @IBAction func keywordExtract(_ sender: NSButton) {
        self.keywordButton.isEnabled = false
        self.keywordTextView.string = "关键词提取中，请稍等..........."
        let queue = DispatchQueue(label: "fenci.keywordqueue")
        queue.async {
            let sentence = self.inputTextView.string
            if sentence == "" {
                return
            }
            if let words = self.fenci?.keywordExtract(sentence, count: Int32(self.selectKeywordCount)) {
                let outputString = self.strarr2str(str: words, split: " ")
                print(outputString)
                DispatchQueue.main.async {
                    self.keywordTextView.string = outputString
                    self.keywordButton.isEnabled = true
                }
            } else {
                print("fail")
                DispatchQueue.main.async {
                    self.keywordTextView.string = "提取关键词失败，请重试！"
                    self.keywordButton.isEnabled = true
                }
            }
        }
    }

    @IBAction func importTXT(_ sender: NSButton) {
        let openPanel = NSOpenPanel()
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowsMultipleSelection = false;
        openPanel.allowedFileTypes = ["txt","md"]
        openPanel.beginSheetModal(for: self.view.window!) { (response) -> Void in
            guard response == NSFileHandlingPanelOKButton else {return}
            print(openPanel.urls)
            let url = openPanel.urls[0]
            do {
                let txt = try String(contentsOf: url, encoding: .utf8)
                DispatchQueue.main.async {
                    self.inputTextView.string = txt
                }
            } catch {
                print(error)
            }
        }
    }
    
    
    @IBAction func export(_ sender: NSButton) {
        let savePanel = NSSavePanel()
        savePanel.nameFieldStringValue = "fenci.txt"
        savePanel.allowedFileTypes = ["txt","md"]
        savePanel.isExtensionHidden = false
        savePanel.beginSheetModal(for: self.view.window!) { (response) -> Void in
            guard response == NSFileHandlingPanelOKButton else {return}
            print(savePanel.url ?? "no url")
            if let txturl = savePanel.url {
                do {
                    try self.outputTextView.string?.write(to: txturl, atomically: false, encoding: .utf8)
                }
                catch {
                    print(error)
                }
            }
        }
    }

    @IBAction func copyToPasteboard(_ sender: NSButton) {
        let pasteboard = NSPasteboard.general()
        pasteboard.declareTypes([NSPasteboardTypeString], owner: nil)
        if let text = outputTextView.string {
            pasteboard.setString(text, forType: NSPasteboardTypeString)
        }
    }

}

