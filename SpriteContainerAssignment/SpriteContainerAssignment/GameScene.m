//
//  GameScene.m
//  SpriteContainerAssignment
//
//  Created by Tom Belov on 02/10/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "GameScene.h"

@interface GameScene () <SKPhysicsContactDelegate>

@property (nonatomic, strong, nullable) UITouch *motivatingTouch;

@end

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
}

- (void)didMoveToView:(SKView *)view {
	self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
	SKSpriteNode *ball1 = [self createBallWithX:100.0
										   andY:self.size.height / 2
								   andVelocity:CGVectorMake(200.0, 200.0)];
	SKSpriteNode *ball2 = [self createBallWithX:300.0
										   andY:self.size.height / 2
								   andVelocity:CGVectorMake(0.0, 0.0)];

	[self addChild:ball1];
	[self addChild:ball2];
}

- (SKSpriteNode *)createBallWithX:(CGFloat)x andY:(CGFloat)y andVelocity:(CGVector)velocity
{
	SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball.png"];

	ball.size = CGSizeMake(90, 90);
	ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width / 2];
	ball.physicsBody.dynamic = YES;
	ball.position = CGPointMake(x, y);
	ball.physicsBody.friction = 0.0;
	ball.physicsBody.restitution = 1.0;
	ball.physicsBody.linearDamping = 0.5;
	ball.physicsBody.angularDamping = 1.0;
	ball.physicsBody.allowsRotation = YES;
	ball.physicsBody.mass = 2.0;
	ball.physicsBody.velocity = velocity;

	return ball;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	CGRect region = CGRectMake(0, 0, self.size.width, self.size.height);
	region.origin = CGPointMake(-self.size.width / 2, -self.size.height / 2);
	for (UITouch *touch in touches) {
		CGPoint p = [touch locationInNode:self];
		if (CGRectContainsPoint(region, p)) {
			self.motivatingTouch = touch;
		}
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if ([touches containsObject:self.motivatingTouch]) {
		[self processTouch];
		self.motivatingTouch = nil;
	}
}

- (void)processTouch {
	CGPoint location = [self.motivatingTouch locationInNode:self];
	SKSpriteNode *ball = [self createBallWithX:location.x
										  andY:location.y
								  andVelocity:CGVectorMake(200.0, 200.0)];
	[self addChild:ball];
}

-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
