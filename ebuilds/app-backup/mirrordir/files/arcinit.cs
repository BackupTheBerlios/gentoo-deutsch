/* stream cipher initialisation, exporting this script from the US
   may be in violation of the US munitions export regulations */
long i;
long j;
long *s;
long *k;
long l;
l = strlen (key ());
s = box ();
i = 0;
k = malloc (0x1000 * 8);
while (i < 0x1000) {
    s[i] = i;
    i = i + 1;
}
j = 0;
i = 0;
while (i < 0x1000) {
    k[i] = (key ()[j] | (key ()[(j + 1) % l] << 8)) & 0x0FFF;
    j = (j + 1) % l;
    i = i + 1;
}
i = 0;
while (i < 0x1000) {
    j = (j + s[i] + k[i]) & 0x0FFF;
    swap (s + i, s + j);
    i = i + 1;
}
free (k);
return 0;
