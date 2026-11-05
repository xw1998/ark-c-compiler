typedef unsigned int u32;
extern void __arkcc_init_globals(void);
int __svc(0x1A) svc_shell(u32 *p);
int __svc(0x1B) svc_thread(u32 *p);
int add3(int a, int b, int c);
void Reset_Handler(void)
{
u32 p[3];
__arkcc_init_globals();
p[0] = 3u; p[1] = (u32)"ARKMAKE: link ok\r\n"; p[2] = 0u;
svc_shell(p);
if (add3(1, 2, 3) == 6) { p[1] = (u32)"ARKMAKE: cross-file add3=6\r\n"; svc_shell(p); }
p[0] = 3u; p[1] = 0u; p[2] = 0u;
svc_thread(p);
for (;;) { }
}
