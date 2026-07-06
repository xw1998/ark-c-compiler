import struct
obj = open('ark_test_all.ark_obj','rb').read()
print('total size:', len(obj))
print('header:', obj[:8])
pos = 8
code_size = struct.unpack_from('<I', obj, pos)[0]; pos += 4
print('code_size:', code_size)
code = obj[pos:pos+code_size]
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
print('key symbols:')
for k in ['Reset_Handler','Default_Handler','SystemInit','main','NMI_Handler','HardFault_Handler','SysTick_Handler','HAL_Init','HAL_Delay','HAL_GetTick','HAL_GPIO_WritePin','HAL_GPIO_Init','MX_GPIO_Init','HAL_IncTick','HAL_RCC_OscConfig','HAL_RCC_ClockConfig','__wfi','__force_stores']:
    print('  %-30s 0x%04X %s' % (k, syms.get(k, 0xFFFFFFFF), 'OK' if k in syms else 'MISSING'))
print()
# relocation table
rel_count = struct.unpack_from('<I', obj, pos)[0]; pos += 4
print('relocation count:', rel_count)
unresolved = 0
for i in range(rel_count):
    off = struct.unpack_from('<I', obj, pos)[0]; pos += 4
    nl = struct.unpack_from('<I', obj, pos)[0]; pos += 4
    name = obj[pos:pos+nl-1].decode('ascii', errors='replace'); pos += nl
    if name not in syms:
        unresolved += 1
        if unresolved <= 20:
            print('  UNRESOLVED @ 0x%04X: %s' % (off, name))
print('total unresolved:', unresolved)
