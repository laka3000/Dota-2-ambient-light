
public class TexturedWorld {
  private PApplet p;

  private float rotationX = 0;
  private float rotationY = 0;
  private float velocityX = 0;
  private float velocityY = 0;
  private float globeRadius;

  private float[] sphereX, sphereY, sphereZ;
  private float sinLUT[];
  private float cosLUT[];
  private float SINCOS_PRECISION = 0.5f;
  private int SINCOS_LENGTH = (int) (360.0 / SINCOS_PRECISION);
  private int sphereDetail = 120;

  public TexturedWorld(PApplet p, PImage texMap, float radius) {
    this.p = p;
    this.globeRadius = radius / 2;
  }

  public void renderGlobe() {
    pushMatrix();
    noFill();
    stroke(255, 200);
    strokeWeight(2);
    smooth();
    popMatrix();

    pushMatrix();
    rotateX(radians(-rotationX));
    rotateY(radians(270 - rotationY));
    fill(200);
    noStroke();
    textureMode(IMAGE);
    texturedSphere(globeRadius, capture);
    popMatrix();
    rotationX += velocityX;
    rotationY += velocityY;
    velocityX *= 0.95;
    velocityY *= 0.95;
  }

  public void initializeSphere(int res) {
    sinLUT = new float[SINCOS_LENGTH];
    cosLUT = new float[SINCOS_LENGTH];

    for (int i = 0; i < SINCOS_LENGTH; i++) {
      sinLUT[i] = (float) Math.sin(i * PConstants.DEG_TO_RAD
        * SINCOS_PRECISION);
      cosLUT[i] = (float) Math.cos(i * PConstants.DEG_TO_RAD
        * SINCOS_PRECISION);
    }

    float delta = (float) SINCOS_LENGTH / res;
    float[] cx = new float[res];
    float[] cz = new float[res];

    // Calc unit circle in XZ plane
    for (int i = 0; i < res; i++) {
      cx[i] = -cosLUT[(int) (i * delta) % SINCOS_LENGTH];
      cz[i] = sinLUT[(int) (i * delta) % SINCOS_LENGTH];
    }

    // Computing vertexlist vertexlist starts at south pole
    int vertCount = res * (res - 1) + 2;
    int currVert = 0;

    // Re-init arrays to store vertices
    sphereX = new float[vertCount];
    sphereY = new float[vertCount];
    sphereZ = new float[vertCount];
    float angle_step = (SINCOS_LENGTH * 0.5f) / res;
    float angle = angle_step;

    // Step along Y axis
    for (int i = 1; i < res; i++) {
      float curradius = sinLUT[(int) angle % SINCOS_LENGTH];
      float currY = -cosLUT[(int) angle % SINCOS_LENGTH];
      for (int j = 0; j < res; j++) {
        sphereX[currVert] = cx[j] * curradius;
        sphereY[currVert] = currY;
        sphereZ[currVert++] = cz[j] * curradius;
      }
      angle += angle_step;
    }
    sphereDetail = res;
  }

  // Generic routine to draw textured sphere
  void texturedSphere(float r, PImage t) {
    int v1, v11, v2;
    r = (r + 240) * 0.33f;
    beginShape(TRIANGLE_STRIP);
    texture(t);
    float iu = (float) (t.width - 1) / (sphereDetail);
    float iv = (float) (t.height - 1) / (sphereDetail);
    float u = 0, v = iv;
    for (int i = 0; i < sphereDetail; i++) {
      vertex(0, -r, 0, u, 0);
      vertex(sphereX[i] * r, sphereY[i] * r, sphereZ[i] * r, u, v);
      u += iu;
    }
    vertex(0, -r, 0, u, 0);
    vertex(sphereX[0] * r, sphereY[0] * r, sphereZ[0] * r, u, v);
    endShape();

    // Middle rings
    int voff = 0;
    for (int i = 2; i < sphereDetail; i++) {
      v1 = v11 = voff;
      voff += sphereDetail;
      v2 = voff;
      u = 0;
      beginShape(TRIANGLE_STRIP);
      texture(t);
      for (int j = 0; j < sphereDetail; j++) {
        vertex(sphereX[v1] * r, sphereY[v1] * r, sphereZ[v1++] * r, 
        u, v);
        vertex(sphereX[v2] * r, sphereY[v2] * r, sphereZ[v2++] * r, 
        u, v + iv);
        u += iu;
      }

      // Close each ring
      v1 = v11;
      v2 = voff;
      vertex(sphereX[v1] * r, sphereY[v1] * r, sphereZ[v1] * r, u, v);
      vertex(sphereX[v2] * r, sphereY[v2] * r, sphereZ[v2] * r, u, v
        + iv);
      endShape();
      v += iv;
    }
    u = 0;

    // Add the northern cap
    beginShape(PConstants.TRIANGLE_STRIP);
    texture(t);
    for (int i = 0; i < sphereDetail; i++) {
      v2 = voff + i;
      vertex(sphereX[v2] * r, sphereY[v2] * r, sphereZ[v2] * r, u, v);
      vertex(0, r, 0, u, v + iv);
      u += iu;
    }
    vertex(sphereX[voff] * r, sphereY[voff] * r, sphereZ[voff] * r, u, v);
    endShape();
  }
}

