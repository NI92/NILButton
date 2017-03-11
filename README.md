# NILButton
Handy SKSpriteNode button class written in Objective-C that handles touch events within itself. Flexible for simple & intermediate use. More advanced functionality would either need to be requested or personally coded in.

This button class was designed to holster a customizable icon & a customizable title. They can be mutually exclusive & invidually tuned. Such as their positions, visual layouts & so forth. 

##Screenshots
![nilbuttontypeiconandlabel_def](https://cloud.githubusercontent.com/assets/7210796/23826544/4b30799e-06af-11e7-8232-50ae4fadb1c5.png)
![nilbuttontypeiconandlabel_sel](https://cloud.githubusercontent.com/assets/7210796/23826553/635fd00a-06af-11e7-9a73-2ca645deea72.png)
![nilbuttontypeicon_def](https://cloud.githubusercontent.com/assets/7210796/23826560/7abaaa22-06af-11e7-8c2c-f6ad69a2fd33.png)
![nilbuttontypelabel_def](https://cloud.githubusercontent.com/assets/7210796/23826566/9055a3f0-06af-11e7-88f4-643944abea5c.png)


##Code Example
 
```
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
    //button.releasedButtonSFX = @""; // OR "= nil;" will turn off the 'release' sound effect.
    //button.iconSize = CGSizeMake(button.frame.size.width*0.65f, button.frame.size.height*0.65f); // Will resize the buttons icon.
    //button.backgroundSelectedStateImageName = @"selectedButtonImageName"; // Selected BACKGROUND image.
    //button.iconSelectedStateImageName = @"selectedButtonIconImageName"; // Selected ICON image.
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
```


##Installation
Simply drag & drop the NILButton folder into your project. Then import the class into a SpriteKit class, such as an SKScene.


##Author
Nick Ignatenko Leonidevich


##License
The MIT License (MIT)

Copyright (c) 2017 Nick Ignatenko Leonidevich

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
