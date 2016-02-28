//
//  SecondViewController.swift
//  ChatPedia
//
//  Created by Isaac Albets Ramonet on 26/02/16.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    
    var messages = [JSQMessage]()
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    
//    var currentRoomId = "-KBWKykTqc5R3NT4C1qt"  // set Hop-On Hop-Off Bus Tour as default
    
    // Firebase references.
    var messageRef     : Firebase!
    var roomRef        : Firebase!
    
    //typing
    var usersTypingQuery: FQuery!
    
    var userIsTypingRef: Firebase! // 1
    private var localTyping = false // 2
    var isTyping: Bool {
        get {
            return localTyping
        }
        set {
            // 3
            localTyping = newValue
            userIsTypingRef.setValue(newValue)
        }
    }
    
    // MARK: - One Time Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Firebase
//        roomRef = CoreFirebaseData.sharedInstance.ref.childByAppendingPath("room").childByAppendingPath(currentRoomId)
        messageRef = roomRef.childByAppendingPath("messages")
        
        // Get all rooms
        // TODO: Hook this up later fully.  just print out for now
//        roomRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
//            for room in snapshot.children.allObjects as! [FDataSnapshot] {
//                //print(room.value)
//                self.currentRoomId = room.key
//            }
//        })

        messageRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            for msg in snapshot.children.allObjects as! [FDataSnapshot] {
                print(msg.value)
            }
        })
        
        self.senderId = CurrentUser.sharedInstance.authData.uid
        self.senderDisplayName = CurrentUser.sharedInstance.displayName
        
        observeTyping()
        
        // JSQ
        self.title = "ChatPedia"
        setupBubbles()
        
        // no avatars
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        
    }
    
    // MARK: - Repeating Load
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        observeMessages()
    }
    
    // MARK: - Firebase
    private func observeMessages() {
        // 1
        let messagesQuery = messageRef.queryOrderedByChild("date").queryLimitedToLast(25)
        // 2
        messagesQuery.observeEventType(.ChildAdded) { (snapshot: FDataSnapshot!) in
            // 3
            let id = snapshot.value["senderId"] as! String
            let text = snapshot.value["text"] as! String
            let senderName = snapshot.value["senderName"] as! String
            let dateStr = snapshot.value["date"] as! String
            
            var dateFormatter = NSDateFormatter()
            dateFormatter.timeZone = NSTimeZone.systemTimeZone()
            dateFormatter.locale = NSLocale.currentLocale()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss Z"
            dateFormatter.formatterBehavior = NSDateFormatterBehavior.BehaviorDefault
            
            let date = dateFormatter.dateFromString(dateStr)
            
            // 4
            self.addMessage(id, text: text, senderName: senderName, date: date!)
            
            // 5
            self.finishReceivingMessage()
        }
    }
    
    // MARK: - Receiving Messages
    func addMessage(id: String, text: String, senderName: String, date: NSDate) {
        let message = JSQMessage(senderId: id, senderDisplayName: senderName, date: date, text: text)
        messages.append(message)
    }
    
    // MARK: - Sending Messages
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!,
                                     senderDisplayName: String!, date: NSDate!) {
        
        let itemRef = messageRef.childByAutoId() // 1
        let messageItem = [ // 2
            "text": text,
            "senderId": senderId,
            "senderName": senderDisplayName,
            "date": date.description
        ]
        itemRef.setValue(messageItem) // 3

        // 4
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        // 5
        finishSendingMessage()
        isTyping = false
        
    }
    
    // MARK: - JSQ Collection View
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
            as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView!.textColor = UIColor.whiteColor()
        } else {
            cell.textView!.textColor = UIColor.blackColor()
        }
        
        return cell
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        print(indexPath.item)
        if indexPath.item % 3 == 0 {
            let message = self.messages[indexPath.item]
            print(message.date)
            return JSQMessagesTimestampFormatter.sharedFormatter().attributedTimestampForDate(message.date)
        }
        else{
            return nil;
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        let data = self.collectionView(self.collectionView, messageDataForItemAtIndexPath: indexPath)
        if (self.senderDisplayName == data.senderDisplayName()) {
            return nil
        }
        return NSAttributedString(string: data.senderDisplayName())
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        let data = self.collectionView(self.collectionView, messageDataForItemAtIndexPath: indexPath)
        if (self.senderDisplayName == data.senderDisplayName()) {
            return 0.0
        }
        return kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        if indexPath.item % 3 == 0 {
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        }
        
        return 0.0
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item] // 1
        if message.senderId == senderId { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    // MARK: - JSQ Typing Indicator
    override func textViewDidChange(textView: UITextView) {
        super.textViewDidChange(textView)
        // If the text is not empty, the user is typing
        isTyping = textView.text != ""
    }
    
    private func observeTyping() {
        let typingIndicatorRef = roomRef.childByAppendingPath("typingIndicator")
        userIsTypingRef = typingIndicatorRef.childByAppendingPath(senderId)
        userIsTypingRef.onDisconnectRemoveValue()
        
        // 1
        usersTypingQuery = typingIndicatorRef.queryOrderedByValue().queryEqualToValue(true)
        
        // 2
        usersTypingQuery.observeEventType(.Value) { (data: FDataSnapshot!) in
            
            // 3 You're the only typing, don't show the indicator
            if data.childrenCount == 1 && self.isTyping {
                return
            }
            
            // 4 Are there others typing?
            self.showTypingIndicator = data.childrenCount > 0
            self.scrollToBottomAnimated(true)
        }
        
    }
    
    // MARK: - JSQ Chat Bubbles
    private func setupBubbles() {
        let factory = JSQMessagesBubbleImageFactory()
        outgoingBubbleImageView = factory.outgoingMessagesBubbleImageWithColor(
            UIColor.jsq_messageBubbleBlueColor())
        incomingBubbleImageView = factory.incomingMessagesBubbleImageWithColor(
            UIColor.jsq_messageBubbleLightGrayColor())
    }
    
    
}

