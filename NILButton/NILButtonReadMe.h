//
//  NILButtonReadMe.h
//
//  Created by Nick Ignatenko Leonidevich on 2017-03-11.
//  Copyright © 2017 Nick Ignatenko. All rights reserved.
//

/*
 
 Handy SKSpriteNode button class written in Objective-C that handles touch events within itself.
 
 
 -----------------------------------------------------------------------------------
 --- EXAMPLE of a 'MyScene' implementation file utilizing the 'NILButton' class: ---
 -----------------------------------------------------------------------------------
 
 #import "MyScene.h"
 #import "NILButton.h"
 
 
 @interface MyScene () <NILButtonDelegate>
 
 @end
 
 
 @implementation MyScene
 
 
 #pragma mark - Init
 
 - (instancetype)initWithSize:(CGSize)size {
 
    self = [super initWithSize:size];
    if (self) {
        [self setupButton];
        NSLog(@"My scene initialized.");
    }
    return self;
 }
 
 
 #pragma mark - Button
 
 - (void)setupButton {
 
    NILButton *button = [[NILButton alloc] initWithType:NILButtonTypeIconAndLabel size:CGSizeMake(100, 100)];
    button.delegate = self; // Important for delegate reporting.
    button.userInteractionEnabled = YES; // Important for registering touches.
    [self addChild:button];
 
    // BONUS: Examples of a few public properties (not required to be called):
    button.releasedButtonSFX = @""; // OR "= nil;" will turn off the 'release' sound effect.
    button.iconSize = CGSizeMake(button.frame.size.width*0.65f, button.frame.size.height*0.65f); // Will resize the buttons icon.
    //button.backgroundSelectedStateImageName = @"selectedButtonImageName"; // There's the buttons background images.
    //button.iconSelectedStateImageName = @"selectedButtonIconImageName"; // Then there's the buttons icon images.
    // Etc.. Check out the 'NILButton' header file for other properties.
 }
 
 
 #pragma mark - Button delegate
 
 // [NILButton delegate method]: Called when 'touchesBegan:' was registered.
 - (void)touchedDownButton:(NILButton *)button {
    
    //[button runAction:[SKAction scaleTo:0.95f duration:0.1f]]; // An example of an SKAction animation.
    NSLog(@"%@ registered 'touchesBegan:' method.", button.name);
 }

 - (void)touchedUpButton:(NILButton *)button {
    
    //[button runAction:[SKAction scaleTo:1.0f duration:0.1f]];
    NSLog(@"%@ registered 'touchesEnded:' method.", button.name);
 }

 - (void)touchMovedButton:(NILButton *)button {
    
    NSLog(@"%@ registered 'touchesMoved:' method.", button.name);
 }

 - (void)touchCancelledButton:(NILButton *)button {
    
    //[button runAction:[SKAction scaleTo:1.0f duration:0.1f]];
    NSLog(@"%@ registered 'touchesCancelled:' method.", button.name);
 }
 
 @end
 
 */

