typedef unsigned int u32;
extern void __arkcc_init_globals(void);
int __svc(0x1A) svc_shell(u32 *p);
int __svc(0x1B) svc_thread(u32 *p);
int probe(void);
void Reset_Handler(void)
{
u32 p[3];
__arkcc_init_globals();
if (probe() == 42) { p[0] = 3u; p[1] = (u32)"ARKMAKE: defs+incs ok, probe=42\r\n"; p[2] = 0u; svc_shell(p); }
else { p[0] = 3u; p[1] = (u32)"ARKMAKE: defs or incs MISSING\r\n"; p[2] = 0u; svc_shell(p); }
p[0] = 3u; p[1] = 0u; p[2] = 0u;
svc_thread(p);
for (;;) { }
}
