D = 0.01;             
L_nozzle = 0.6*D;
L_down = 18*D;
R_domain = 9*D;

// Points
Point(1) = {0, 0, 0, 1e-4};
Point(2) = {L_nozzle, 0, 0, 1e-4};
Point(3) = {L_nozzle, 0.5*D, 0, 1e-4};
Point(4) = {0, 0.5*D, 0, 1e-4};

Point(5) = {0, R_domain, 0, 4e-3};
Point(6) = {L_nozzle + L_down, R_domain, 0, 4e-3};
Point(7) = {L_nozzle + L_down, 0, 0, 1e-3};

// Lines
Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,1};
Line(5) = {3,7};
Line(6) = {7,6};
Line(7) = {6,5};
Line(8) = {5,4};

Field[1] = BoundaryLayer;
Field[1].EdgesList = {3};
Field[1].hwall_n = 8e-6;
Field[1].ratio = 1.18;
Field[1].thickness = 0.0022;
Field[1].Quads = 1;
Background Field = 1;

// Mesh control (modified distribution)
Transfinite Line {3} = 35 Using Progression 1.15;
Transfinite Line {2,5} = 28;
Transfinite Line {4,8} = 22;
Transfinite Line {6,7} = 38;

// Surfaces
Curve Loop(1) = {3,4,1,2};
Curve Loop(2) = {5,6,7,8,-3};

Plane Surface(1) = {1};
Plane Surface(2) = {2};

// Physical groups
Physical Curve("inlet") = {4,8};
Physical Curve("outlet") = {5};
Physical Curve("wall") = {3};
Physical Curve("symmetry") = {1};
Physical Curve("farfield") = {2,6,7};

Physical Surface("fluid") = {1,2};

// Mesh settings
Mesh.Algorithm = 6;
Mesh.RecombineAll = 1;
Mesh.ElementOrder = 1;