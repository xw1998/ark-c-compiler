/* feat_svc.c - __svc declaration (ARM Compiler 5 compatible)
 * The ARM backend should emit instructions like SVC #0x10
 */
typedef int int32;
typedef unsigned int uint32;

int32  __svc ( 0x10 ) svcrt_call_dev_io(uint32 *p);
void   __svc ( 0x11 ) svcrt_call_task_ctrl(uint32 fn, uint32 p);
uint32 __svc ( 0x12 ) svcrt_call_sys_info(uint32 fn);
int32  __svc ( 0x13 ) svcrt_call_event_ctrl(uint32 *p);
int32  __svc ( 0x15 ) svcrt_call_sync_ctrl(uint32 *p);

int main(void) {
    uint32 info = 0;
    uint32 ptr = 0;
    /* Call SVC functions (on ARM this triggers an SVC exception) */
    info = svcrt_call_sys_info(1);
    svcrt_call_dev_io(&ptr);
    return 0;
}
