//
//  GameWon.m
//  BreakoutDemo
//
//  Created by Tom Belov on 05/10/2019.
//  Copyright © 2019 Artyom Belov. All rights reserved.
//

#import "GameWon.h"
#import "GameScene.h"

@implementation GameWon

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	// Called when touch begins
	if (touches) {
		SKView *skView = (SKView *)self.view;
		[self removeFromParent];

		GameScene *scene = [GameScene nodeWithFileNamed:@"GameScene"];
		scene.scaleMode = SKSceneScaleModeAspectFill;

		[skView presentScene:scene];
	}
}

@end
