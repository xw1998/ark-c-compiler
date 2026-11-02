/* Workload A for the QEMU ARM execution gate.
 *
 * Mixes loops, an int array, shift/xor/multiply, a helper call and a
 * comparison so that a wrong instruction encoding or a broken calling
 * convention shows up as a wrong exit code instead of a silent pass.
 * The result is masked to 6 bits so it is a legal process exit code.
 */

static int mix(int a, int b)
{
    return (a * 3 + b) ^ (a << 2);
}

int main(void)
{
    int buf[8];
    int i;
    int acc = 0;

    for (i = 0; i < 8; i++) {
        buf[i] = i * i + 1;
    }
    for (i = 0; i < 8; i++) {
        acc = acc + mix(buf[i], i);
    }
    acc = acc & 0x3F;
    if (acc == 0) {
        acc = 1;
    }
    return acc;
}
