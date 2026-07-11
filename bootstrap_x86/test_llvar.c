int main(void) {
    long long x = 42;
    int *p = (int*)&x;
    return p[0];
}
