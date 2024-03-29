//
//  SARInputField.m
//  Global Time
//
//  Created by Stephen Ramthun on 04/02/2017.
//  Copyright © 2017 Stephen Ramthun. All rights reserved.
//

#import "SARInputField.h"

const CGFloat kRectHeight          = 5.0;
const CGFloat kBarMultiplier       = 2.2;
const CGFloat kBarRadius           = 3.0;
const CGFloat kFontOpacityInactive = 0.3;

@interface SARInputField ()

@property (nonatomic) NSColor *fillColor;

@end

@implementation SARInputField

- (instancetype)initWithCoder:(NSCoder *)coder {
  if (self = [super initWithCoder:coder]) {
    _fillColor = [NSColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    [self setPlaceholderAttributedString:[self attributedStringWithFontSize:26.0 string:@"city"]];
  }
  return self;
}

/**
 * Creates and returns a NSAttributedString.
 *
 * @param fontSize    size of font
 * @return            an allocated and initialized attributed string object
 */
- (NSAttributedString *)attributedStringWithFontSize:(CGFloat)fontSize string:(NSString *)string {
  NSFont *placeHolderFont               = [NSFont systemFontOfSize:fontSize];
  NSColor *placeHolderFontColor         = [NSColor colorWithRed:1.00 green:0.91 blue:0.49 alpha:kFontOpacityInactive];
  NSDictionary *placeHolderAttributes   = @{NSForegroundColorAttributeName:placeHolderFontColor,
                                            NSFontAttributeName:placeHolderFont};
  NSAttributedString *placeHolderString = [[NSAttributedString alloc] initWithString:string
                                                                          attributes:placeHolderAttributes];
  return placeHolderString;
}

#pragma mark - Text Field Delegate

- (void)textDidChange:(NSNotification *)notification {
  [self setNeedsDisplay];
}

- (void)textDidBeginEditing:(NSNotification *)notification {
  self.fillColor = [NSColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:kFontOpacityInactive];
  [self setNeedsDisplay];
}

- (void)textDidEndEditing:(NSNotification *)notification {
  self.fillColor = [NSColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
  [self setNeedsDisplay];
  
  if (self.stringValue.length < 1) {
    return;
  }
  SEL selector = NSSelectorFromString(@"userEnteredString:");
  if ([self.delegate respondsToSelector:selector]) {
    [self.delegate performSelector:selector withObject:self.stringValue];
  }
}

#pragma mark - Drawing

- (void)drawRect:(NSRect)dirtyRect {
  [super drawRect:dirtyRect];
  [self.fillColor setFill];
  
  CGFloat barWidth   = [self.stringValue sizeWithAttributes:nil].width;
  NSRect  rect       = NSMakeRect(0.0,
                                  NSHeight(self.frame) - kRectHeight,
                                  ceil(barWidth * kBarMultiplier),
                                  kRectHeight);
  NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:rect xRadius:kBarRadius yRadius:kBarRadius];
  [path fill];
}

@end
