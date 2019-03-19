//
//  SwiftyMessageProtocal.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/3/18.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import SwiftMessages

//protocol SwiftMessageAbleProtocol {
//    func showSwiftMessage(style: CustomMessageView.Style, text: String, isWindowLvl: Bool, customPresentationContext: SwiftMessages.PresentationContext, customHeight: CGFloat)
//    func showNotificationMessageWithTapGesture(title: String, subtitle: String, _ tapHandler: @escaping () -> ())
//    func hideAllMessages(afterDelay: (() -> ())?)
//}
//
//extension SwiftMessageAbleProtocol {
//    func showSwiftMessage(style: CustomMessageView.Style, text: String, isWindowLvl: Bool = false, customPresentationContext: SwiftMessages.PresentationContext = .automatic, customHeight: CGFloat = 40) {
//        hideAllMessages(){
//            let view: CustomMessageView = try! SwiftMessages.viewFromNib()
//
//            view.style = style
//            view.preferredHeight = customHeight
//            view.messageLabel.text = text
//
//            var config = SwiftMessages.Config()
//            if isWindowLvl {
//                config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
//            } else {
//                config.presentationContext = customPresentationContext
//            }
//            config.ignoreDuplicates = false
//
//            SwiftMessages.show(config: config, view: view)
//        }
//    }
//
//    func showNotificationMessageWithTapGesture(title: String, subtitle: String, _ tapHandler: @escaping () -> ()) {
//        hideAllMessages() {
//            let view = MessageView.viewFromNib(layout: .messageView)
//
//            view.configureContent(title: title, body: subtitle, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: nil)
//
//            view.button?.isHidden = true
//            view.iconImageView?.isHidden = true
//            view.iconLabel?.isHidden = true
//
//            view.tapHandler = { _ in
//                self.hideAllMessages()
//                tapHandler()
//            }
//
//            view.configureTheme(backgroundColor: UIColor(hexString: "4A4A4A")!, foregroundColor: UIColor.white)
//
//            var config = SwiftMessages.defaultConfig
//            config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
//
//            SwiftMessages.show(config: config, view: view)
//        }
//    }
//
//    func hideAllMessages(afterDelay: (() -> ())? = nil) {
//        SwiftMessages.hide()
//        guard let afterDelay = afterDelay else { return }
//        delay(seconds: 0.3) {
//            afterDelay()
//        }
//    }
//}
//
//
//
//
//class CustomMessageView {
//
//
//
//}
