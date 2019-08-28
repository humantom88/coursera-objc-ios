//
//  GameOver.m
//  BreakoutDemo
//
//  Created by Artyom Belov on 14/08/2019.
//  Copyright © 2019 Artyom Belov. All rights reserved.
//

#import "GameOver.h"
#import "GameScene.h"

@implementation GameOver

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if (touches){
		GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];

		// Set the scale mode to scale to fit the window
		scene.scaleMode = SKSceneScaleModeAspectFit;

		SKView *skView = (SKView *)self.view;

		// Present the scene
		[skView presentScene:scene];
	}
}

@end
