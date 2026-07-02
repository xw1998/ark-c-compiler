/* test_tls.c - __thread thread-local storage test
 * Expected exit code: 5
 */
__thread int counter = 0;
int main(void) {
    counter = 5;
    return counter;
}
