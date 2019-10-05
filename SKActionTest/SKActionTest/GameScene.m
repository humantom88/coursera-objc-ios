//
//  GameScene.m
//  SKActionTest
//
//  Created by Tom Belov on 05/10/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "GameScene.h"

// PROGRAM DOESN'T WORK, JUST EXAMPLE OF USING ACTIONS

static const uint32_t category_fence = 0x0 << 2;
static const uint32_t category_ball = 0x0 << 1;
static const uint32_t category_ball_blue = 0x0 << 3;
static const uint32_t category_body = 0x0 << 4;

@interface GameScene () <SKPhysicsContactDelegate>

@property (nonatomic, assign) int state;
@property (nonatomic, strong) SKSpriteNode *man;
@property (nonatomic, strong) SKAction *undo;

@end

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
}

- (void)didMoveToView:(SKView *)view {
	self.state = 0;
	self.name = @"fence";

	self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
	self.physicsWorld.contactDelegate = self;
	self.physicsBody.categoryBitMask = category_fence;
	self.physicsBody.collisionBitMask = 0x0;
	self.physicsBody.contactTestBitMask = 0x0;
	self.physicsBody.friction = 0.5;

	SKFieldNode *fieldNode = [SKFieldNode vortexField];
	fieldNode.position = CGPointMake(self.size.width / 2, self.size.height / 2);
	[self addChild:fieldNode];

	int num = 20;
	for (int i = 0; i < num; i++) {
		SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"blueball.png"];
		sprite.name = @"ball_blue";
		[self addSprite:sprite
		   categoryMask:(category_ball | category_ball_blue)
			contactMask:(category_fence | category_ball)
		  collisionMask:(category_fence | category_ball) | category_body];
	}

	[self makeBody];
}

- (SKSpriteNode *)makeBodyPart:(NSString *)name andZPosition:(int)zPosition andPosition:(CGPoint)position {
	SKSpriteNode *bodyPart = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"%@.png", name]];
	bodyPart.zPosition = zPosition;
	bodyPart.position = position;
	return bodyPart;
}

- (void)makeBody {
	// Sprites
	SKSpriteNode *head, *body, *leg_r, *leg_l, *arm_r, *arm_l;

	head = [self makeBodyPart:@"head" andZPosition:3 andPosition:CGPointMake(300, 300)];
	body = [self makeBodyPart:@"body" andZPosition:-1 andPosition:CGPointMake(0, -1.0 * body.size.height)];
	leg_r = [self makeBodyPart:@"leg_right" andZPosition:-1 andPosition:CGPointMake(.3 * leg_r.size.height, -1 * body.size.height)];
	leg_r.alpha = 1.0;
	leg_l = [self makeBodyPart:@"leg_left" andZPosition:-2 andPosition:CGPointMake(.26 * leg_l.size.height, -1 * body.size.height)];
	leg_l.alpha = 1.0;
	arm_r = [self makeBodyPart:@"arm_right" andZPosition:1 andPosition:CGPointMake(-.50 * arm_r.size.width, -.1 * arm_r.size.height)];
	arm_r.alpha = 1.0;
	arm_l = [self makeBodyPart:@"arm_left" andZPosition:-3 andPosition:CGPointMake(.33 * arm_l.size.width, 0.0)];
	arm_l.alpha = 1.0;

	[body addChild:leg_r];
	[body addChild:leg_l];
	[body addChild:arm_r];
	[body addChild:arm_r];

	[head addChild:body];

	// Physics bodies
	SKPhysicsBody *p_head, *p_body, *p_leg_r, *p_leg_l, *p_arm_r, *p_arm_l;

	p_head = [SKPhysicsBody bodyWithCircleOfRadius:head.size.width / 2];
	p_head.dynamic = YES;
	p_head.affectedByGravity = YES;
	p_head.friction = 0.0;
	p_head.restitution = 0.9;
	p_head.linearDamping = 0.1;
	p_head.angularDamping = 0.1;
	p_head.allowsRotation = NO;
	p_head.categoryBitMask = category_body;
	p_head.contactTestBitMask = 0x0;
	p_head.collisionBitMask = category_ball | category_fence;
	p_head.mass = 0.3;
	p_head.velocity = CGVectorMake(0, 0);
	p_head.usesPreciseCollisionDetection = YES;

	p_body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(body.size.width, body.size.height)
											 center:CGPointMake(0.0, -body.size.height / 2)];
	p_body.dynamic = YES;
	p_body.affectedByGravity = YES;
	p_body.friction = 0.0;
	p_body.restitution = 0.9;
	p_body.linearDamping = 0.1;
	p_body.angularDamping = 0.1;
	p_body.allowsRotation = YES;
	p_body.categoryBitMask = category_body;
	p_body.contactTestBitMask = 0x0;
	p_body.collisionBitMask = category_ball | category_fence;
	p_body.mass = 0.3;
	p_body.velocity = CGVectorMake(0, 0);
	p_body.usesPreciseCollisionDetection = YES;

	p_arm_r = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(arm_r.size.width, arm_r.size.height)];
	p_arm_r.dynamic = YES;
	p_arm_r.affectedByGravity = YES;
	p_arm_r.friction = 0.0;
	p_arm_r.restitution = 0.9;
	p_arm_r.linearDamping = 0.1;
	p_arm_r.angularDamping = 0.1;
	p_arm_r.allowsRotation = YES;
	p_arm_r.categoryBitMask = category_body;
	p_arm_r.contactTestBitMask = 0x0;
	p_arm_r.collisionBitMask = category_ball | category_fence;
	p_arm_r.mass = 0.2;
	p_arm_r.velocity = CGVectorMake(0, 0);
	p_arm_r.usesPreciseCollisionDetection = YES;

	p_arm_l = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(arm_l.size.width, arm_l.size.height)];
	p_arm_l.dynamic = YES;
	p_arm_l.affectedByGravity = YES;
	p_arm_l.friction = 0.0;
	p_arm_l.restitution = 0.9;
	p_arm_l.linearDamping = 0.1;
	p_arm_l.angularDamping = 0.1;
	p_arm_l.allowsRotation = YES;
	p_arm_l.categoryBitMask = category_body;
	p_arm_l.contactTestBitMask = 0x0;
	p_arm_l.collisionBitMask = category_ball | category_fence;
	p_arm_l.mass = 0.2;
	p_arm_l.velocity = CGVectorMake(0, 0);
	p_arm_l.usesPreciseCollisionDetection = YES;

	p_leg_r = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(leg_r.size.width, leg_r.size.height)];
	p_leg_r.dynamic = YES;
	p_leg_r.affectedByGravity = YES;
	p_leg_r.friction = 0.0;
	p_leg_r.restitution = 0.9;
	p_leg_r.linearDamping = 0.1;
	p_leg_r.angularDamping = 0.1;
	p_leg_r.allowsRotation = YES;
	p_leg_r.categoryBitMask = category_body;
	p_leg_r.contactTestBitMask = 0x0;
	p_leg_r.collisionBitMask = category_ball | category_fence;
	p_leg_r.mass = 0.2;
	p_leg_r.velocity = CGVectorMake(0, 0);
	p_leg_r.usesPreciseCollisionDetection = YES;

	p_leg_l = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(leg_l.size.width, leg_l.size.height)];
	p_leg_l.dynamic = YES;
	p_leg_l.affectedByGravity = YES;
	p_leg_l.friction = 0.0;
	p_leg_l.restitution = 0.9;
	p_leg_l.linearDamping = 0.1;
	p_leg_l.angularDamping = 0.1;
	p_leg_l.allowsRotation = YES;
	p_leg_l.categoryBitMask = category_body;
	p_leg_l.contactTestBitMask = 0x0;
	p_leg_l.collisionBitMask = category_ball | category_fence;
	p_leg_l.mass = 0.2;
	p_leg_l.velocity = CGVectorMake(0, 0);
	p_leg_l.usesPreciseCollisionDetection = YES;

	head.physicsBody = p_head;
	body.physicsBody = p_body;
	arm_r.physicsBody = p_arm_r;
	arm_l.physicsBody = p_arm_l;
	leg_r.physicsBody = p_leg_r;
	leg_l.physicsBody = p_leg_l;

	self.man = head;

	[self addChild:head];

	CGPoint headBodyAnchor = CGPointMake(0.0, 0.0);
	SKPhysicsJointPin *headBodyJoint = [SKPhysicsJointPin jointWithBodyA:p_head bodyB:p_body anchor:headBodyAnchor];
	headBodyJoint.shouldEnableLimits = YES;
	headBodyJoint.lowerAngleLimit = -M_PI / 8.0;
	headBodyJoint.upperAngleLimit = M_PI / 8.0;
	headBodyJoint.frictionTorque = 1.0;
	[self.scene.physicsWorld addJoint:headBodyJoint];

	CGPoint bodyArmRAnchor = CGPointMake(0.0, 0.0);
	bodyArmRAnchor.y += body.size.height / 2;
	SKPhysicsJointPin *bodyArmRJoint = [SKPhysicsJointPin jointWithBodyA:p_body bodyB:p_arm_r anchor:bodyArmRAnchor];
	bodyArmRJoint.shouldEnableLimits = YES;
	bodyArmRJoint.lowerAngleLimit = -M_PI / 8.0;
	bodyArmRJoint.upperAngleLimit = M_PI / 4.0;
	bodyArmRJoint.frictionTorque = 1.0;
	[self.scene.physicsWorld addJoint:bodyArmRJoint];

	CGPoint bodyArmLAnchor = CGPointMake(0.0, 0.0);
	bodyArmLAnchor.y += body.size.height / 2;
	SKPhysicsJointPin *bodyArmLJoint = [SKPhysicsJointPin jointWithBodyA:p_body bodyB:p_arm_l anchor:bodyArmLAnchor];
	bodyArmLJoint.shouldEnableLimits = YES;
	bodyArmLJoint.lowerAngleLimit = -M_PI / 4.0;
	bodyArmLJoint.upperAngleLimit = -M_PI_4;
	bodyArmLJoint.frictionTorque = 1.0;
	[self.scene.physicsWorld addJoint:bodyArmLJoint];

	CGPoint bodyLegLAnchor = CGPointMake(0.0, 0.0);
	bodyLegLAnchor.y -= body.size.height / 2;
	SKPhysicsJointPin *bodyLegLJoint = [SKPhysicsJointPin jointWithBodyA:p_body bodyB:p_leg_r anchor:bodyLegLAnchor];
	bodyLegLJoint.shouldEnableLimits = YES;
	bodyLegLJoint.lowerAngleLimit = -M_PI / 4.0;
	bodyLegLJoint.upperAngleLimit = M_PI / 4.0;
	bodyLegLJoint.frictionTorque = 1.0;
	[self.scene.physicsWorld addJoint:bodyLegLJoint];

	CGPoint bodyLegRAnchor = CGPointMake(0.0, 0.0);
	bodyLegRAnchor.y -= body.size.height / 2;
	SKPhysicsJointPin *bodyLegRJoint = [SKPhysicsJointPin jointWithBodyA:p_body bodyB:p_leg_r anchor:bodyLegRAnchor];
	bodyLegRJoint.shouldEnableLimits = YES;
	bodyLegRJoint.lowerAngleLimit = -M_PI / 2.0;
	bodyLegRJoint.upperAngleLimit = M_PI / 0.0;
	bodyLegRJoint.frictionTorque = 1.0;
	[self.scene.physicsWorld addJoint:bodyLegRJoint];
}

- (void)addSprite:(SKSpriteNode *)sprite categoryMask:(uint32_t)categoryMask contactMask:(uint32_t)contactMask collisionMask:(uint32_t)collisionMask {
	sprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:sprite.size.width / 2];
	sprite.physicsBody.dynamic = YES;
	sprite.physicsBody.affectedByGravity = NO;
	sprite.position = CGPointMake(arc4random_uniform(self.size.width), arc4random_uniform(self.size.height));
	sprite.physicsBody.friction = 0.0;
	sprite.physicsBody.restitution = 0.9;
	sprite.physicsBody.linearDamping = 0.1;
	sprite.physicsBody.angularDamping = 0.1;
	sprite.physicsBody.allowsRotation = NO;
	sprite.physicsBody.categoryBitMask = categoryMask;
	sprite.physicsBody.contactTestBitMask = contactMask;
	sprite.physicsBody.collisionBitMask = collisionMask;
	sprite.physicsBody.mass = 1.0;
	sprite.physicsBody.velocity = CGVectorMake(arc4random_uniform(10) - 5.0, arc4random_uniform(10) - 5.0);

	[self addChild:sprite];
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
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (touches) {
		SKAction *action = [SKAction playSoundFileNamed:@"beep.m4a" waitForCompletion:YES];
		[self runAction:action];

		if (self.state == 0) {
			NSLog(@"\nMoving to point");
			action = [SKAction moveTo:CGPointMake(self.size.width / 2, self.size.height - 75) duration:5];
		} else if (self.state == 1) {
			NSLog(@"\nRotating");
			action = [SKAction rotateByAngle:2 * M_PI duration:2];
		} else if (self.state == 2) {
			NSLog(@"\nScale by");
			action = [SKAction scaleBy:2.0 duration:2];
		} else if (self.state == 3) {
			NSLog(@"\nScale X to");
			action = [SKAction scaleXTo:1.0 duration:2];
		} else if (self.state == 4) {
			 NSLog(@"\nScale Y to");
			 action = [SKAction scaleYTo:1.0 duration:2];
			 [self.man runAction:action];
			 self.state++;
		} else if (self.state == 5) {
			NSLog(@"\nFade Out");
			action = [SKAction fadeOutWithDuration:2.0];
		} else if (self.state == 6) {
			NSLog(@"\nFade In");
			action = [SKAction fadeInWithDuration:2.0];
		} else if (self.state == 7) {
			NSLog(@"\nResize");
			action = [SKAction resizeByWidth:200 height:200 duration:2];
			self.undo = [action reversedAction];
		} else if (self.state == 8) {
			NSLog(@"\nUndo");
			action = self.undo;
		} else if (self.state == 9) {
			NSLog(@"\nChange Mass from %f", self.physicsBody.mass);
			action = [SKAction changeMassTo:50 duration:2];
		} else if (self.state == 10) {
			NSLog(@"\nChange Mass from %f", self.physicsBody.mass);
			action = [SKAction changeMassTo:0.1 duration:2];
		} else if (self.state == 11) {
			NSLog(@"\nChange Mass from %f", self.physicsBody.mass);
			action = [SKAction changeMassTo:0.3 duration:2];
		} else if (self.state == 12) {
			NSLog(@"\nPlay Audio");
			action = [SKAction playSoundFileNamed:@"beep.m4a" waitForCompletion:YES];
		} else if (self.state == 13) {
			NSLog(@"\nUse Completion Block");
			action = [SKAction waitForDuration:2];
			[self.man runAction:action completion:^{
				self.man.physicsBody.dynamic = NO;
				SKAction *secondAction = [SKAction waitForDuration:2];
				[self.man runAction:secondAction completion:^{
					self.man.physicsBody.dynamic = YES;
				}];
			}];
			self.state++;
			return;
		} else if (self.state == 14) {
			NSLog(@"\nSequence");
			SKAction *a, *b, *c, *d, *e, *f, *sequence;
			a = [SKAction waitForDuration:2];
			b = [SKAction playSoundFileNamed:@"beep.m4a" waitForCompletion:YES];
			c = [SKAction moveTo:CGPointMake(100, 300) duration:5];
			d = [SKAction runBlock:^{
				self.man.physicsBody.allowsRotation = YES;
			}];
			e = [SKAction runBlock:^{
				self.man.physicsBody.allowsRotation = NO;
			}];
			f = [SKAction rotateToAngle:0 duration:2.0];
			sequence = [SKAction sequence:@[a,b,a,b,a,c,a,d,e,f]];
			action = sequence;
			self.state++;
		}

		[self.man runAction:action];
		self.state++;
	}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
