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
        outputTextView.string = "这里会输出分词后的文本，以给定的分隔符划分（默认为空格）。"
    }

    @IBAction func chooseMethod(_ sender: NSPopUpButton) {
        selectedItem = sender.indexOfSelectedItem
    }

    @IBAction func segmentSentence(_ sender: NSButton) {
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
                    }
                } else {
                    DispatchQueue.main.async {
                        self.outputTextView.string = "分词失败，请重试！"
                    }
                }
            case 1:
                if let words = self.fenci?.hmmSegment(sentence) {
                    let outputString = self.strarr2str(str: words, split: splitstr)
                    DispatchQueue.main.async {
                        self.outputTextView.string = outputString
                    }
                } else {
                    DispatchQueue.main.async {
                        self.outputTextView.string = "分词失败，请重试！"
                    }
                }
            case 2:
                if let words = self.fenci?.mixSegment(sentence) {
                    let outputString = self.strarr2str(str: words, split: splitstr)
                    DispatchQueue.main.async {
                        self.outputTextView.string = outputString
                    }
                } else {
                    DispatchQueue.main.async {
                        self.outputTextView.string = "分词失败，请重试！"
                    }
                }
            case 3:
                if let words = self.fenci?.fullSegment(sentence) {
                    let outputString = self.strarr2str(str: words, split: splitstr)
                    DispatchQueue.main.async {
                        self.outputTextView.string = outputString
                    }
                } else {
                    DispatchQueue.main.async {
                        self.outputTextView.string = "分词失败，请重试！"
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

