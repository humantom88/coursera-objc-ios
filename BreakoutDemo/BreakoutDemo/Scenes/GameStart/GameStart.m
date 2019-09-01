//
//  GameStart.m
//  BreakoutDemo
//
//  Created by Artyom Belov on 14/08/2019.
//  Copyright © 2019 Artyom Belov. All rights reserved.
//

#import "GameStart.h"
#import "GameScene.h"

@implementation GameStart

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	if (touches)
	{
		SKView *skView = (SKView *)self.view;

		GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];

		// Set the scale mode to scale to fit the window
		scene.scaleMode = SKSceneScaleModeAspectFit;

		// Present the scene
		[skView presentScene:scene];
	}
}

@end
