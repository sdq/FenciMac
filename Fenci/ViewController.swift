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
    
    let fenci = FenciHelper.sharedInstance()
    let methods = ["最大概率法 MPSegment","隐式马尔科夫模型 HMMSegment","混合模式 MixSegment","全模式 FullSegment","搜索模式 QuerySegment"]
    var selectedItem = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        methodButton.removeAllItems()
        methodButton.addItemsWithTitles(methods)
        methodButton.selectItemAtIndex(selectedItem)
        inputTextView.string = "在这里输入文本"
        outputTextView.editable = false
        outputTextView.string = "[\"在\",\"这里\",\"输入\",\"文本\"]"
    }

    @IBAction func chooseMethod(sender: NSPopUpButton) {
        selectedItem = sender.indexOfSelectedItem
    }

    @IBAction func segmentSentence(sender: NSButton) {
        let sentence = inputTextView.string
        if sentence == "" {
            return
        }
        switch selectedItem {
        case 0:
            let words = fenci.mpSegment(sentence)
            outputTextView.string = "\(words)"
        case 1:
            let words = fenci.hmmSegment(sentence)
            outputTextView.string = "\(words)"
        case 2:
            let words = fenci.mixSegment(sentence)
            outputTextView.string = "\(words)"
        case 3:
            let words = fenci.fullSegment(sentence)
            outputTextView.string = "\(words)"
        case 4:
            let words = fenci.querySegment(sentence)
            outputTextView.string = "\(words)"
        default:
            break
        }
    }

    @IBAction func goToGithub(sender: NSButton) {
        if let checkURL = NSURL(string: "https://github.com/sdq/FenciMac") {
            if NSWorkspace.sharedWorkspace().openURL(checkURL) {
                print("url successfully opened")
            }
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

