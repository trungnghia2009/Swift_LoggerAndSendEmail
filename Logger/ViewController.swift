//
//  ViewController.swift
//  Logger
//
//  Created by trungnghia on 07/02/2023.
//

import UIKit
import MessageUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        MyLogger.info("Feature: \(Config.featureEnabled ?? false), bffUrl: \(Config.bffUrl ?? "")")
        
        // Uncomment for testing logger's synchronous flow
//        MyLogger.info("Nghia1")
//        MyLogger.info("Nghia2")
//        MyLogger.warning("Nghia3")
//        MyLogger.error("Nghia4")
//        MyLogger.info("Nghia5 Current thread: \(Thread.current)")
//        MyLogger.warning("Nghia6")
//        MyLogger.warning("Nghia7")
//        MyLogger.warning("Nghia8")
//        MyLogger.warning("Nghia9")
//        MyLogger.warning("Nghia10")
//        MyLogger.error("Nghia11")
//        navigationScreen(param1: "", param2: 1)
    }
    
    @discardableResult
    func navigationScreen(param1: String, param2: Int) -> Int {
        MyLogger.info("I'm here for you...")
        MyLogger.error("Wrong value", shouldLogContext: false)
        return 1
    }
    
    
    @IBAction func didTapRightBarBtn(_ sender: Any) {
        MyLogger.info("Did tap left bar button...")
        let mailManager = MailManager()
        mailManager.sendEmailWithLogAttachment(controller: self, delegate: self)
    }
    

    @IBAction func didTapLeftBarBtn(_ sender: Any) {
        MyLogger.info("Did tap right bar button...")
    }
}

extension ViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
