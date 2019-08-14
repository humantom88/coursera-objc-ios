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

static const CGFloat kTrackPixelsPerSecond = 1000;

- (void)didMoveToView:(SKView *)view
{
	self.backgroundColor = [SKColor blackColor];
	self.scaleMode = SKSceneScaleModeAspectFit;
	self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
	SKNode *ball = [self childNodeWithName:@"ball"];
	ball.physicsBody.angularVelocity = 1.0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	// Run 'Pulse' action from 'Actions.sks'
	[_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];

	for (UITouch *touch in touches) {
		CGPoint p = [touch locationInNode:self];
		NSLog(@"\n %f %f %f %f", p.x, p.y, self.frame.size.width, self.frame.size.height);

		if (p.x < self.frame.size.height * 0.3) {
			self.leftPaddleMotivatingTouch = touch;
			NSLog(@"Left");
		} else if (p.x > self.frame.size.height * 0.7) {
			self.rightPaddleMotivatingTouch = touch;
			NSLog(@"Right");
		} else {
			SKNode *ball = [self childNodeWithName:@"ball"];
			ball.physicsBody.velocity = CGVectorMake(ball.physicsBody.velocity.dx * 2.0, ball.physicsBody.velocity.dy);
		}

		[self trackPaddlesNoMotivatingTouches];
	}
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self trackPaddlesNoMotivatingTouches];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self clearTouches:touches];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self clearTouches:touches];
}

- (void)clearTouches:(NSSet *)touches
{
	if ([touches containsObject:self.leftPaddleMotivatingTouch])
	{
		self.leftPaddleMotivatingTouch = nil;
	}

	if ([touches containsObject:self.rightPaddleMotivatingTouch])
	{
		self.rightPaddleMotivatingTouch = nil;
	}
}

- (void)trackPaddlesNoMotivatingTouches
{
	id a = @[@{@"node": [self childNodeWithName:@"leftPaddle"],
			   @"touch": self.leftPaddleMotivatingTouch ?: [NSNull null]},
			 @{@"node": [self childNodeWithName:@"rightPaddle"],
			   @"touch": self.rightPaddleMotivatingTouch ?: [NSNull null]}];
	for (NSDictionary *o in a)
	{
		SKNode *node = o[@"node"];
		UITouch *touch = o[@"touch"];

		if ([[NSNull null] isEqual:touch])
		{
			continue;
		}

		CGFloat yPos = [touch locationInNode:self].y;
		NSTimeInterval duration = ABS(yPos - node.position.y) / kTrackPixelsPerSecond;

		SKAction *moveAction = [SKAction moveToY:yPos duration:duration];
		[node runAction:moveAction withKey:@"moving!"];

	}
}


-(void)update:(CFTimeInterval)currentTime
{
	// Called before each frame is rendered
}

@end
