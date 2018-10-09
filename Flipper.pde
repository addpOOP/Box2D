class Flipper
{
  // Box2D body
  Body pBody; 
  PShape pShape;
  boolean leftFlipper;

  Flipper(Vec2 position, boolean leftFlipper)
  {
    this.leftFlipper = leftFlipper;

    PolygonShape shape = new PolygonShape();

    Vec2[] vertices = new Vec2[4];

    if (leftFlipper)
    {
      vertices[0] = new Vec2(0, 0);
      vertices[1] = new Vec2(0, 10);
      vertices[2] = new Vec2(50, 6);
      vertices[3] = new Vec2(0, 4);
    } else
    {
      vertices[0] = new Vec2(0, 0);
      vertices[1] = new Vec2(20, 2);
      vertices[2] = new Vec2(50, 0);
      vertices[3] = new Vec2(50, 10);
    }

    Vec2[] box2DVertices = new Vec2[vertices.length];

    pShape = createShape();
    pShape.beginShape();

    for (int i = 0; i < vertices.length; i++)
    {
      float x = vertices[i].x;
      float y = vertices[i].y;

      pShape.vertex(x, y);

      box2DVertices[i] = new Vec2(box2d.scalarPixelsToWorld(x), -box2d.scalarPixelsToWorld(y));
    }

    pShape.endShape(CLOSE);

    shape.set(box2DVertices, box2DVertices.length);

    BodyDef bodyDef = new BodyDef();
    bodyDef.type = BodyType.DYNAMIC;
    bodyDef.position.set(box2d.coordPixelsToWorld(position));

    this.pBody = box2d.createBody(bodyDef);
    this.pBody.createFixture(shape, 10);

    PolygonShape baseShape = new PolygonShape();
    baseShape.setAsBox(1, 1);

    BodyDef baseBodyDef = new BodyDef();
    baseBodyDef.type = BodyType.STATIC;
    baseBodyDef.position.set(box2d.coordPixelsToWorld(new Vec2(position.x, position.y)));
    baseBodyDef.setFixedRotation(true);

    Body baseBody = box2d.createBody(baseBodyDef);
    baseBody.createFixture(baseShape, 1);

    RevoluteJointDef rotationJoint = new RevoluteJointDef();
    rotationJoint.bodyA = pBody;
    rotationJoint.bodyB = baseBody;
    rotationJoint.collideConnected = false;

    if (leftFlipper)
    {
      rotationJoint.localAnchorA = new Vec2(0.0, -0.5);
    } else
    {
      rotationJoint.localAnchorA = new Vec2(5.0, -0.5);
    }
    rotationJoint.enableLimit = true;
    rotationJoint.lowerAngle = radians(-45);
    rotationJoint.upperAngle = radians(45);

    box2d.createJoint(rotationJoint);
    this.pBody.setUserData(this);
  }

  void render()
  {
    Vec2 ballPos = box2d.getBodyPixelCoord(this.pBody);

    float angle = this.pBody.getAngle();

    pushMatrix();
    translate(ballPos.x, ballPos.y);
    rotate(-angle);
    shape(pShape);
    popMatrix();
  }
  void flip(float amt, boolean isLeftFlipper)
  {
    if (isLeftFlipper == leftFlipper)
    {
      this.pBody.applyTorque(amt * (leftFlipper ? 1 : -1));
    }
  }
}