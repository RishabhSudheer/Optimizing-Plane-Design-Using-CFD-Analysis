// =====================================================================
//  CDF-62  |  1:100 printable transport-aircraft model for the CFD study
//  CDF Simulation Project - parametric airframe (OpenSCAD 2021.01+)
//  This file: W1 wing, F2 fuselage (ogive nose), T1 conventional tail
// ---------------------------------------------------------------------
//  Geometry is written in FULL-SCALE metres and scaled at the end:
//    units = 10    -> millimetres of the 1:100 model (printing, default)
//    units = 0.01  -> metres of the 1:100 model (CFD export)
//  This file is pre-set to its configuration below; F6 (Render) + Export STL.
//    wing_type : 1 = W1 baseline (35 deg)  2 = W2 (27 deg)  3 = W3 winglet
//    fuse_type : 1 = F1 baseline           2 = F2 ogive nose 3 = F3 high upsweep
//    tail_type : 1 = T1 conventional       2 = T2 T-tail    3 = T3 V-tail
//
//  FUSION 360: Fusion cannot open .scad directly. Render here (F6), then
//  File > Export > STL (or use the matching .step file supplied with this
//  file, which opens in Fusion as one closed solid body).
// =====================================================================
wing_type = 1;
fuse_type = 2;
tail_type = 1;

part = "assembly";   // "assembly", "fuselage_shell", "wing_right", "wing_left", "tail",
                     // "cutaway" (preview only: fuselage cut open with the parts inside)
units = 10;          // see above
show_components = false; // preview only (F5): battery, ESC, EDF, receiver, servos
dump = false;        // internal: echo loft points at full precision (export script)
$mir = false;        // internal: set on mirrored copies when dump = true

// Minimum trailing-edge thickness, FULL-SCALE metres (0.01 = 0.1 mm on the
// print). 0 keeps the exact CFD airfoils (trailing edges as thin as 0.02 mm,
// fine for CFD/resin). For FDM printing use 0.05 (= 0.5 mm on the print).
te_min = 0;

// NASA SC(2)-0714, 14% (wing root)
AF_SC14 = [[1.00000,-0.00950],[0.99759,-0.00873],[0.99039,-0.00643],[0.97847,-0.00274],[0.96194,0.00214],[0.94096,0.00813],[0.91573,0.01477],[0.88651,0.02190],[0.85355,0.02915],[0.81720,0.03630],[0.77779,0.04305],[0.73570,0.04926],[0.69134,0.05465],[0.64514,0.05924],[0.59755,0.06297],[0.54901,0.06585],[0.50000,0.06800],[0.45099,0.06928],[0.40245,0.06988],[0.35486,0.06975],[0.30866,0.06886],[0.26430,0.06722],[0.22221,0.06493],[0.18280,0.06185],[0.14645,0.05817],[0.11349,0.05399],[0.08427,0.04917],[0.05904,0.04375],[0.03806,0.03758],[0.02153,0.03036],[0.00961,0.02194],[0.00241,0.01156],[0.00000,0.00000],[0.00241,-0.01156],[0.00961,-0.02194],[0.02153,-0.03035],[0.03806,-0.03748],[0.05904,-0.04365],[0.08427,-0.04907],[0.11349,-0.05392],[0.14645,-0.05817],[0.18280,-0.06185],[0.22221,-0.06496],[0.26430,-0.06742],[0.30866,-0.06906],[0.35486,-0.06970],[0.40245,-0.06925],[0.45099,-0.06765],[0.50000,-0.06460],[0.54901,-0.05923],[0.59755,-0.05154],[0.64514,-0.04222],[0.69134,-0.03230],[0.73570,-0.02255],[0.77779,-0.01364],[0.81720,-0.00682],[0.85355,-0.00252],[0.88651,-0.00087],[0.91573,-0.00149],[0.94096,-0.00373],[0.96194,-0.00709],[0.97847,-0.01065],[0.99039,-0.01371],[0.99759,-0.01580],[1.00000,-0.01650]];
// mean of SC(2)-0712 and SC(2)-0710, 11% (wing kink)
AF_SC11 = [[1.00000,-0.01180],[0.99759,-0.01110],[0.99039,-0.00901],[0.97847,-0.00569],[0.96194,-0.00143],[0.94096,0.00353],[0.91573,0.00905],[0.88651,0.01491],[0.85355,0.02101],[0.81720,0.02710],[0.77779,0.03290],[0.73570,0.03809],[0.69134,0.04262],[0.64514,0.04639],[0.59755,0.04944],[0.54901,0.05179],[0.50000,0.05355],[0.45099,0.05459],[0.40245,0.05505],[0.35486,0.05490],[0.30866,0.05417],[0.26430,0.05290],[0.22221,0.05106],[0.18280,0.04863],[0.14645,0.04571],[0.11349,0.04225],[0.08427,0.03839],[0.05904,0.03405],[0.03806,0.02912],[0.02153,0.02348],[0.00961,0.01690],[0.00241,0.00900],[0.00000,0.00000],[0.00241,-0.00900],[0.00961,-0.01690],[0.02153,-0.02348],[0.03806,-0.02912],[0.05904,-0.03400],[0.08427,-0.03834],[0.11349,-0.04227],[0.14645,-0.04576],[0.18280,-0.04871],[0.22221,-0.05121],[0.26430,-0.05305],[0.30866,-0.05427],[0.35486,-0.05480],[0.40245,-0.05456],[0.45099,-0.05337],[0.50000,-0.05095],[0.54901,-0.04699],[0.59755,-0.04141],[0.64514,-0.03478],[0.69134,-0.02753],[0.73570,-0.02003],[0.77779,-0.01324],[0.81720,-0.00765],[0.85355,-0.00407],[0.88651,-0.00280],[0.91573,-0.00342],[0.94096,-0.00557],[0.96194,-0.00860],[0.97847,-0.01183],[0.99039,-0.01466],[0.99759,-0.01660],[1.00000,-0.01725]];
// NASA SC(2)-0710, 10% (wing tip)
AF_SC10 = [[1.00000,-0.01190],[0.99759,-0.01120],[0.99039,-0.00911],[0.97847,-0.00580],[0.96194,-0.00167],[0.94096,0.00309],[0.91573,0.00835],[0.88651,0.01393],[0.85355,0.01970],[0.81720,0.02542],[0.77779,0.03077],[0.73570,0.03533],[0.69134,0.03919],[0.64514,0.04239],[0.59755,0.04502],[0.54901,0.04714],[0.50000,0.04870],[0.45099,0.04959],[0.40245,0.05000],[0.35486,0.04985],[0.30866,0.04917],[0.26430,0.04803],[0.22221,0.04631],[0.18280,0.04407],[0.14645,0.04138],[0.11349,0.03818],[0.08427,0.03460],[0.05904,0.03062],[0.03806,0.02618],[0.02153,0.02112],[0.00961,0.01519],[0.00241,0.00814],[0.00000,0.00000],[0.00241,-0.00814],[0.00961,-0.01519],[0.02153,-0.02112],[0.03806,-0.02618],[0.05904,-0.03062],[0.08427,-0.03460],[0.11349,-0.03818],[0.14645,-0.04138],[0.18280,-0.04410],[0.22221,-0.04641],[0.26430,-0.04813],[0.30866,-0.04927],[0.35486,-0.04980],[0.40245,-0.04958],[0.45099,-0.04857],[0.50000,-0.04650],[0.54901,-0.04308],[0.59755,-0.03817],[0.64514,-0.03218],[0.69134,-0.02550],[0.73570,-0.01849],[0.77779,-0.01203],[0.81720,-0.00674],[0.85355,-0.00339],[0.88651,-0.00223],[0.91573,-0.00294],[0.94096,-0.00512],[0.96194,-0.00815],[0.97847,-0.01138],[0.99039,-0.01421],[0.99759,-0.01615],[1.00000,-0.01680]];
// NACA 0009 (winglet)
AF_N09 = [[1.00000,0.00094],[0.99759,0.00120],[0.99039,0.00195],[0.97847,0.00318],[0.96194,0.00486],[0.94096,0.00694],[0.91573,0.00937],[0.88651,0.01211],[0.85355,0.01508],[0.81720,0.01823],[0.77779,0.02149],[0.73570,0.02481],[0.69134,0.02811],[0.64514,0.03132],[0.59755,0.03438],[0.54901,0.03720],[0.50000,0.03971],[0.45099,0.04182],[0.40245,0.04345],[0.35486,0.04454],[0.30866,0.04500],[0.26430,0.04479],[0.22221,0.04386],[0.18280,0.04220],[0.14645,0.03981],[0.11349,0.03672],[0.08427,0.03296],[0.05904,0.02859],[0.03806,0.02368],[0.02153,0.01831],[0.00961,0.01254],[0.00241,0.00642],[0.00000,0.00000],[0.00241,-0.00642],[0.00961,-0.01254],[0.02153,-0.01831],[0.03806,-0.02368],[0.05904,-0.02859],[0.08427,-0.03296],[0.11349,-0.03672],[0.14645,-0.03981],[0.18280,-0.04220],[0.22221,-0.04386],[0.26430,-0.04479],[0.30866,-0.04500],[0.35486,-0.04454],[0.40245,-0.04345],[0.45099,-0.04182],[0.50000,-0.03971],[0.54901,-0.03720],[0.59755,-0.03438],[0.64514,-0.03132],[0.69134,-0.02811],[0.73570,-0.02481],[0.77779,-0.02149],[0.81720,-0.01823],[0.85355,-0.01508],[0.88651,-0.01211],[0.91573,-0.00937],[0.94096,-0.00694],[0.96194,-0.00486],[0.97847,-0.00318],[0.99039,-0.00195],[0.99759,-0.00120],[1.00000,-0.00094]];
// NACA 0010 (tails)
AF_N10 = [[1.00000,0.00105],[0.99759,0.00133],[0.99039,0.00217],[0.97847,0.00353],[0.96194,0.00540],[0.94096,0.00771],[0.91573,0.01042],[0.88651,0.01345],[0.85355,0.01676],[0.81720,0.02026],[0.77779,0.02388],[0.73570,0.02757],[0.69134,0.03123],[0.64514,0.03480],[0.59755,0.03820],[0.54901,0.04133],[0.50000,0.04412],[0.45099,0.04646],[0.40245,0.04828],[0.35486,0.04949],[0.30866,0.05000],[0.26430,0.04976],[0.22221,0.04873],[0.18280,0.04689],[0.14645,0.04424],[0.11349,0.04080],[0.08427,0.03662],[0.05904,0.03177],[0.03806,0.02632],[0.02153,0.02035],[0.00961,0.01393],[0.00241,0.00713],[0.00000,0.00000],[0.00241,-0.00713],[0.00961,-0.01393],[0.02153,-0.02035],[0.03806,-0.02632],[0.05904,-0.03177],[0.08427,-0.03662],[0.11349,-0.04080],[0.14645,-0.04424],[0.18280,-0.04689],[0.22221,-0.04873],[0.26430,-0.04976],[0.30866,-0.05000],[0.35486,-0.04949],[0.40245,-0.04828],[0.45099,-0.04646],[0.50000,-0.04412],[0.54901,-0.04133],[0.59755,-0.03820],[0.64514,-0.03480],[0.69134,-0.03123],[0.73570,-0.02757],[0.77779,-0.02388],[0.81720,-0.02026],[0.85355,-0.01676],[0.88651,-0.01345],[0.91573,-0.01042],[0.94096,-0.00771],[0.96194,-0.00540],[0.97847,-0.00353],[0.99039,-0.00217],[0.99759,-0.00133],[1.00000,-0.00105]];

// ---------------- helpers --------------------------------------------
function lerp_af(a, b, t) = [for (i = [0:len(a)-1]) a[i]*(1-t) + b[i]*t];
// thicken the trailing edge to at least te_min (linear ramp from the LE,
// upper surface up, lower surface down); no change when te_min = 0
function te_fix(af, c) =
    let(n = len(af), te0 = af[0][1] - af[n-1][1],
        d = max(0, te_min/c - te0)/2, h = (n-1)/2)
    [for (i = [0:n-1]) let(s = i < h ? 1 : i > h ? -1 : 0)
        [af[i][0], af[i][1] + s*d*af[i][0]]];
// section: airfoil af, chord c, leading edge at (xle, y, z); phi = angle of the
// span direction from horizontal (0 = flat wing, 90 = vertical fin)
function sec(af, c, xle, y, z, phi) =
    [for (q = te_fix(af, c)) [xle + c*q[0], y - c*q[1]*sin(phi), z + c*q[1]*cos(phi)]];
module loft(secs) {
    ns = len(secs); n = len(secs[0]);
    pts = [for (s = secs) for (p = s) p];
    faces = concat(
        [for (i = [0:ns-2]) for (j = [0:n-1])
            [i*n+j, (i+1)*n+j, (i+1)*n+(j+1)%n, i*n+(j+1)%n]],
        [[for (j = [0:n-1]) j]],
        [[for (j = [n-1:-1:0]) (ns-1)*n+j]]);
    polyhedron(points=pts, faces=faces, convexity=8);
    if (dump) echo(LOFT = [$mir ? 1 : 0, ns, n,
        [for (p = pts) for (v = p) let(f = floor(v)) [f, round((v - f)*1e5)]]]);
}

// =====================================================================
// WING  (W1 baseline, W2 less sweep, W3 winglet)
// =====================================================================
C_ROOT = 15.0; C_KINK = 7.8; C_TIP = 2.7;
Y_KINK = 10.87; SEMI = 29.38;          // projected semi-span (58.76 m span)
Z_WING = -1.5; DIH = 5;                 // low wing, 5 deg dihedral, no twist
LAM = wing_type == 2 ? 27 : 35;         // leading-edge sweep
X0  = 31.9 - 11*tan(LAM);               // keeps the mean chord at the same x
// blended winglet (W3)
WL_H = 2.5; WL_CANT = 18; WL_R = 1.0; WL_SWEEP = 40; WL_CTOP = 1.0;
PHI1  = 90 - WL_CANT;                   // winglet angle from horizontal
BL_DY = WL_R*(sin(PHI1) - sin(DIH));
BL_DZ = WL_R*(cos(DIH) - cos(PHI1));
ST_L  = (WL_H - BL_DZ)/sin(PHI1);       // straight winglet length
WL_DY = BL_DY + ST_L*cos(PHI1);         // sideways extent of the winglet
Y_TIP = wing_type == 3 ? SEMI - WL_DY : SEMI;   // projected span kept at 58.76 m
function wx(y) = X0 + y*tan(LAM);
function wz(y) = Z_WING + y*tan(DIH);
function wc(y) = y <= Y_KINK ? C_ROOT + (C_KINK - C_ROOT)*y/Y_KINK
                             : C_KINK + (C_TIP - C_KINK)*(y - Y_KINK)/(Y_TIP - Y_KINK);
NB = 8;                                 // sections through the blend
BL_LEN = WL_R*(PHI1 - DIH)*PI/180;
WL_LEN = BL_LEN + ST_L;
function wl_sec(k) =                    // k = 0..NB blend, NB+1 = winglet top
    let(phi = k <= NB ? DIH + (PHI1 - DIH)*k/NB : PHI1,
        t   = k <= NB ? BL_LEN*k/NB : WL_LEN,
        y   = k <= NB ? Y_TIP + WL_R*(sin(phi) - sin(DIH)) : Y_TIP + WL_DY,
        z   = k <= NB ? wz(Y_TIP) + WL_R*(cos(DIH) - cos(phi)) : wz(Y_TIP) + WL_H,
        xle = k <= NB ? wx(Y_TIP) + t*tan((LAM + WL_SWEEP)/2)
                      : wx(Y_TIP) + BL_LEN*tan((LAM + WL_SWEEP)/2) + ST_L*tan(WL_SWEEP),
        c   = C_TIP + (WL_CTOP - C_TIP)*t/WL_LEN,
        af  = k <= NB ? lerp_af(AF_SC10, AF_N09, k/NB) : AF_N09)
    sec(af, c, xle, y, z, phi);
function wsec(af, y) = sec(af, wc(y), wx(y), y, wz(y), DIH);
module wing_half() {
    base = [wsec(AF_SC14, -0.3), wsec(AF_SC11, Y_KINK)];
    if (wing_type == 3) loft(concat(base, [for (k = [0:NB+1]) wl_sec(k)]));
    else                loft(concat(base, [wsec(AF_SC10, Y_TIP)]));
}
module wing() { wing_half(); mirror([0,1,0]) wing_half($mir = true); }

// =====================================================================
// FUSELAGE  (F1 baseline, F2 ogive nose, F3 high upsweep)
// =====================================================================
L_F = 62; R_F = 3.1; R_END = 0.35;
LN  = fuse_type == 2 ? 13 : 9;          // nose length
XCS = fuse_type == 3 ? 43 : 40;         // tail-cone start
DN  = fuse_type == 2 ? -0.3 : -0.6;     // nose droop
HUP = fuse_type == 3 ? 3.2 : 1.8;       // tail upsweep
RHO = (R_F*R_F + LN*LN)/(2*R_F);        // ogive radius (28.8 m for F2)
function r_nose(x) = fuse_type == 2 ? sqrt(RHO*RHO - (LN-x)*(LN-x)) + R_F - RHO
                                    : R_F*sqrt(max(0, 1 - pow(1 - x/LN, 2)));
function sc(x) = (x - XCS)/(L_F - XCS);
function fr(x) = x < LN ? r_nose(x) : x < XCS ? R_F : R_F - (R_F - R_END)*pow(sc(x), 1.4);
function fz(x) = x < LN ? DN*pow(1 - x/LN, 2) : x < XCS ? 0 : HUP*pow(sc(x), 1.8);
N_RING = 48;
XS = concat([for (k = [0:20]) 0.02 + (LN - 0.02)*(1 - cos(90*k/20))],
            [for (k = [1:4]) LN + (XCS - LN)*k/4],
            [for (k = [1:18]) XCS + (L_F - XCS)*k/18]);
function ring(x, dr = 0) = let(r = max(0.01, fr(x) - dr), z = fz(x))
    [for (j = [0:N_RING-1]) let(a = 360*j/N_RING) [x, r*cos(a), z + r*sin(a)]];
module fuselage(dr = 0) { loft([for (x = XS) ring(x, dr)]); }

// =====================================================================
// TAILS  (T1 conventional, T2 T-tail, T3 V-tail), NACA 0010 everywhere
// =====================================================================
function top(x) = fz(x) + fr(x);       // fuselage top line
// vertical fin: root LE x, root/tip chord, height above the fuselage, LE sweep
module fin(xr, cr, ct, h, sw) {
    xm = xr + cr/2; z0 = top(xm); zin = fz(xm) + 0.3*fr(xm);
    f = function(z) let(u = (z - z0)/h) sec(AF_N10, cr + (ct - cr)*u, xr + (z - z0)*tan(sw), 0, z, 90);
    loft([f(zin), f(z0 + h)]);
}
// one lifting panel from a root point, along a direction at angle g from horizontal
module panel(xr, yr, zr, cr, ct, len, sw, g) {
    p = function(s) sec(AF_N10, cr + (ct - cr)*max(0, s)/len, xr + s*tan(sw),
                        yr + s*cos(g), zr + s*sin(g), g);
    loft([p(-0.3), p(len)]);
}
FIN1 = [51.0, 10.0, 3.2, 9.5, 45];      // T1 fin: root LE, cr, ct, height, sweep
FIN2 = [51.0, 10.0, 6.0, 9.5, 40];      // T2 fin (bigger tip chord carries the tailplane)
module tail() {
    if (tail_type == 1) {
        fin(FIN1[0], FIN1[1], FIN1[2], FIN1[3], FIN1[4]);
        panel(52.0, 0, fz(55.5), 7.0, 2.2, 10.7/cos(7), 37, 7);
        mirror([0, 1, 0]) panel($mir = true, 52.0, 0, fz(55.5), 7.0, 2.2, 10.7/cos(7), 37, 7);
    }
    if (tail_type == 2) {
        fin(FIN2[0], FIN2[1], FIN2[2], FIN2[3], FIN2[4]);
        xm = FIN2[0] + FIN2[1]/2;
        xt = FIN2[0] + FIN2[3]*tan(FIN2[4]);          // fin tip leading edge
        zt = top(xm) + FIN2[3] - 0.1;
        panel(xt + (FIN2[2] - 5.6)/2, 0, zt, 5.6, 2.2, 9.8/cos(3), 33, -3);
        mirror([0, 1, 0]) panel($mir = true, xt + (FIN2[2] - 5.6)/2, 0, zt, 5.6, 2.2, 9.8/cos(3), 33, -3);
    }
    if (tail_type == 3) {
        panel(51.5, 0, fz(56), 9.5, 3.6, 12.3, 40, 38.6);
        mirror([0, 1, 0]) panel($mir = true, 51.5, 0, fz(56), 9.5, 3.6, 12.3, 40, 38.6);
    }
}

// =====================================================================
// INTERNAL COMPONENTS (full-scale metres: 1 m here = 1 cm on the model)
// =====================================================================
module components() {
    color("orange", 0.5) translate([9, -1.5, -1.6])  cube([6.5, 3.0, 2.6]);  // 3S 850 mAh LiPo
    color("red", 0.5)    translate([17, -1.2, -1.0]) cube([4.5, 2.4, 1.0]);  // 30 A ESC
    color("green", 0.5)  translate([22, -1.0, 0.8])  cube([3.5, 2.0, 0.8]);  // receiver
    color("blue", 0.5)   translate([37, 0, 0.2]) rotate([0, 90, 0]) cylinder(d = 4.6, h = 5.0, $fn = 32); // 40 mm EDF
    color("gray", 0.5)   translate([47, -0.6, 0.6])  cube([2.3, 1.2, 1.6]);  // tail servo
}

// =====================================================================
// PRINT PARTS
// =====================================================================
WALL = 0.12;                            // 1.2 mm printed skin at 1:100
module spar_holes() {                   // 6 mm carbon tube, root to kink, each side
    spar_hole(); mirror([0, 1, 0]) spar_hole();
}
// centred on the chord plane at 35% chord (the SC(2) camber line is ~0 there);
// an earlier +3% chord offset broke out through the upper skin near the kink
module spar_hole() hull() {
    translate([wx(0) + 0.35*wc(0), 0, wz(0)]) sphere(d = 0.62, $fn = 16);
    translate([wx(Y_KINK - 1) + 0.35*wc(Y_KINK - 1), Y_KINK - 1, wz(Y_KINK - 1)])
        sphere(d = 0.62, $fn = 16);
}
module fuselage_shell() {
    difference() {
        fuselage();
        fuselage(WALL);
        translate([8, -1.6, 0.5]) cube([18, 3.2, 4]);     // top hatch for battery, ESC, receiver
        wing();                                            // wing saddle
    }
}

scale(units) {
    if (part == "assembly")       union() { fuselage(); wing(); tail(); }
    if (part == "fuselage_shell") fuselage_shell();
    if (part == "wing_right")     difference() { wing_half(); spar_holes(); }
    if (part == "wing_left")      mirror([0,1,0]) difference() { wing_half(); spar_holes(); }
    if (part == "tail")           tail();
    if (part == "cutaway") {          // preview (F5) to see the parts inside
        difference() { fuselage_shell(); translate([-1, -10, -10]) cube([70, 10, 20]); }
        components();
    }
}
if (show_components) scale(units) %components();
