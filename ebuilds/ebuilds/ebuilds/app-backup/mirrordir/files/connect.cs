/* client connection script, exporting this script from the US
   may be in violation of the US munitions export regulations */
Huge *r; Huge *s; Huge *p; Huge *q; Huge *g;
Huge *m; Huge *x; Huge *y; Huge *X; Huge *Y;
long l; long type; 
char *c; char *prot;
l = strlen ("dIffIe--HelLmaN\n");
if (l != send ("dIffIe--HelLmaN\n", l, 0))
    return 0;
prot = "1234";
prot[0] = 0;
prot[1] = 1;
type = typeoption ();
prot[2] = type;
prot[3] = 0;
if (send (prot, 4, 0) != 4)
    return 0;
p = prime (type);
g = 2;
y = random (typesize (type));
Y = pow (g, y, p);
if (writehuge (Y, 0))
    return 0;
l = strlen ("DIfFiE--hEllMan\n");
if (recv (&c, l, 0) != l)
    return 1;
if (strncmp ("DIfFiE--hEllMan\n", c, l))
    return 1;
if (!(X = readhuge (0)))
    return 0;
m = pow (X, y, p);
huge2bin (m, &c, &l);
initarcrd (c, l / 2);
initarcwr (c + l / 2, l / 2);
x = 0;
y = 0;
if (!(y = readhuge (1)))
    return 0;
if (checksavedkey (y, type))
    return 0;
if (!(r = readhuge (1)))
    return 0;
if (!(s = readhuge (1)))
    return 0;
q = p >> 1;
/* signature equation */
if (m != (((pow (g, s, p) * pow (y, r % q, p)) % p * r) % p))
    return 0;
return 1;

