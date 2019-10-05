//
//  GameScene.m
//  SpriteContainerAssignment
//
//  Created by Tom Belov on 02/10/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "GameScene.h"

static const uint32_t category_fence = 0x1 << 3;
static const uint32_t category_football	= 0x1 << 2;
static const uint32_t category_ball	= 0x1 << 1;

typedef NS_ENUM(NSUInteger, BallType) {
	ball,
	football,
};

@interface GameScene () <SKPhysicsContactDelegate>

@property (nonatomic, strong, nullable) UITouch *motivatingTouch;
@property (nonatomic, assign) NSInteger ballsNumber;

@end

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
}

- (void)didMoveToView:(SKView *)view {
	self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
	self.physicsBody.categoryBitMask = category_fence;
	self.physicsBody.collisionBitMask = 0x0;
	self.physicsBody.contactTestBitMask = 0x0;
	self.physicsWorld.contactDelegate = self;

	SKSpriteNode *ball1 = [self createBallWithX:100.0
										   andY:self.size.height / 2
								   andVelocity:CGVectorMake(200.0, 200.0)
										andType:ball
										andName:@"Ball1"];
	SKSpriteNode *ball2 = [self createBallWithX:300.0
										   andY:self.size.height / 2
								   andVelocity:CGVectorMake(0.0, 0.0)
										andType:ball
										andName:@"Ball2"];

	[self addChild:ball1];
	[self addChild:ball2];
}

- (SKSpriteNode *)createBallWithX:(CGFloat)x andY:(CGFloat)y andVelocity:(CGVector)velocity andType:(BallType)balltype andName:(NSString *)ballName
{
	NSString *ballFilename;
	uint32_t contactCategory;
	uint32_t contactTestCategory;
	switch (balltype) {
		case ball:
			ballFilename = @"ball.png";
			contactCategory = category_ball;
			contactTestCategory = category_football;
			break;
		default:
			ballFilename = @"football.png";
			contactCategory = category_football;
			contactTestCategory = category_ball;
			break;
	}

	SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:ballFilename];

	ball.name = ballName;
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
	ball.physicsBody.categoryBitMask = contactCategory;
	ball.physicsBody.contactTestBitMask = contactTestCategory | category_fence;
	ball.physicsBody.collisionBitMask = category_ball | category_football | category_fence;
	ball.physicsBody.usesPreciseCollisionDetection = NO;

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
	NSString *ballName = @"Football";
	[ballName stringByAppendingFormat:@"%ld", _ballsNumber];
	self.ballsNumber++;
	SKSpriteNode *ball = [self createBallWithX:location.x
										  andY:location.y
								  andVelocity:CGVectorMake(200.0, 200.0)
									   andType:football
									   andName:ballName];
	[self addChild:ball];
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
	NSString *nameA = contact.bodyA.node.name;
	NSString *nameB = contact.bodyB.node.name;

	if (([nameA containsString:@"Ball"] && [nameB containsString:@"Football"]) || ([nameA containsString:@"Football"] && [nameB containsString:@"Ball"])) {
		[self removeFromParent];
	}
}

-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
