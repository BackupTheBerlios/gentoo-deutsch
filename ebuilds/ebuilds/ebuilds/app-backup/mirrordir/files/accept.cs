/* server connection script, exporting this script from the US
   may be in violation of the US munitions export regulations */
Huge *r; Huge *s; Huge *p; Huge *q; Huge *g; Huge *m;
Huge *x; Huge *y; Huge *X; Huge *Y; Huge *k; long l;
long save; long type;
char *c; char *prot;
save = 0;
l = strlen ("dIffIe--HelLmaN\n");
if (recv (&c, l, MSG_PEEK) != l)
    return 1;
if (strncmp ("dIffIe--HelLmaN\n", c, l))
    return 1;
if (recv (&c, l, 0) != l)
    return 0;
if (recv (&prot, 4, 0) != 4)
    return 0;
if (prot[0] != 0 || prot[1] != 1)
    return 0;
type = prot[2];
if (!(Y = readhuge (0)))
    return 0;
l = strlen ("DIfFiE--hEllMan\n");
if (l != send ("DIfFiE--hEllMan\n", l, 0))
    return 0;
p = prime (type);
g = 2;
x = random (typesize (type));
X = pow (g, x, p);
if (writehuge (X, 0))
    return 0;
m = pow (Y, x, p);
huge2bin (m, &c, &l);
initarcrd (c + l / 2, l / 2);
initarcwr (c, l / 2);
/* x assumes a new meaning here: the hosts private signature key */
x = 0;
y = 0;
if (loadkeys (&x, &y, type))
    return 0;
if (!x) {
    x = pow (g, random (typesize (type)), p);
    save = 1;
}
if (!y) {
    y = pow (g, x, p);
    save = 1;
}
writehuge (y, 1);
if (save)
    savekeys (x, y, type);
/* p-NEW signature scheme by Nyberg and Rueppel */
q = p >> 1;
k = random (typesize (type)) % q;
r = (m * pow (g, (p - 1) - k, p)) % p;
s = k - (((r % q) * x) % q);
if (s < 0)
    s = p - 1 + s;
if (writehuge (r, 1))
    return 0;
if (writehuge (s, 1))
    return 0;
return 1;

