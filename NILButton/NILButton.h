//
//  NILButton.h
//
//  Created by Nick Ignatenko Leonidevich on 2017-03-11.
//  Copyright © 2017 Nick Ignatenko. All rights reserved.
//
//  Button class.

#import <SpriteKit/SpriteKit.h>

@class NILButton;


@protocol NILButtonDelegate <NSObject>

@optional
- (void)touchedDownButton:(NILButton *)button;
- (void)touchedUpButton:(NILButton *)button;
- (void)touchMovedButton:(NILButton *)button;
- (void)touchCancelledButton:(NILButton *)button;

@end


// Button types
typedef NS_ENUM (NSUInteger, NILButtonType) {
    NILButtonTypePlain,         // Size & color (or background image).
    NILButtonTypeIcon,          // Size, color (or background image) & an icon.
    NILButtonTypeLabel,         // Size, color (or background image) & label.
    NILButtonTypeIconAndLabel   // Size, color (or background image), icon & label.
};

// Button object positions
typedef NS_ENUM (NSUInteger, NILButtonObjectPosition) {
    NILButtonObjectPositionTop,
    NILButtonObjectPositionMiddle,
    NILButtonObjectPositionBottom
};


@interface NILButton : SKSpriteNode

@property (weak, nonatomic) id <NILButtonDelegate> delegate;
@property (nonatomic) NILButtonType type; // Defines what objects are available within the button.

// Background & icon images
@property (strong, nonatomic) NSString *backgroundDefaultStateImageName; // Default class object background image. Ignores nil & @"".
@property (strong, nonatomic) NSString *backgroundSelectedStateImageName; // Selected class object background image. Ignores nil & @"".
@property (strong, nonatomic) NSString *iconDefaultStateImageName; // Default icon image. Ignores nil & @"".
@property (strong, nonatomic) NSString *iconSelectedStateImageName; // Selected icon image. Ignores nil & @"".
@property (nonatomic) NILButtonObjectPosition iconPosition; // Icon position within the button itself.
@property (nonatomic) CGSize iconSize; // Icons size.

// Label
@property (strong, nonatomic) NSString *labelText;
@property (strong, nonatomic) UIFont *labelFont;
@property (nonatomic) SKColor *labelDefaultStateFontColor; // Default label text color.
@property (nonatomic) SKColor *labelSelectedStateFontColor; // Selected label text color.
@property (nonatomic) NILButtonObjectPosition labelPosition; // Label position within the button itself.

// SFX
@property (nonatomic) BOOL sfxEnabled;
@property (strong, nonatomic) NSString *selectedButtonSFX; // Input nil or @"" to turn it off (stop it from activating).
@property (strong, nonatomic) NSString *releasedButtonSFX; // Same thing can be done here.


// Init
- (instancetype)initWithType:(NILButtonType)type size:(CGSize)size;

@end
