import struct, sys
obj = open('ark_test.ark_obj','rb').read()
hdr = obj[:8]
print('header:', hdr)
pos = 8
code_size = struct.unpack_from('<I', obj, pos)[0]; pos += 4
print('code_size:', code_size)
pos += code_size
sym_count = struct.unpack_from('<I', obj, pos)[0]; pos += 4
print('symbol count:', sym_count)
syms = {}
for i in range(sym_count):
    nl = struct.unpack_from('<I', obj, pos)[0]; pos += 4
    name = obj[pos:pos+nl-1].decode('ascii', errors='replace'); pos += nl
    off = struct.unpack_from('<I', obj, pos)[0]; pos += 4
    t = obj[pos]; pos += 1
    syms[name] = off
    if any(k in name for k in ['Reset_Handler','Default_Handler','SystemInit','main','NMI','HardFault','MemManage','BusFault','UsageFault','SVC','DebugMon','PendSV','SysTick','HAL_Init','HAL_Delay','HAL_GPIO_WritePin','MX_GPIO_Init']):
        print('  %-35s 0x%04X' % (name, off))
print()
print('Reset_Handler:', hex(syms.get('Reset_Handler',0)))
print('Default_Handler:', hex(syms.get('Default_Handler',0)))
print('SysTick_Handler:', hex(syms.get('SysTick_Handler',0)))
