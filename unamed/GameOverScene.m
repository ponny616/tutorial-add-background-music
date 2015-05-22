//
//  GameOverScene.m
//  unamed
//
//  Created by Tiago Torres on 15/05/15.
//  Copyright (c) 2015 Tiago Torres. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"

@implementation GameOverScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        // 2
        NSString * message;
        message = @"Game Over";
        // 3
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Kohinoor Devanagari Light"];
        label.text = message;
        label.fontSize = 60;
        label.fontColor = [SKColor whiteColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/1.3);
        [self addChild:label];
        
        NSString *littleComment2;
        littleComment2 = @"Haha! Loser!";
        SKLabelNode *comment2 = [SKLabelNode labelNodeWithFontNamed:@"Kohinoor Devanagari Light"];
        comment2.text = littleComment2;
        comment2.fontSize = 20;
        comment2.fontColor = [SKColor whiteColor];
        comment2.position = CGPointMake(self.size.width/3.5, 590);
        [self addChild:comment2];
        
        NSString *littleComment;
        littleComment = @"Wanna...";
        SKLabelNode *comment = [SKLabelNode labelNodeWithFontNamed:@"Kohinoor Devanagari Light"];
        comment.text = littleComment;
        comment.fontSize = 10;
        comment.fontColor = [SKColor whiteColor];
        comment.position = CGPointMake(self.size.width/3, 80);
        [self addChild:comment];
        
        //4
        NSString * tryAgainMessage;
        tryAgainMessage = @"Try Again?";
        SKLabelNode *tryAgainButton = [SKLabelNode labelNodeWithFontNamed:@"Kohinoor Devanagari Light"];
        tryAgainButton.text = tryAgainMessage;
        tryAgainButton.fontColor = [SKColor whiteColor];
        tryAgainButton.position = CGPointMake(self.size.width/2, 50);
        tryAgainButton.name = @"tryAgain";
        [self addChild:tryAgainButton];
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location]; //1
    
    if ([node.name isEqualToString:@"tryAgain"]) { //2
        
        //3
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        GameScene * scene = [GameScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: reveal];
        
    }
}
@end