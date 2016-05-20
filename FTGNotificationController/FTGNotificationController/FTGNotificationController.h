//
//  FTGNotificationController.h
//  FTGNotificationControllerDemo
//
//  Created by Khoa Pham on 6/19/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @abstract Block called on notification post notification.
 @param note The notification.
 @param observer The observer.
 */
typedef void (^FTGNotificationBlock)(NSNotification *note, id observer);


/**
 @abstract FTGNotificationController makes Notification Observing simpler and safer.
 @discussion FTGNotificationController adds support for handling notifications with blocks and custom actions. Notification will never message a deallocated observer. Observer removal never throws exceptions, and observers are removed implicitely on controller deallocation. FTGNotificationController is also thread safe. When used in a concurrent environment, it protects observers from possible ressurection and avoids ensuing crash. By default, the controller maintains a strong reference to objects observed.
 */
@interface FTGNotificationController : NSObject

/**
 @abstract Creates and returns an initialized Notification controller instance.
 @param observer The object notified on notification post.
 @return The initialized Notification controller instance.
 */
+ (instancetype)controllerWithObserver:(id)observer;

/**
 @abstract Convenience initializer.
 @param observer The object notified on notification post. The specified observer must support weak references.
 @return The initialized Notification controller instance.
 @discussion By default, Notification controller retains objects observed.
 */
- (instancetype)initWithObserver:(id)observer;

/// The observer notified on notification post. Specified on initialization.
@property (atomic, weak, readonly) id observer;

/**
 @abstract Registers observer for notification post.
 @param notificationName The name of the notification for which to register the observer; that is, only notifications with this name are used to add the block to the operation queue.
 @param object The object whose notifications you want to add the block to the operation queue.
 @param queue The operation queue to which block should be added.
 @param block The block to be executed when the notification is received.
 @discussion On notification post, the specified block is called. Inorder to avoid retain loops, the block must avoid referencing the Notification controller or an owner thereof. Observing an already observed notification or nil is allowed.
 */
- (void)observeNotificationName:(NSString *)notificationName
                         object:(id)object
                          queue:(NSOperationQueue *)queue
                          block:(FTGNotificationBlock)block;

/**
 @abstract Registers observer for notification post.
 @param notificationName The name of the notification for which to register the observer; that is, only notifications with this name are used to add the block to the operation queue.
 @param object The object whose notifications you want to add the block to the operation queue.
 @param action Selector that specifies the message the receiver sends notificationObserver to notify it of the notification posting.
 @discussion On notification post, the specified block is called. Inorder to avoid retain loops, the block must avoid referencing the Notification controller or an owner thereof. Observing an already observed notification or nil is allowed.
 */
- (void)observeNotificationName:(NSString *)notificationName
                         object:(id)object
                         action:(SEL)action;


/**
 @abstract Registers observer for multiple notification posts.
 @param notificationNames The names of the notifications for which to register the observer; that is, only notifications with this name are used to add the block to the operation queue.
 @param object The object whose notifications you want to add the block to the operation queue.
 @param queue The operation queue to which block should be added.
 @param block The block to be executed when the notification is received.
 @discussion On notification post, the specified block is called. Inorder to avoid retain loops, the block must avoid referencing the Notification controller or an owner thereof. Observing an already observed notification or nil is allowed.
 */
- (void)observeNotificationNames:(NSArray *)notificationNames
                         object:(id)object
                          queue:(NSOperationQueue *)queue
                          block:(FTGNotificationBlock)block;

/**
 @abstract Registers observer for multiple notification posts.
 @param notificationNames The names of the notifications for which to register the observer; that is, only notifications with this name are used to add the block to the operation queue.
 @param object The object whose notifications you want to add the block to the operation queue.
 @param action Selector that specifies the message the receiver sends notificationObserver to notify it of the notification posting.
 @discussion On notification post, the observer's action selector is called. Observing an already observed notification or nil is allowed.
 */
- (void)observeNotificationNames:(NSArray *)notificationNames
                         object:(id)object
                         action:(SEL)action;

/**
 @abstract Unobserve notification that specifies object.
 @param notificationName Name of the notification to remove.
 @param object Specify a notification sender to remove only entries that specify this object.
 @discussion If not observing notification, or unobserving nil, this method is allowed.
 */
- (void)unobserveNotificationName:(NSString *)notificationName
                           object:(id)object;

/**
 @abstract Unobserve all notifications.
 @discussion If not observing any notifications, this method is allowed.
 */
- (void)unobserveAll;

@end

