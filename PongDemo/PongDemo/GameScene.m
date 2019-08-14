//
//  GameScene.m
//  PongDemo
//
//  Created by Tom Belov on 12/08/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "GameScene.h"

@interface GameScene ()

@property (strong, nonatomic) UITouch *leftPaddleMotivatingTouch;
@property (strong, nonatomic) UITouch *rightPaddleMotivatingTouch;

@end

@implementation GameScene {
	SKShapeNode *_spinnyNode;
	SKLabelNode *_label;
}

- (void)didMoveToView:(SKView *)view {
	self.backgroundColor = [SKColor blackColor];
	self.scaleMode = SKSceneScaleModeAspectFit;
	self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
	SKNode *ball = [self childNodeWithName:@"ball"];
	ball.physicsBody.angularVelocity = 1.0;
}


- (void)touchDownAtPoint:(CGPoint)pos {
	SKShapeNode *n = [_spinnyNode copy];
	n.position = pos;
	n.strokeColor = [SKColor greenColor];
	[self addChild:n];
}

- (void)touchMovedToPoint:(CGPoint)pos {
	SKShapeNode *n = [_spinnyNode copy];
	n.position = pos;
	n.strokeColor = [SKColor blueColor];
	[self addChild:n];
}

- (void)touchUpAtPoint:(CGPoint)pos {
	SKShapeNode *n = [_spinnyNode copy];
	n.position = pos;
	n.strokeColor = [SKColor redColor];
	[self addChild:n];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	// Run 'Pulse' action from 'Actions.sks'
	[_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];

	for (UITouch *touch in touches) {
		CGPoint p = [touch locationInNode:self];
		NSLog(@"\n %f %f %f %f", p.x, p.y, self.frame.size.width, self.frame.size.height);

		if (p.x < self.scene.size.width * 0.3) {
			self.leftPaddleMotivatingTouch = touch;
			NSLog(@"Left");
		} else if (p.x > self.scene.size.width * 0.7) {
			self.rightPaddleMotivatingTouch = touch;
			NSLog(@"Right");
		} else {
			SKNode *ball = [self childNodeWithName:@"ball"];
			ball.physicsBody.velocity = CGVectorMake(ball.physicsBody.velocity.dx * 2.0, ball.physicsBody.velocity.dy);
		}
	}
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	// for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self]];}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	// for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	// for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}


-(void)update:(CFTimeInterval)currentTime {
	// Called before each frame is rendered
}

@end
