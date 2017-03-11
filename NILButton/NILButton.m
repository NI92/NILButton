//
//  NILButton.m
//
//  Created by Nick Ignatenko Leonidevich on 2017-03-11.
//  Copyright © 2017 Nick Ignatenko. All rights reserved.
//

#import "NILButton.h"


@interface NILButton ()

@property (nonatomic) CGSize privateSize;

// Type data
@property (strong, nonatomic) SKLabelNode *label;
@property (strong, nonatomic) SKSpriteNode *icon;

@property (nonatomic) CGFloat labelYOffset; // Used to correct a labels default offset position.

// SFX
@property (strong, nonatomic) SKAction *playSFXSelect;
@property (strong, nonatomic) SKAction *playSFXRelease;
@property (nonatomic) BOOL privateSFXSelectEnabled;
@property (nonatomic) BOOL privateSFXReleaseEnabled;

@end


@implementation NILButton


#pragma mark - Init

/** Designated initializer method. */
- (instancetype)initWithType:(NILButtonType)type size:(CGSize)size {
    
    self = [super initWithColor:[SKColor clearColor] size:size];
    if (self) {
        _privateSize = size;
        [self setupDefaults];
        self.type = type; // Using 'self.' instead of '_' on purpose to call upon setter!
    }
    return self;
}

// *Note: In case the user of this class is a bombaclaud & doesn't check the header file, then these methods will try to correct thy lack of attention. Delete or comment out the following 5 methods if you don't need them.

- (instancetype)initWithTexture:(nullable SKTexture *)texture color:(SKColor *)color size:(CGSize)size {
    
    self = [super initWithTexture:texture color:color size:size];
    if (self) {
        _privateSize = size;
        [self setupDefaults];
        self.type = NILButtonTypePlain;
    }
    return self;
}

- (instancetype)initWithTexture:(nullable SKTexture *)texture {
    
    self = [super initWithTexture:texture];
    if (self) {
        _privateSize = self.frame.size;
        [self setupDefaults];
        self.type = NILButtonTypePlain;
    }
    return self;
}

- (instancetype)initWithImageNamed:(NSString *)name {
    
    self = [super initWithImageNamed:name];
    if (self) {
        _privateSize = self.frame.size;
        [self setupDefaults];
        self.type = NILButtonTypePlain;
    }
    return self;
}

- (instancetype)initWithColor:(SKColor *)color size:(CGSize)size {
    
    self = [super initWithColor:color size:size];
    if (self) {
        _privateSize = size;
        [self setupDefaults];
        self.type = NILButtonTypePlain;
    }
    return self;
}

- (instancetype)init {
    
    CGSize defaultSize = CGSizeMake(32, 32);
    
    self = [super initWithColor:[SKColor clearColor] size:defaultSize];
    if (self) {
        _privateSize = defaultSize;
        [self setupDefaults];
        self.type = NILButtonTypePlain;
    }
    return self;
}


#pragma mark - Lifecycle

- (void)dealloc {
    
    self.delegate = nil;
    self.label = nil;
    self.icon = nil;
}


#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (touches.count == 1) {
        [self buttonSelected];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (touches.count == 1) {
        [self buttonReleased];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (touches.count == 1) {
        if ([self.delegate respondsToSelector:@selector(touchMovedButton:)]) {
            [self.delegate touchMovedButton:self];
        }
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (touches.count == 1) {
        [self buttonReleased];
    }
}


#pragma mark - Defaults

- (void)setupDefaults {
    
    self.name = @"Button";
    // Default images
    self.backgroundDefaultStateImageName = @"nilButton_background_frame_def";
    self.backgroundSelectedStateImageName = @"nilButton_background_frame_sel";
    
    // Private objects
    [self setupIcon];
    [self setupLabel];
    [self setupSFX];
}


#pragma mark - Icon

/** Default icon configuration. */
- (void)setupIcon {
    
    self.icon = [[SKSpriteNode alloc] initWithColor:[SKColor orangeColor] size:CGSizeMake(self.privateSize.width/3,
                                                                                          self.privateSize.height/3)];
    self.icon.name = @"Button Icon";
    self.icon.zPosition = self.zPosition++;
    [self addChild:self.icon];
    
    self.iconPosition = NILButtonIconPositionMiddle;
    self.iconSize = self.icon.frame.size;
    
    [self enableIcon:YES];
    
    // Default images
    self.iconDefaultStateImageName = @"nilButton_icon_questionMark_def";
    self.iconSelectedStateImageName = @"nilButton_icon_questionMark_sel";
}


#pragma mark - Label

/** Default label configuration. */
- (void)setupLabel {
    
    self.label = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
    self.label.name = @"Button Label";
    self.label.fontColor = [SKColor blackColor];
    self.label.fontSize = 12.0f;
    self.label.zPosition = self.zPosition++;
    self.label.text = @"button";
    [self addChild:self.label];
    
    self.labelPosition = NILButtonLabelPositionBottom;
    
    [self enableLabel:YES];
    
    // Default font data
    _labelFont = [UIFont fontWithName:self.labelFont.fontName size:self.label.fontSize];
    _labelDefaultStateFontColor = self.label.fontColor;
    _labelSelectedStateFontColor = [SKColor whiteColor];
}


#pragma mark - SFX

/** default sound effects. */
- (void)setupSFX {
    
    self.sfxEnabled = YES;
    
    self.selectedButtonSFX = @"nilButtonSFXSelect";
    self.releasedButtonSFX = @"nilButtonSFXRelease";
    self.privateSFXSelectEnabled = YES;
    self.privateSFXReleaseEnabled = YES;
}


#pragma mark - Getters

/** Label frame can change after it was created. The offset getter makes sure to check for the new value every time it's called. */
- (CGFloat)labelYOffset {
    
    if (self.label) {
        return -(self.label.frame.size.height/2);
    }
    return _labelYOffset;
}


#pragma mark - Setters

- (void)setType:(NILButtonType)type {
    
    _type = type;
    
    switch (type) {
        case NILButtonTypePlain:
            [self enableIcon:NO];
            [self enableLabel:NO];
            break;
            
        case NILButtonTypeIcon:
            [self enableIcon:YES];
            [self enableLabel:NO];
            break;
            
        case NILButtonTypeLabel:
            [self enableIcon:NO];
            [self enableLabel:YES];
            break;
            
        case NILButtonTypeIconAndLabel:
            [self enableIcon:YES];
            [self enableLabel:YES];
            break;
    }
}

- (void)setLabelText:(NSString *)labelText {
    
    _labelText = labelText;
    
    self.label.text = labelText;
}

- (void)setLabelFont:(UIFont *)labelFont {
    
    _labelFont = labelFont;
    
    self.label.fontName = labelFont.fontName;
    self.label.fontSize = labelFont.pointSize;
}

- (void)setLabelDefaultStateFontColor:(UIColor *)labelDefaultStateFontColor {
    
    _labelDefaultStateFontColor = labelDefaultStateFontColor;
    
    self.label.fontColor = labelDefaultStateFontColor;
}

- (void)setLabelSelectedStateFontColor:(UIColor *)labelSelectedStateFontColor {
    
    _labelSelectedStateFontColor = labelSelectedStateFontColor;
    
    self.label.fontColor = labelSelectedStateFontColor;
}

/** Re-positions the label within the button accordingly. */
- (void)setLabelPosition:(NILButtonLabelPosition)labelPosition {
    
    _labelPosition = labelPosition;
    
    switch (labelPosition) {
        case NILButtonLabelPositionTop:
            self.label.position = CGPointMake(0, (self.privateSize.height/2)-(self.label.frame.size.height-self.labelYOffset));
            break;
            
        case NILButtonLabelPositionMiddle:
            self.label.position = CGPointMake(0, self.labelYOffset);
            break;
            
        case NILButtonLabelPositionBottom:
            self.label.position = CGPointMake(0, -(self.privateSize.height/2)+(self.label.frame.size.height+self.labelYOffset));
            break;
    }
}

- (void)setBackgroundDefaultStateImageName:(NSString *)backgroundDefaultStateImageName {
    
    if (backgroundDefaultStateImageName.length >= 1) {
        _backgroundDefaultStateImageName = backgroundDefaultStateImageName;
        [self backgroundImageName:backgroundDefaultStateImageName];
    }
}

- (void)setBackgroundSelectedStateImageName:(NSString *)backgroundSelectedStateImageName {
    
    if (backgroundSelectedStateImageName.length >= 1) {
        _backgroundSelectedStateImageName = backgroundSelectedStateImageName;
    }
}

- (void)setIconDefaultStateImageName:(NSString *)iconDefaultStateImageName {
    
    if (iconDefaultStateImageName.length >= 1) {
        _iconDefaultStateImageName = iconDefaultStateImageName;
        [self iconImageName:iconDefaultStateImageName];
    }
}

- (void)setIconSelectedStateImageName:(NSString *)iconSelectedStateImageName {
    
    if (iconSelectedStateImageName.length >= 1) {
        _iconSelectedStateImageName = iconSelectedStateImageName;
    }
}

/** Re-positions the icon within the button accordingly. */
- (void)setIconPosition:(NILButtonIconPosition)iconPosition {
    
    _iconPosition = iconPosition;
    
    switch (iconPosition) {
        case NILButtonIconPositionTop:
            self.icon.position = CGPointMake(0, (self.privateSize.height/2)-(self.icon.frame.size.height*0.75f));
            break;
            
        case NILButtonIconPositionMiddle:
            self.icon.position = CGPointMake(0, 0);
            break;
            
        case NILButtonIconPositionBottom:
            self.icon.position = CGPointMake(0, -(self.privateSize.height/2)+(self.icon.frame.size.height*0.75f));
            break;
    }
}

/** Icon node resizing. */
- (void)setIconSize:(CGSize)iconSize {
    
    _iconSize = iconSize;
    
    [self.icon setSize:iconSize];
    [self iconImageName:self.iconDefaultStateImageName];
}

- (void)setSelectedButtonSFX:(NSString *)selectedButtonSFX {
    
    _selectedButtonSFX = selectedButtonSFX;
    
    if (selectedButtonSFX.length <= 0) {
        self.privateSFXSelectEnabled = NO;
    }
    self.playSFXSelect = [SKAction playSoundFileNamed:selectedButtonSFX waitForCompletion:NO];
}

- (void)setReleasedButtonSFX:(NSString *)releasedButtonSFX {
    
    _releasedButtonSFX = releasedButtonSFX;
    
    if (releasedButtonSFX.length <= 0) {
        self.privateSFXReleaseEnabled = NO;
    }
    self.playSFXRelease = [SKAction playSoundFileNamed:releasedButtonSFX waitForCompletion:NO];
}


#pragma mark - Helpers

/** Convenience method for setting up the background (class) node's image texture. */
- (void)backgroundImageName:(NSString *)imageName {
    
    if (imageName) {
        self.texture = [SKTexture textureWithImageNamed:imageName];
        self.texture.filteringMode = SKTextureFilteringNearest;
    }
}

/** Convenience method for setting up the icon node's image texture. */
- (void)iconImageName:(NSString *)imageName {
    
    if (imageName) {
        self.icon.texture = [SKTexture textureWithImageNamed:imageName];
        self.icon.texture.filteringMode = SKTextureFilteringNearest;
    }
}

/** Whether the label can be seen & interacted with or not. */
- (void)enableLabel:(BOOL)enable {
    
    if (enable) {
        self.label.hidden = NO;
    }
    else {
        self.label.hidden = YES;
    }
}

/** Whether the icon can be seen & interacted with or not. */
- (void)enableIcon:(BOOL)enable {
    
    if (enable) {
        self.icon.hidden = NO;
    }
    else {
        self.icon.hidden = YES;
    }
}

/** Convenience method for handling a touch down event. */
- (void)buttonSelected {
    
    if (self.sfxEnabled && self.privateSFXSelectEnabled) {
        [self runAction:self.playSFXSelect];
    }
    [self backgroundImageName:@"nilButton_background_frame_sel"];
    [self iconImageName:self.iconSelectedStateImageName];
    
    if ([self.delegate respondsToSelector:@selector(touchedDownButton:)]) {
        [self.delegate touchedDownButton:self];
    }
}

/** Convenience method for handling a touch up event. */
- (void)buttonReleased {
    
    if (self.sfxEnabled && self.privateSFXReleaseEnabled) {
        [self runAction:self.playSFXRelease];
    }
    [self backgroundImageName:@"nilButton_background_frame_def"];
    [self iconImageName:self.iconDefaultStateImageName];
    
    if ([self.delegate respondsToSelector:@selector(touchedUpButton:)]) {
        [self.delegate touchedUpButton:self];
    }
}

@end
