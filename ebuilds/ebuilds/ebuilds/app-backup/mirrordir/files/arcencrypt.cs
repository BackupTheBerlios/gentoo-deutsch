/* stream cipher encryption, exporting this script from the US
   may be in violation of the US munitions export regulations */
long offset;
long i;
long j;
long *s;
long c;
long start;
long len;
long t;
long left_over;
char *d;
if (!start)
    s = box ();
data (&d);
len = strlen (d);
if (!len)
    return 0;
if (offset) {
    t = left_over;
    if (offset == 1) {
	d[0] = d[0] ^ (t >> 8);
	d = d + 1;
	len = len - 1;
	if (!len) {
	    offset = 2;
	    return 0;
	}
    }
    d[0] = d[0] ^ (t >> 16);
    d = d + 1;
    len = len - 1;
}
c = len / 3;
while (c) {
    c = c - 1;
    incmod (&i, 0x0FFF);
    addmod (&j, s[i], 0x0FFF);
    swap (s + i, s + j);
    t = s[(s[i] + s[j]) & 0x0FFF];
    incmod (&i, 0x0FFF);
    addmod (&j, s[i], 0x0FFF);
    swap (s + i, s + j);
    t = t | (s[(s[i] + s[j]) & 0x0FFF] << 12);
    memxor (d, t, 3);
    d = d + 3;
    len = len - 3;
}
offset = len;
if (len) {
    incmod (&i, 0x0FFF);
    addmod (&j, s[i], 0x0FFF);
    swap (s + i, s + j);
    t = s[(s[i] + s[j]) & 0x0FFF];
    incmod (&i, 0x0FFF);
    addmod (&j, s[i], 0x0FFF);
    swap (s + i, s + j);
    t = t | (s[(s[i] + s[j]) & 0x0FFF] << 12);
    left_over = t;
    d[0] = d[0] ^ t;
    if (len == 2)
	d[1] = d[1] ^ (t >> 8);
}
return 0;
