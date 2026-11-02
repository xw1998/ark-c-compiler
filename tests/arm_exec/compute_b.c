/* Workload B for the QEMU ARM execution gate.
 *
 * Intentionally different from workload A: it drives multiply, divide and
 * modulo, so it must produce a different exit code (3).  Two workloads with
 * different results are what makes "the exit code really comes from the
 * generated code" a checkable claim.
 */

int main(void)
{
    int i;
    int acc = 0;

    for (i = 1; i <= 10; i++) {
        acc = acc + (i * 17) / 3;
    }
    acc = acc % 61;
    if (acc == 0) {
        acc = 1;
    }
    return acc;
}
