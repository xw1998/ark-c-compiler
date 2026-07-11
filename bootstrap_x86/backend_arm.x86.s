# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .globl _g_gvar_names
_g_gvar_names:
    .zero 8192
    .globl _g_gvar_addrs
_g_gvar_addrs:
    .zero 8192
    .globl _g_gvar_sizes
_g_gvar_sizes:
    .zero 8192
    .globl _g_gvar_count
_g_gvar_count:
    .long 0
    .globl _g_data_sram_start
_g_data_sram_start:
    .long 0
    .globl _g_data_sram_end
_g_data_sram_end:
    .long 0
    .globl _g_bss_sram_start
_g_bss_sram_start:
    .long 0
    .globl _g_bss_sram_end
_g_bss_sram_end:
    .long 0
    .globl _g_arm_syms
_g_arm_syms:
    .zero 49152
    .globl _g_arm_sym_count
_g_arm_sym_count:
    .long 0
    .globl _g_arm_relocs
_g_arm_relocs:
    .zero 49152
    .globl _g_arm_reloc_count
_g_arm_reloc_count:
    .long 0
    .globl _g_arm_backend
_g_arm_backend:
    .long ark_str_1169
    .long ark_str_1170
    .long 4
    .long _arm_emit
    .long _arm_assemble
    .long _arm_link
    .section .rdata,"dr"
ark_str_0:
    .asciz "    "
ark_str_1:
    .asciz "    MOV r"
ark_str_2:
    .asciz ", #"
ark_str_3:
    .asciz "    MOVW r"
ark_str_4:
    .asciz ", #"
ark_str_5:
    .asciz "    MOVT r"
ark_str_6:
    .asciz ", #"
ark_str_7:
    .asciz "PUSH {r0}"
ark_str_8:
    .asciz "POP {r0}"
ark_str_9:
    .asciz "POP {r1}"
ark_str_10:
    .asciz "VMOV s0, r0"
ark_str_11:
    .asciz "VMOV s1, r1"
ark_str_12:
    .asciz "    "
ark_str_13:
    .asciz ".F32 s0, s0, s1\n"
ark_str_14:
    .asciz "VMOV r0, s0"
ark_str_15:
    .asciz "POP {r3}"
ark_str_16:
    .asciz "POP {r2}"
ark_str_17:
    .asciz "POP {r1}"
ark_str_18:
    .asciz "POP {r0}"
ark_str_19:
    .asciz "VMOV s0, r0"
ark_str_20:
    .asciz "VMOV s1, r1"
ark_str_21:
    .asciz "VMOV s2, r2"
ark_str_22:
    .asciz "VMOV s3, r3"
ark_str_23:
    .asciz "    "
ark_str_24:
    .asciz ".F64 d0, d0, d1\n"
ark_str_25:
    .asciz "VMOV r0, s0"
ark_str_26:
    .asciz "VMOV r1, s1"
ark_str_27:
    .asciz "    PUSH {r1}\n"
ark_str_28:
    .asciz ".L_"
ark_str_29:
    .asciz ":\n"
ark_str_30:
    .asciz "    "
ark_str_31:
    .asciz " .L_"
ark_str_32:
    .asciz "ADD r0, r0, r1"
ark_str_33:
    .asciz "SUB r0, r0, r1"
ark_str_34:
    .asciz "MUL r0, r1"
ark_str_35:
    .asciz "SDIV r0, r0, r1"
ark_str_36:
    .asciz "SDIV r2, r0, r1"
ark_str_37:
    .asciz "MUL r2, r1"
ark_str_38:
    .asciz "SUB r0, r0, r2"
ark_str_39:
    .asciz "AND r0, r1"
ark_str_40:
    .asciz "ORR r0, r1"
ark_str_41:
    .asciz "EOR r0, r1"
ark_str_42:
    .asciz "LSL r0, r1"
ark_str_43:
    .asciz "LSR r0, r1"
ark_str_44:
    .asciz "ASR r0, r1"
ark_str_45:
    .asciz "CMP r0, r1"
ark_str_46:
    .asciz "ITE EQ"
ark_str_47:
    .asciz "MOVEQ r0, #1"
ark_str_48:
    .asciz "MOVNE r0, #0"
ark_str_49:
    .asciz "CMP r0, r1"
ark_str_50:
    .asciz "ITE NE"
ark_str_51:
    .asciz "MOVNE r0, #1"
ark_str_52:
    .asciz "MOVEQ r0, #0"
ark_str_53:
    .asciz "CMP r0, r1"
ark_str_54:
    .asciz "ITE LO"
ark_str_55:
    .asciz "MOVLO r0, #1"
ark_str_56:
    .asciz "MOVHS r0, #0"
ark_str_57:
    .asciz "ITE LT"
ark_str_58:
    .asciz "MOVLT r0, #1"
ark_str_59:
    .asciz "MOVGE r0, #0"
ark_str_60:
    .asciz "CMP r0, r1"
ark_str_61:
    .asciz "ITE HI"
ark_str_62:
    .asciz "MOVHI r0, #1"
ark_str_63:
    .asciz "MOVLS r0, #0"
ark_str_64:
    .asciz "ITE GT"
ark_str_65:
    .asciz "MOVGT r0, #1"
ark_str_66:
    .asciz "MOVLE r0, #0"
ark_str_67:
    .asciz "CMP r0, r1"
ark_str_68:
    .asciz "ITE LS"
ark_str_69:
    .asciz "MOVLS r0, #1"
ark_str_70:
    .asciz "MOVHI r0, #0"
ark_str_71:
    .asciz "ITE LE"
ark_str_72:
    .asciz "MOVLE r0, #1"
ark_str_73:
    .asciz "MOVGT r0, #0"
ark_str_74:
    .asciz "CMP r0, r1"
ark_str_75:
    .asciz "ITE HS"
ark_str_76:
    .asciz "MOVHS r0, #1"
ark_str_77:
    .asciz "MOVLO r0, #0"
ark_str_78:
    .asciz "ITE GE"
ark_str_79:
    .asciz "MOVGE r0, #1"
ark_str_80:
    .asciz "MOVLT r0, #0"
ark_str_81:
    .asciz "; unknown binary op"
ark_str_82:
    .asciz "NEG r0, r0"
ark_str_83:
    .asciz "MVN r0, r0"
ark_str_84:
    .asciz "CMP r0, #0"
ark_str_85:
    .asciz "MOV r0, #0"
ark_str_86:
    .asciz "IT EQ"
ark_str_87:
    .asciz "MOVEQ r0, #1"
ark_str_88:
    .asciz "; unknown unary op"
ark_str_89:
    .asciz ":\n"
ark_str_90:
    .asciz ".cfi_startproc"
ark_str_91:
    .asciz "PUSH {r5, r6, r7, lr}"
ark_str_92:
    .asciz "PUSH {r5, r6, r7, lr}"
ark_str_93:
    .asciz "    SUB sp, sp, #"
ark_str_94:
    .asciz "MOV r6, sp"
ark_str_95:
    .asciz "BX lr"
ark_str_96:
    .asciz "MOV sp, r6"
ark_str_97:
    .asciz "    ADD sp, sp, #"
ark_str_98:
    .asciz "POP {r5, r6, r7, pc}"
ark_str_99:
    .asciz "POP {r5, r6, r7, pc}"
ark_str_100:
    .asciz "; Ark C Compiler - generated Thumb-2 assembly\n"
ark_str_101:
    .asciz ".thumb\n"
ark_str_102:
    .asciz ".text\n\n"
ark_str_103:
    .asciz ".file 1 \""
ark_str_104:
    .asciz "\"\n"
ark_str_105:
    .asciz ".section .rodata\n"
ark_str_106:
    .asciz ".L_str_"
ark_str_107:
    .asciz ":\n    .asciz \""
ark_str_108:
    .asciz "\\n"
ark_str_109:
    .asciz "\\t"
ark_str_110:
    .asciz "\\\\"
ark_str_111:
    .asciz "\\\""
ark_str_112:
    .asciz "\"\n"
ark_str_113:
    .asciz ".text\n\n"
ark_str_114:
    .asciz ".section .rodata\n"
ark_str_115:
    .asciz "0123456789abcdef"
ark_str_116:
    .asciz ".L_flt_"
ark_str_117:
    .asciz ":\n    .word 0x"
ark_str_118:
    .asciz ".L_dbl_"
ark_str_119:
    .asciz ":\n    .word 0x"
ark_str_120:
    .asciz "\n    .word 0x"
ark_str_121:
    .asciz ".text\n\n"
ark_str_122:
    .asciz ".global "
ark_str_123:
    .asciz ".set "
ark_str_124:
    .asciz ", "
ark_str_125:
    .asciz "\n\n"
ark_str_126:
    .asciz ".section .text."
ark_str_127:
    .asciz ", \"ax\", %progbits\n"
ark_str_128:
    .asciz ".global "
ark_str_129:
    .asciz ".weak "
ark_str_130:
    .asciz "@ __attribute__((used))\n"
ark_str_131:
    .asciz "@ __value_in_regs\n"
ark_str_132:
    .asciz "@ __pure\n"
ark_str_133:
    .asciz "@ __attribute__((const))\n"
ark_str_134:
    .asciz "@ __interwork\n"
ark_str_135:
    .asciz "@ __smc("
ark_str_136:
    .asciz ")\n"
ark_str_137:
    .asciz "@ __global_reg("
ark_str_138:
    .asciz ")\n"
ark_str_139:
    .asciz ":\n"
ark_str_140:
    .asciz "    "
ark_str_141:
    .asciz ".type "
ark_str_142:
    .asciz ", %function\n"
ark_str_143:
    .asciz "Reset_Handler"
ark_str_144:
    .asciz "    BL __arkcc_init_globals\n"
ark_str_145:
    .asciz "    STR r0, [r6, #"
ark_str_146:
    .asciz "]\n"
ark_str_147:
    .asciz ".loc 1 "
ark_str_148:
    .asciz "    MOV r3, r"
ark_str_149:
    .asciz "\n"
ark_str_150:
    .asciz "    LDR r3, [r6, #"
ark_str_151:
    .asciz "]\n"
ark_str_152:
    .asciz "    LDR r0, [r3, #"
ark_str_153:
    .asciz "]\n"
ark_str_154:
    .asciz "    STR r0, [r6, #"
ark_str_155:
    .asciz "]\n"
ark_str_156:
    .asciz "    ADD r0, r6, #"
ark_str_157:
    .asciz "\n    MOV r1, r3\n"
ark_str_158:
    .asciz "    PUSH {lr}\n    BL memcpy\n    POP {r0}\n"
ark_str_159:
    .asciz "    STR r"
ark_str_160:
    .asciz ", [r6, #"
ark_str_161:
    .asciz "]\n"
ark_str_162:
    .asciz "    LDR r0, [r6, #"
ark_str_163:
    .asciz "]\n"
ark_str_164:
    .asciz "    STR r0, [r6, #"
ark_str_165:
    .asciz "]\n"
ark_str_166:
    .asciz "    LDR r0, =.L_str_"
ark_str_167:
    .asciz "    LDRB r0, [r6, #"
ark_str_168:
    .asciz "    LDRSB r0, [r6, #"
ark_str_169:
    .asciz "]\n"
ark_str_170:
    .asciz "    LDRH r0, [r6, #"
ark_str_171:
    .asciz "    LDRSH r0, [r6, #"
ark_str_172:
    .asciz "]\n"
ark_str_173:
    .asciz "    LDR r0, [r6, #"
ark_str_174:
    .asciz "]\n    LDR r1, [r6, #"
ark_str_175:
    .asciz "]\n"
ark_str_176:
    .asciz "    PUSH {r1}\n"
ark_str_177:
    .asciz "    LDR r0, [r6, #"
ark_str_178:
    .asciz "]\n"
ark_str_179:
    .asciz "    ADD r0, r6, #"
ark_str_180:
    .asciz "    LDR r0, [r1, #0]\n"
ark_str_181:
    .asciz "    LDR r2, [r1, #4]\n"
ark_str_182:
    .asciz "    PUSH {r2}\n"
ark_str_183:
    .asciz "LDR r0, [r0]"
ark_str_184:
    .asciz "    POP {r1}\n"
ark_str_185:
    .asciz "    STR r0, [r2, #0]\n"
ark_str_186:
    .asciz "    STR r1, [r2, #4]\n"
ark_str_187:
    .asciz "STR r0, [r1]"
ark_str_188:
    .asciz "    POP {r1}\n"
ark_str_189:
    .asciz "    PUSH {r1}\n"
ark_str_190:
    .asciz "    STRB r0, [r6, #"
ark_str_191:
    .asciz "]\n"
ark_str_192:
    .asciz "    STRH r0, [r6, #"
ark_str_193:
    .asciz "]\n"
ark_str_194:
    .asciz "    POP {r1}\n"
ark_str_195:
    .asciz "    STR r0, [r6, #"
ark_str_196:
    .asciz "]\n"
ark_str_197:
    .asciz "    STR r1, [r6, #"
ark_str_198:
    .asciz "]\n"
ark_str_199:
    .asciz "    POP {r1}\n"
ark_str_200:
    .asciz "    STR r0, [r6, #"
ark_str_201:
    .asciz "]\n"
ark_str_202:
    .asciz "    STR r1, [r6, #"
ark_str_203:
    .asciz "]\n"
ark_str_204:
    .asciz "    STR r0, [r6, #"
ark_str_205:
    .asciz "]\n"
ark_str_206:
    .asciz "MUL r1, r2"
ark_str_207:
    .asciz "ADD r0, r0, r1"
ark_str_208:
    .asciz "LDRB r0, [r0, #0]"
ark_str_209:
    .asciz "LDRSH r0, [r0, #0]"
ark_str_210:
    .asciz "LDRB r2, [r0, #0]"
ark_str_211:
    .asciz "LDRB r3, [r0, #1]"
ark_str_212:
    .asciz "LSL r3, r3, #8"
ark_str_213:
    .asciz "ORR r0, r2, r3"
ark_str_214:
    .asciz "LDRB r2, [r0, #0]"
ark_str_215:
    .asciz "LDRB r3, [r0, #1]"
ark_str_216:
    .asciz "LSL r3, r3, #8"
ark_str_217:
    .asciz "ORR r2, r2, r3"
ark_str_218:
    .asciz "LDRB r3, [r0, #2]"
ark_str_219:
    .asciz "LSL r3, r3, #16"
ark_str_220:
    .asciz "ORR r2, r2, r3"
ark_str_221:
    .asciz "LDRB r3, [r0, #3]"
ark_str_222:
    .asciz "LSL r3, r3, #24"
ark_str_223:
    .asciz "ORR r0, r2, r3"
ark_str_224:
    .asciz "LDR r2, [r0, #0]"
ark_str_225:
    .asciz "LDR r3, [r0, #4]"
ark_str_226:
    .asciz "PUSH {r2}"
ark_str_227:
    .asciz "PUSH {r3}"
ark_str_228:
    .asciz "LDR r0, [r0, #0]"
ark_str_229:
    .asciz "POP {r1}"
ark_str_230:
    .asciz "POP {r2}"
ark_str_231:
    .asciz "STR r0, [r2, #0]"
ark_str_232:
    .asciz "STR r1, [r2, #4]"
ark_str_233:
    .asciz "PUSH {r0}"
ark_str_234:
    .asciz "PUSH {r1}"
ark_str_235:
    .asciz "STRB r0, [r1, #0]"
ark_str_236:
    .asciz "STRH r0, [r1, #0]"
ark_str_237:
    .asciz "STRB r0, [r1, #0]"
ark_str_238:
    .asciz "LSR r2, r0, #8"
ark_str_239:
    .asciz "STRB r2, [r1, #1]"
ark_str_240:
    .asciz "STRB r0, [r1, #0]"
ark_str_241:
    .asciz "LSR r2, r0, #8"
ark_str_242:
    .asciz "STRB r2, [r1, #1]"
ark_str_243:
    .asciz "LSR r2, r0, #16"
ark_str_244:
    .asciz "STRB r2, [r1, #2]"
ark_str_245:
    .asciz "LSR r2, r0, #24"
ark_str_246:
    .asciz "STRB r2, [r1, #3]"
ark_str_247:
    .asciz "STR r0, [r1, #0]"
ark_str_248:
    .asciz ".L_"
ark_str_249:
    .asciz ":\n"
ark_str_250:
    .asciz "B"
ark_str_251:
    .asciz "    B .L_"
ark_str_252:
    .asciz "CMP r0, #0"
ark_str_253:
    .asciz "BEQ"
ark_str_254:
    .asciz "CMP r0, #0"
ark_str_255:
    .asciz "BNE"
ark_str_256:
    .asciz "CMP r0, r1"
ark_str_257:
    .asciz "BEQ"
ark_str_258:
    .asciz "    LDR r0, =.L_dbl_"
ark_str_259:
    .asciz "LDR r1, [r0]"
ark_str_260:
    .asciz "LDR r2, [r0, #4]"
ark_str_261:
    .asciz "    PUSH {r1}\n"
ark_str_262:
    .asciz "    PUSH {r2}\n"
ark_str_263:
    .asciz "    LDR r0, =.L_flt_"
ark_str_264:
    .asciz "LDR r0, [r0]"
ark_str_265:
    .asciz "VADD"
ark_str_266:
    .asciz "VADD"
ark_str_267:
    .asciz "POP {r3}"
ark_str_268:
    .asciz "POP {r2}"
ark_str_269:
    .asciz "POP {r1}"
ark_str_270:
    .asciz "POP {r0}"
ark_str_271:
    .asciz "BL __aeabi_dadd"
ark_str_272:
    .asciz "    PUSH {r1}\n"
ark_str_273:
    .asciz "BL __aeabi_fadd"
ark_str_274:
    .asciz "VSUB"
ark_str_275:
    .asciz "VSUB"
ark_str_276:
    .asciz "POP {r3}"
ark_str_277:
    .asciz "POP {r2}"
ark_str_278:
    .asciz "POP {r1}"
ark_str_279:
    .asciz "POP {r0}"
ark_str_280:
    .asciz "BL __aeabi_dsub"
ark_str_281:
    .asciz "    PUSH {r1}\n"
ark_str_282:
    .asciz "BL __aeabi_fsub"
ark_str_283:
    .asciz "VMUL"
ark_str_284:
    .asciz "VMUL"
ark_str_285:
    .asciz "POP {r3}"
ark_str_286:
    .asciz "POP {r2}"
ark_str_287:
    .asciz "POP {r1}"
ark_str_288:
    .asciz "POP {r0}"
ark_str_289:
    .asciz "BL __aeabi_dmul"
ark_str_290:
    .asciz "    PUSH {r1}\n"
ark_str_291:
    .asciz "BL __aeabi_fmul"
ark_str_292:
    .asciz "VDIV"
ark_str_293:
    .asciz "VDIV"
ark_str_294:
    .asciz "POP {r3}"
ark_str_295:
    .asciz "POP {r2}"
ark_str_296:
    .asciz "POP {r1}"
ark_str_297:
    .asciz "POP {r0}"
ark_str_298:
    .asciz "BL __aeabi_ddiv"
ark_str_299:
    .asciz "    PUSH {r1}\n"
ark_str_300:
    .asciz "BL __aeabi_fdiv"
ark_str_301:
    .asciz "POP {r1}"
ark_str_302:
    .asciz "POP {r0}"
ark_str_303:
    .asciz "VMOV s0, r0"
ark_str_304:
    .asciz "VMOV s1, r1"
ark_str_305:
    .asciz "VCVT.U32.F64 s0, d0"
ark_str_306:
    .asciz "VCVT.S32.F64 s0, d0"
ark_str_307:
    .asciz "VMOV r0, s0"
ark_str_308:
    .asciz "VMOV s0, r0"
ark_str_309:
    .asciz "VCVT.U32.F32 s0, s0"
ark_str_310:
    .asciz "VCVT.S32.F32 s0, s0"
ark_str_311:
    .asciz "VMOV r0, s0"
ark_str_312:
    .asciz "POP {r1}"
ark_str_313:
    .asciz "POP {r0}"
ark_str_314:
    .asciz "BL __aeabi_d2uiz"
ark_str_315:
    .asciz "BL __aeabi_d2iz"
ark_str_316:
    .asciz "BL __aeabi_f2uiz"
ark_str_317:
    .asciz "BL __aeabi_f2iz"
ark_str_318:
    .asciz "VMOV s0, r0"
ark_str_319:
    .asciz "VCVT.F64.U32 d0, s0"
ark_str_320:
    .asciz "VCVT.F64.S32 d0, s0"
ark_str_321:
    .asciz "VMOV r0, s0"
ark_str_322:
    .asciz "VMOV r1, s1"
ark_str_323:
    .asciz "    PUSH {r1}\n"
ark_str_324:
    .asciz "VCVT.F32.U32 s0, s0"
ark_str_325:
    .asciz "VCVT.F32.S32 s0, s0"
ark_str_326:
    .asciz "VMOV r0, s0"
ark_str_327:
    .asciz "BL __aeabi_ui2d"
ark_str_328:
    .asciz "BL __aeabi_i2d"
ark_str_329:
    .asciz "    PUSH {r1}\n"
ark_str_330:
    .asciz "BL __aeabi_ui2f"
ark_str_331:
    .asciz "BL __aeabi_i2f"
ark_str_332:
    .asciz "VMOV s0, r0"
ark_str_333:
    .asciz "VMOV s1, r1"
ark_str_334:
    .asciz "VCVT.F32.F64 s0, d0"
ark_str_335:
    .asciz "VMOV r0, s0"
ark_str_336:
    .asciz "VMOV s0, r0"
ark_str_337:
    .asciz "VCVT.F64.F32 d0, s0"
ark_str_338:
    .asciz "VMOV r0, s0"
ark_str_339:
    .asciz "VMOV r1, s1"
ark_str_340:
    .asciz "    PUSH {r1}\n"
ark_str_341:
    .asciz "BL __aeabi_d2f"
ark_str_342:
    .asciz "BL __aeabi_f2d"
ark_str_343:
    .asciz "    PUSH {r1}\n"
ark_str_344:
    .asciz "EQ"
ark_str_345:
    .asciz "POP {r3}"
ark_str_346:
    .asciz "POP {r2}"
ark_str_347:
    .asciz "POP {r1}"
ark_str_348:
    .asciz "POP {r0}"
ark_str_349:
    .asciz "VMOV s0, r0"
ark_str_350:
    .asciz "VMOV s1, r1"
ark_str_351:
    .asciz "VMOV s2, r2"
ark_str_352:
    .asciz "VMOV s3, r3"
ark_str_353:
    .asciz "VCMP.F64 d0, d1"
ark_str_354:
    .asciz "VMOV s0, r0"
ark_str_355:
    .asciz "VMOV s1, r1"
ark_str_356:
    .asciz "VCMP.F32 s0, s1"
ark_str_357:
    .asciz "VMRS APSR_nzcv, FPSCR"
ark_str_358:
    .asciz "EQ"
ark_str_359:
    .asciz "NE"
ark_str_360:
    .asciz "LT"
ark_str_361:
    .asciz "GT"
ark_str_362:
    .asciz "LE"
ark_str_363:
    .asciz "GE"
ark_str_364:
    .asciz "EQ"
ark_str_365:
    .asciz "    IT "
ark_str_366:
    .asciz "    MOV"
ark_str_367:
    .asciz " r0, #1\n"
ark_str_368:
    .asciz "__aeabi_fcmpeq"
ark_str_369:
    .asciz "__aeabi_dcmpeq"
ark_str_370:
    .asciz "__aeabi_fcmpeq"
ark_str_371:
    .asciz "__aeabi_dcmpeq"
ark_str_372:
    .asciz "__aeabi_fcmpeq"
ark_str_373:
    .asciz "__aeabi_dcmplt"
ark_str_374:
    .asciz "__aeabi_fcmplt"
ark_str_375:
    .asciz "__aeabi_dcmpgt"
ark_str_376:
    .asciz "__aeabi_fcmpgt"
ark_str_377:
    .asciz "__aeabi_dcmple"
ark_str_378:
    .asciz "__aeabi_fcmple"
ark_str_379:
    .asciz "__aeabi_dcmpge"
ark_str_380:
    .asciz "__aeabi_fcmpge"
ark_str_381:
    .asciz "POP {r3}"
ark_str_382:
    .asciz "POP {r2}"
ark_str_383:
    .asciz "POP {r1}"
ark_str_384:
    .asciz "POP {r0}"
ark_str_385:
    .asciz "    BL "
ark_str_386:
    .asciz "EOR r0, r0, #1"
ark_str_387:
    .asciz "    "
ark_str_388:
    .asciz "    "
ark_str_389:
    .asciz "    "
ark_str_390:
    .asciz "__nop"
ark_str_391:
    .asciz "__isb"
ark_str_392:
    .asciz "__dsb"
ark_str_393:
    .asciz "__dmb"
ark_str_394:
    .asciz "__memory_changed"
ark_str_395:
    .asciz "__disable_irq"
ark_str_396:
    .asciz "__enable_irq"
ark_str_397:
    .asciz "__wfi"
ark_str_398:
    .asciz "__wfe"
ark_str_399:
    .asciz "__sev"
ark_str_400:
    .asciz "__clz"
ark_str_401:
    .asciz "    POP {r"
ark_str_402:
    .asciz "}\n"
ark_str_403:
    .asciz "    ADD sp, sp, #"
ark_str_404:
    .asciz "__nop"
ark_str_405:
    .asciz "    NOP\n"
ark_str_406:
    .asciz "__isb"
ark_str_407:
    .asciz "    ISB SY\n"
ark_str_408:
    .asciz "__dsb"
ark_str_409:
    .asciz "    DSB SY\n"
ark_str_410:
    .asciz "__dmb"
ark_str_411:
    .asciz "    DMB SY\n"
ark_str_412:
    .asciz "__memory_changed"
ark_str_413:
    .asciz "__disable_irq"
ark_str_414:
    .asciz "    CPSID i\n"
ark_str_415:
    .asciz "__enable_irq"
ark_str_416:
    .asciz "    CPSIE i\n"
ark_str_417:
    .asciz "__wfi"
ark_str_418:
    .asciz "    WFI\n"
ark_str_419:
    .asciz "__wfe"
ark_str_420:
    .asciz "    WFE\n"
ark_str_421:
    .asciz "__sev"
ark_str_422:
    .asciz "    SEV\n"
ark_str_423:
    .asciz "__clz"
ark_str_424:
    .asciz "    CLZ r0, r0\n"
ark_str_425:
    .asciz "    POP {r"
ark_str_426:
    .asciz "}\n"
ark_str_427:
    .asciz "    SUB sp, sp, #"
ark_str_428:
    .asciz "    MOV r0, sp\n"
ark_str_429:
    .asciz "    BL "
ark_str_430:
    .asciz "    ADD sp, sp, #"
ark_str_431:
    .asciz "    POP {ip}\n"
ark_str_432:
    .asciz "    ORR ip, ip, #1\n"
ark_str_433:
    .asciz "    POP {r"
ark_str_434:
    .asciz "}\n"
ark_str_435:
    .asciz "    SUB sp, sp, #4\n"
ark_str_436:
    .asciz "    BLX ip\n"
ark_str_437:
    .asciz "    BL "
ark_str_438:
    .asciz "    ADD sp, sp, #4\n"
ark_str_439:
    .asciz "    ADD sp, sp, #"
ark_str_440:
    .asciz "    PUSH {r1}\n"
ark_str_441:
    .asciz "    SVC #"
ark_str_442:
    .asciz "    SMC #"
ark_str_443:
    .asciz "    UDIV r0, r0, r1\n"
ark_str_444:
    .asciz "    SDIV r0, r0, r1\n"
ark_str_445:
    .asciz "    UDIV r2, r0, r1\n"
ark_str_446:
    .asciz "    SDIV r2, r0, r1\n"
ark_str_447:
    .asciz "MUL r2, r2, r1"
ark_str_448:
    .asciz "SUB r0, r0, r2"
ark_str_449:
    .asciz "__aeabi_ladd"
ark_str_450:
    .asciz "__aeabi_lsub"
ark_str_451:
    .asciz "__aeabi_lmul"
ark_str_452:
    .asciz "__aeabi_uldivmod"
ark_str_453:
    .asciz "__aeabi_ldivmod"
ark_str_454:
    .asciz "__aeabi_uldivmod"
ark_str_455:
    .asciz "__aeabi_ldivmod"
ark_str_456:
    .asciz "POP {r3}"
ark_str_457:
    .asciz "POP {r2}"
ark_str_458:
    .asciz "POP {r1}"
ark_str_459:
    .asciz "POP {r0}"
ark_str_460:
    .asciz "    BL "
ark_str_461:
    .asciz "MOV r0, r2"
ark_str_462:
    .asciz "MOV r1, r3"
ark_str_463:
    .asciz "    PUSH {r1}\n"
ark_str_464:
    .asciz "__aeabi_ulcmp"
ark_str_465:
    .asciz "__aeabi_lcmp"
ark_str_466:
    .asciz "POP {r3}"
ark_str_467:
    .asciz "POP {r2}"
ark_str_468:
    .asciz "POP {r1}"
ark_str_469:
    .asciz "POP {r0}"
ark_str_470:
    .asciz "    BL "
ark_str_471:
    .asciz "CMP r0, #0"
ark_str_472:
    .asciz "ITE EQ"
ark_str_473:
    .asciz "MOVEQ r0, #1"
ark_str_474:
    .asciz "MOVNE r0, #0"
ark_str_475:
    .asciz "ITE NE"
ark_str_476:
    .asciz "MOVNE r0, #1"
ark_str_477:
    .asciz "MOVEQ r0, #0"
ark_str_478:
    .asciz "ITE LT"
ark_str_479:
    .asciz "MOVLT r0, #1"
ark_str_480:
    .asciz "MOVGE r0, #0"
ark_str_481:
    .asciz "ITE GT"
ark_str_482:
    .asciz "MOVGT r0, #1"
ark_str_483:
    .asciz "MOVLE r0, #0"
ark_str_484:
    .asciz "ITE LE"
ark_str_485:
    .asciz "MOVLE r0, #1"
ark_str_486:
    .asciz "MOVGT r0, #0"
ark_str_487:
    .asciz "ITE GE"
ark_str_488:
    .asciz "MOVGE r0, #1"
ark_str_489:
    .asciz "MOVLT r0, #0"
ark_str_490:
    .asciz "BL memcpy"
ark_str_491:
    .asciz "AND r0, r2"
ark_str_492:
    .asciz "    LSL r0, r0, #"
ark_str_493:
    .asciz "    LSL r2, r2, #"
ark_str_494:
    .asciz "LDR r3, [r1]"
ark_str_495:
    .asciz "BIC r3, r2"
ark_str_496:
    .asciz "ORR r3, r0"
ark_str_497:
    .asciz "STR r3, [r1]"
ark_str_498:
    .asciz "LDR r0, [r0]"
ark_str_499:
    .asciz "    LSR r0, r0, #"
ark_str_500:
    .asciz "    LSL r0, r0, #"
ark_str_501:
    .asciz "    ASR r0, r0, #"
ark_str_502:
    .asciz "AND r0, r2"
ark_str_503:
    .asciz "    LDR r0, [r6, #"
ark_str_504:
    .asciz "]\n"
ark_str_505:
    .asciz "    LDR r2, [r1, #"
ark_str_506:
    .asciz "]\n"
ark_str_507:
    .asciz "    STR r2, [r0, #"
ark_str_508:
    .asciz "]\n"
ark_str_509:
    .asciz "MOV sp, r6"
ark_str_510:
    .asciz "    ADD sp, sp, #"
ark_str_511:
    .asciz "POP {r5, r6, r7, pc}"
ark_str_512:
    .asciz "POP {r5, r6, r7, pc}"
ark_str_513:
    .asciz "ADD r0, r0, #7"
ark_str_514:
    .asciz "BIC r0, r0, #7"
ark_str_515:
    .asciz "SUB sp, sp, r0"
ark_str_516:
    .asciz "MOV r0, sp"
ark_str_517:
    .asciz "SADD16 r0, r0, r1"
ark_str_518:
    .asciz "SSUB16 r0, r0, r1"
ark_str_519:
    .asciz "SADD8 r0, r0, r1"
ark_str_520:
    .asciz "SSUB8 r0, r0, r1"
ark_str_521:
    .asciz "    ; unknown ir op "
ark_str_522:
    .asciz ".cfi_endproc"
ark_str_523:
    .asciz ".size "
ark_str_524:
    .asciz ", .-"
ark_str_525:
    .asciz ".section .init_array, \"aw\"\n"
ark_str_526:
    .asciz ".align 2\n"
ark_str_527:
    .asciz ".word "
ark_str_528:
    .asciz ".text\n"
ark_str_529:
    .asciz ".section .fini_array, \"aw\"\n"
ark_str_530:
    .asciz ".align 2\n"
ark_str_531:
    .asciz ".word "
ark_str_532:
    .asciz ".text\n"
ark_str_533:
    .asciz ".global __arkcc_init_globals\n"
ark_str_534:
    .asciz ".thumb_func\n"
ark_str_535:
    .asciz "__arkcc_init_globals:\n"
ark_str_536:
    .asciz "    PUSH {lr}\n"
ark_str_537:
    .asciz "    STR r0, [r1]\n"
ark_str_538:
    .asciz "    STR r0, [r1, #4]\n"
ark_str_539:
    .asciz "    STR r0, [r1]\n"
ark_str_540:
    .asciz "    STRB r0, [r1]\n"
ark_str_541:
    .asciz "    STRH r0, [r1]\n"
ark_str_542:
    .asciz "    STR r0, [r1]\n"
ark_str_543:
    .asciz "    STRB r0, [r1]\n"
ark_str_544:
    .asciz "    STRB r0, [r1]\n"
ark_str_545:
    .asciz "    STRH r0, [r1]\n"
ark_str_546:
    .asciz "    STR r0, [r1]\n"
ark_str_547:
    .asciz "    STR r0, [r1, #4]\n"
ark_str_548:
    .asciz "    STR r0, [r1]\n"
ark_str_549:
    .asciz "    CMP r0, r1\n"
ark_str_550:
    .asciz "    BEQ .L_bss_done\n"
ark_str_551:
    .asciz "    MOV r2, #0\n"
ark_str_552:
    .asciz ".L_bss_loop:\n"
ark_str_553:
    .asciz "    STR r2, [r0]\n"
ark_str_554:
    .asciz "    ADD r0, r0, #4\n"
ark_str_555:
    .asciz "    CMP r0, r1\n"
ark_str_556:
    .asciz "    BNE .L_bss_loop\n"
ark_str_557:
    .asciz ".L_bss_done:\n"
ark_str_558:
    .asciz "    POP {r0}\n"
ark_str_559:
    .asciz "    BX r0\n\n"
ark_str_560:
    .asciz ".global __aeabi_ladd\n"
ark_str_561:
    .asciz ".thumb_func\n"
ark_str_562:
    .asciz "__aeabi_ladd:\n"
ark_str_563:
    .asciz "    ADD r0, r0, r2\n"
ark_str_564:
    .asciz "    ADC r1, r3\n"
ark_str_565:
    .asciz "    BX lr\n\n"
ark_str_566:
    .asciz ".global __aeabi_lsub\n"
ark_str_567:
    .asciz ".thumb_func\n"
ark_str_568:
    .asciz "__aeabi_lsub:\n"
ark_str_569:
    .asciz "    SUB r0, r0, r2\n"
ark_str_570:
    .asciz "    SBC r1, r3\n"
ark_str_571:
    .asciz "    BX lr\n\n"
ark_str_572:
    .asciz ".global __aeabi_lmul\n"
ark_str_573:
    .asciz ".thumb_func\n"
ark_str_574:
    .asciz "__aeabi_lmul:\n"
ark_str_575:
    .asciz "    PUSH {r4, r5, lr}\n"
ark_str_576:
    .asciz "    MOV r4, r3\n"
ark_str_577:
    .asciz "    MUL r4, r0\n"
ark_str_578:
    .asciz "    MOV r5, r1\n"
ark_str_579:
    .asciz "    MUL r5, r2\n"
ark_str_580:
    .asciz "    UMULL r0, r1, r0, r2\n"
ark_str_581:
    .asciz "    ADD r1, r4\n"
ark_str_582:
    .asciz "    ADD r1, r5\n"
ark_str_583:
    .asciz "    POP {r4, r5, pc}\n\n"
ark_str_584:
    .asciz ".global __aeabi_lcmp\n"
ark_str_585:
    .asciz ".thumb_func\n"
ark_str_586:
    .asciz "__aeabi_lcmp:\n"
ark_str_587:
    .asciz "    CMP r1, r3\n"
ark_str_588:
    .asciz "    BGT .L_lcmp_gt\n"
ark_str_589:
    .asciz "    BLT .L_lcmp_lt\n"
ark_str_590:
    .asciz "    CMP r0, r2\n"
ark_str_591:
    .asciz "    BHI .L_lcmp_gt\n"
ark_str_592:
    .asciz "    BCC .L_lcmp_lt\n"
ark_str_593:
    .asciz "    MOV r0, #0\n"
ark_str_594:
    .asciz "    BX lr\n"
ark_str_595:
    .asciz ".L_lcmp_lt:\n"
ark_str_596:
    .asciz "    MOV r0, #0\n"
ark_str_597:
    .asciz "    MVN r0, r0\n"
ark_str_598:
    .asciz "    BX lr\n"
ark_str_599:
    .asciz ".L_lcmp_gt:\n"
ark_str_600:
    .asciz "    MOV r0, #1\n"
ark_str_601:
    .asciz "    BX lr\n\n"
ark_str_602:
    .asciz ".global __aeabi_ulcmp\n"
ark_str_603:
    .asciz ".thumb_func\n"
ark_str_604:
    .asciz "__aeabi_ulcmp:\n"
ark_str_605:
    .asciz "    CMP r1, r3\n"
ark_str_606:
    .asciz "    BHI .L_ulcmp_gt\n"
ark_str_607:
    .asciz "    BCC .L_ulcmp_lt\n"
ark_str_608:
    .asciz "    CMP r0, r2\n"
ark_str_609:
    .asciz "    BHI .L_ulcmp_gt\n"
ark_str_610:
    .asciz "    BCC .L_ulcmp_lt\n"
ark_str_611:
    .asciz "    MOV r0, #0\n"
ark_str_612:
    .asciz "    BX lr\n"
ark_str_613:
    .asciz ".L_ulcmp_lt:\n"
ark_str_614:
    .asciz "    MOV r0, #0\n"
ark_str_615:
    .asciz "    MVN r0, r0\n"
ark_str_616:
    .asciz "    BX lr\n"
ark_str_617:
    .asciz ".L_ulcmp_gt:\n"
ark_str_618:
    .asciz "    MOV r0, #1\n"
ark_str_619:
    .asciz "    BX lr\n\n"
ark_str_620:
    .asciz ".global __aeabi_uldivmod\n"
ark_str_621:
    .asciz ".thumb_func\n"
ark_str_622:
    .asciz "__aeabi_uldivmod:\n"
ark_str_623:
    .asciz "    Push {r4, r5, r6, r7, lr}\n"
ark_str_624:
    .asciz "    MOV r6, r2\n"
ark_str_625:
    .asciz "    MOV r7, r3\n"
ark_str_626:
    .asciz "    MOV r2, #0\n"
ark_str_627:
    .asciz "    MOV r3, #0\n"
ark_str_628:
    .asciz "    MOV r4, #64\n"
ark_str_629:
    .asciz "    MOV r5, r6\n"
ark_str_630:
    .asciz "    ORR r5, r7\n"
ark_str_631:
    .asciz "    CMP r5, #0\n"
ark_str_632:
    .asciz "    BEQ .L_uldiv_zero\n"
ark_str_633:
    .asciz ".L_uldiv_loop:\n"
ark_str_634:
    .asciz "    LSR r5, r1, #31\n"
ark_str_635:
    .asciz "    Push {r5}\n"
ark_str_636:
    .asciz "    LSR r5, r0, #31\n"
ark_str_637:
    .asciz "    LSL r0, r0, #1\n"
ark_str_638:
    .asciz "    LSL r1, r1, #1\n"
ark_str_639:
    .asciz "    ORR r1, r5\n"
ark_str_640:
    .asciz "    Pop {r5}\n"
ark_str_641:
    .asciz "    Push {r4}\n"
ark_str_642:
    .asciz "    LSR r4, r2, #31\n"
ark_str_643:
    .asciz "    LSL r2, r2, #1\n"
ark_str_644:
    .asciz "    ORR r2, r5\n"
ark_str_645:
    .asciz "    LSL r3, r3, #1\n"
ark_str_646:
    .asciz "    ORR r3, r4\n"
ark_str_647:
    .asciz "    Pop {r4}\n"
ark_str_648:
    .asciz "    CMP r3, r7\n"
ark_str_649:
    .asciz "    BHI .L_uldiv_sub\n"
ark_str_650:
    .asciz "    BCC .L_uldiv_skip\n"
ark_str_651:
    .asciz "    CMP r2, r6\n"
ark_str_652:
    .asciz "    BCC .L_uldiv_skip\n"
ark_str_653:
    .asciz ".L_uldiv_sub:\n"
ark_str_654:
    .asciz "    SUB r2, r2, r6\n"
ark_str_655:
    .asciz "    SBC r3, r7\n"
ark_str_656:
    .asciz "    MOV r5, #1\n"
ark_str_657:
    .asciz "    ORR r0, r5\n"
ark_str_658:
    .asciz ".L_uldiv_skip:\n"
ark_str_659:
    .asciz "    SUB r4, r4, #1\n"
ark_str_660:
    .asciz "    BNE .L_uldiv_loop\n"
ark_str_661:
    .asciz "    Pop {r4, r5, r6, r7, pc}\n"
ark_str_662:
    .asciz ".L_uldiv_zero:\n"
ark_str_663:
    .asciz "    MOV r0, #0\n"
ark_str_664:
    .asciz "    MOV r1, #0\n"
ark_str_665:
    .asciz "    MOV r2, #0\n"
ark_str_666:
    .asciz "    MOV r3, #0\n"
ark_str_667:
    .asciz "    Pop {r4, r5, r6, r7, pc}\n\n"
ark_str_668:
    .asciz ".global __aeabi_ldivmod\n"
ark_str_669:
    .asciz ".thumb_func\n"
ark_str_670:
    .asciz "__aeabi_ldivmod:\n"
ark_str_671:
    .asciz "    Push {r4, r5, r6, r7, lr}\n"
ark_str_672:
    .asciz "    ASR r5, r1, #31\n"
ark_str_673:
    .asciz "    MOV r6, r5\n"
ark_str_674:
    .asciz "    CMP r5, #0\n"
ark_str_675:
    .asciz "    BEQ .L_ldiv_posd\n"
ark_str_676:
    .asciz "    CMP r0, #0\n"
ark_str_677:
    .asciz "    BEQ .L_ldiv_neg_d_hi\n"
ark_str_678:
    .asciz "    RSB r0, r0\n"
ark_str_679:
    .asciz "    MVN r1, r1\n"
ark_str_680:
    .asciz "    B .L_ldiv_posd\n"
ark_str_681:
    .asciz ".L_ldiv_neg_d_hi:\n"
ark_str_682:
    .asciz "    RSB r1, r1\n"
ark_str_683:
    .asciz ".L_ldiv_posd:\n"
ark_str_684:
    .asciz "    ASR r5, r3, #31\n"
ark_str_685:
    .asciz "    CMP r5, #0\n"
ark_str_686:
    .asciz "    BEQ .L_ldiv_posb\n"
ark_str_687:
    .asciz "    CMP r2, #0\n"
ark_str_688:
    .asciz "    BEQ .L_ldiv_neg_b_hi\n"
ark_str_689:
    .asciz "    RSB r2, r2\n"
ark_str_690:
    .asciz "    MVN r3, r3\n"
ark_str_691:
    .asciz "    B .L_ldiv_posb\n"
ark_str_692:
    .asciz ".L_ldiv_neg_b_hi:\n"
ark_str_693:
    .asciz "    RSB r3, r3\n"
ark_str_694:
    .asciz ".L_ldiv_posb:\n"
ark_str_695:
    .asciz "    BL __aeabi_uldivmod\n"
ark_str_696:
    .asciz "    MOV r4, r6\n"
ark_str_697:
    .asciz "    EOR r4, r5\n"
ark_str_698:
    .asciz "    CMP r4, #0\n"
ark_str_699:
    .asciz "    BEQ .L_ldiv_qpos\n"
ark_str_700:
    .asciz "    CMP r0, #0\n"
ark_str_701:
    .asciz "    BEQ .L_ldiv_neg_q_hi\n"
ark_str_702:
    .asciz "    RSB r0, r0\n"
ark_str_703:
    .asciz "    MVN r1, r1\n"
ark_str_704:
    .asciz "    B .L_ldiv_qpos\n"
ark_str_705:
    .asciz ".L_ldiv_neg_q_hi:\n"
ark_str_706:
    .asciz "    RSB r1, r1\n"
ark_str_707:
    .asciz ".L_ldiv_qpos:\n"
ark_str_708:
    .asciz "    CMP r6, #0\n"
ark_str_709:
    .asciz "    BEQ .L_ldiv_rpos\n"
ark_str_710:
    .asciz "    CMP r2, #0\n"
ark_str_711:
    .asciz "    BEQ .L_ldiv_neg_r_hi\n"
ark_str_712:
    .asciz "    RSB r2, r2\n"
ark_str_713:
    .asciz "    MVN r3, r3\n"
ark_str_714:
    .asciz "    B .L_ldiv_rpos\n"
ark_str_715:
    .asciz ".L_ldiv_neg_r_hi:\n"
ark_str_716:
    .asciz "    RSB r3, r3\n"
ark_str_717:
    .asciz ".L_ldiv_rpos:\n"
ark_str_718:
    .asciz "    Pop {r4, r5, r6, r7, pc}\n\n"
ark_str_719:
    .asciz ".global __aeabi_f2iz\n.thumb_func\n__aeabi_f2iz:\n"
ark_str_720:
    .asciz "    LSR r1, r0, #23\n"
ark_str_721:
    .asciz "    LSL r1, r1, #1\n"
ark_str_722:
    .asciz "    LSR r1, r1, #1\n"
ark_str_723:
    .asciz "    CMP r1, #150\n"
ark_str_724:
    .asciz "    BGE .L_f2iz_shl\n"
ark_str_725:
    .asciz "    CMP r1, #126\n"
ark_str_726:
    .asciz "    BLT .L_f2iz_zero\n"
ark_str_727:
    .asciz "    SUB r2, r1, #127\n"
ark_str_728:
    .asciz "    LSL r0, r0, #9\n"
ark_str_729:
    .asciz "    LSR r0, r0, r2\n"
ark_str_730:
    .asciz "    B .L_f2iz_sign\n"
ark_str_731:
    .asciz ".L_f2iz_shl:\n"
ark_str_732:
    .asciz "    SUB r2, r1, #150\n"
ark_str_733:
    .asciz "    MOV r0, #0x800000\n"
ark_str_734:
    .asciz "    LSL r0, r0, r2\n"
ark_str_735:
    .asciz ".L_f2iz_sign:\n"
ark_str_736:
    .asciz "    LSR r1, r0, #31\n"
ark_str_737:
    .asciz "    CMP r1, #0\n"
ark_str_738:
    .asciz "    BEQ .L_f2iz_done\n"
ark_str_739:
    .asciz "    RSB r0, r0, #0\n"
ark_str_740:
    .asciz ".L_f2iz_done:\n"
ark_str_741:
    .asciz "    BX lr\n"
ark_str_742:
    .asciz ".L_f2iz_zero:\n"
ark_str_743:
    .asciz "    MOV r0, #0\n"
ark_str_744:
    .asciz "    BX lr\n\n"
ark_str_745:
    .asciz ".global __aeabi_f2uiz\n.thumb_func\n__aeabi_f2uiz:\n"
ark_str_746:
    .asciz "    PUSH {lr}\n"
ark_str_747:
    .asciz "    BL __aeabi_f2iz\n"
ark_str_748:
    .asciz "    POP {r0}\n"
ark_str_749:
    .asciz "    BX r0\n\n"
ark_str_750:
    .asciz ".global __aeabi_i2f\n.thumb_func\n__aeabi_i2f:\n"
ark_str_751:
    .asciz "    PUSH {lr}\n"
ark_str_752:
    .asciz "    CMP r0, #0\n"
ark_str_753:
    .asciz "    BGE .L_i2f_pos\n"
ark_str_754:
    .asciz "    RSB r0, r0, #0\n"
ark_str_755:
    .asciz "    MOV r1, #1\n"
ark_str_756:
    .asciz "    B .L_i2f_conv\n"
ark_str_757:
    .asciz ".L_i2f_pos:\n"
ark_str_758:
    .asciz "    MOV r1, #0\n"
ark_str_759:
    .asciz ".L_i2f_conv:\n"
ark_str_760:
    .asciz "    CLZ r2, r0\n"
ark_str_761:
    .asciz "    RSB r2, r2, #31\n"
ark_str_762:
    .asciz "    MOV r3, #127\n"
ark_str_763:
    .asciz "    ADD r3, r3, r2\n"
ark_str_764:
    .asciz "    LSL r3, r3, #23\n"
ark_str_765:
    .asciz "    LSL r0, r0, r2\n"
ark_str_766:
    .asciz "    LSL r0, r0, #1\n"
ark_str_767:
    .asciz "    LSR r0, r0, #9\n"
ark_str_768:
    .asciz "    ORR r0, r0, r3\n"
ark_str_769:
    .asciz "    CMP r1, #0\n"
ark_str_770:
    .asciz "    BEQ .L_i2f_done\n"
ark_str_771:
    .asciz "    MOV r1, #1\n"
ark_str_772:
    .asciz "    LSL r1, r1, #31\n"
ark_str_773:
    .asciz "    ORR r0, r0, r1\n"
ark_str_774:
    .asciz ".L_i2f_done:\n"
ark_str_775:
    .asciz "    POP {r0}\n"
ark_str_776:
    .asciz "    BX r0\n\n"
ark_str_777:
    .asciz ".global __aeabi_ui2f\n.thumb_func\n__aeabi_ui2f:\n"
ark_str_778:
    .asciz "    PUSH {lr}\n"
ark_str_779:
    .asciz "    MOV r1, #0\n"
ark_str_780:
    .asciz "    B .L_i2f_conv\n\n"
ark_str_781:
    .asciz ".global __aeabi_fadd\n.thumb_func\n__aeabi_fadd:\n"
ark_str_782:
    .asciz "    BX lr\n\n"
ark_str_783:
    .asciz ".global __aeabi_fsub\n.thumb_func\n__aeabi_fsub:\n"
ark_str_784:
    .asciz "    BX lr\n\n"
ark_str_785:
    .asciz ".global __aeabi_fmul\n.thumb_func\n__aeabi_fmul:\n"
ark_str_786:
    .asciz "    BX lr\n\n"
ark_str_787:
    .asciz ".global __aeabi_fdiv\n.thumb_func\n__aeabi_fdiv:\n"
ark_str_788:
    .asciz "    BX lr\n\n"
ark_str_789:
    .asciz ".global __aeabi_d2iz\n.thumb_func\n__aeabi_d2iz:\n"
ark_str_790:
    .asciz "    POP {r1}\n"
ark_str_791:
    .asciz "    PUSH {lr}\n"
ark_str_792:
    .asciz "    BL __aeabi_f2iz\n"
ark_str_793:
    .asciz "    POP {r0}\n"
ark_str_794:
    .asciz "    BX r0\n\n"
ark_str_795:
    .asciz ".global __aeabi_d2uiz\n.thumb_func\n__aeabi_d2uiz:\n"
ark_str_796:
    .asciz "    POP {r1}\n"
ark_str_797:
    .asciz "    PUSH {lr}\n"
ark_str_798:
    .asciz "    BL __aeabi_f2uiz\n"
ark_str_799:
    .asciz "    POP {r0}\n"
ark_str_800:
    .asciz "    BX r0\n\n"
ark_str_801:
    .asciz ".global __aeabi_i2d\n.thumb_func\n__aeabi_i2d:\n"
ark_str_802:
    .asciz "    PUSH {lr}\n"
ark_str_803:
    .asciz "    BL __aeabi_i2f\n"
ark_str_804:
    .asciz "    MOV r1, #0\n"
ark_str_805:
    .asciz "    POP {r0}\n"
ark_str_806:
    .asciz "    BX r0\n\n"
ark_str_807:
    .asciz ".global __aeabi_ui2d\n.thumb_func\n__aeabi_ui2d:\n"
ark_str_808:
    .asciz "    PUSH {lr}\n"
ark_str_809:
    .asciz "    BL __aeabi_ui2f\n"
ark_str_810:
    .asciz "    MOV r1, #0\n"
ark_str_811:
    .asciz "    POP {r0}\n"
ark_str_812:
    .asciz "    BX r0\n\n"
ark_str_813:
    .asciz ".global __aeabi_dadd\n.thumb_func\n__aeabi_dadd:\n"
ark_str_814:
    .asciz "    BX lr\n\n"
ark_str_815:
    .asciz ".global __aeabi_dsub\n.thumb_func\n__aeabi_dsub:\n"
ark_str_816:
    .asciz "    BX lr\n\n"
ark_str_817:
    .asciz ".global __aeabi_dmul\n.thumb_func\n__aeabi_dmul:\n"
ark_str_818:
    .asciz "    BX lr\n\n"
ark_str_819:
    .asciz ".global __aeabi_ddiv\n.thumb_func\n__aeabi_ddiv:\n"
ark_str_820:
    .asciz "    BX lr\n\n"
ark_str_821:
    .asciz ".global __aeabi_fcmpeq\n.thumb_func\n__aeabi_fcmpeq:\n"
ark_str_822:
    .asciz "    CMP r0, r1\n"
ark_str_823:
    .asciz "    ITE EQ\n"
ark_str_824:
    .asciz "    MOVEQ r0, #1\n"
ark_str_825:
    .asciz "    MOVNE r0, #0\n"
ark_str_826:
    .asciz "    BX lr\n\n"
ark_str_827:
    .asciz ".global __aeabi_fcmplt\n.thumb_func\n__aeabi_fcmplt:\n"
ark_str_828:
    .asciz "    CMP r0, r1\n"
ark_str_829:
    .asciz "    ITE LT\n"
ark_str_830:
    .asciz "    MOVLT r0, #1\n"
ark_str_831:
    .asciz "    MOVGE r0, #0\n"
ark_str_832:
    .asciz "    BX lr\n\n"
ark_str_833:
    .asciz ".global __aeabi_fcmpgt\n.thumb_func\n__aeabi_fcmpgt:\n"
ark_str_834:
    .asciz "    CMP r0, r1\n"
ark_str_835:
    .asciz "    ITE GT\n"
ark_str_836:
    .asciz "    MOVGT r0, #1\n"
ark_str_837:
    .asciz "    MOVLE r0, #0\n"
ark_str_838:
    .asciz "    BX lr\n\n"
ark_str_839:
    .asciz ".global __aeabi_fcmple\n.thumb_func\n__aeabi_fcmple:\n"
ark_str_840:
    .asciz "    CMP r0, r1\n"
ark_str_841:
    .asciz "    ITE LE\n"
ark_str_842:
    .asciz "    MOVLE r0, #1\n"
ark_str_843:
    .asciz "    MOVGT r0, #0\n"
ark_str_844:
    .asciz "    BX lr\n\n"
ark_str_845:
    .asciz ".global __aeabi_fcmpge\n.thumb_func\n__aeabi_fcmpge:\n"
ark_str_846:
    .asciz "    CMP r0, r1\n"
ark_str_847:
    .asciz "    ITE GE\n"
ark_str_848:
    .asciz "    MOVGE r0, #1\n"
ark_str_849:
    .asciz "    MOVLT r0, #0\n"
ark_str_850:
    .asciz "    BX lr\n\n"
ark_str_851:
    .asciz ".global "
ark_str_852:
    .asciz ".set "
ark_str_853:
    .asciz ", 0x"
ark_str_854:
    .asciz "0123456789abcdef"
ark_str_855:
    .asciz ".section \""
ark_str_856:
    .asciz "\"\n"
ark_str_857:
    .asciz ".data\n"
ark_str_858:
    .asciz ".bss\n"
ark_str_859:
    .asciz ".section .rodata\n"
ark_str_860:
    .asciz ".section .tbss,\"aw\",%nobits\n"
ark_str_861:
    .asciz ".section .tdata,\"aw\",%progbits\n"
ark_str_862:
    .asciz ".global "
ark_str_863:
    .asciz ".balign "
ark_str_864:
    .asciz ".align 4\n"
ark_str_865:
    .asciz ":\n"
ark_str_866:
    .asciz "    .zero "
ark_str_867:
    .asciz "0123456789abcdef"
ark_str_868:
    .asciz "    .word 0x"
ark_str_869:
    .asciz "    .asciz \""
ark_str_870:
    .asciz "\\n"
ark_str_871:
    .asciz "\\t"
ark_str_872:
    .asciz "\\\\"
ark_str_873:
    .asciz "\\\""
ark_str_874:
    .asciz "0123456789abcdef"
ark_str_875:
    .asciz "\"\n"
ark_str_876:
    .asciz "    .zero "
ark_str_877:
    .asciz "    .word "
ark_str_878:
    .asciz "    .zero "
ark_str_879:
    .asciz ".text\n\n"
ark_str_880:
    .asciz "input.c"
ark_str_881:
    .asciz ".section .debug_abbrev,\"\",%progbits\n"
ark_str_882:
    .asciz ".balign 4\n"
ark_str_883:
    .asciz "    .byte 1\n"
ark_str_884:
    .asciz "    .byte 17\n"
ark_str_885:
    .asciz "    .byte 0\n"
ark_str_886:
    .asciz "    .byte 3\n  .byte 8\n"
ark_str_887:
    .asciz "    .byte 16\n  .byte 6\n"
ark_str_888:
    .asciz "    .byte 0\n  .byte 0\n"
ark_str_889:
    .asciz "    .byte 2\n"
ark_str_890:
    .asciz "    .byte 46\n"
ark_str_891:
    .asciz "    .byte 0\n"
ark_str_892:
    .asciz "    .byte 3\n  .byte 8\n"
ark_str_893:
    .asciz "    .byte 17\n  .byte 1\n"
ark_str_894:
    .asciz "    .byte 18\n  .byte 1\n"
ark_str_895:
    .asciz "    .byte 0\n  .byte 0\n"
ark_str_896:
    .asciz "    .byte 0\n"
ark_str_897:
    .asciz ".section .debug_info,\"\",%progbits\n"
ark_str_898:
    .asciz ".balign 4\n"
ark_str_899:
    .asciz "    .word 0\n"
ark_str_900:
    .asciz "    .half 2\n"
ark_str_901:
    .asciz "    .word 0\n"
ark_str_902:
    .asciz "    .byte 4\n"
ark_str_903:
    .asciz "    .byte 1\n"
ark_str_904:
    .asciz "    .asciz \""
ark_str_905:
    .asciz "\"\n"
ark_str_906:
    .asciz "    .word 0\n"
ark_str_907:
    .asciz "    .byte 2\n"
ark_str_908:
    .asciz "    .asciz \""
ark_str_909:
    .asciz "\"\n"
ark_str_910:
    .asciz "    .word "
ark_str_911:
    .asciz "    .word "
ark_str_912:
    .asciz "_end\n"
ark_str_913:
    .asciz "    .byte 0\n"
ark_str_914:
    .asciz ".section .debug_line,\"\",%progbits\n"
ark_str_915:
    .asciz ".balign 4\n"
ark_str_916:
    .asciz "    .word 0\n"
ark_str_917:
    .asciz "    .half 2\n"
ark_str_918:
    .asciz "    .word 0\n"
ark_str_919:
    .asciz "    .byte 4\n"
ark_str_920:
    .asciz "    .byte 0\n"
ark_str_921:
    .asciz "    .byte 1\n"
ark_str_922:
    .asciz "    .byte 1\n"
ark_str_923:
    .asciz "    .byte 13\n"
ark_str_924:
    .asciz "    .byte 0,1,1,0,1,0,0,1,1,1,1,1\n"
ark_str_925:
    .asciz "    .asciz \""
ark_str_926:
    .asciz "\"\n"
ark_str_927:
    .asciz "    .byte 0\n"
ark_str_928:
    .asciz "    .asciz \""
ark_str_929:
    .asciz "\"\n"
ark_str_930:
    .asciz "    .byte 0,0,0\n"
ark_str_931:
    .asciz "    .byte 0\n"
ark_str_932:
    .asciz "    .byte 0,9,2\n"
ark_str_933:
    .asciz ".text\n"
ark_str_934:
    .asciz "BL"
ark_str_935:
    .asciz "MOVW"
ark_str_936:
    .asciz "MOVT"
ark_str_937:
    .asciz "SDIV"
ark_str_938:
    .asciz "UDIV"
ark_str_939:
    .asciz "UMULL"
ark_str_940:
    .asciz "B.W"
ark_str_941:
    .asciz "B"
ark_str_942:
    .asciz "BEQ"
ark_str_943:
    .asciz "BNE"
ark_str_944:
    .asciz "BCS"
ark_str_945:
    .asciz "BCC"
ark_str_946:
    .asciz "BGE"
ark_str_947:
    .asciz "BLT"
ark_str_948:
    .asciz "BGT"
ark_str_949:
    .asciz "BLE"
ark_str_950:
    .asciz "DMB"
ark_str_951:
    .asciz "DSB"
ark_str_952:
    .asciz "ISB"
ark_str_953:
    .asciz "RRX"
ark_str_954:
    .asciz "VMOV"
ark_str_955:
    .asciz "VADD"
ark_str_956:
    .asciz "VSUB"
ark_str_957:
    .asciz "VMUL"
ark_str_958:
    .asciz "VDIV"
ark_str_959:
    .asciz "VCVT"
ark_str_960:
    .asciz "VCMP"
ark_str_961:
    .asciz "VMRS"
ark_str_962:
    .asciz "VSTR"
ark_str_963:
    .asciz "VLDR"
ark_str_964:
    .asciz "VNEG"
ark_str_965:
    .asciz "VABS"
ark_str_966:
    .asciz "VSQRT"
ark_str_967:
    .asciz ".set"
ark_str_968:
    .asciz ".equ"
ark_str_969:
    .asciz ".zero"
ark_str_970:
    .asciz ".skip"
ark_str_971:
    .asciz ".space"
ark_str_972:
    .asciz ".word"
ark_str_973:
    .asciz ".long"
ark_str_974:
    .asciz ".byte"
ark_str_975:
    .asciz ".asciz"
ark_str_976:
    .asciz ".ascii"
ark_str_977:
    .asciz ".align"
ark_str_978:
    .asciz ".balign"
ark_str_979:
    .asciz "LDR"
ark_str_980:
    .asciz "LDRB"
ark_str_981:
    .asciz "STR"
ark_str_982:
    .asciz "STRB"
ark_str_983:
    .asciz "LDRH"
ark_str_984:
    .asciz "STRH"
ark_str_985:
    .asciz "LDRSH"
ark_str_986:
    .asciz "LDRSB"
ark_str_987:
    .asciz "LDRH"
ark_str_988:
    .asciz "STRH"
ark_str_989:
    .asciz "LDRSH"
ark_str_990:
    .asciz "LDRSB"
ark_str_991:
    .asciz "PUSH"
ark_str_992:
    .asciz "POP"
ark_str_993:
    .asciz "ADD"
ark_str_994:
    .asciz "SUB"
ark_str_995:
    .asciz "CMP"
ark_str_996:
    .asciz "MOVEQ"
ark_str_997:
    .asciz "MOVNE"
ark_str_998:
    .asciz "MOVLT"
ark_str_999:
    .asciz "MOVGT"
ark_str_1000:
    .asciz "MOVLE"
ark_str_1001:
    .asciz "MOVGE"
ark_str_1002:
    .asciz "MOVLO"
ark_str_1003:
    .asciz "MOVHI"
ark_str_1004:
    .asciz "MOVLS"
ark_str_1005:
    .asciz "MOVHS"
ark_str_1006:
    .asciz "MOVCS"
ark_str_1007:
    .asciz "MOVCC"
ark_str_1008:
    .asciz ".set"
ark_str_1009:
    .asciz ".equ"
ark_str_1010:
    .asciz ".zero"
ark_str_1011:
    .asciz ".skip"
ark_str_1012:
    .asciz ".space"
ark_str_1013:
    .asciz ".word"
ark_str_1014:
    .asciz ".long"
ark_str_1015:
    .asciz ".byte"
ark_str_1016:
    .asciz ".asciz"
ark_str_1017:
    .asciz ".ascii"
ark_str_1018:
    .asciz ".asciz"
ark_str_1019:
    .asciz ".align"
ark_str_1020:
    .asciz ".balign"
ark_str_1021:
    .asciz "PUSH"
ark_str_1022:
    .asciz "POP"
ark_str_1023:
    .asciz "MOV"
ark_str_1024:
    .asciz "MOVEQ"
ark_str_1025:
    .asciz "MOVNE"
ark_str_1026:
    .asciz "MOVLT"
ark_str_1027:
    .asciz "MOVGT"
ark_str_1028:
    .asciz "MOVLE"
ark_str_1029:
    .asciz "MOVGE"
ark_str_1030:
    .asciz "MOVLO"
ark_str_1031:
    .asciz "MOVHI"
ark_str_1032:
    .asciz "MOVLS"
ark_str_1033:
    .asciz "MOVHS"
ark_str_1034:
    .asciz "MOVCS"
ark_str_1035:
    .asciz "MOVCC"
ark_str_1036:
    .asciz "MOVW"
ark_str_1037:
    .asciz "MOVT"
ark_str_1038:
    .asciz "ADD"
ark_str_1039:
    .asciz "SUB"
ark_str_1040:
    .asciz "MUL"
ark_str_1041:
    .asciz "ADC"
ark_str_1042:
    .asciz "SBC"
ark_str_1043:
    .asciz "UMULL"
ark_str_1044:
    .asciz "SDIV"
ark_str_1045:
    .asciz "UDIV"
ark_str_1046:
    .asciz "SDIV"
ark_str_1047:
    .asciz "AND"
ark_str_1048:
    .asciz "ORR"
ark_str_1049:
    .asciz "EOR"
ark_str_1050:
    .asciz "LSL"
ark_str_1051:
    .asciz "LSR"
ark_str_1052:
    .asciz "ASR"
ark_str_1053:
    .asciz "BIC"
ark_str_1054:
    .asciz "MVN"
ark_str_1055:
    .asciz "NEG"
ark_str_1056:
    .asciz "RSB"
ark_str_1057:
    .asciz "CMP"
ark_str_1058:
    .asciz "LDR"
ark_str_1059:
    .asciz "LDRB"
ark_str_1060:
    .asciz "STR"
ark_str_1061:
    .asciz "STRB"
ark_str_1062:
    .asciz "[asm-arm] unresolved symbol '%s' in LDR =label\n"
ark_str_1063:
    .asciz "BX"
ark_str_1064:
    .asciz "NOP"
ark_str_1065:
    .asciz "IT"
ark_str_1066:
    .asciz "ITT"
ark_str_1067:
    .asciz "ITE"
ark_str_1068:
    .asciz "ITTT"
ark_str_1069:
    .asciz "EQ"
ark_str_1070:
    .asciz "NE"
ark_str_1071:
    .asciz "HS"
ark_str_1072:
    .asciz "CS"
ark_str_1073:
    .asciz "LO"
ark_str_1074:
    .asciz "CC"
ark_str_1075:
    .asciz "MI"
ark_str_1076:
    .asciz "PL"
ark_str_1077:
    .asciz "VS"
ark_str_1078:
    .asciz "VC"
ark_str_1079:
    .asciz "HI"
ark_str_1080:
    .asciz "LS"
ark_str_1081:
    .asciz "GE"
ark_str_1082:
    .asciz "LT"
ark_str_1083:
    .asciz "GT"
ark_str_1084:
    .asciz "LE"
ark_str_1085:
    .asciz "IT"
ark_str_1086:
    .asciz "ITT"
ark_str_1087:
    .asciz "ITE"
ark_str_1088:
    .asciz "BL"
ark_str_1089:
    .asciz "B"
ark_str_1090:
    .asciz "BEQ"
ark_str_1091:
    .asciz "BNE"
ark_str_1092:
    .asciz "BLT"
ark_str_1093:
    .asciz "BGT"
ark_str_1094:
    .asciz "BLE"
ark_str_1095:
    .asciz "BGE"
ark_str_1096:
    .asciz "BCC"
ark_str_1097:
    .asciz "BCS"
ark_str_1098:
    .asciz "BEQ"
ark_str_1099:
    .asciz "BNE"
ark_str_1100:
    .asciz "BCS"
ark_str_1101:
    .asciz "BCC"
ark_str_1102:
    .asciz "BGE"
ark_str_1103:
    .asciz "BLT"
ark_str_1104:
    .asciz "BGT"
ark_str_1105:
    .asciz "BLE"
ark_str_1106:
    .asciz "STRH"
ark_str_1107:
    .asciz "LDRH"
ark_str_1108:
    .asciz "LDRSH"
ark_str_1109:
    .asciz "LDRSB"
ark_str_1110:
    .asciz "STRH"
ark_str_1111:
    .asciz "LDRH"
ark_str_1112:
    .asciz "LDRSH"
ark_str_1113:
    .asciz "STRH"
ark_str_1114:
    .asciz "LDRH"
ark_str_1115:
    .asciz "LDRSH"
ark_str_1116:
    .asciz "CPSID"
ark_str_1117:
    .asciz "CPSIE"
ark_str_1118:
    .asciz "CPSID"
ark_str_1119:
    .asciz "DMB"
ark_str_1120:
    .asciz "DSB"
ark_str_1121:
    .asciz "ISB"
ark_str_1122:
    .asciz "DMB"
ark_str_1123:
    .asciz "DSB"
ark_str_1124:
    .asciz "SEV"
ark_str_1125:
    .asciz "WFE"
ark_str_1126:
    .asciz "WFI"
ark_str_1127:
    .asciz "SEV"
ark_str_1128:
    .asciz "WFE"
ark_str_1129:
    .asciz "REV"
ark_str_1130:
    .asciz "REV16"
ark_str_1131:
    .asciz "REVSH"
ark_str_1132:
    .asciz "REV"
ark_str_1133:
    .asciz "REV16"
ark_str_1134:
    .asciz "RRX"
ark_str_1135:
    .asciz "VMOV"
ark_str_1136:
    .asciz "VADD"
ark_str_1137:
    .asciz "VSUB"
ark_str_1138:
    .asciz "VMUL"
ark_str_1139:
    .asciz "VDIV"
ark_str_1140:
    .asciz "F64"
ark_str_1141:
    .asciz "VADD"
ark_str_1142:
    .asciz "VSUB"
ark_str_1143:
    .asciz "VMUL"
ark_str_1144:
    .asciz "VCVT"
ark_str_1145:
    .asciz "S32F32"
ark_str_1146:
    .asciz "F32S32"
ark_str_1147:
    .asciz "S32F64"
ark_str_1148:
    .asciz "F64S32"
ark_str_1149:
    .asciz "S32F64"
ark_str_1150:
    .asciz "F64S32"
ark_str_1151:
    .asciz "VCMP"
ark_str_1152:
    .asciz "F64"
ark_str_1153:
    .asciz "VMRS"
ark_str_1154:
    .asciz "VNEG"
ark_str_1155:
    .asciz "VABS"
ark_str_1156:
    .asciz "VSQRT"
ark_str_1157:
    .asciz "F64"
ark_str_1158:
    .asciz "VNEG"
ark_str_1159:
    .asciz "VABS"
ark_str_1160:
    .asciz "VLDR"
ark_str_1161:
    .asciz "VSTR"
ark_str_1162:
    .asciz "F64"
ark_str_1163:
    .asciz "VLDR"
ark_str_1164:
    .asciz "[asm-arm] unresolved label '%s'\n"
ark_str_1165:
    .asciz "ARKCC_DUMP_SYMS"
ark_str_1166:
    .asciz "=== ARM Symbol Map (%d labels) ===\n"
ark_str_1167:
    .asciz "  %-40s 0x%04X (%d)\n"
ark_str_1168:
    .asciz "=== End Symbol Map ===\n"
ark_str_1169:
    .asciz "arm"
ark_str_1170:
    .asciz "armv7m-thumb2-eabi"
    .text
_emit_line:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -16(%ebp)
    leal ark_str_0, %eax
    pushl %eax
    pushl -24(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -16(%ebp)
    pushl -24(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    pushl -24(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_mov_imm:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lemit_mov_imm_2
    pushl -24(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lemit_mov_imm_3
.Lemit_mov_imm_2:
    pushl $0
.Lemit_mov_imm_3:
    popl %eax
    cmpl $0, %eax
    je .Lemit_mov_imm_0
    leal ark_str_1, %eax
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -32(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_2, %eax
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    pushl -40(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_mov_imm_1
.Lemit_mov_imm_0:
    leal ark_str_3, %eax
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -32(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_4, %eax
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    pushl $65535
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    pushl -40(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_5, %eax
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -32(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_6, %eax
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $65535
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    pushl -40(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lemit_mov_imm_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_push_r0:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    leal ark_str_7, %eax
    pushl %eax
    pushl -24(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_pop_r0:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    leal ark_str_8, %eax
    pushl %eax
    pushl -24(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_pop_r1:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    leal ark_str_9, %eax
    pushl %eax
    pushl -24(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_sret_lookup:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -48(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lsret_lookup_0:
    pushl -24(%ebp)
    pushl -40(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsret_lookup_1
    pushl -32(%ebp)
    pushl -56(%ebp)
    pushl -24(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsret_lookup_3
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsret_lookup_3:
.Lsret_lookup_4:
.Lsret_lookup_2:
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    addl $4, %esp
    jmp .Lsret_lookup_0
.Lsret_lookup_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_sret_get_size:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -48(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lsret_get_size_0:
    pushl -24(%ebp)
    pushl -40(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsret_get_size_1
    pushl -32(%ebp)
    pushl -56(%ebp)
    pushl -24(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsret_get_size_3
    pushl -48(%ebp)
    pushl -24(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsret_get_size_3:
.Lsret_get_size_4:
.Lsret_get_size_2:
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    addl $4, %esp
    jmp .Lsret_get_size_0
.Lsret_get_size_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_vfp_f32_binop:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -16(%ebp)
    pushl -24(%ebp)
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_10, %eax
    pushl %eax
    pushl -24(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_11, %eax
    pushl %eax
    pushl -24(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_12, %eax
    pushl %eax
    pushl -24(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -16(%ebp)
    pushl -24(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_13, %eax
    pushl %eax
    pushl -24(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_14, %eax
    pushl %eax
    pushl -24(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_vfp_f64_binop:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -16(%ebp)
    leal ark_str_15, %eax
    pushl %eax
    pushl -24(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_16, %eax
    pushl %eax
    pushl -24(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_17, %eax
    pushl %eax
    pushl -24(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_18, %eax
    pushl %eax
    pushl -24(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_19, %eax
    pushl %eax
    pushl -24(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_20, %eax
    pushl %eax
    pushl -24(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_21, %eax
    pushl %eax
    pushl -24(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_22, %eax
    pushl %eax
    pushl -24(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_23, %eax
    pushl %eax
    pushl -24(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -16(%ebp)
    pushl -24(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_24, %eax
    pushl %eax
    pushl -24(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_25, %eax
    pushl %eax
    pushl -24(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_26, %eax
    pushl %eax
    pushl -24(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_27, %eax
    pushl %eax
    pushl -24(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_label:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    leal ark_str_28, %eax
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -32(%ebp)
    pushl -40(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    pushl -40(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_29, %eax
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_b_label:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -16(%ebp)
    leal ark_str_30, %eax
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -32(%ebp)
    pushl -40(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_31, %eax
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    pushl -40(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    pushl -40(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -16(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    pushl -40(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_binary:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    pushl $256
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -48(%ebp)
    pushl $256
    popl %eax
    notl %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_binary_1
    pushl -24(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_binary_2
    pushl -24(%ebp)
    pushl $17
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_binary_3
    pushl -24(%ebp)
    pushl $18
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_binary_4
    pushl -24(%ebp)
    pushl $19
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_binary_5
    pushl -24(%ebp)
    pushl $30
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_binary_6
    pushl -24(%ebp)
    pushl $31
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_binary_7
    pushl -24(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_binary_8
    pushl -24(%ebp)
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_binary_9
    pushl -24(%ebp)
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_binary_10
    pushl -24(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_binary_11
    pushl -24(%ebp)
    pushl $22
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_binary_12
    pushl -24(%ebp)
    pushl $23
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_binary_13
    pushl -24(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_binary_14
    pushl -24(%ebp)
    pushl $25
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_binary_15
    pushl -24(%ebp)
    pushl $26
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_binary_16
    jmp .Lemit_binary_17
.Lemit_binary_1:
    leal ark_str_32, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_2:
    leal ark_str_33, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_3:
    leal ark_str_34, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_4:
    leal ark_str_35, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_5:
    leal ark_str_36, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_37, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_38, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_6:
    leal ark_str_39, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_7:
    leal ark_str_40, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_8:
    leal ark_str_41, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_9:
    leal ark_str_42, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_10:
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lemit_binary_18
    leal ark_str_43, %eax
    pushl %eax
    jmp .Lemit_binary_19
.Lemit_binary_18:
    leal ark_str_44, %eax
    pushl %eax
.Lemit_binary_19:
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_11:
    leal ark_str_45, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_46, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_47, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_48, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_12:
    leal ark_str_49, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_50, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_51, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_52, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_13:
    leal ark_str_53, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lemit_binary_20
    leal ark_str_54, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_55, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_56, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_21
.Lemit_binary_20:
    leal ark_str_57, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_58, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_59, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lemit_binary_21:
    jmp .Lemit_binary_0
.Lemit_binary_14:
    leal ark_str_60, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lemit_binary_22
    leal ark_str_61, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_62, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_63, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_23
.Lemit_binary_22:
    leal ark_str_64, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_65, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_66, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lemit_binary_23:
    jmp .Lemit_binary_0
.Lemit_binary_15:
    leal ark_str_67, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lemit_binary_24
    leal ark_str_68, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_69, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_70, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_25
.Lemit_binary_24:
    leal ark_str_71, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_72, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_73, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lemit_binary_25:
    jmp .Lemit_binary_0
.Lemit_binary_16:
    leal ark_str_74, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lemit_binary_26
    leal ark_str_75, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_76, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_77, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_27
.Lemit_binary_26:
    leal ark_str_78, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_79, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_80, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lemit_binary_27:
    jmp .Lemit_binary_0
.Lemit_binary_17:
    leal ark_str_81, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_0:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_unary:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_unary_1
    pushl -24(%ebp)
    pushl $33
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_unary_2
    pushl -24(%ebp)
    pushl $29
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_unary_3
    jmp .Lemit_unary_4
.Lemit_unary_1:
    leal ark_str_82, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_unary_0
.Lemit_unary_2:
    leal ark_str_83, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_unary_0
.Lemit_unary_3:
    leal ark_str_84, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_85, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_86, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_87, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_unary_0
.Lemit_unary_4:
    leal ark_str_88, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_unary_0
.Lemit_unary_0:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_prologue:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -48(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 24(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 28(%ebp), %eax
    movl %eax, -16(%ebp)
    pushl -48(%ebp)
    pushl -56(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_89, %eax
    pushl %eax
    pushl -56(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -16(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lemit_prologue_0
    leal ark_str_90, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_prologue_1
.Lemit_prologue_0:
.Lemit_prologue_1:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lemit_prologue_2
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lemit_prologue_2:
.Lemit_prologue_3:
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lemit_prologue_4
    leal ark_str_91, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_prologue_5
.Lemit_prologue_4:
    leal ark_str_92, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lemit_prologue_5:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lemit_prologue_6
    leal ark_str_93, %eax
    pushl %eax
    pushl -56(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    pushl -56(%ebp)
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    pushl -56(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_prologue_7
.Lemit_prologue_6:
.Lemit_prologue_7:
    leal ark_str_94, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_epilogue_return:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lemit_epilogue_return_0
    leal ark_str_95, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lemit_epilogue_return_0:
.Lemit_epilogue_return_1:
    pushl -40(%ebp)
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_96, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -32(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lemit_epilogue_return_2
    leal ark_str_97, %eax
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -32(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    pushl -40(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_epilogue_return_3
.Lemit_epilogue_return_2:
.Lemit_epilogue_return_3:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lemit_epilogue_return_4
    leal ark_str_98, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_epilogue_return_5
.Lemit_epilogue_return_4:
    leal ark_str_99, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lemit_epilogue_return_5:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_gvar_find:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lgvar_find_0:
    pushl -16(%ebp)
    movl _g_gvar_count, %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_find_1
    pushl -24(%ebp)
    movl $_g_gvar_names, %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_find_3
    movl $_g_gvar_addrs, %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lgvar_find_3:
.Lgvar_find_4:
.Lgvar_find_2:
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    addl $4, %esp
    jmp .Lgvar_find_0
.Lgvar_find_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_gvar_find_size:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lgvar_find_size_0:
    pushl -16(%ebp)
    movl _g_gvar_count, %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_find_size_1
    pushl -24(%ebp)
    movl $_g_gvar_names, %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_find_size_3
    movl $_g_gvar_sizes, %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lgvar_find_size_3:
.Lgvar_find_size_4:
.Lgvar_find_size_2:
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    addl $4, %esp
    jmp .Lgvar_find_size_0
.Lgvar_find_size_1:
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_gvar_known:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lgvar_known_0:
    pushl -16(%ebp)
    movl _g_gvar_count, %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_known_1
    pushl -24(%ebp)
    movl $_g_gvar_names, %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_known_3
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lgvar_known_3:
.Lgvar_known_4:
.Lgvar_known_2:
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    addl $4, %esp
    jmp .Lgvar_known_0
.Lgvar_known_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_gvar_assign:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl $536870912
    popl %eax
    movl %eax, -48(%ebp)
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_gvar_count
    addl $4, %esp
    pushl -48(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_data_sram_start
    addl $4, %esp
    pushl -48(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_data_sram_end
    addl $4, %esp
    pushl -48(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_bss_sram_start
    addl $4, %esp
    pushl -48(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_bss_sram_end
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lgvar_assign_0:
    pushl -40(%ebp)
    pushl -56(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_3
    movl _g_gvar_count, %eax
    pushl %eax
    pushl $2048
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lgvar_assign_4
.Lgvar_assign_3:
    pushl $0
.Lgvar_assign_4:
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_1
    pushl -56(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_5
    jmp .Lgvar_assign_2
.Lgvar_assign_5:
.Lgvar_assign_6:
    pushl -32(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_7
    jmp .Lgvar_assign_2
.Lgvar_assign_7:
.Lgvar_assign_8:
    pushl -32(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_9
    jmp .Lgvar_assign_2
.Lgvar_assign_9:
.Lgvar_assign_10:
    pushl -32(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_17
    pushl -32(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lgvar_assign_18
.Lgvar_assign_17:
    pushl $0
.Lgvar_assign_18:
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_15
    pushl -32(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lgvar_assign_16
.Lgvar_assign_15:
    pushl $0
.Lgvar_assign_16:
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_13
    pushl -32(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jne .L64f_gvar_assign_130
    cmpl %eax, (%esp)
    jne .L64f_gvar_assign_130
    addl $4, %esp
    pushl $1
    jmp .L64e_gvar_assign_130
.L64f_gvar_assign_130:
    addl $4, %esp
    pushl $0
.L64e_gvar_assign_130:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lgvar_assign_14
.Lgvar_assign_13:
    pushl $0
.Lgvar_assign_14:
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_11
    jmp .Lgvar_assign_2
.Lgvar_assign_11:
.Lgvar_assign_12:
    pushl -32(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_19
    pushl -32(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _type_size
    addl $4, %esp
    pushl %eax
    jmp .Lgvar_assign_20
.Lgvar_assign_19:
    pushl $4
.Lgvar_assign_20:
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_21
    pushl $4
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lgvar_assign_22
.Lgvar_assign_21:
.Lgvar_assign_22:
    pushl -48(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $3
    popl %eax
    notl %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    movl $_g_gvar_names, %eax
    pushl %eax
    movl _g_gvar_count, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_g_gvar_addrs, %eax
    pushl %eax
    movl _g_gvar_count, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_g_gvar_sizes, %eax
    pushl %eax
    movl _g_gvar_count, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl _g_gvar_count, %eax
    pushl %eax
    movl _g_gvar_count, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_gvar_count
    addl $4, %esp
    pushl -48(%ebp)
    pushl -24(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Lgvar_assign_2:
    pushl -40(%ebp)
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    addl $4, %esp
    jmp .Lgvar_assign_0
.Lgvar_assign_1:
    pushl -48(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $3
    popl %eax
    notl %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl -48(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_data_sram_end
    addl $4, %esp
    pushl -48(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_bss_sram_start
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lgvar_assign_23:
    pushl -40(%ebp)
    pushl -56(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_26
    movl _g_gvar_count, %eax
    pushl %eax
    pushl $2048
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lgvar_assign_27
.Lgvar_assign_26:
    pushl $0
.Lgvar_assign_27:
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_24
    pushl -56(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_28
    jmp .Lgvar_assign_25
.Lgvar_assign_28:
.Lgvar_assign_29:
    pushl -32(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_30
    movl $_g_gvar_names, %eax
    pushl %eax
    movl _g_gvar_count, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_g_gvar_addrs, %eax
    pushl %eax
    movl _g_gvar_count, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_g_gvar_sizes, %eax
    pushl %eax
    movl _g_gvar_count, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_32
    pushl -32(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _type_size
    addl $4, %esp
    pushl %eax
    jmp .Lgvar_assign_33
.Lgvar_assign_32:
    pushl $4
.Lgvar_assign_33:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl _g_gvar_count, %eax
    pushl %eax
    movl _g_gvar_count, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_gvar_count
    addl $4, %esp
    jmp .Lgvar_assign_25
.Lgvar_assign_30:
.Lgvar_assign_31:
    pushl -32(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_34
    pushl -32(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lgvar_assign_42
    pushl -32(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lgvar_assign_43
.Lgvar_assign_42:
    pushl $1
.Lgvar_assign_43:
    popl %eax
    cmpl $0, %eax
    jne .Lgvar_assign_40
    pushl -32(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lgvar_assign_41
.Lgvar_assign_40:
    pushl $1
.Lgvar_assign_41:
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_38
    pushl -32(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jne .L64f_gvar_assign_399
    cmpl %eax, (%esp)
    jne .L64f_gvar_assign_399
    addl $4, %esp
    pushl $1
    jmp .L64e_gvar_assign_399
.L64f_gvar_assign_399:
    addl $4, %esp
    pushl $0
.L64e_gvar_assign_399:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lgvar_assign_39
.Lgvar_assign_38:
    pushl $0
.Lgvar_assign_39:
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_36
    jmp .Lgvar_assign_37
.Lgvar_assign_36:
    jmp .Lgvar_assign_25
.Lgvar_assign_37:
    jmp .Lgvar_assign_35
.Lgvar_assign_34:
.Lgvar_assign_35:
    pushl -32(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_44
    pushl -32(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _type_size
    addl $4, %esp
    pushl %eax
    jmp .Lgvar_assign_45
.Lgvar_assign_44:
    pushl $4
.Lgvar_assign_45:
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lgvar_assign_46
    pushl $4
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lgvar_assign_47
.Lgvar_assign_46:
.Lgvar_assign_47:
    pushl -48(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $3
    popl %eax
    notl %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    movl $_g_gvar_names, %eax
    pushl %eax
    movl _g_gvar_count, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_g_gvar_addrs, %eax
    pushl %eax
    movl _g_gvar_count, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_g_gvar_sizes, %eax
    pushl %eax
    movl _g_gvar_count, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl _g_gvar_count, %eax
    pushl %eax
    movl _g_gvar_count, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_gvar_count
    addl $4, %esp
    pushl -48(%ebp)
    pushl -24(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Lgvar_assign_25:
    pushl -40(%ebp)
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    addl $4, %esp
    jmp .Lgvar_assign_23
.Lgvar_assign_24:
    pushl -48(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $3
    popl %eax
    notl %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_bss_sram_end
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_codegen_arm:
    pushl %ebp
    movl %esp, %ebp
    subl $2512, %esp
    movl 8(%ebp), %eax
    movl %eax, -2264(%ebp)
    movl $_g_config, %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_2
    movl $_g_config, %eax
    pushl %eax
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_3
.Lcodegen_arm_2:
    pushl $1
.Lcodegen_arm_3:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_0
    pushl $1
    jmp .Lcodegen_arm_1
.Lcodegen_arm_0:
    pushl $0
.Lcodegen_arm_1:
    popl %eax
    movl %eax, -2232(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_init
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -2264(%ebp)
    call _gvar_assign
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_100, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_101, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_102, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -2232(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_6
    pushl -2264(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_7
.Lcodegen_arm_6:
    pushl $0
.Lcodegen_arm_7:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_4
    leal ark_str_103, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -2264(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_104, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_5
.Lcodegen_arm_4:
.Lcodegen_arm_5:
    pushl -2264(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_8
    leal ark_str_105, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -2224(%ebp)
    pushl -2224(%ebp)
    addl $4, %esp
.Lcodegen_arm_10:
    pushl -2224(%ebp)
    pushl -2264(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_11
    pushl -2264(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -2224(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -2216(%ebp)
    leal ark_str_106, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -2216(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_107, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -2208(%ebp)
    pushl -2208(%ebp)
    addl $4, %esp
.Lcodegen_arm_13:
    pushl -2208(%ebp)
    pushl -2216(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_14
    pushl -2216(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -2208(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -2200(%ebp)
    movzbl -2200(%ebp), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_16
    leal ark_str_108, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_17
.Lcodegen_arm_16:
    movzbl -2200(%ebp), %eax
    pushl %eax
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_18
    leal ark_str_109, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_19
.Lcodegen_arm_18:
    movzbl -2200(%ebp), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_20
    leal ark_str_110, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_21
.Lcodegen_arm_20:
    movzbl -2200(%ebp), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_22
    leal ark_str_111, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_23
.Lcodegen_arm_22:
    movzbl -2200(%ebp), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_23:
.Lcodegen_arm_21:
.Lcodegen_arm_19:
.Lcodegen_arm_17:
.Lcodegen_arm_15:
    pushl -2208(%ebp)
    pushl -2208(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -2208(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_13
.Lcodegen_arm_14:
    leal ark_str_112, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_12:
    pushl -2224(%ebp)
    pushl -2224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -2224(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_10
.Lcodegen_arm_11:
    leal ark_str_113, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_9
.Lcodegen_arm_8:
.Lcodegen_arm_9:
    pushl -2264(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_24
    leal ark_str_114, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -2224(%ebp)
    pushl -2224(%ebp)
    addl $4, %esp
.Lcodegen_arm_26:
    pushl -2224(%ebp)
    pushl -2264(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_27
    leal ark_str_115, %eax
    pushl %eax
    popl %eax
    movl %eax, -2168(%ebp)
    leal -2216(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -2264(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -2224(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    fldl (%esp)
    addl $8, %esp
    subl $4, %esp
    fstps (%esp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -2216(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -2200(%ebp)
    pushl -2200(%ebp)
    addl $4, %esp
    pushl $7
    popl %eax
    movl %eax, -2176(%ebp)
    pushl -2176(%ebp)
    addl $4, %esp
.Lcodegen_arm_29:
    pushl -2176(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_30
    leal -2192(%ebp), %eax
    pushl %eax
    pushl -2176(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -2168(%ebp)
    pushl -2200(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -2200(%ebp)
    pushl $4
    popl %eax
    movl %eax, -2200(%ebp)
    pushl -2200(%ebp)
    addl $4, %esp
.Lcodegen_arm_31:
    pushl -2176(%ebp)
    pushl -2176(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -2176(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_29
.Lcodegen_arm_30:
    leal -2192(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal ark_str_116, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -2224(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_117, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2192(%ebp), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2208(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -2264(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -2224(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    leal ark_str_118, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -2224(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_119, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2208(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -2160(%ebp)
    pushl $7
    popl %eax
    movl %eax, -2136(%ebp)
    pushl -2136(%ebp)
    addl $4, %esp
.Lcodegen_arm_32:
    pushl -2136(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_33
    leal -2152(%ebp), %eax
    pushl %eax
    pushl -2136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -2168(%ebp)
    pushl -2160(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -2160(%ebp)
    pushl $4
    popl %eax
    movl %eax, -2160(%ebp)
    pushl -2160(%ebp)
    addl $4, %esp
.Lcodegen_arm_34:
    pushl -2136(%ebp)
    pushl -2136(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -2136(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_32
.Lcodegen_arm_33:
    leal -2152(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -2152(%ebp), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_120, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2208(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -2160(%ebp)
    pushl $7
    popl %eax
    movl %eax, -2136(%ebp)
    pushl -2136(%ebp)
    addl $4, %esp
.Lcodegen_arm_35:
    pushl -2136(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_36
    leal -2152(%ebp), %eax
    pushl %eax
    pushl -2136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -2168(%ebp)
    pushl -2160(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -2160(%ebp)
    pushl $4
    popl %eax
    movl %eax, -2160(%ebp)
    pushl -2160(%ebp)
    addl $4, %esp
.Lcodegen_arm_37:
    pushl -2136(%ebp)
    pushl -2136(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -2136(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_35
.Lcodegen_arm_36:
    leal -2152(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -2152(%ebp), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_28:
    pushl -2224(%ebp)
    pushl -2224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -2224(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_26
.Lcodegen_arm_27:
    leal ark_str_121, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_25
.Lcodegen_arm_24:
.Lcodegen_arm_25:
    pushl $0
    popl %eax
    movl %eax, -176(%ebp)
    pushl $0
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
.Lcodegen_arm_38:
    pushl -168(%ebp)
    pushl -2264(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_41
    pushl -176(%ebp)
    pushl $256
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_42
.Lcodegen_arm_41:
    pushl $0
.Lcodegen_arm_42:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_39
    pushl -2264(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -168(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    pushl $120
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_45
    pushl -152(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $11
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_47
    pushl -152(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_48
.Lcodegen_arm_47:
    pushl $1
.Lcodegen_arm_48:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_46
.Lcodegen_arm_45:
    pushl $0
.Lcodegen_arm_46:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_43
    pushl -152(%ebp)
    call _type_size
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_49
    leal -2224(%ebp), %eax
    pushl %eax
    pushl -176(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -1200(%ebp), %eax
    pushl %eax
    pushl -176(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -144(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $3
    popl %eax
    notl %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -176(%ebp)
    pushl -176(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_50
.Lcodegen_arm_49:
.Lcodegen_arm_50:
    jmp .Lcodegen_arm_44
.Lcodegen_arm_43:
.Lcodegen_arm_44:
.Lcodegen_arm_40:
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_38
.Lcodegen_arm_39:
    pushl $0
    popl %eax
    movl %eax, -2240(%ebp)
    pushl -2240(%ebp)
    addl $4, %esp
.Lcodegen_arm_51:
    pushl -2240(%ebp)
    pushl -2264(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_52
    pushl -2264(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -2240(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl $0
    popl %eax
    movl %eax, -144(%ebp)
    pushl $0
    popl %eax
    movl %eax, -136(%ebp)
    pushl -168(%ebp)
    pushl $120
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_58
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $11
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_60
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_61
.Lcodegen_arm_60:
    pushl $1
.Lcodegen_arm_61:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_59
.Lcodegen_arm_58:
    pushl $0
.Lcodegen_arm_59:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_56
    pushl -128(%ebp)
    call _type_size
    addl $4, %esp
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_57
.Lcodegen_arm_56:
    pushl $0
.Lcodegen_arm_57:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_54
    pushl $1
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_55
.Lcodegen_arm_54:
.Lcodegen_arm_55:
    pushl -168(%ebp)
    pushl $76
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_62
    leal ark_str_122, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_123, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_124, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $76
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_125, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_53
.Lcodegen_arm_62:
.Lcodegen_arm_63:
    movl $_g_config, %eax
    pushl %eax
    pushl $52
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_66
    pushl -168(%ebp)
    pushl $76
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_67
.Lcodegen_arm_66:
    pushl $0
.Lcodegen_arm_67:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_64
    leal ark_str_126, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_127, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_65
.Lcodegen_arm_64:
.Lcodegen_arm_65:
    leal ark_str_128, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_68
    leal ark_str_129, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_69
.Lcodegen_arm_68:
.Lcodegen_arm_69:
    pushl -168(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_70
    leal ark_str_130, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_71
.Lcodegen_arm_70:
.Lcodegen_arm_71:
    pushl -168(%ebp)
    pushl $84
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_72
    leal ark_str_131, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_73
.Lcodegen_arm_72:
.Lcodegen_arm_73:
    pushl -168(%ebp)
    pushl $88
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_74
    leal ark_str_132, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_75
.Lcodegen_arm_74:
.Lcodegen_arm_75:
    pushl -168(%ebp)
    pushl $92
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_76
    leal ark_str_133, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_77
.Lcodegen_arm_76:
.Lcodegen_arm_77:
    pushl -168(%ebp)
    pushl $96
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_78
    leal ark_str_134, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_79
.Lcodegen_arm_78:
.Lcodegen_arm_79:
    pushl -168(%ebp)
    pushl $100
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_80
    leal ark_str_135, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $100
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_136, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_81
.Lcodegen_arm_80:
.Lcodegen_arm_81:
    pushl -168(%ebp)
    pushl $104
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_82
    leal ark_str_137, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $104
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_138, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_83
.Lcodegen_arm_82:
.Lcodegen_arm_83:
    pushl -168(%ebp)
    pushl $56
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_84
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_139, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $80
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_86
    pushl -168(%ebp)
    pushl $80
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl $1
    popl %eax
    movl %eax, -120(%ebp)
.Lcodegen_arm_88:
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_89
    pushl -120(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_90
.Lcodegen_arm_92:
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_96
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_97
.Lcodegen_arm_96:
    pushl $1
.Lcodegen_arm_97:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_94
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_95
.Lcodegen_arm_94:
    pushl $1
.Lcodegen_arm_95:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_93
    pushl -128(%ebp)
    pushl -128(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_92
.Lcodegen_arm_93:
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_98
    jmp .Lcodegen_arm_89
.Lcodegen_arm_98:
.Lcodegen_arm_99:
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_100
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -128(%ebp)
    pushl -128(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_88
.Lcodegen_arm_100:
.Lcodegen_arm_101:
    leal ark_str_140, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_91
.Lcodegen_arm_90:
.Lcodegen_arm_91:
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_102
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    pushl -128(%ebp)
    pushl -128(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_88
.Lcodegen_arm_102:
.Lcodegen_arm_103:
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -128(%ebp)
    pushl -128(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_88
.Lcodegen_arm_89:
    pushl -120(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_104
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_105
.Lcodegen_arm_104:
.Lcodegen_arm_105:
    jmp .Lcodegen_arm_87
.Lcodegen_arm_86:
.Lcodegen_arm_87:
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_53
.Lcodegen_arm_84:
.Lcodegen_arm_85:
    pushl -2232(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_106
    leal ark_str_141, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_142, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_107
.Lcodegen_arm_106:
.Lcodegen_arm_107:
    pushl -2232(%ebp)
    pushl -168(%ebp)
    pushl $44
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -168(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -160(%ebp)
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_prologue
    addl $24, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_143, %eax
    pushl %eax
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_110
    movl _g_data_sram_start, %eax
    pushl %eax
    movl _g_data_sram_end, %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_112
    movl _g_bss_sram_start, %eax
    pushl %eax
    movl _g_bss_sram_end, %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_113
.Lcodegen_arm_112:
    pushl $1
.Lcodegen_arm_113:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_111
.Lcodegen_arm_110:
    pushl $0
.Lcodegen_arm_111:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_108
    leal ark_str_144, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_109
.Lcodegen_arm_108:
.Lcodegen_arm_109:
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_114
    leal ark_str_145, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_146, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_115
.Lcodegen_arm_114:
.Lcodegen_arm_115:
    pushl $0
    popl %eax
    movl %eax, -128(%ebp)
    pushl $0
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
.Lcodegen_arm_116:
    pushl -152(%ebp)
    pushl -168(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_117
    pushl -168(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -152(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -2232(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_123
    pushl -120(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_124
.Lcodegen_arm_123:
    pushl $0
.Lcodegen_arm_124:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_121
    pushl -120(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -128(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_122
.Lcodegen_arm_121:
    pushl $0
.Lcodegen_arm_122:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_119
    pushl -120(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    leal ark_str_147, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -128(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_120
.Lcodegen_arm_119:
.Lcodegen_arm_120:
    pushl -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_126
    pushl -112(%ebp)
    pushl $17
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_127
    pushl -112(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_128
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_129
    pushl -112(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_130
    pushl -112(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_131
    pushl -112(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_132
    pushl -112(%ebp)
    pushl $22
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_133
    pushl -112(%ebp)
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_134
    pushl -112(%ebp)
    pushl $23
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_135
    pushl -112(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_136
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_137
    pushl -112(%ebp)
    pushl $56
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_138
    pushl -112(%ebp)
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_139
    pushl -112(%ebp)
    pushl $58
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_140
    pushl -112(%ebp)
    pushl $59
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_141
    pushl -112(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_142
    pushl -112(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_143
    pushl -112(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_144
    pushl -112(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_145
    pushl -112(%ebp)
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_146
    pushl -112(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_147
    pushl -112(%ebp)
    pushl $25
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_148
    pushl -112(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_149
    pushl -112(%ebp)
    pushl $26
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_150
    pushl -112(%ebp)
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_151
    pushl -112(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_152
    pushl -112(%ebp)
    pushl $27
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_153
    pushl -112(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_154
    pushl -112(%ebp)
    pushl $29
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_155
    pushl -112(%ebp)
    pushl $30
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_156
    pushl -112(%ebp)
    pushl $31
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_157
    pushl -112(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_158
    pushl -112(%ebp)
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_159
    pushl -112(%ebp)
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_160
    pushl -112(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_161
    pushl -112(%ebp)
    pushl $33
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_162
    pushl -112(%ebp)
    pushl $37
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_163
    pushl -112(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_164
    pushl -112(%ebp)
    pushl $38
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_165
    pushl -112(%ebp)
    pushl $51
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_166
    pushl -112(%ebp)
    pushl $39
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_167
    pushl -112(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_168
    pushl -112(%ebp)
    pushl $42
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_169
    pushl -112(%ebp)
    pushl $41
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_170
    pushl -112(%ebp)
    pushl $43
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_171
    pushl -112(%ebp)
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_172
    pushl -112(%ebp)
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_173
    pushl -112(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_174
    pushl -112(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_175
    pushl -112(%ebp)
    pushl $50
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_176
    pushl -112(%ebp)
    pushl $52
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_177
    pushl -112(%ebp)
    pushl $53
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_178
    pushl -112(%ebp)
    pushl $54
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_179
    pushl -112(%ebp)
    pushl $55
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_180
    jmp .Lcodegen_arm_181
.Lcodegen_arm_126:
.Lcodegen_arm_127:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_128:
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $16777215
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_182
    pushl -104(%ebp)
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_183
.Lcodegen_arm_182:
.Lcodegen_arm_183:
    pushl -96(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_184
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -88(%ebp)
    pushl -104(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_186
    leal ark_str_148, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_149, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_187
.Lcodegen_arm_186:
    pushl -160(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -104(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    leal ark_str_150, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_151, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_187:
    pushl -96(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_188
    pushl $0
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
.Lcodegen_arm_190:
    pushl -80(%ebp)
    pushl -96(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_191
    leal ark_str_152, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_153, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_154, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    pushl -80(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_155, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_192:
    pushl -80(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_190
.Lcodegen_arm_191:
    jmp .Lcodegen_arm_189
.Lcodegen_arm_188:
    pushl $0
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_156, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_157, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    pushl $2
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_158, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_189:
    jmp .Lcodegen_arm_185
.Lcodegen_arm_184:
    pushl -104(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_193
    leal ark_str_159, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_160, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_161, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_194
.Lcodegen_arm_193:
    pushl -160(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -104(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    leal ark_str_162, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_163, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_164, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_165, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_194:
.Lcodegen_arm_185:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_129:
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_130:
    leal ark_str_166, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_131:
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $256
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_195
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_197
    leal ark_str_167, %eax
    pushl %eax
    jmp .Lcodegen_arm_198
.Lcodegen_arm_197:
    leal ark_str_168, %eax
    pushl %eax
.Lcodegen_arm_198:
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_169, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_196
.Lcodegen_arm_195:
    pushl -104(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_199
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_201
    leal ark_str_170, %eax
    pushl %eax
    jmp .Lcodegen_arm_202
.Lcodegen_arm_201:
    leal ark_str_171, %eax
    pushl %eax
.Lcodegen_arm_202:
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_172, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_200
.Lcodegen_arm_199:
    pushl -104(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_203
    leal ark_str_173, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_174, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl $4
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %eax, 4(%esp)
    adcl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_175, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_176, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_204
.Lcodegen_arm_203:
    leal ark_str_177, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_178, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_204:
.Lcodegen_arm_200:
.Lcodegen_arm_196:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_132:
    leal ark_str_179, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_133:
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _gvar_find
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _gvar_find_size
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_205
    pushl -104(%ebp)
    pushl $1
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_180, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_181, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_182, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_206
.Lcodegen_arm_205:
    pushl -104(%ebp)
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_183, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_206:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_134:
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _gvar_find
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_135:
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _gvar_find
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _gvar_find_size
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_207
    leal ark_str_184, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    pushl $2
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_185, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_186, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_208
.Lcodegen_arm_207:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    pushl $1
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_187, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_208:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_136:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_137:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_138:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_188, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_189, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_139:
.Lcodegen_arm_140:
.Lcodegen_arm_141:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_142:
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $65536
    popl %eax
    notl %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_209
    pushl $4
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_210
.Lcodegen_arm_209:
.Lcodegen_arm_210:
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_211
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_190, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_191, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_212
.Lcodegen_arm_211:
    pushl -104(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_213
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_192, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_193, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_214
.Lcodegen_arm_213:
    pushl -104(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_215
    leal ark_str_194, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_195, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_196, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_197, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl $4
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %eax, 4(%esp)
    adcl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_198, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_217
    leal ark_str_199, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_200, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl $8
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %eax, 4(%esp)
    adcl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_201, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_202, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl $12
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %eax, 4(%esp)
    adcl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_203, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_218
.Lcodegen_arm_217:
.Lcodegen_arm_218:
    jmp .Lcodegen_arm_216
.Lcodegen_arm_215:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_204, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_205, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_216:
.Lcodegen_arm_214:
.Lcodegen_arm_212:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_143:
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -104(%ebp)
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1024
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_219
    pushl $1
    jmp .Lcodegen_arm_220
.Lcodegen_arm_219:
    pushl $0
.Lcodegen_arm_220:
    popl %eax
    movl %eax, -96(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_221
    pushl -104(%ebp)
    pushl $2
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_206, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_222
.Lcodegen_arm_221:
.Lcodegen_arm_222:
    leal ark_str_207, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_223
    leal ark_str_208, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_224
.Lcodegen_arm_223:
    pushl -104(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_227
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_228
.Lcodegen_arm_227:
    pushl $0
.Lcodegen_arm_228:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_225
    leal ark_str_209, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_226
.Lcodegen_arm_225:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_229
    pushl -104(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_231
    leal ark_str_210, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_211, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_212, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_213, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_232
.Lcodegen_arm_231:
    leal ark_str_214, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_215, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_216, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_217, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_218, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_219, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_220, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_221, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_222, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_223, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_232:
    jmp .Lcodegen_arm_230
.Lcodegen_arm_229:
    pushl -104(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_233
    leal ark_str_224, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_225, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_226, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_227, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_233:
    leal ark_str_228, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_234:
.Lcodegen_arm_230:
.Lcodegen_arm_226:
.Lcodegen_arm_224:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_144:
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -104(%ebp)
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1024
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_235
    pushl $1
    jmp .Lcodegen_arm_236
.Lcodegen_arm_235:
    pushl $0
.Lcodegen_arm_236:
    popl %eax
    movl %eax, -96(%ebp)
    pushl -104(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_237
    leal ark_str_229, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_230, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_231, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_232, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_233, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_234, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_237:
.Lcodegen_arm_238:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_239
    leal ark_str_235, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_240
.Lcodegen_arm_239:
    pushl -104(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_243
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_244
.Lcodegen_arm_243:
    pushl $0
.Lcodegen_arm_244:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_241
    leal ark_str_236, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_242
.Lcodegen_arm_241:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_245
    pushl -104(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_247
    leal ark_str_237, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_238, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_239, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_248
.Lcodegen_arm_247:
    leal ark_str_240, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_241, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_242, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_243, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_244, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_245, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_246, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_248:
    jmp .Lcodegen_arm_246
.Lcodegen_arm_245:
    leal ark_str_247, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_246:
.Lcodegen_arm_242:
.Lcodegen_arm_240:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_145:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_binary
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_146:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_unary
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_147:
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_label
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_148:
    leal ark_str_248, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_249, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_149:
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal ark_str_250, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_b_label
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_150:
    leal ark_str_251, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_151:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_252, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal ark_str_253, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_b_label
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_152:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_254, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal ark_str_255, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_b_label
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_153:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl $1
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_256, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal ark_str_257, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_b_label
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_154:
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $512
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_249
    leal ark_str_258, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_259, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_260, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_261, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_262, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_250
.Lcodegen_arm_249:
    leal ark_str_263, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_264, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_250:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_155:
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $512
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    movl $_g_config, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_251
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_253
    leal ark_str_265, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_vfp_f64_binop
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_254
.Lcodegen_arm_253:
    leal ark_str_266, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_vfp_f32_binop
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_254:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_251:
.Lcodegen_arm_252:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_255
    leal ark_str_267, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_268, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_269, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_270, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_271, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_272, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_256
.Lcodegen_arm_255:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_273, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_256:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_156:
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $512
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    movl $_g_config, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_257
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_259
    leal ark_str_274, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_vfp_f64_binop
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_260
.Lcodegen_arm_259:
    leal ark_str_275, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_vfp_f32_binop
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_260:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_257:
.Lcodegen_arm_258:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_261
    leal ark_str_276, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_277, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_278, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_279, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_280, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_281, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_262
.Lcodegen_arm_261:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_282, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_262:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_157:
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $512
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    movl $_g_config, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_263
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_265
    leal ark_str_283, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_vfp_f64_binop
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_266
.Lcodegen_arm_265:
    leal ark_str_284, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_vfp_f32_binop
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_266:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_263:
.Lcodegen_arm_264:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_267
    leal ark_str_285, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_286, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_287, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_288, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_289, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_290, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_268
.Lcodegen_arm_267:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_291, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_268:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_158:
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $512
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    movl $_g_config, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_269
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_271
    leal ark_str_292, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_vfp_f64_binop
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_272
.Lcodegen_arm_271:
    leal ark_str_293, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_vfp_f32_binop
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_272:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_269:
.Lcodegen_arm_270:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_273
    leal ark_str_294, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_295, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_296, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_297, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_298, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_299, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_274
.Lcodegen_arm_273:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_300, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_274:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_159:
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $512
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1024
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    movl $_g_config, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_275
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_277
    leal ark_str_301, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_302, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_303, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_304, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_279
    leal ark_str_305, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_280
.Lcodegen_arm_279:
    leal ark_str_306, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_280:
    leal ark_str_307, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_278
.Lcodegen_arm_277:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_308, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_281
    leal ark_str_309, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_282
.Lcodegen_arm_281:
    leal ark_str_310, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_282:
    leal ark_str_311, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_278:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_275:
.Lcodegen_arm_276:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_283
    leal ark_str_312, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_313, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_285
    leal ark_str_314, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_286
.Lcodegen_arm_285:
    leal ark_str_315, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_286:
    jmp .Lcodegen_arm_284
.Lcodegen_arm_283:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_287
    leal ark_str_316, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_288
.Lcodegen_arm_287:
    leal ark_str_317, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_288:
.Lcodegen_arm_284:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_160:
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $512
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1024
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    movl $_g_config, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_289
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_318, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_291
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_293
    leal ark_str_319, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_294
.Lcodegen_arm_293:
    leal ark_str_320, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_294:
    leal ark_str_321, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_322, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_323, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_292
.Lcodegen_arm_291:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_295
    leal ark_str_324, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_296
.Lcodegen_arm_295:
    leal ark_str_325, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_296:
    leal ark_str_326, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_292:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_289:
.Lcodegen_arm_290:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_297
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_299
    leal ark_str_327, %eax
    pushl %eax
    jmp .Lcodegen_arm_300
.Lcodegen_arm_299:
    leal ark_str_328, %eax
    pushl %eax
.Lcodegen_arm_300:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_329, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_298
.Lcodegen_arm_297:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_301
    leal ark_str_330, %eax
    pushl %eax
    jmp .Lcodegen_arm_302
.Lcodegen_arm_301:
    leal ark_str_331, %eax
    pushl %eax
.Lcodegen_arm_302:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_298:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_161:
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $512
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $256
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    movl $_g_config, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_303
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_307
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_308
.Lcodegen_arm_307:
    pushl $0
.Lcodegen_arm_308:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_305
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_332, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_333, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_334, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_335, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_306
.Lcodegen_arm_305:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_311
    pushl -96(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_312
.Lcodegen_arm_311:
    pushl $0
.Lcodegen_arm_312:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_309
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_336, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_337, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_338, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_339, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_340, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_310
.Lcodegen_arm_309:
.Lcodegen_arm_310:
.Lcodegen_arm_306:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_303:
.Lcodegen_arm_304:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_315
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_316
.Lcodegen_arm_315:
    pushl $0
.Lcodegen_arm_316:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_313
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_341, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_314
.Lcodegen_arm_313:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_319
    pushl -96(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_320
.Lcodegen_arm_319:
    pushl $0
.Lcodegen_arm_320:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_317
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_342, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_343, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_318
.Lcodegen_arm_317:
.Lcodegen_arm_318:
.Lcodegen_arm_314:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_162:
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $512
    popl %eax
    notl %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $512
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    movl $_g_config, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_321
    leal ark_str_344, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_323
    leal ark_str_345, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_346, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_347, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_348, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_349, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_350, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_351, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_352, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_353, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_324
.Lcodegen_arm_323:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_354, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_355, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_356, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_324:
    leal ark_str_357, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_326
    pushl -80(%ebp)
    pushl $22
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_327
    pushl -80(%ebp)
    pushl $23
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_328
    pushl -80(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_329
    pushl -80(%ebp)
    pushl $25
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_330
    pushl -80(%ebp)
    pushl $26
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_331
    jmp .Lcodegen_arm_332
.Lcodegen_arm_326:
    leal ark_str_358, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_325
.Lcodegen_arm_327:
    leal ark_str_359, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_325
.Lcodegen_arm_328:
    leal ark_str_360, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_325
.Lcodegen_arm_329:
    leal ark_str_361, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_325
.Lcodegen_arm_330:
    leal ark_str_362, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_325
.Lcodegen_arm_331:
    leal ark_str_363, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_325
.Lcodegen_arm_332:
    leal ark_str_364, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_325
.Lcodegen_arm_325:
    leal ark_str_365, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_366, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_367, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_321:
.Lcodegen_arm_322:
    leal ark_str_368, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -104(%ebp)
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_334
    pushl -80(%ebp)
    pushl $22
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_335
    pushl -80(%ebp)
    pushl $23
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_336
    pushl -80(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_337
    pushl -80(%ebp)
    pushl $25
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_338
    pushl -80(%ebp)
    pushl $26
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_339
    jmp .Lcodegen_arm_340
.Lcodegen_arm_334:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_341
    leal ark_str_369, %eax
    pushl %eax
    jmp .Lcodegen_arm_342
.Lcodegen_arm_341:
    leal ark_str_370, %eax
    pushl %eax
.Lcodegen_arm_342:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_333
.Lcodegen_arm_335:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_343
    leal ark_str_371, %eax
    pushl %eax
    jmp .Lcodegen_arm_344
.Lcodegen_arm_343:
    leal ark_str_372, %eax
    pushl %eax
.Lcodegen_arm_344:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_333
.Lcodegen_arm_336:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_345
    leal ark_str_373, %eax
    pushl %eax
    jmp .Lcodegen_arm_346
.Lcodegen_arm_345:
    leal ark_str_374, %eax
    pushl %eax
.Lcodegen_arm_346:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_333
.Lcodegen_arm_337:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_347
    leal ark_str_375, %eax
    pushl %eax
    jmp .Lcodegen_arm_348
.Lcodegen_arm_347:
    leal ark_str_376, %eax
    pushl %eax
.Lcodegen_arm_348:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_333
.Lcodegen_arm_338:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_349
    leal ark_str_377, %eax
    pushl %eax
    jmp .Lcodegen_arm_350
.Lcodegen_arm_349:
    leal ark_str_378, %eax
    pushl %eax
.Lcodegen_arm_350:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_333
.Lcodegen_arm_339:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_351
    leal ark_str_379, %eax
    pushl %eax
    jmp .Lcodegen_arm_352
.Lcodegen_arm_351:
    leal ark_str_380, %eax
    pushl %eax
.Lcodegen_arm_352:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_333
.Lcodegen_arm_340:
    jmp .Lcodegen_arm_333
.Lcodegen_arm_333:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_353
    leal ark_str_381, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_382, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_383, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_384, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_354
.Lcodegen_arm_353:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_354:
    leal ark_str_385, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    pushl $22
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_355
    leal ark_str_386, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_356
.Lcodegen_arm_355:
.Lcodegen_arm_356:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_163:
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_359
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $64
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_360
.Lcodegen_arm_359:
    pushl $0
.Lcodegen_arm_360:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_357
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
.Lcodegen_arm_361:
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_363
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_364
.Lcodegen_arm_363:
    pushl $1
.Lcodegen_arm_364:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_362
    pushl -104(%ebp)
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_361
.Lcodegen_arm_362:
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_365
    pushl -104(%ebp)
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    addl $4, %esp
    leal ark_str_387, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_367:
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_369
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_370
.Lcodegen_arm_369:
    pushl $0
.Lcodegen_arm_370:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_368
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_373
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_374
.Lcodegen_arm_373:
    pushl $0
.Lcodegen_arm_374:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_371
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $110
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_375
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_388, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_376
.Lcodegen_arm_375:
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $116
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_377
    pushl $9
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_378
.Lcodegen_arm_377:
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_379
    pushl $92
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_380
.Lcodegen_arm_379:
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_381
    pushl $34
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_382
.Lcodegen_arm_381:
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_382:
.Lcodegen_arm_380:
.Lcodegen_arm_378:
.Lcodegen_arm_376:
    pushl -104(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_372
.Lcodegen_arm_371:
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $37
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_387
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_388
.Lcodegen_arm_387:
    pushl $0
.Lcodegen_arm_388:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_385
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $51
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_386
.Lcodegen_arm_385:
    pushl $0
.Lcodegen_arm_386:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_383
    pushl $114
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_384
.Lcodegen_arm_383:
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    addl $4, %esp
.Lcodegen_arm_384:
.Lcodegen_arm_372:
    jmp .Lcodegen_arm_367
.Lcodegen_arm_368:
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_366
.Lcodegen_arm_365:
.Lcodegen_arm_366:
    jmp .Lcodegen_arm_358
.Lcodegen_arm_357:
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_389
    leal ark_str_389, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_390
.Lcodegen_arm_389:
.Lcodegen_arm_390:
.Lcodegen_arm_358:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_164:
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -104(%ebp)
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_391
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $63
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_392
.Lcodegen_arm_391:
    pushl $0
.Lcodegen_arm_392:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_393
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lcodegen_arm_394
.Lcodegen_arm_393:
    pushl -104(%ebp)
.Lcodegen_arm_394:
    popl %eax
    movl %eax, -80(%ebp)
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_395
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -176(%ebp)
    leal -1200(%ebp), %eax
    pushl %eax
    leal -2224(%ebp), %eax
    pushl %eax
    call _sret_lookup
    addl $16, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_396
.Lcodegen_arm_395:
    pushl $0
.Lcodegen_arm_396:
    popl %eax
    movl %eax, -72(%ebp)
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_399
    leal ark_str_390, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_419
    leal ark_str_391, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_420
.Lcodegen_arm_419:
    pushl $1
.Lcodegen_arm_420:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_417
    leal ark_str_392, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_418
.Lcodegen_arm_417:
    pushl $1
.Lcodegen_arm_418:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_415
    leal ark_str_393, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_416
.Lcodegen_arm_415:
    pushl $1
.Lcodegen_arm_416:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_413
    leal ark_str_394, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_414
.Lcodegen_arm_413:
    pushl $1
.Lcodegen_arm_414:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_411
    leal ark_str_395, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_412
.Lcodegen_arm_411:
    pushl $1
.Lcodegen_arm_412:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_409
    leal ark_str_396, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_410
.Lcodegen_arm_409:
    pushl $1
.Lcodegen_arm_410:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_407
    leal ark_str_397, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_408
.Lcodegen_arm_407:
    pushl $1
.Lcodegen_arm_408:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_405
    leal ark_str_398, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_406
.Lcodegen_arm_405:
    pushl $1
.Lcodegen_arm_406:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_403
    leal ark_str_399, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_404
.Lcodegen_arm_403:
    pushl $1
.Lcodegen_arm_404:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_401
    leal ark_str_400, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_402
.Lcodegen_arm_401:
    pushl $1
.Lcodegen_arm_402:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_400
.Lcodegen_arm_399:
    pushl $0
.Lcodegen_arm_400:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_397
    pushl -80(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_421
    pushl $4
    jmp .Lcodegen_arm_422
.Lcodegen_arm_421:
    pushl -80(%ebp)
.Lcodegen_arm_422:
    popl %eax
    movl %eax, -64(%ebp)
    pushl -80(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_423
    pushl -80(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lcodegen_arm_424
.Lcodegen_arm_423:
    pushl $0
.Lcodegen_arm_424:
    popl %eax
    movl %eax, -56(%ebp)
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
.Lcodegen_arm_425:
    pushl -96(%ebp)
    pushl -64(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_426
    leal ark_str_401, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_402, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_427:
    pushl -96(%ebp)
    pushl -96(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_425
.Lcodegen_arm_426:
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_428
    leal ark_str_403, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_429
.Lcodegen_arm_428:
.Lcodegen_arm_429:
    leal ark_str_404, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_430
    leal ark_str_405, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_431
.Lcodegen_arm_430:
    leal ark_str_406, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_432
    leal ark_str_407, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_433
.Lcodegen_arm_432:
    leal ark_str_408, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_434
    leal ark_str_409, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_435
.Lcodegen_arm_434:
    leal ark_str_410, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_436
    leal ark_str_411, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_437
.Lcodegen_arm_436:
    leal ark_str_412, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_438
    jmp .Lcodegen_arm_439
.Lcodegen_arm_438:
    leal ark_str_413, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_440
    leal ark_str_414, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_441
.Lcodegen_arm_440:
    leal ark_str_415, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_442
    leal ark_str_416, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_443
.Lcodegen_arm_442:
    leal ark_str_417, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_444
    leal ark_str_418, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_445
.Lcodegen_arm_444:
    leal ark_str_419, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_446
    leal ark_str_420, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_447
.Lcodegen_arm_446:
    leal ark_str_421, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_448
    leal ark_str_422, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_449
.Lcodegen_arm_448:
    leal ark_str_423, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_450
    leal ark_str_424, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_451
.Lcodegen_arm_450:
.Lcodegen_arm_451:
.Lcodegen_arm_449:
.Lcodegen_arm_447:
.Lcodegen_arm_445:
.Lcodegen_arm_443:
.Lcodegen_arm_441:
.Lcodegen_arm_439:
.Lcodegen_arm_437:
.Lcodegen_arm_435:
.Lcodegen_arm_433:
.Lcodegen_arm_431:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_397:
.Lcodegen_arm_398:
    pushl -72(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_452
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -176(%ebp)
    leal -1200(%ebp), %eax
    pushl %eax
    leal -2224(%ebp), %eax
    pushl %eax
    call _sret_get_size
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -80(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_454
    pushl $3
    jmp .Lcodegen_arm_455
.Lcodegen_arm_454:
    pushl -80(%ebp)
.Lcodegen_arm_455:
    popl %eax
    movl %eax, -56(%ebp)
    pushl -80(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_456
    pushl -80(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lcodegen_arm_457
.Lcodegen_arm_456:
    pushl $0
.Lcodegen_arm_457:
    popl %eax
    movl %eax, -48(%ebp)
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
.Lcodegen_arm_458:
    pushl -96(%ebp)
    pushl -56(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_459
    leal ark_str_425, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_426, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_460:
    pushl -96(%ebp)
    pushl -96(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_458
.Lcodegen_arm_459:
    leal ark_str_427, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_428, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_429, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_430, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    pushl -48(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_452:
.Lcodegen_arm_453:
    pushl -80(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_461
    pushl $4
    jmp .Lcodegen_arm_462
.Lcodegen_arm_461:
    pushl -80(%ebp)
.Lcodegen_arm_462:
    popl %eax
    movl %eax, -64(%ebp)
    pushl -80(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_463
    pushl -80(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lcodegen_arm_464
.Lcodegen_arm_463:
    pushl $0
.Lcodegen_arm_464:
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_465
    leal ark_str_431, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_432, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_466
.Lcodegen_arm_465:
.Lcodegen_arm_466:
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
.Lcodegen_arm_467:
    pushl -96(%ebp)
    pushl -64(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_468
    leal ark_str_433, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_434, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_469:
    pushl -96(%ebp)
    pushl -96(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_467
.Lcodegen_arm_468:
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_470
    leal ark_str_435, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_471
.Lcodegen_arm_470:
.Lcodegen_arm_471:
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_472
    leal ark_str_436, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_473
.Lcodegen_arm_472:
    leal ark_str_437, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_473:
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_474
    leal ark_str_438, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_475
.Lcodegen_arm_474:
.Lcodegen_arm_475:
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_476
    leal ark_str_439, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_477
.Lcodegen_arm_476:
.Lcodegen_arm_477:
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_478
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
.Lcodegen_arm_480:
    pushl -32(%ebp)
    pushl -2264(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_481
    pushl -120(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -2264(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -32(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_483
    pushl -2264(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -32(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $120
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_487
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $5
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_489
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_490
.Lcodegen_arm_489:
    pushl $1
.Lcodegen_arm_490:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_488
.Lcodegen_arm_487:
    pushl $0
.Lcodegen_arm_488:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_485
    pushl $1
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_486
.Lcodegen_arm_485:
.Lcodegen_arm_486:
    jmp .Lcodegen_arm_481
.Lcodegen_arm_483:
.Lcodegen_arm_484:
.Lcodegen_arm_482:
    pushl -32(%ebp)
    pushl -32(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_480
.Lcodegen_arm_481:
    jmp .Lcodegen_arm_479
.Lcodegen_arm_478:
.Lcodegen_arm_479:
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_491
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_440, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_492
.Lcodegen_arm_491:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_492:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_165:
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -104(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_441, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_166:
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -104(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_442, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_167:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_493
    leal ark_str_443, %eax
    pushl %eax
    jmp .Lcodegen_arm_494
.Lcodegen_arm_493:
    leal ark_str_444, %eax
    pushl %eax
.Lcodegen_arm_494:
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_168:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_495
    leal ark_str_445, %eax
    pushl %eax
    jmp .Lcodegen_arm_496
.Lcodegen_arm_495:
    leal ark_str_446, %eax
    pushl %eax
.Lcodegen_arm_496:
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_447, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_448, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_169:
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_170:
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $256
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $256
    popl %eax
    notl %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
    pushl $0
    popl %eax
    movl %eax, -80(%ebp)
    pushl $0
    popl %eax
    movl %eax, -72(%ebp)
    pushl -96(%ebp)
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_498
    pushl -64(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_499
    pushl -64(%ebp)
    pushl $17
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_500
    pushl -64(%ebp)
    pushl $18
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_501
    pushl -64(%ebp)
    pushl $19
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_502
    jmp .Lcodegen_arm_503
.Lcodegen_arm_498:
    leal ark_str_449, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_497
.Lcodegen_arm_499:
    leal ark_str_450, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_497
.Lcodegen_arm_500:
    leal ark_str_451, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_497
.Lcodegen_arm_501:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_504
    leal ark_str_452, %eax
    pushl %eax
    jmp .Lcodegen_arm_505
.Lcodegen_arm_504:
    leal ark_str_453, %eax
    pushl %eax
.Lcodegen_arm_505:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_497
.Lcodegen_arm_502:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_506
    leal ark_str_454, %eax
    pushl %eax
    jmp .Lcodegen_arm_507
.Lcodegen_arm_506:
    leal ark_str_455, %eax
    pushl %eax
.Lcodegen_arm_507:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_497
.Lcodegen_arm_503:
    jmp .Lcodegen_arm_497
.Lcodegen_arm_497:
    leal ark_str_456, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_457, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_458, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_459, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_508
    leal ark_str_460, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_509
.Lcodegen_arm_508:
.Lcodegen_arm_509:
    pushl -72(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_510
    leal ark_str_461, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_462, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_511
.Lcodegen_arm_510:
.Lcodegen_arm_511:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_463, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_171:
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $256
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $256
    popl %eax
    notl %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_512
    leal ark_str_464, %eax
    pushl %eax
    jmp .Lcodegen_arm_513
.Lcodegen_arm_512:
    leal ark_str_465, %eax
    pushl %eax
.Lcodegen_arm_513:
    popl %eax
    movl %eax, -88(%ebp)
    leal ark_str_466, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_467, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_468, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_469, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_470, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_471, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_515
    pushl -80(%ebp)
    pushl $22
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_516
    pushl -80(%ebp)
    pushl $23
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_517
    pushl -80(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_518
    pushl -80(%ebp)
    pushl $25
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_519
    pushl -80(%ebp)
    pushl $26
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_520
    jmp .Lcodegen_arm_521
.Lcodegen_arm_515:
    leal ark_str_472, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_473, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_474, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_514
.Lcodegen_arm_516:
    leal ark_str_475, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_476, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_477, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_514
.Lcodegen_arm_517:
    leal ark_str_478, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_479, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_480, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_514
.Lcodegen_arm_518:
    leal ark_str_481, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_482, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_483, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_514
.Lcodegen_arm_519:
    leal ark_str_484, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_485, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_486, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_514
.Lcodegen_arm_520:
    leal ark_str_487, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_488, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_489, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_514
.Lcodegen_arm_521:
    jmp .Lcodegen_arm_514
.Lcodegen_arm_514:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_172:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl $2
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_490, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_173:
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -104(%ebp)
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_522
    pushl $-1
    jmp .Lcodegen_arm_523
.Lcodegen_arm_522:
    pushl $1
    pushl -96(%ebp)
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
.Lcodegen_arm_523:
    popl %eax
    movl %eax, -88(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    pushl $2
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_491, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_524
    leal ark_str_492, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_493, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_525
.Lcodegen_arm_524:
.Lcodegen_arm_525:
    leal ark_str_494, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_495, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_496, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_497, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_174:
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -104(%ebp)
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -120(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $256
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -96(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_526
    pushl $-1
    jmp .Lcodegen_arm_527
.Lcodegen_arm_526:
    pushl $1
    pushl -96(%ebp)
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
.Lcodegen_arm_527:
    popl %eax
    movl %eax, -80(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_498, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_528
    leal ark_str_499, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_529
.Lcodegen_arm_528:
.Lcodegen_arm_529:
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_532
    pushl -96(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_533
.Lcodegen_arm_532:
    pushl $0
.Lcodegen_arm_533:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_530
    pushl $32
    pushl -96(%ebp)
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    leal ark_str_500, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -72(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_501, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -72(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_531
.Lcodegen_arm_530:
    pushl -80(%ebp)
    pushl $2
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_502, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_531:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_175:
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_534
    pushl -168(%ebp)
    pushl $120
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _type_size
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_503, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_504, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
.Lcodegen_arm_536:
    pushl -88(%ebp)
    pushl -96(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_537
    leal ark_str_505, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_506, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_507, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_508, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_538:
    pushl -88(%ebp)
    pushl -88(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_536
.Lcodegen_arm_537:
    leal ark_str_509, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_539
    leal ark_str_510, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -160(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_540
.Lcodegen_arm_539:
.Lcodegen_arm_540:
    pushl -168(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_541
    leal ark_str_511, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_542
.Lcodegen_arm_541:
    leal ark_str_512, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_542:
    jmp .Lcodegen_arm_535
.Lcodegen_arm_534:
    pushl -168(%ebp)
    pushl $44
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -168(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -160(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_epilogue_return
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_535:
    jmp .Lcodegen_arm_125
.Lcodegen_arm_176:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_513, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_514, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_515, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_516, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_177:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_517, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_178:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_518, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_179:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_519, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_180:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r1
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_520, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_181:
    leal ark_str_521, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_125
.Lcodegen_arm_125:
.Lcodegen_arm_118:
    pushl -152(%ebp)
    pushl -152(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_116
.Lcodegen_arm_117:
    pushl -2232(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_543
    leal ark_str_522, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_523, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_524, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_544
.Lcodegen_arm_543:
.Lcodegen_arm_544:
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_547
    pushl -168(%ebp)
    pushl $76
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_548
.Lcodegen_arm_547:
    pushl $0
.Lcodegen_arm_548:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_545
    leal ark_str_525, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_526, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_527, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_528, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_546
.Lcodegen_arm_545:
.Lcodegen_arm_546:
    pushl -168(%ebp)
    pushl $68
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_551
    pushl -168(%ebp)
    pushl $76
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_552
.Lcodegen_arm_551:
    pushl $0
.Lcodegen_arm_552:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_549
    leal ark_str_529, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_530, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_531, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_532, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_550
.Lcodegen_arm_549:
.Lcodegen_arm_550:
.Lcodegen_arm_53:
    pushl -2240(%ebp)
    pushl -2240(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -2240(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_51
.Lcodegen_arm_52:
    movl _g_data_sram_start, %eax
    pushl %eax
    movl _g_data_sram_end, %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_555
    movl _g_bss_sram_start, %eax
    pushl %eax
    movl _g_bss_sram_end, %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_556
.Lcodegen_arm_555:
    pushl $1
.Lcodegen_arm_556:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_553
    leal ark_str_533, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_534, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_535, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_536, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
.Lcodegen_arm_557:
    pushl -168(%ebp)
    pushl -2264(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_558
    pushl -2264(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -168(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_562
    pushl -160(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_563
.Lcodegen_arm_562:
    pushl $1
.Lcodegen_arm_563:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_560
    jmp .Lcodegen_arm_559
.Lcodegen_arm_560:
.Lcodegen_arm_561:
    pushl -160(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_564
    jmp .Lcodegen_arm_559
.Lcodegen_arm_564:
.Lcodegen_arm_565:
    pushl -160(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_572
    pushl -160(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_573
.Lcodegen_arm_572:
    pushl $0
.Lcodegen_arm_573:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_570
    pushl -160(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_571
.Lcodegen_arm_570:
    pushl $0
.Lcodegen_arm_571:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_568
    pushl -160(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jne .L64f_codegen_arm_6505
    cmpl %eax, (%esp)
    jne .L64f_codegen_arm_6505
    addl $4, %esp
    pushl $1
    jmp .L64e_codegen_arm_6505
.L64f_codegen_arm_6505:
    addl $4, %esp
    pushl $0
.L64e_codegen_arm_6505:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_569
.Lcodegen_arm_568:
    pushl $0
.Lcodegen_arm_569:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_566
    jmp .Lcodegen_arm_559
.Lcodegen_arm_566:
.Lcodegen_arm_567:
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _gvar_find
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    pushl -152(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_574
    jmp .Lcodegen_arm_559
.Lcodegen_arm_574:
.Lcodegen_arm_575:
    pushl -160(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_576
    pushl -160(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _type_size
    addl $4, %esp
    pushl %eax
    jmp .Lcodegen_arm_577
.Lcodegen_arm_576:
    pushl $4
.Lcodegen_arm_577:
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    pushl -144(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_578
    pushl $4
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_579
.Lcodegen_arm_578:
.Lcodegen_arm_579:
    pushl -160(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_580
    pushl -160(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_582
    pushl -160(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_583
.Lcodegen_arm_582:
    pushl $0
.Lcodegen_arm_583:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_584
    leal -96(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -160(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl $1
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_537, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_538, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_585
.Lcodegen_arm_584:
    leal -104(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -160(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    fldl (%esp)
    addl $8, %esp
    subl $4, %esp
    fstps (%esp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -104(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl $1
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_539, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_585:
    jmp .Lcodegen_arm_581
.Lcodegen_arm_580:
    pushl -160(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_586
    pushl -160(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_592
    pushl -160(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_593
.Lcodegen_arm_592:
    pushl $0
.Lcodegen_arm_593:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_590
    pushl -160(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_591
.Lcodegen_arm_590:
    pushl $0
.Lcodegen_arm_591:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_588
    pushl -160(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _type_size
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    pushl -136(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_594
    pushl $4
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_595
.Lcodegen_arm_594:
.Lcodegen_arm_595:
    pushl -160(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_589
.Lcodegen_arm_588:
    pushl $4
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    pushl -144(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
.Lcodegen_arm_589:
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_596
    pushl -144(%ebp)
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_597
.Lcodegen_arm_596:
.Lcodegen_arm_597:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $123
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_598
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_599
.Lcodegen_arm_598:
.Lcodegen_arm_599:
    pushl $0
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
.Lcodegen_arm_600:
    pushl -120(%ebp)
    pushl -128(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_601
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
.Lcodegen_arm_603:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_609
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_610
.Lcodegen_arm_609:
    pushl $1
.Lcodegen_arm_610:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_607
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_608
.Lcodegen_arm_607:
    pushl $1
.Lcodegen_arm_608:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_605
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $123
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_606
.Lcodegen_arm_605:
    pushl $1
.Lcodegen_arm_606:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_604
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_603
.Lcodegen_arm_604:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_611
.Lcodegen_arm_613:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_615
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $61
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_616
.Lcodegen_arm_615:
    pushl $0
.Lcodegen_arm_616:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_614
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_613
.Lcodegen_arm_614:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $61
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_617
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_618
.Lcodegen_arm_617:
.Lcodegen_arm_618:
.Lcodegen_arm_619:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_621
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_622
.Lcodegen_arm_621:
    pushl $1
.Lcodegen_arm_622:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_620
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_619
.Lcodegen_arm_620:
    jmp .Lcodegen_arm_612
.Lcodegen_arm_611:
.Lcodegen_arm_612:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $91
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_623
.Lcodegen_arm_625:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_627
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $93
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_628
.Lcodegen_arm_627:
    pushl $0
.Lcodegen_arm_628:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_626
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_625
.Lcodegen_arm_626:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $93
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_629
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_630
.Lcodegen_arm_629:
.Lcodegen_arm_630:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $61
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_631
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_632
.Lcodegen_arm_631:
.Lcodegen_arm_632:
.Lcodegen_arm_633:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_635
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_636
.Lcodegen_arm_635:
    pushl $1
.Lcodegen_arm_636:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_634
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_633
.Lcodegen_arm_634:
    jmp .Lcodegen_arm_624
.Lcodegen_arm_623:
.Lcodegen_arm_624:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_637
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
.Lcodegen_arm_639:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_641
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_642
.Lcodegen_arm_641:
    pushl $0
.Lcodegen_arm_642:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_640
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_639
.Lcodegen_arm_640:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_643
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_644
.Lcodegen_arm_643:
.Lcodegen_arm_644:
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_638
.Lcodegen_arm_637:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $45
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_645
    pushl $1
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_646
.Lcodegen_arm_645:
.Lcodegen_arm_646:
.Lcodegen_arm_638:
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_647
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_651
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $120
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_653
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $88
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_654
.Lcodegen_arm_653:
    pushl $1
.Lcodegen_arm_654:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_652
.Lcodegen_arm_651:
    pushl $0
.Lcodegen_arm_652:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_649
    pushl -112(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
.Lcodegen_arm_655:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_661
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_662
.Lcodegen_arm_661:
    pushl $0
.Lcodegen_arm_662:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_659
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_663
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_664
.Lcodegen_arm_663:
    pushl $0
.Lcodegen_arm_664:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_660
.Lcodegen_arm_659:
    pushl $1
.Lcodegen_arm_660:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_657
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_665
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $70
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_666
.Lcodegen_arm_665:
    pushl $0
.Lcodegen_arm_666:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_658
.Lcodegen_arm_657:
    pushl $1
.Lcodegen_arm_658:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_656
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -80(%ebp)
    movzbl -80(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_669
    movzbl -80(%ebp), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_670
.Lcodegen_arm_669:
    pushl $0
.Lcodegen_arm_670:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_667
    movzbl -80(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lcodegen_arm_668
.Lcodegen_arm_667:
    movzbl -80(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_673
    movzbl -80(%ebp), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_674
.Lcodegen_arm_673:
    pushl $0
.Lcodegen_arm_674:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_671
    movzbl -80(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    jmp .Lcodegen_arm_672
.Lcodegen_arm_671:
    movzbl -80(%ebp), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
.Lcodegen_arm_672:
.Lcodegen_arm_668:
    popl %eax
    movl %eax, -72(%ebp)
    pushl -104(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -72(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_655
.Lcodegen_arm_656:
    pushl $1
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_650
.Lcodegen_arm_649:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_677
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_678
.Lcodegen_arm_677:
    pushl $0
.Lcodegen_arm_678:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_675
.Lcodegen_arm_679:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_681
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_682
.Lcodegen_arm_681:
    pushl $0
.Lcodegen_arm_682:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_680
    pushl -104(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_679
.Lcodegen_arm_680:
    pushl $1
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_676
.Lcodegen_arm_675:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $39
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_683
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_685
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    pushl $110
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_688
    pushl -80(%ebp)
    pushl $116
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_689
    pushl -80(%ebp)
    pushl $114
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_690
    pushl -80(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_691
    pushl -80(%ebp)
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_692
    pushl -80(%ebp)
    pushl $39
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_693
    pushl -80(%ebp)
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_694
    jmp .Lcodegen_arm_695
.Lcodegen_arm_688:
    pushl $10
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_687
.Lcodegen_arm_689:
    pushl $9
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_687
.Lcodegen_arm_690:
    pushl $13
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_687
.Lcodegen_arm_691:
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_687
.Lcodegen_arm_692:
    pushl $92
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_687
.Lcodegen_arm_693:
    pushl $39
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_687
.Lcodegen_arm_694:
    pushl $34
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_687
.Lcodegen_arm_695:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_687
.Lcodegen_arm_687:
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_686
.Lcodegen_arm_685:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
.Lcodegen_arm_686:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $39
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_696
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_697
.Lcodegen_arm_696:
.Lcodegen_arm_697:
    pushl $1
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_684
.Lcodegen_arm_683:
.Lcodegen_arm_684:
.Lcodegen_arm_676:
.Lcodegen_arm_650:
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_700
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_704
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $122
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_705
.Lcodegen_arm_704:
    pushl $0
.Lcodegen_arm_705:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_702
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_706
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $90
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_707
.Lcodegen_arm_706:
    pushl $0
.Lcodegen_arm_707:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_703
.Lcodegen_arm_702:
    pushl $1
.Lcodegen_arm_703:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_701
.Lcodegen_arm_700:
    pushl $0
.Lcodegen_arm_701:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_698
.Lcodegen_arm_708:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_720
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_721
.Lcodegen_arm_720:
    pushl $0
.Lcodegen_arm_721:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_718
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_722
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $122
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_723
.Lcodegen_arm_722:
    pushl $0
.Lcodegen_arm_723:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_719
.Lcodegen_arm_718:
    pushl $1
.Lcodegen_arm_719:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_716
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_724
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $90
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_725
.Lcodegen_arm_724:
    pushl $0
.Lcodegen_arm_725:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_717
.Lcodegen_arm_716:
    pushl $1
.Lcodegen_arm_717:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_714
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_715
.Lcodegen_arm_714:
    pushl $1
.Lcodegen_arm_715:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_712
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $43
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_713
.Lcodegen_arm_712:
    pushl $1
.Lcodegen_arm_713:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_710
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $45
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_711
.Lcodegen_arm_710:
    pushl $1
.Lcodegen_arm_711:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_709
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_708
.Lcodegen_arm_709:
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_699
.Lcodegen_arm_698:
.Lcodegen_arm_699:
    jmp .Lcodegen_arm_648
.Lcodegen_arm_647:
.Lcodegen_arm_648:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_726
    pushl -104(%ebp)
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_727
.Lcodegen_arm_726:
.Lcodegen_arm_727:
    pushl $0
    popl %eax
    movl %eax, -80(%ebp)
.Lcodegen_arm_728:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_732
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_734
    pushl -80(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_735
.Lcodegen_arm_734:
    pushl $0
.Lcodegen_arm_735:
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_733
.Lcodegen_arm_732:
    pushl $0
.Lcodegen_arm_733:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_730
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $125
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_736
    pushl -80(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_737
.Lcodegen_arm_736:
    pushl $0
.Lcodegen_arm_737:
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_731
.Lcodegen_arm_730:
    pushl $0
.Lcodegen_arm_731:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_729
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $123
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_738
    pushl -80(%ebp)
    pushl -80(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_739
.Lcodegen_arm_738:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $125
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_740
    pushl -80(%ebp)
    pushl -80(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_741
.Lcodegen_arm_740:
.Lcodegen_arm_741:
.Lcodegen_arm_739:
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_728
.Lcodegen_arm_729:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_742
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_743
.Lcodegen_arm_742:
.Lcodegen_arm_743:
.Lcodegen_arm_744:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $125
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_745
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_744
.Lcodegen_arm_745:
    pushl -104(%ebp)
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl -120(%ebp)
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_746
    leal ark_str_540, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_747
.Lcodegen_arm_746:
    pushl -136(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_748
    leal ark_str_541, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_749
.Lcodegen_arm_748:
    leal ark_str_542, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_749:
.Lcodegen_arm_747:
.Lcodegen_arm_602:
    pushl -120(%ebp)
    pushl -120(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_600
.Lcodegen_arm_601:
    jmp .Lcodegen_arm_587
.Lcodegen_arm_586:
    pushl -160(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_750
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
.Lcodegen_arm_752:
    pushl -104(%ebp)
    pushl -144(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_755
    pushl -160(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_756
.Lcodegen_arm_755:
    pushl $0
.Lcodegen_arm_756:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_753
    pushl -160(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl -104(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_543, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_754:
    pushl -104(%ebp)
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_752
.Lcodegen_arm_753:
    jmp .Lcodegen_arm_751
.Lcodegen_arm_750:
    pushl -160(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl $1
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_757
    leal ark_str_544, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_758
.Lcodegen_arm_757:
    pushl -144(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_759
    leal ark_str_545, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_760
.Lcodegen_arm_759:
    pushl -144(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_761
    leal ark_str_546, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -160(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl $32
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    addl $4, %esp
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_547, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_762
.Lcodegen_arm_761:
    leal ark_str_548, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_762:
.Lcodegen_arm_760:
.Lcodegen_arm_758:
.Lcodegen_arm_751:
.Lcodegen_arm_587:
.Lcodegen_arm_581:
.Lcodegen_arm_559:
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_557
.Lcodegen_arm_558:
    movl _g_bss_sram_start, %eax
    pushl %eax
    movl _g_bss_sram_end, %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_763
    movl _g_bss_sram_start, %eax
    pushl %eax
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    movl _g_bss_sram_end, %eax
    pushl %eax
    pushl $1
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_549, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_550, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_551, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_552, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_553, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_554, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_555, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_556, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_557, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_764
.Lcodegen_arm_763:
.Lcodegen_arm_764:
    leal ark_str_558, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_559, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_554
.Lcodegen_arm_553:
.Lcodegen_arm_554:
    leal ark_str_560, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_561, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_562, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_563, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_564, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_565, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_566, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_567, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_568, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_569, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_570, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_571, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_572, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_573, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_574, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_575, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_576, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_577, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_578, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_579, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_580, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_581, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_582, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_583, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_584, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_585, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_586, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_587, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_588, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_589, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_590, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_591, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_592, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_593, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_594, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_595, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_596, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_597, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_598, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_599, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_600, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_601, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_602, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_603, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_604, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_605, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_606, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_607, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_608, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_609, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_610, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_611, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_612, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_613, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_614, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_615, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_616, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_617, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_618, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_619, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_620, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_621, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_622, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_623, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_624, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_625, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_626, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_627, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_628, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_629, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_630, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_631, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_632, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_633, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_634, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_635, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_636, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_637, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_638, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_639, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_640, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_641, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_642, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_643, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_644, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_645, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_646, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_647, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_648, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_649, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_650, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_651, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_652, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_653, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_654, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_655, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_656, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_657, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_658, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_659, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_660, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_661, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_662, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_663, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_664, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_665, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_666, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_667, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_668, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_669, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_670, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_671, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_672, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_673, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_674, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_675, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_676, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_677, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_678, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_679, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_680, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_681, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_682, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_683, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_684, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_685, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_686, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_687, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_688, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_689, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_690, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_691, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_692, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_693, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_694, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_695, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_696, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_697, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_698, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_699, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_700, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_701, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_702, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_703, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_704, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_705, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_706, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_707, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_708, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_709, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_710, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_711, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_712, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_713, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_714, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_715, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_716, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_717, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_718, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_719, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_720, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_721, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_722, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_723, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_724, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_725, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_726, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_727, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_728, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_729, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_730, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_731, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_732, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_733, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_734, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_735, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_736, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_737, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_738, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_739, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_740, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_741, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_742, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_743, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_744, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_745, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_746, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_747, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_748, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_749, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_750, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_751, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_752, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_753, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_754, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_755, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_756, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_757, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_758, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_759, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_760, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_761, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_762, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_763, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_764, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_765, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_766, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_767, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_768, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_769, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_770, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_771, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_772, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_773, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_774, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_775, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_776, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_777, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_778, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_779, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_780, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_781, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_782, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_783, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_784, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_785, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_786, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_787, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_788, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_789, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_790, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_791, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_792, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_793, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_794, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_795, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_796, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_797, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_798, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_799, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_800, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_801, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_802, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_803, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_804, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_805, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_806, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_807, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_808, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_809, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_810, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_811, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_812, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_813, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_814, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_815, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_816, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_817, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_818, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_819, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_820, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_821, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_822, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_823, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_824, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_825, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_826, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_827, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_828, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_829, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_830, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_831, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_832, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_833, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_834, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_835, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_836, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_837, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_838, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_839, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_840, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_841, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_842, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_843, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_844, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_845, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_846, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_847, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_848, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_849, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_850, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_767
    pushl -2264(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_768
.Lcodegen_arm_767:
    pushl $0
.Lcodegen_arm_768:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_765
    pushl $0
    popl %eax
    movl %eax, -160(%ebp)
    pushl $0
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
.Lcodegen_arm_769:
    pushl -168(%ebp)
    pushl -2264(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_770
    pushl -2264(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -168(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl $0
    popl %eax
    movl %eax, -136(%ebp)
    pushl $0
    popl %eax
    movl %eax, -128(%ebp)
    pushl -152(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_772
    jmp .Lcodegen_arm_771
.Lcodegen_arm_772:
.Lcodegen_arm_773:
    pushl -152(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_774
    pushl -152(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_776
    leal ark_str_851, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_777
.Lcodegen_arm_776:
.Lcodegen_arm_777:
    leal ark_str_852, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_853, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    leal ark_str_854, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl $7
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
.Lcodegen_arm_778:
    pushl -96(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_779
    leal -112(%ebp), %eax
    pushl %eax
    pushl -96(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -88(%ebp)
    pushl -120(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -120(%ebp)
    pushl $4
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
.Lcodegen_arm_780:
    pushl -96(%ebp)
    pushl -96(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_778
.Lcodegen_arm_779:
    leal -112(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -112(%ebp), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_771
.Lcodegen_arm_774:
.Lcodegen_arm_775:
    pushl -152(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_781
    pushl -152(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _type_size
    addl $4, %esp
    pushl %eax
    jmp .Lcodegen_arm_782
.Lcodegen_arm_781:
    pushl $4
.Lcodegen_arm_782:
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    pushl -144(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_783
    pushl $4
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_784
.Lcodegen_arm_783:
.Lcodegen_arm_784:
    pushl -152(%ebp)
    pushl $52
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_785
    pushl -152(%ebp)
    pushl $52
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_786
.Lcodegen_arm_785:
    pushl -152(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_787
    pushl $2
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_788
.Lcodegen_arm_787:
    pushl -152(%ebp)
    pushl $56
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_789
    pushl $3
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_790
.Lcodegen_arm_789:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
.Lcodegen_arm_790:
.Lcodegen_arm_788:
.Lcodegen_arm_786:
    pushl -152(%ebp)
    pushl $80
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_791
    pushl -152(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_795
    pushl -152(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_796
.Lcodegen_arm_795:
    pushl $1
.Lcodegen_arm_796:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_793
    pushl $5
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_794
.Lcodegen_arm_793:
    pushl $6
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
.Lcodegen_arm_794:
    jmp .Lcodegen_arm_792
.Lcodegen_arm_791:
.Lcodegen_arm_792:
    pushl -128(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_797
    leal ark_str_855, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -128(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_856, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $4
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_798
.Lcodegen_arm_797:
    pushl -160(%ebp)
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_799
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_801
    leal ark_str_857, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_802
.Lcodegen_arm_801:
    pushl -136(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_803
    leal ark_str_858, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_804
.Lcodegen_arm_803:
    pushl -136(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_805
    leal ark_str_859, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_806
.Lcodegen_arm_805:
    pushl -136(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_807
    leal ark_str_860, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_808
.Lcodegen_arm_807:
    pushl -136(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_809
    leal ark_str_861, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_810
.Lcodegen_arm_809:
.Lcodegen_arm_810:
.Lcodegen_arm_808:
.Lcodegen_arm_806:
.Lcodegen_arm_804:
.Lcodegen_arm_802:
    pushl -136(%ebp)
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_800
.Lcodegen_arm_799:
.Lcodegen_arm_800:
.Lcodegen_arm_798:
    pushl -152(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_811
    leal ark_str_862, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_812
.Lcodegen_arm_811:
.Lcodegen_arm_812:
    pushl -152(%ebp)
    pushl $68
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_813
    leal ark_str_863, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl $68
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_814
.Lcodegen_arm_813:
    leal ark_str_864, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_814:
    pushl -152(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_865, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_817
    pushl -152(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_818
.Lcodegen_arm_817:
    pushl $1
.Lcodegen_arm_818:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_815
    leal ark_str_866, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_816
.Lcodegen_arm_815:
    pushl -152(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_819
    leal ark_str_867, %eax
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    leal -120(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -152(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    fldl (%esp)
    addl $8, %esp
    subl $4, %esp
    fstps (%esp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -120(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl $7
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
.Lcodegen_arm_821:
    pushl -88(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_822
    leal -104(%ebp), %eax
    pushl %eax
    pushl -88(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -80(%ebp)
    pushl -112(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $4
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
.Lcodegen_arm_823:
    pushl -88(%ebp)
    pushl -88(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_821
.Lcodegen_arm_822:
    leal -104(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal ark_str_868, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -104(%ebp), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_820
.Lcodegen_arm_819:
    pushl -152(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_824
    pushl -152(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    leal ark_str_869, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
.Lcodegen_arm_826:
    pushl -112(%ebp)
    pushl -120(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_827
    pushl -152(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -104(%ebp)
    movzbl -104(%ebp), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_829
    leal ark_str_870, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_830
.Lcodegen_arm_829:
    movzbl -104(%ebp), %eax
    pushl %eax
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_831
    leal ark_str_871, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_832
.Lcodegen_arm_831:
    movzbl -104(%ebp), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_833
    leal ark_str_872, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_834
.Lcodegen_arm_833:
    movzbl -104(%ebp), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_835
    leal ark_str_873, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_836
.Lcodegen_arm_835:
    movzbl -104(%ebp), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_839
    movzbl -104(%ebp), %eax
    pushl %eax
    pushl $127
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_840
.Lcodegen_arm_839:
    pushl $1
.Lcodegen_arm_840:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_837
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
    leal ark_str_874, %eax
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    leal -96(%ebp), %eax
    pushl %eax
    pushl -88(%ebp)
    pushl -88(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $92
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl -88(%ebp)
    pushl -88(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $120
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl -88(%ebp)
    pushl -88(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -80(%ebp)
    movzbl -104(%ebp), %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl -88(%ebp)
    pushl -88(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -80(%ebp)
    movzbl -104(%ebp), %eax
    pushl %eax
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl -88(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_838
.Lcodegen_arm_837:
    movzbl -104(%ebp), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_838:
.Lcodegen_arm_836:
.Lcodegen_arm_834:
.Lcodegen_arm_832:
.Lcodegen_arm_830:
.Lcodegen_arm_828:
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_826
.Lcodegen_arm_827:
    leal ark_str_875, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -144(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_841
    leal ark_str_876, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    pushl -120(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_842
.Lcodegen_arm_841:
.Lcodegen_arm_842:
    jmp .Lcodegen_arm_825
.Lcodegen_arm_824:
    leal ark_str_877, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_843
    leal ark_str_878, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_844
.Lcodegen_arm_843:
.Lcodegen_arm_844:
.Lcodegen_arm_825:
.Lcodegen_arm_820:
.Lcodegen_arm_816:
.Lcodegen_arm_771:
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_769
.Lcodegen_arm_770:
    leal ark_str_879, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_766
.Lcodegen_arm_765:
.Lcodegen_arm_766:
    movl $_g_config, %eax
    pushl %eax
    pushl $84
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_845
    pushl -2264(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_847
    pushl -2264(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    jmp .Lcodegen_arm_848
.Lcodegen_arm_847:
    leal ark_str_880, %eax
    pushl %eax
.Lcodegen_arm_848:
    popl %eax
    movl %eax, -160(%ebp)
    leal ark_str_881, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_882, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_883, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_884, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_885, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_886, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_887, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_888, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_889, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_890, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_891, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_892, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_893, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_894, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_895, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_896, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_897, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_898, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_899, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_900, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_901, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_902, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_903, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_904, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -160(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_905, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_906, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
.Lcodegen_arm_849:
    pushl -168(%ebp)
    pushl -2264(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_850
    pushl -2264(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -168(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    pushl $76
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_852
    jmp .Lcodegen_arm_851
.Lcodegen_arm_852:
.Lcodegen_arm_853:
    leal ark_str_907, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_908, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_909, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_910, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_911, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_912, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_851:
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_849
.Lcodegen_arm_850:
    leal ark_str_913, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_914, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_915, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_916, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_917, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_918, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_919, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_920, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_921, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_922, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_923, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_924, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_925, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -160(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_926, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_927, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_928, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -160(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_929, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_930, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_931, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_932, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_933, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_846
.Lcodegen_arm_845:
.Lcodegen_arm_846:
    leal -2256(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_is_alpha_a:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lis_alpha_a_6
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $122
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_alpha_a_7
.Lis_alpha_a_6:
    pushl $0
.Lis_alpha_a_7:
    popl %eax
    cmpl $0, %eax
    jne .Lis_alpha_a_4
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lis_alpha_a_8
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $90
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_alpha_a_9
.Lis_alpha_a_8:
    pushl $0
.Lis_alpha_a_9:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_alpha_a_5
.Lis_alpha_a_4:
    pushl $1
.Lis_alpha_a_5:
    popl %eax
    cmpl $0, %eax
    jne .Lis_alpha_a_2
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $95
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_alpha_a_3
.Lis_alpha_a_2:
    pushl $1
.Lis_alpha_a_3:
    popl %eax
    cmpl $0, %eax
    jne .Lis_alpha_a_0
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_alpha_a_1
.Lis_alpha_a_0:
    pushl $1
.Lis_alpha_a_1:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_is_alnum_a:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movzbl -24(%ebp), %eax
    pushl %eax
    call _is_alpha_a
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_alnum_a_0
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lis_alnum_a_2
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_alnum_a_3
.Lis_alnum_a_2:
    pushl $0
.Lis_alnum_a_3:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_alnum_a_1
.Lis_alnum_a_0:
    pushl $1
.Lis_alnum_a_1:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_is_space_a:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_space_a_2
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_space_a_3
.Lis_space_a_2:
    pushl $1
.Lis_space_a_3:
    popl %eax
    cmpl $0, %eax
    jne .Lis_space_a_0
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_space_a_1
.Lis_space_a_0:
    pushl $1
.Lis_space_a_1:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_my_toupper_a:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lmy_toupper_a_2
    pushl -24(%ebp)
    pushl $122
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lmy_toupper_a_3
.Lmy_toupper_a_2:
    pushl $0
.Lmy_toupper_a_3:
    popl %eax
    cmpl $0, %eax
    je .Lmy_toupper_a_0
    pushl -24(%ebp)
    pushl $97
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lmy_toupper_a_0:
.Lmy_toupper_a_1:
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_strieq_a:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -16(%ebp)
.Lstrieq_a_0:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lstrieq_a_2
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lstrieq_a_3
.Lstrieq_a_2:
    pushl $0
.Lstrieq_a_3:
    popl %eax
    cmpl $0, %eax
    je .Lstrieq_a_1
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _my_toupper_a
    addl $4, %esp
    pushl %eax
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _my_toupper_a
    addl $4, %esp
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lstrieq_a_4
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lstrieq_a_4:
.Lstrieq_a_5:
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    addl $4, %esp
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    addl $4, %esp
    jmp .Lstrieq_a_0
.Lstrieq_a_1:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lstrieq_a_6
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lstrieq_a_7
.Lstrieq_a_6:
    pushl $0
.Lstrieq_a_7:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_skip_space_a:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
.Lskip_space_a_0:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_space_a
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_space_a_1
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    jmp .Lskip_space_a_0
.Lskip_space_a_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_skip_to_eol_a:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
.Lskip_to_eol_a_0:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_to_eol_a_2
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lskip_to_eol_a_3
.Lskip_to_eol_a_2:
    pushl $0
.Lskip_to_eol_a_3:
    popl %eax
    cmpl $0, %eax
    je .Lskip_to_eol_a_1
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    jmp .Lskip_to_eol_a_0
.Lskip_to_eol_a_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_read_word_a:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -40(%ebp)
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_word_a_0
.Lread_word_a_2:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_word_a_6
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_alnum_a
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_word_a_7
.Lread_word_a_6:
    pushl $0
.Lread_word_a_7:
    popl %eax
    cmpl $0, %eax
    je .Lread_word_a_4
    pushl -16(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_word_a_5
.Lread_word_a_4:
    pushl $0
.Lread_word_a_5:
    popl %eax
    cmpl $0, %eax
    je .Lread_word_a_3
    pushl -32(%ebp)
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    jmp .Lread_word_a_2
.Lread_word_a_3:
    jmp .Lread_word_a_1
.Lread_word_a_0:
.Lread_word_a_8:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_word_a_14
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_alnum_a
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_word_a_15
.Lread_word_a_14:
    pushl $0
.Lread_word_a_15:
    popl %eax
    cmpl $0, %eax
    je .Lread_word_a_12
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_word_a_13
.Lread_word_a_12:
    pushl $0
.Lread_word_a_13:
    popl %eax
    cmpl $0, %eax
    je .Lread_word_a_10
    pushl -16(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_word_a_11
.Lread_word_a_10:
    pushl $0
.Lread_word_a_11:
    popl %eax
    cmpl $0, %eax
    je .Lread_word_a_9
    pushl -32(%ebp)
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    jmp .Lread_word_a_8
.Lread_word_a_9:
.Lread_word_a_1:
    pushl -32(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_reg_a:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -24(%ebp)
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $114
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_reg_a_2
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $82
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_3
.Lparse_reg_a_2:
    pushl $1
.Lparse_reg_a_3:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reg_a_0
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
.Lparse_reg_a_4:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_reg_a_6
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_7
.Lparse_reg_a_6:
    pushl $0
.Lparse_reg_a_7:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reg_a_5
    pushl -16(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    jmp .Lparse_reg_a_4
.Lparse_reg_a_5:
    pushl -16(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_reg_a_0:
.Lparse_reg_a_1:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $115
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_reg_a_12
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $83
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_13
.Lparse_reg_a_12:
    pushl $1
.Lparse_reg_a_13:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reg_a_10
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $112
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_reg_a_14
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $80
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_15
.Lparse_reg_a_14:
    pushl $1
.Lparse_reg_a_15:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_11
.Lparse_reg_a_10:
    pushl $0
.Lparse_reg_a_11:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reg_a_8
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $13
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_reg_a_8:
.Lparse_reg_a_9:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $108
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_reg_a_20
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $76
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_21
.Lparse_reg_a_20:
    pushl $1
.Lparse_reg_a_21:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reg_a_18
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $114
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_reg_a_22
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $82
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_23
.Lparse_reg_a_22:
    pushl $1
.Lparse_reg_a_23:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_19
.Lparse_reg_a_18:
    pushl $0
.Lparse_reg_a_19:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reg_a_16
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $14
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_reg_a_16:
.Lparse_reg_a_17:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $112
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_reg_a_28
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $80
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_29
.Lparse_reg_a_28:
    pushl $1
.Lparse_reg_a_29:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reg_a_26
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $99
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_reg_a_30
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $67
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_31
.Lparse_reg_a_30:
    pushl $1
.Lparse_reg_a_31:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_27
.Lparse_reg_a_26:
    pushl $0
.Lparse_reg_a_27:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reg_a_24
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $15
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_reg_a_24:
.Lparse_reg_a_25:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $105
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_reg_a_36
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $73
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_37
.Lparse_reg_a_36:
    pushl $1
.Lparse_reg_a_37:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reg_a_34
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $112
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_reg_a_38
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $80
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_39
.Lparse_reg_a_38:
    pushl $1
.Lparse_reg_a_39:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_35
.Lparse_reg_a_34:
    pushl $0
.Lparse_reg_a_35:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reg_a_32
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $12
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_reg_a_32:
.Lparse_reg_a_33:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_reg_a_44
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $70
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_45
.Lparse_reg_a_44:
    pushl $1
.Lparse_reg_a_45:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reg_a_42
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $112
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_reg_a_46
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $80
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_47
.Lparse_reg_a_46:
    pushl $1
.Lparse_reg_a_47:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reg_a_43
.Lparse_reg_a_42:
    pushl $0
.Lparse_reg_a_43:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reg_a_40
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $11
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_reg_a_40:
.Lparse_reg_a_41:
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_vfp_sreg_a:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -24(%ebp)
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $115
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_vfp_sreg_a_4
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $83
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_vfp_sreg_a_5
.Lparse_vfp_sreg_a_4:
    pushl $1
.Lparse_vfp_sreg_a_5:
    popl %eax
    cmpl $0, %eax
    je .Lparse_vfp_sreg_a_2
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_vfp_sreg_a_6
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_vfp_sreg_a_7
.Lparse_vfp_sreg_a_6:
    pushl $0
.Lparse_vfp_sreg_a_7:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_vfp_sreg_a_3
.Lparse_vfp_sreg_a_2:
    pushl $0
.Lparse_vfp_sreg_a_3:
    popl %eax
    cmpl $0, %eax
    je .Lparse_vfp_sreg_a_0
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
.Lparse_vfp_sreg_a_8:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_vfp_sreg_a_10
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_vfp_sreg_a_11
.Lparse_vfp_sreg_a_10:
    pushl $0
.Lparse_vfp_sreg_a_11:
    popl %eax
    cmpl $0, %eax
    je .Lparse_vfp_sreg_a_9
    pushl -16(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    jmp .Lparse_vfp_sreg_a_8
.Lparse_vfp_sreg_a_9:
    pushl -16(%ebp)
    pushl $31
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_vfp_sreg_a_12
    pushl $31
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lparse_vfp_sreg_a_13
.Lparse_vfp_sreg_a_12:
.Lparse_vfp_sreg_a_13:
    pushl -16(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_vfp_sreg_a_0:
.Lparse_vfp_sreg_a_1:
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_vfp_dreg_a:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -24(%ebp)
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $100
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_vfp_dreg_a_2
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $68
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_vfp_dreg_a_3
.Lparse_vfp_dreg_a_2:
    pushl $1
.Lparse_vfp_dreg_a_3:
    popl %eax
    cmpl $0, %eax
    je .Lparse_vfp_dreg_a_0
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
.Lparse_vfp_dreg_a_4:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_vfp_dreg_a_6
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_vfp_dreg_a_7
.Lparse_vfp_dreg_a_6:
    pushl $0
.Lparse_vfp_dreg_a_7:
    popl %eax
    cmpl $0, %eax
    je .Lparse_vfp_dreg_a_5
    pushl -16(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    jmp .Lparse_vfp_dreg_a_4
.Lparse_vfp_dreg_a_5:
    pushl -16(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_vfp_dreg_a_8
    pushl $15
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lparse_vfp_dreg_a_9
.Lparse_vfp_dreg_a_8:
.Lparse_vfp_dreg_a_9:
    pushl -16(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_vfp_dreg_a_0:
.Lparse_vfp_dreg_a_1:
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_read_vfp_suffix_a:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -40(%ebp)
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lread_vfp_suffix_a_0:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_vfp_suffix_a_2
    pushl -16(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_vfp_suffix_a_3
.Lread_vfp_suffix_a_2:
    pushl $0
.Lread_vfp_suffix_a_3:
    popl %eax
    cmpl $0, %eax
    je .Lread_vfp_suffix_a_1
    pushl -40(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
.Lread_vfp_suffix_a_4:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_alnum_a
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_vfp_suffix_a_8
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_vfp_suffix_a_9
.Lread_vfp_suffix_a_8:
    pushl $0
.Lread_vfp_suffix_a_9:
    popl %eax
    cmpl $0, %eax
    je .Lread_vfp_suffix_a_6
    pushl -16(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_vfp_suffix_a_7
.Lread_vfp_suffix_a_6:
    pushl $0
.Lread_vfp_suffix_a_7:
    popl %eax
    cmpl $0, %eax
    je .Lread_vfp_suffix_a_5
    pushl -32(%ebp)
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    jmp .Lread_vfp_suffix_a_4
.Lread_vfp_suffix_a_5:
    jmp .Lread_vfp_suffix_a_0
.Lread_vfp_suffix_a_1:
    pushl -32(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_imm_a:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -56(%ebp)
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_imm_a_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_imm_a_0:
.Lparse_imm_a_1:
    pushl -56(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $45
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_imm_a_2
    pushl $1
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    jmp .Lparse_imm_a_3
.Lparse_imm_a_2:
.Lparse_imm_a_3:
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_imm_a_6
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $120
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_imm_a_8
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $88
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_imm_a_9
.Lparse_imm_a_8:
    pushl $1
.Lparse_imm_a_9:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_imm_a_7
.Lparse_imm_a_6:
    pushl $0
.Lparse_imm_a_7:
    popl %eax
    cmpl $0, %eax
    je .Lparse_imm_a_4
    pushl -56(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lparse_imm_a_10:
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -32(%ebp)
    movzbl -32(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_imm_a_15
    movzbl -32(%ebp), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_imm_a_16
.Lparse_imm_a_15:
    pushl $0
.Lparse_imm_a_16:
    popl %eax
    cmpl $0, %eax
    je .Lparse_imm_a_13
    movzbl -32(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lparse_imm_a_14
.Lparse_imm_a_13:
    movzbl -32(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_imm_a_19
    movzbl -32(%ebp), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_imm_a_20
.Lparse_imm_a_19:
    pushl $0
.Lparse_imm_a_20:
    popl %eax
    cmpl $0, %eax
    je .Lparse_imm_a_17
    movzbl -32(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lparse_imm_a_18
.Lparse_imm_a_17:
    movzbl -32(%ebp), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_imm_a_23
    movzbl -32(%ebp), %eax
    pushl %eax
    pushl $70
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_imm_a_24
.Lparse_imm_a_23:
    pushl $0
.Lparse_imm_a_24:
    popl %eax
    cmpl $0, %eax
    je .Lparse_imm_a_21
    movzbl -32(%ebp), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lparse_imm_a_22
.Lparse_imm_a_21:
    jmp .Lparse_imm_a_11
.Lparse_imm_a_22:
.Lparse_imm_a_18:
.Lparse_imm_a_14:
    pushl -40(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
.Lparse_imm_a_12:
    jmp .Lparse_imm_a_10
.Lparse_imm_a_11:
    jmp .Lparse_imm_a_5
.Lparse_imm_a_4:
.Lparse_imm_a_25:
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_imm_a_27
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_imm_a_28
.Lparse_imm_a_27:
    pushl $0
.Lparse_imm_a_28:
    popl %eax
    cmpl $0, %eax
    je .Lparse_imm_a_26
    pushl -40(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    jmp .Lparse_imm_a_25
.Lparse_imm_a_26:
.Lparse_imm_a_5:
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_imm_a_29
    pushl -40(%ebp)
    popl %eax
    negl %eax
    pushl %eax
    jmp .Lparse_imm_a_30
.Lparse_imm_a_29:
    pushl -40(%ebp)
.Lparse_imm_a_30:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_eat_comma_a:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leat_comma_a_0
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    jmp .Leat_comma_a_1
.Leat_comma_a_0:
.Leat_comma_a_1:
    pushl -24(%ebp)
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_out16:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -16(%ebp)
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lout16_0
    pushl -24(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lout16_0:
.Lout16_1:
    pushl -24(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $8
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_add_label_a:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -40(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ladd_label_a_0
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ladd_label_a_2
    pushl $32
    jmp .Ladd_label_a_3
.Ladd_label_a_2:
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
.Ladd_label_a_3:
    popl %eax
    movl %eax, -16(%ebp)
    pushl -40(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Ladd_label_a_1
.Ladd_label_a_0:
.Ladd_label_a_1:
    pushl -40(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_find_label_a:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lfind_label_a_0:
    pushl -24(%ebp)
    pushl -40(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lfind_label_a_1
    pushl -32(%ebp)
    pushl -40(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lfind_label_a_3
    pushl -40(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lfind_label_a_3:
.Lfind_label_a_4:
.Lfind_label_a_2:
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    addl $4, %esp
    jmp .Lfind_label_a_0
.Lfind_label_a_1:
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_add_ref_a:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -48(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl -56(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ladd_ref_a_0
    pushl -56(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ladd_ref_a_2
    pushl $32
    jmp .Ladd_ref_a_3
.Ladd_ref_a_2:
    pushl -56(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
.Ladd_ref_a_3:
    popl %eax
    movl %eax, -24(%ebp)
    pushl -56(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Ladd_ref_a_1
.Ladd_ref_a_0:
.Ladd_ref_a_1:
    pushl -56(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_add_set_a:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -40(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $52
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ladd_set_a_0
    pushl -40(%ebp)
    pushl $52
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ladd_set_a_2
    pushl $32
    jmp .Ladd_set_a_3
.Ladd_set_a_2:
    pushl -40(%ebp)
    pushl $52
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
.Ladd_set_a_3:
    popl %eax
    movl %eax, -16(%ebp)
    pushl -40(%ebp)
    pushl $44
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $52
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $44
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    pushl $52
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Ladd_set_a_1
.Ladd_set_a_0:
.Ladd_set_a_1:
    pushl -40(%ebp)
    pushl $44
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    pushl $44
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_find_set_a:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lfind_set_a_0:
    pushl -24(%ebp)
    pushl -40(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lfind_set_a_1
    pushl -32(%ebp)
    pushl -40(%ebp)
    pushl $44
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lfind_set_a_3
    pushl -40(%ebp)
    pushl $44
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lfind_set_a_3:
.Lfind_set_a_4:
.Lfind_set_a_2:
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    addl $4, %esp
    jmp .Lfind_set_a_0
.Lfind_set_a_1:
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_add_literal_a:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -40(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ladd_literal_a_0
    pushl -40(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ladd_literal_a_2
    pushl $32
    jmp .Ladd_literal_a_3
.Ladd_literal_a_2:
    pushl -40(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
.Ladd_literal_a_3:
    popl %eax
    movl %eax, -16(%ebp)
    pushl -40(%ebp)
    pushl $56
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $56
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Ladd_literal_a_1
.Ladd_literal_a_0:
.Ladd_literal_a_1:
    pushl -40(%ebp)
    pushl $56
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    pushl $56
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    pushl $56
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_resolve_symbol_a:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl -40(%ebp)
    call _find_set_a
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lresolve_symbol_a_0
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lresolve_symbol_a_0:
.Lresolve_symbol_a_1:
    pushl -32(%ebp)
    pushl -40(%ebp)
    call _find_label_a
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_ldr_str_size_a:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lldr_str_size_a_0
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lldr_str_size_a_0:
.Lldr_str_size_a_1:
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lldr_str_size_a_2
    pushl -40(%ebp)
    pushl $31
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lldr_str_size_a_4
    pushl $2
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lldr_str_size_a_4:
.Lldr_str_size_a_5:
    jmp .Lldr_str_size_a_3
.Lldr_str_size_a_2:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lldr_str_size_a_6
    pushl -40(%ebp)
    pushl $62
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lldr_str_size_a_10
    pushl -40(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %edx
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lldr_str_size_a_11
.Lldr_str_size_a_10:
    pushl $0
.Lldr_str_size_a_11:
    popl %eax
    cmpl $0, %eax
    je .Lldr_str_size_a_8
    pushl $2
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lldr_str_size_a_8:
.Lldr_str_size_a_9:
    jmp .Lldr_str_size_a_7
.Lldr_str_size_a_6:
    pushl -40(%ebp)
    pushl $124
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lldr_str_size_a_14
    pushl -40(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %edx
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lldr_str_size_a_15
.Lldr_str_size_a_14:
    pushl $0
.Lldr_str_size_a_15:
    popl %eax
    cmpl $0, %eax
    je .Lldr_str_size_a_12
    pushl $2
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lldr_str_size_a_12:
.Lldr_str_size_a_13:
.Lldr_str_size_a_7:
.Lldr_str_size_a_3:
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_op_size_a:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    leal ark_str_934, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lop_size_a_0
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lop_size_a_0:
.Lop_size_a_1:
    leal ark_str_935, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lop_size_a_2
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lop_size_a_2:
.Lop_size_a_3:
    leal ark_str_936, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lop_size_a_4
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lop_size_a_4:
.Lop_size_a_5:
    leal ark_str_937, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lop_size_a_6
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lop_size_a_6:
.Lop_size_a_7:
    leal ark_str_938, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lop_size_a_8
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lop_size_a_8:
.Lop_size_a_9:
    leal ark_str_939, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lop_size_a_10
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lop_size_a_10:
.Lop_size_a_11:
    leal ark_str_940, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lop_size_a_12
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lop_size_a_12:
.Lop_size_a_13:
    leal ark_str_941, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lop_size_a_14
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lop_size_a_14:
.Lop_size_a_15:
    leal ark_str_942, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_30
    leal ark_str_943, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_31
.Lop_size_a_30:
    pushl $1
.Lop_size_a_31:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_28
    leal ark_str_944, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_29
.Lop_size_a_28:
    pushl $1
.Lop_size_a_29:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_26
    leal ark_str_945, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_27
.Lop_size_a_26:
    pushl $1
.Lop_size_a_27:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_24
    leal ark_str_946, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_25
.Lop_size_a_24:
    pushl $1
.Lop_size_a_25:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_22
    leal ark_str_947, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_23
.Lop_size_a_22:
    pushl $1
.Lop_size_a_23:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_20
    leal ark_str_948, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_21
.Lop_size_a_20:
    pushl $1
.Lop_size_a_21:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_18
    leal ark_str_949, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_19
.Lop_size_a_18:
    pushl $1
.Lop_size_a_19:
    popl %eax
    cmpl $0, %eax
    je .Lop_size_a_16
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lop_size_a_16:
.Lop_size_a_17:
    leal ark_str_950, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_36
    leal ark_str_951, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_37
.Lop_size_a_36:
    pushl $1
.Lop_size_a_37:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_34
    leal ark_str_952, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_35
.Lop_size_a_34:
    pushl $1
.Lop_size_a_35:
    popl %eax
    cmpl $0, %eax
    je .Lop_size_a_32
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lop_size_a_32:
.Lop_size_a_33:
    leal ark_str_953, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lop_size_a_38
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lop_size_a_38:
.Lop_size_a_39:
    leal ark_str_954, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_64
    leal ark_str_955, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_65
.Lop_size_a_64:
    pushl $1
.Lop_size_a_65:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_62
    leal ark_str_956, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_63
.Lop_size_a_62:
    pushl $1
.Lop_size_a_63:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_60
    leal ark_str_957, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_61
.Lop_size_a_60:
    pushl $1
.Lop_size_a_61:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_58
    leal ark_str_958, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_59
.Lop_size_a_58:
    pushl $1
.Lop_size_a_59:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_56
    leal ark_str_959, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_57
.Lop_size_a_56:
    pushl $1
.Lop_size_a_57:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_54
    leal ark_str_960, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_55
.Lop_size_a_54:
    pushl $1
.Lop_size_a_55:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_52
    leal ark_str_961, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_53
.Lop_size_a_52:
    pushl $1
.Lop_size_a_53:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_50
    leal ark_str_962, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_51
.Lop_size_a_50:
    pushl $1
.Lop_size_a_51:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_48
    leal ark_str_963, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_49
.Lop_size_a_48:
    pushl $1
.Lop_size_a_49:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_46
    leal ark_str_964, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_47
.Lop_size_a_46:
    pushl $1
.Lop_size_a_47:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_44
    leal ark_str_965, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_45
.Lop_size_a_44:
    pushl $1
.Lop_size_a_45:
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_42
    leal ark_str_966, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lop_size_a_43
.Lop_size_a_42:
    pushl $1
.Lop_size_a_43:
    popl %eax
    cmpl $0, %eax
    je .Lop_size_a_40
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lop_size_a_40:
.Lop_size_a_41:
    pushl $2
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_pass1_a:
    pushl %ebp
    movl %esp, %ebp
    subl $480, %esp
    movl 8(%ebp), %eax
    movl %eax, -232(%ebp)
    pushl -232(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    pushl $0
    popl %eax
    movl %eax, -216(%ebp)
    pushl -232(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -232(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -232(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lpass1_a_0:
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_1
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_2
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_0
.Lpass1_a_2:
.Lpass1_a_3:
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $59
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_4
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_to_eol_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass1_a_0
.Lpass1_a_4:
.Lpass1_a_5:
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_6
    jmp .Lpass1_a_1
.Lpass1_a_6:
.Lpass1_a_7:
    pushl $64
    leal -208(%ebp), %eax
    pushl %eax
    leal -224(%ebp), %eax
    pushl %eax
    call _read_word_a
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    pushl -144(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_8
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_to_eol_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass1_a_0
.Lpass1_a_8:
.Lpass1_a_9:
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $58
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_10
    pushl -216(%ebp)
    leal -208(%ebp), %eax
    pushl %eax
    pushl -232(%ebp)
    call _add_label_a
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_16
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $59
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_17
.Lpass1_a_16:
    pushl $1
.Lpass1_a_17:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_14
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_15
.Lpass1_a_14:
    pushl $1
.Lpass1_a_15:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_12
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $59
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_18
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_to_eol_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass1_a_19
.Lpass1_a_18:
.Lpass1_a_19:
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_20
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_21
.Lpass1_a_20:
.Lpass1_a_21:
    jmp .Lpass1_a_0
.Lpass1_a_12:
.Lpass1_a_13:
    pushl $64
    leal -208(%ebp), %eax
    pushl %eax
    leal -224(%ebp), %eax
    pushl %eax
    call _read_word_a
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    pushl -144(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_22
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_to_eol_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass1_a_0
.Lpass1_a_22:
.Lpass1_a_23:
    jmp .Lpass1_a_11
.Lpass1_a_10:
.Lpass1_a_11:
    leal -208(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_24
    leal ark_str_967, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_28
    leal ark_str_968, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_29
.Lpass1_a_28:
    pushl $1
.Lpass1_a_29:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_26
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $64
    leal -136(%ebp), %eax
    pushl %eax
    leal -224(%ebp), %eax
    pushl %eax
    call _read_word_a
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    pushl -144(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_30
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_32
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_33
.Lpass1_a_32:
.Lpass1_a_33:
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_36
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $120
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_38
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $88
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_39
.Lpass1_a_38:
    pushl $1
.Lpass1_a_39:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_37
.Lpass1_a_36:
    pushl $0
.Lpass1_a_37:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_34
    pushl $0
    popl %eax
    movl %eax, -72(%ebp)
    pushl -224(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    pushl -224(%ebp)
    addl $4, %esp
.Lpass1_a_40:
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_46
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_47
.Lpass1_a_46:
    pushl $0
.Lpass1_a_47:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_44
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_48
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_49
.Lpass1_a_48:
    pushl $0
.Lpass1_a_49:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_45
.Lpass1_a_44:
    pushl $1
.Lpass1_a_45:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_42
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_50
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $70
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_51
.Lpass1_a_50:
    pushl $0
.Lpass1_a_51:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_43
.Lpass1_a_42:
    pushl $1
.Lpass1_a_43:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_41
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -64(%ebp)
    movzbl -64(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_54
    movzbl -64(%ebp), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_55
.Lpass1_a_54:
    pushl $0
.Lpass1_a_55:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_52
    movzbl -64(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lpass1_a_53
.Lpass1_a_52:
    movzbl -64(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_58
    movzbl -64(%ebp), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_59
.Lpass1_a_58:
    pushl $0
.Lpass1_a_59:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_56
    movzbl -64(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    jmp .Lpass1_a_57
.Lpass1_a_56:
    movzbl -64(%ebp), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
.Lpass1_a_57:
.Lpass1_a_53:
    popl %eax
    movl %eax, -56(%ebp)
    pushl -72(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    addl $4, %esp
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_40
.Lpass1_a_41:
    pushl -72(%ebp)
    leal -136(%ebp), %eax
    pushl %eax
    pushl -232(%ebp)
    call _add_set_a
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass1_a_35
.Lpass1_a_34:
    pushl $64
    leal -72(%ebp), %eax
    pushl %eax
    leal -224(%ebp), %eax
    pushl %eax
    call _read_word_a
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    pushl -144(%ebp)
    addl $4, %esp
    leal -72(%ebp), %eax
    pushl %eax
    addl $4, %esp
.Lpass1_a_35:
    jmp .Lpass1_a_31
.Lpass1_a_30:
.Lpass1_a_31:
    jmp .Lpass1_a_27
.Lpass1_a_26:
    leal ark_str_969, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_64
    leal ark_str_970, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_65
.Lpass1_a_64:
    pushl $1
.Lpass1_a_65:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_62
    leal ark_str_971, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_63
.Lpass1_a_62:
    pushl $1
.Lpass1_a_63:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_60
    pushl $0
    popl %eax
    movl %eax, -136(%ebp)
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_66
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_67
.Lpass1_a_66:
.Lpass1_a_67:
.Lpass1_a_68:
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_70
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_71
.Lpass1_a_70:
    pushl $0
.Lpass1_a_71:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_69
    pushl -136(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_68
.Lpass1_a_69:
    pushl -216(%ebp)
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_61
.Lpass1_a_60:
    leal ark_str_972, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_74
    leal ark_str_973, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_75
.Lpass1_a_74:
    pushl $1
.Lpass1_a_75:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_72
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -224(%ebp)
    popl %eax
    movl %eax, -128(%ebp)
.Lpass1_a_76:
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_78
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_79
.Lpass1_a_78:
    pushl $0
.Lpass1_a_79:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_77
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_80
    pushl -136(%ebp)
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_81
.Lpass1_a_80:
.Lpass1_a_81:
    pushl -128(%ebp)
    pushl -128(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_76
.Lpass1_a_77:
    pushl -216(%ebp)
    pushl $4
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_73
.Lpass1_a_72:
    leal ark_str_974, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_82
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -224(%ebp)
    popl %eax
    movl %eax, -128(%ebp)
.Lpass1_a_84:
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_86
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_87
.Lpass1_a_86:
    pushl $0
.Lpass1_a_87:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_85
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_88
    pushl -136(%ebp)
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_89
.Lpass1_a_88:
.Lpass1_a_89:
    pushl -128(%ebp)
    pushl -128(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_84
.Lpass1_a_85:
    pushl -216(%ebp)
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_83
.Lpass1_a_82:
    leal ark_str_975, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_90
    pushl $0
    popl %eax
    movl %eax, -136(%ebp)
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_92
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
.Lpass1_a_94:
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_98
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_99
.Lpass1_a_98:
    pushl $0
.Lpass1_a_99:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_96
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_97
.Lpass1_a_96:
    pushl $0
.Lpass1_a_97:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_95
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_100
    pushl -136(%ebp)
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    addl $4, %esp
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_102
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_103
.Lpass1_a_102:
.Lpass1_a_103:
    jmp .Lpass1_a_101
.Lpass1_a_100:
    pushl -136(%ebp)
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    addl $4, %esp
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
.Lpass1_a_101:
    jmp .Lpass1_a_94
.Lpass1_a_95:
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_104
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_105
.Lpass1_a_104:
.Lpass1_a_105:
    jmp .Lpass1_a_93
.Lpass1_a_92:
.Lpass1_a_93:
    pushl -136(%ebp)
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    addl $4, %esp
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_106
    pushl -136(%ebp)
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_107
.Lpass1_a_106:
.Lpass1_a_107:
    pushl -216(%ebp)
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_91
.Lpass1_a_90:
    leal ark_str_976, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_108
    pushl $0
    popl %eax
    movl %eax, -136(%ebp)
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_110
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
.Lpass1_a_112:
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_116
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_117
.Lpass1_a_116:
    pushl $0
.Lpass1_a_117:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_114
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_115
.Lpass1_a_114:
    pushl $0
.Lpass1_a_115:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_113
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_118
    pushl -136(%ebp)
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    addl $4, %esp
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_120
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_121
.Lpass1_a_120:
.Lpass1_a_121:
    jmp .Lpass1_a_119
.Lpass1_a_118:
    pushl -136(%ebp)
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    addl $4, %esp
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
.Lpass1_a_119:
    jmp .Lpass1_a_112
.Lpass1_a_113:
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_122
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_123
.Lpass1_a_122:
.Lpass1_a_123:
    jmp .Lpass1_a_111
.Lpass1_a_110:
.Lpass1_a_111:
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_124
    pushl -136(%ebp)
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_125
.Lpass1_a_124:
.Lpass1_a_125:
    pushl -216(%ebp)
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_109
.Lpass1_a_108:
    leal ark_str_977, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_128
    leal ark_str_978, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_129
.Lpass1_a_128:
    pushl $1
.Lpass1_a_129:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_126
    pushl $0
    popl %eax
    movl %eax, -136(%ebp)
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_130
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_131
.Lpass1_a_130:
.Lpass1_a_131:
.Lpass1_a_132:
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_134
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_135
.Lpass1_a_134:
    pushl $0
.Lpass1_a_135:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_133
    pushl -136(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_132
.Lpass1_a_133:
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_136
    pushl -216(%ebp)
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %edx
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_138
    pushl -216(%ebp)
    pushl -136(%ebp)
    pushl -128(%ebp)
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_139
.Lpass1_a_138:
.Lpass1_a_139:
    jmp .Lpass1_a_137
.Lpass1_a_136:
.Lpass1_a_137:
    jmp .Lpass1_a_127
.Lpass1_a_126:
.Lpass1_a_127:
.Lpass1_a_109:
.Lpass1_a_91:
.Lpass1_a_83:
.Lpass1_a_73:
.Lpass1_a_61:
.Lpass1_a_27:
    jmp .Lpass1_a_25
.Lpass1_a_24:
    leal ark_str_979, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_154
    leal ark_str_980, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_155
.Lpass1_a_154:
    pushl $1
.Lpass1_a_155:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_152
    leal ark_str_981, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_153
.Lpass1_a_152:
    pushl $1
.Lpass1_a_153:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_150
    leal ark_str_982, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_151
.Lpass1_a_150:
    pushl $1
.Lpass1_a_151:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_148
    leal ark_str_983, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_149
.Lpass1_a_148:
    pushl $1
.Lpass1_a_149:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_146
    leal ark_str_984, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_147
.Lpass1_a_146:
    pushl $1
.Lpass1_a_147:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_144
    leal ark_str_985, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_145
.Lpass1_a_144:
    pushl $1
.Lpass1_a_145:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_142
    leal ark_str_986, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_143
.Lpass1_a_142:
    pushl $1
.Lpass1_a_143:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_140
    leal -208(%ebp), %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $66
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_160
    leal -208(%ebp), %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $98
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_161
.Lpass1_a_160:
    pushl $1
.Lpass1_a_161:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_158
    leal -208(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $76
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_162
    leal -208(%ebp), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $66
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_163
.Lpass1_a_162:
    pushl $0
.Lpass1_a_163:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_159
.Lpass1_a_158:
    pushl $1
.Lpass1_a_159:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_156
    leal -208(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $83
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_164
    leal -208(%ebp), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $66
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_165
.Lpass1_a_164:
    pushl $0
.Lpass1_a_165:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_157
.Lpass1_a_156:
    pushl $1
.Lpass1_a_157:
    popl %eax
    movl %eax, -136(%ebp)
    leal ark_str_987, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_170
    leal ark_str_988, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_171
.Lpass1_a_170:
    pushl $1
.Lpass1_a_171:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_168
    leal ark_str_989, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_169
.Lpass1_a_168:
    pushl $1
.Lpass1_a_169:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_166
    leal ark_str_990, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_167
.Lpass1_a_166:
    pushl $1
.Lpass1_a_167:
    popl %eax
    movl %eax, -128(%ebp)
    leal -224(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_172
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass1_a_173
.Lpass1_a_172:
.Lpass1_a_173:
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $61
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_174
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    pushl $64
    leal -112(%ebp), %eax
    pushl %eax
    leal -224(%ebp), %eax
    pushl %eax
    call _read_word_a
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    pushl -144(%ebp)
    addl $4, %esp
    pushl -216(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_175
.Lpass1_a_174:
    pushl $0
    popl %eax
    movl %eax, -112(%ebp)
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $91
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_176
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass1_a_177
.Lpass1_a_176:
.Lpass1_a_177:
    leal -224(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_178
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_180
    leal -224(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_181
.Lpass1_a_180:
.Lpass1_a_181:
    jmp .Lpass1_a_179
.Lpass1_a_178:
.Lpass1_a_179:
    pushl -216(%ebp)
    pushl -128(%ebp)
    pushl -136(%ebp)
    pushl -112(%ebp)
    call _ldr_str_size_a
    addl $12, %esp
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
.Lpass1_a_175:
    jmp .Lpass1_a_141
.Lpass1_a_140:
    leal ark_str_991, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_184
    leal ark_str_992, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_185
.Lpass1_a_184:
    pushl $1
.Lpass1_a_185:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_182
    pushl $0
    popl %eax
    movl %eax, -136(%ebp)
    pushl $0
    popl %eax
    movl %eax, -128(%ebp)
    leal -128(%ebp), %eax
    pushl %eax
    leal -136(%ebp), %eax
    pushl %eax
    leal -224(%ebp), %eax
    pushl %eax
    call _parse_reglist_a
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    pushl -128(%ebp)
    addl $4, %esp
    pushl -120(%ebp)
    pushl $7936
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_186
    pushl -216(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_187
.Lpass1_a_186:
    pushl -216(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
.Lpass1_a_187:
    jmp .Lpass1_a_183
.Lpass1_a_182:
    leal ark_str_993, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_190
    leal ark_str_994, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_191
.Lpass1_a_190:
    pushl $1
.Lpass1_a_191:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_188
    leal -224(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_192
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass1_a_193
.Lpass1_a_192:
.Lpass1_a_193:
    leal -224(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_194
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass1_a_195
.Lpass1_a_194:
.Lpass1_a_195:
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_196
    leal -224(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -136(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_200
    pushl -128(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_201
.Lpass1_a_200:
    pushl $0
.Lpass1_a_201:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_198
    pushl -216(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_199
.Lpass1_a_198:
    pushl -136(%ebp)
    pushl -128(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_202
    pushl -216(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_203
.Lpass1_a_202:
    pushl -120(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_208
    pushl -136(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_209
.Lpass1_a_208:
    pushl $0
.Lpass1_a_209:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_206
    pushl -128(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_207
.Lpass1_a_206:
    pushl $0
.Lpass1_a_207:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_204
    pushl -216(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_205
.Lpass1_a_204:
    pushl -216(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
.Lpass1_a_205:
.Lpass1_a_203:
.Lpass1_a_199:
    jmp .Lpass1_a_197
.Lpass1_a_196:
    pushl -216(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
.Lpass1_a_197:
    jmp .Lpass1_a_189
.Lpass1_a_188:
    leal ark_str_995, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_210
    leal -224(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_212
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass1_a_213
.Lpass1_a_212:
.Lpass1_a_213:
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_214
    leal -224(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_218
    pushl -128(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_219
.Lpass1_a_218:
    pushl $0
.Lpass1_a_219:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_216
    pushl -216(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_217
.Lpass1_a_216:
    pushl -216(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
.Lpass1_a_217:
    jmp .Lpass1_a_215
.Lpass1_a_214:
    leal -224(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -216(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
.Lpass1_a_215:
    jmp .Lpass1_a_211
.Lpass1_a_210:
    leal ark_str_996, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_242
    leal ark_str_997, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_243
.Lpass1_a_242:
    pushl $1
.Lpass1_a_243:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_240
    leal ark_str_998, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_241
.Lpass1_a_240:
    pushl $1
.Lpass1_a_241:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_238
    leal ark_str_999, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_239
.Lpass1_a_238:
    pushl $1
.Lpass1_a_239:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_236
    leal ark_str_1000, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_237
.Lpass1_a_236:
    pushl $1
.Lpass1_a_237:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_234
    leal ark_str_1001, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_235
.Lpass1_a_234:
    pushl $1
.Lpass1_a_235:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_232
    leal ark_str_1002, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_233
.Lpass1_a_232:
    pushl $1
.Lpass1_a_233:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_230
    leal ark_str_1003, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_231
.Lpass1_a_230:
    pushl $1
.Lpass1_a_231:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_228
    leal ark_str_1004, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_229
.Lpass1_a_228:
    pushl $1
.Lpass1_a_229:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_226
    leal ark_str_1005, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_227
.Lpass1_a_226:
    pushl $1
.Lpass1_a_227:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_224
    leal ark_str_1006, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_225
.Lpass1_a_224:
    pushl $1
.Lpass1_a_225:
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_222
    leal ark_str_1007, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass1_a_223
.Lpass1_a_222:
    pushl $1
.Lpass1_a_223:
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_220
    leal -224(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_244
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass1_a_245
.Lpass1_a_244:
.Lpass1_a_245:
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_246
    leal -224(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -216(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_247
.Lpass1_a_246:
    leal -224(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -216(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
.Lpass1_a_247:
    jmp .Lpass1_a_221
.Lpass1_a_220:
    pushl -216(%ebp)
    leal -208(%ebp), %eax
    pushl %eax
    call _op_size_a
    addl $4, %esp
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
.Lpass1_a_221:
.Lpass1_a_211:
.Lpass1_a_189:
.Lpass1_a_183:
.Lpass1_a_141:
.Lpass1_a_25:
    leal -224(%ebp), %eax
    pushl %eax
    call _skip_to_eol_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass1_a_248
    pushl -224(%ebp)
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    addl $4, %esp
    jmp .Lpass1_a_249
.Lpass1_a_248:
.Lpass1_a_249:
    jmp .Lpass1_a_0
.Lpass1_a_1:
    pushl -232(%ebp)
    pushl $68
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_reglist_a:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -48(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -40(%ebp)
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl -48(%ebp)
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $123
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_reglist_a_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_reglist_a_0:
.Lparse_reglist_a_1:
    pushl -56(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
.Lparse_reglist_a_2:
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_reglist_a_4
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $125
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reglist_a_5
.Lparse_reglist_a_4:
    pushl $0
.Lparse_reglist_a_5:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reglist_a_3
    pushl -56(%ebp)
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $108
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_reglist_a_8
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $76
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reglist_a_9
.Lparse_reglist_a_8:
    pushl $1
.Lparse_reglist_a_9:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reglist_a_6
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $114
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_reglist_a_12
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $82
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reglist_a_13
.Lparse_reglist_a_12:
    pushl $1
.Lparse_reglist_a_13:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reglist_a_10
    pushl -48(%ebp)
    pushl $1
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_reglist_a_11
.Lparse_reglist_a_10:
    pushl -56(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
.Lparse_reglist_a_11:
    jmp .Lparse_reglist_a_7
.Lparse_reglist_a_6:
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $112
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_reglist_a_16
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $80
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reglist_a_17
.Lparse_reglist_a_16:
    pushl $1
.Lparse_reglist_a_17:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reglist_a_14
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $99
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_reglist_a_20
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $67
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reglist_a_21
.Lparse_reglist_a_20:
    pushl $1
.Lparse_reglist_a_21:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reglist_a_18
    pushl -40(%ebp)
    pushl $1
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_reglist_a_19
.Lparse_reglist_a_18:
    pushl -56(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
.Lparse_reglist_a_19:
    jmp .Lparse_reglist_a_15
.Lparse_reglist_a_14:
    pushl -56(%ebp)
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_reglist_a_22
    pushl -32(%ebp)
    pushl $1
    pushl -24(%ebp)
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lparse_reglist_a_23
.Lparse_reglist_a_22:
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_reglist_a_30
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $125
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reglist_a_31
.Lparse_reglist_a_30:
    pushl $0
.Lparse_reglist_a_31:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reglist_a_28
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reglist_a_29
.Lparse_reglist_a_28:
    pushl $0
.Lparse_reglist_a_29:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reglist_a_26
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_reglist_a_27
.Lparse_reglist_a_26:
    pushl $0
.Lparse_reglist_a_27:
    popl %eax
    cmpl $0, %eax
    je .Lparse_reglist_a_24
    pushl -56(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    jmp .Lparse_reglist_a_25
.Lparse_reglist_a_24:
.Lparse_reglist_a_25:
.Lparse_reglist_a_23:
.Lparse_reglist_a_15:
.Lparse_reglist_a_7:
    pushl -56(%ebp)
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_reglist_a_32
    pushl -56(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    jmp .Lparse_reglist_a_33
.Lparse_reglist_a_32:
.Lparse_reglist_a_33:
    jmp .Lparse_reglist_a_2
.Lparse_reglist_a_3:
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $125
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_reglist_a_34
    pushl -56(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    jmp .Lparse_reglist_a_35
.Lparse_reglist_a_34:
.Lparse_reglist_a_35:
    pushl -32(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_bl_a:
    pushl %ebp
    movl %esp, %ebp
    subl $368, %esp
    movl 8(%ebp), %eax
    movl %eax, -120(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    pushl $23
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -96(%ebp)
    pushl $22
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    pushl -96(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    pushl -96(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1023
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -96(%ebp)
    pushl $2047
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -80(%ebp)
    pushl -88(%ebp)
    popl %ecx
    popl %eax
    xorl %ecx, %eax
    pushl %eax
    popl %eax
    notl %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -72(%ebp)
    pushl -88(%ebp)
    popl %ecx
    popl %eax
    xorl %ecx, %eax
    pushl %eax
    popl %eax
    notl %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl $61440
    pushl -88(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -64(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl $53248
    pushl -48(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -32(%ebp)
    pushl -120(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    pushl -120(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_b_w_a:
    pushl %ebp
    movl %esp, %ebp
    subl $368, %esp
    movl 8(%ebp), %eax
    movl %eax, -120(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    pushl $23
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -96(%ebp)
    pushl $22
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    pushl -96(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    pushl -96(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1023
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -96(%ebp)
    pushl $2047
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -80(%ebp)
    pushl -88(%ebp)
    popl %ecx
    popl %eax
    xorl %ecx, %eax
    pushl %eax
    popl %eax
    notl %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -72(%ebp)
    pushl -88(%ebp)
    popl %ecx
    popl %eax
    xorl %ecx, %eax
    pushl %eax
    popl %eax
    notl %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl $61440
    pushl -88(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -64(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl $36864
    pushl -48(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -32(%ebp)
    pushl -120(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    pushl -120(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_bcond_w_a:
    pushl %ebp
    movl %esp, %ebp
    subl $368, %esp
    movl 8(%ebp), %eax
    movl %eax, -120(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -112(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    pushl $19
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    pushl -88(%ebp)
    pushl $18
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    pushl -88(%ebp)
    pushl $17
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -88(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $63
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -88(%ebp)
    pushl $2047
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -72(%ebp)
    popl %eax
    movl %eax, -40(%ebp)
    pushl -64(%ebp)
    popl %eax
    movl %eax, -32(%ebp)
    pushl $61440
    pushl -80(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -112(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl $32768
    pushl -40(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -24(%ebp)
    pushl -120(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -16(%ebp)
    pushl -120(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_read_label_name_a:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -40(%ebp)
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lread_label_name_a_0:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_label_name_a_12
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_label_name_a_13
.Lread_label_name_a_12:
    pushl $0
.Lread_label_name_a_13:
    popl %eax
    cmpl $0, %eax
    je .Lread_label_name_a_10
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_label_name_a_11
.Lread_label_name_a_10:
    pushl $0
.Lread_label_name_a_11:
    popl %eax
    cmpl $0, %eax
    je .Lread_label_name_a_8
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_label_name_a_9
.Lread_label_name_a_8:
    pushl $0
.Lread_label_name_a_9:
    popl %eax
    cmpl $0, %eax
    je .Lread_label_name_a_6
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $59
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_label_name_a_7
.Lread_label_name_a_6:
    pushl $0
.Lread_label_name_a_7:
    popl %eax
    cmpl $0, %eax
    je .Lread_label_name_a_4
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_label_name_a_5
.Lread_label_name_a_4:
    pushl $0
.Lread_label_name_a_5:
    popl %eax
    cmpl $0, %eax
    je .Lread_label_name_a_2
    pushl -16(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_label_name_a_3
.Lread_label_name_a_2:
    pushl $0
.Lread_label_name_a_3:
    popl %eax
    cmpl $0, %eax
    je .Lread_label_name_a_1
    pushl -32(%ebp)
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    jmp .Lread_label_name_a_0
.Lread_label_name_a_1:
    pushl -32(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_pass2_a:
    pushl %ebp
    movl %esp, %ebp
    subl $528, %esp
    movl 8(%ebp), %eax
    movl %eax, -280(%ebp)
    pushl -280(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -280(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lpass2_a_0:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_1
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_2
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_0
.Lpass2_a_2:
.Lpass2_a_3:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $59
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_4
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_to_eol_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_0
.Lpass2_a_4:
.Lpass2_a_5:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_6
    jmp .Lpass2_a_1
.Lpass2_a_6:
.Lpass2_a_7:
    pushl $64
    leal -264(%ebp), %eax
    pushl %eax
    leal -272(%ebp), %eax
    pushl %eax
    call _read_word_a
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -200(%ebp)
    pushl -200(%ebp)
    addl $4, %esp
    pushl -200(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_8
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_to_eol_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_0
.Lpass2_a_8:
.Lpass2_a_9:
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $58
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_10
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_16
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $59
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_17
.Lpass2_a_16:
    pushl $1
.Lpass2_a_17:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_14
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_15
.Lpass2_a_14:
    pushl $1
.Lpass2_a_15:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_12
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $59
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_18
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_to_eol_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_19
.Lpass2_a_18:
.Lpass2_a_19:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_20
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_21
.Lpass2_a_20:
.Lpass2_a_21:
    jmp .Lpass2_a_0
.Lpass2_a_12:
.Lpass2_a_13:
    pushl $64
    leal -264(%ebp), %eax
    pushl %eax
    leal -272(%ebp), %eax
    pushl %eax
    call _read_word_a
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -200(%ebp)
    pushl -200(%ebp)
    addl $4, %esp
    pushl -200(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_22
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_to_eol_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_0
.Lpass2_a_22:
.Lpass2_a_23:
    jmp .Lpass2_a_11
.Lpass2_a_10:
.Lpass2_a_11:
    leal -264(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_24
    leal ark_str_1008, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_28
    leal ark_str_1009, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_29
.Lpass2_a_28:
    pushl $1
.Lpass2_a_29:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_26
    jmp .Lpass2_a_27
.Lpass2_a_26:
    leal ark_str_1010, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_34
    leal ark_str_1011, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_35
.Lpass2_a_34:
    pushl $1
.Lpass2_a_35:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_32
    leal ark_str_1012, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_33
.Lpass2_a_32:
    pushl $1
.Lpass2_a_33:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_30
    pushl $0
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_36
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_37
.Lpass2_a_36:
.Lpass2_a_37:
.Lpass2_a_38:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_40
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_41
.Lpass2_a_40:
    pushl $0
.Lpass2_a_41:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_39
    pushl -192(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_38
.Lpass2_a_39:
.Lpass2_a_42:
    pushl -192(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_44
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_45
.Lpass2_a_44:
    pushl $0
.Lpass2_a_45:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_43
    pushl -280(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -192(%ebp)
    pushl -192(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_42
.Lpass2_a_43:
    jmp .Lpass2_a_31
.Lpass2_a_30:
    leal ark_str_1013, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_48
    leal ark_str_1014, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_49
.Lpass2_a_48:
    pushl $1
.Lpass2_a_49:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_46
.Lpass2_a_50:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_52
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_53
.Lpass2_a_52:
    pushl $0
.Lpass2_a_53:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_51
    pushl $0
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_56
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $120
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_58
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $88
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_59
.Lpass2_a_58:
    pushl $1
.Lpass2_a_59:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_57
.Lpass2_a_56:
    pushl $0
.Lpass2_a_57:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_54
    pushl -272(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    pushl -272(%ebp)
    addl $4, %esp
.Lpass2_a_60:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_66
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_67
.Lpass2_a_66:
    pushl $0
.Lpass2_a_67:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_64
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_68
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_69
.Lpass2_a_68:
    pushl $0
.Lpass2_a_69:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_65
.Lpass2_a_64:
    pushl $1
.Lpass2_a_65:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_62
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_70
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $70
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_71
.Lpass2_a_70:
    pushl $0
.Lpass2_a_71:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_63
.Lpass2_a_62:
    pushl $1
.Lpass2_a_63:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_61
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -184(%ebp)
    movzbl -184(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_74
    movzbl -184(%ebp), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_75
.Lpass2_a_74:
    pushl $0
.Lpass2_a_75:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_72
    movzbl -184(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lpass2_a_73
.Lpass2_a_72:
    movzbl -184(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_78
    movzbl -184(%ebp), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_79
.Lpass2_a_78:
    pushl $0
.Lpass2_a_79:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_76
    movzbl -184(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    jmp .Lpass2_a_77
.Lpass2_a_76:
    movzbl -184(%ebp), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
.Lpass2_a_77:
.Lpass2_a_73:
    popl %eax
    movl %eax, -176(%ebp)
    pushl -192(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_60
.Lpass2_a_61:
    jmp .Lpass2_a_55
.Lpass2_a_54:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $45
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_80
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
.Lpass2_a_82:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_84
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_85
.Lpass2_a_84:
    pushl $0
.Lpass2_a_85:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_83
    pushl -192(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_82
.Lpass2_a_83:
    pushl -192(%ebp)
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_81
.Lpass2_a_80:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_88
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_89
.Lpass2_a_88:
    pushl $0
.Lpass2_a_89:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_86
.Lpass2_a_90:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_92
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_93
.Lpass2_a_92:
    pushl $0
.Lpass2_a_93:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_91
    pushl -192(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_90
.Lpass2_a_91:
    jmp .Lpass2_a_87
.Lpass2_a_86:
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
.Lpass2_a_94:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_104
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_105
.Lpass2_a_104:
    pushl $0
.Lpass2_a_105:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_102
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_103
.Lpass2_a_102:
    pushl $0
.Lpass2_a_103:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_100
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_101
.Lpass2_a_100:
    pushl $0
.Lpass2_a_101:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_98
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_99
.Lpass2_a_98:
    pushl $0
.Lpass2_a_99:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_96
    pushl -56(%ebp)
    pushl $127
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_97
.Lpass2_a_96:
    pushl $0
.Lpass2_a_97:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_95
    leal -184(%ebp), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl -56(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lpass2_a_94
.Lpass2_a_95:
    leal -184(%ebp), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_106
    leal -184(%ebp), %eax
    pushl %eax
    pushl -280(%ebp)
    call _find_label_a
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_108
    leal -184(%ebp), %eax
    pushl %eax
    pushl -280(%ebp)
    call _find_set_a
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_109
.Lpass2_a_108:
.Lpass2_a_109:
    pushl -48(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_110
    pushl -48(%ebp)
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_111
.Lpass2_a_110:
    pushl $4
    leal -184(%ebp), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    call _add_ref_a
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_111:
    jmp .Lpass2_a_107
.Lpass2_a_106:
.Lpass2_a_107:
.Lpass2_a_87:
.Lpass2_a_81:
.Lpass2_a_55:
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_112
    pushl -280(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -280(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -280(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -280(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lpass2_a_113
.Lpass2_a_112:
.Lpass2_a_113:
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_114
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_115
.Lpass2_a_114:
.Lpass2_a_115:
    jmp .Lpass2_a_50
.Lpass2_a_51:
    jmp .Lpass2_a_47
.Lpass2_a_46:
    leal ark_str_1015, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_116
.Lpass2_a_118:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_120
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_121
.Lpass2_a_120:
    pushl $0
.Lpass2_a_121:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_119
    pushl $0
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_124
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $120
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_126
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $88
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_127
.Lpass2_a_126:
    pushl $1
.Lpass2_a_127:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_125
.Lpass2_a_124:
    pushl $0
.Lpass2_a_125:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_122
    pushl -272(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    pushl -272(%ebp)
    addl $4, %esp
.Lpass2_a_128:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_134
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_135
.Lpass2_a_134:
    pushl $0
.Lpass2_a_135:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_132
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_136
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_137
.Lpass2_a_136:
    pushl $0
.Lpass2_a_137:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_133
.Lpass2_a_132:
    pushl $1
.Lpass2_a_133:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_130
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_138
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $70
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_139
.Lpass2_a_138:
    pushl $0
.Lpass2_a_139:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_131
.Lpass2_a_130:
    pushl $1
.Lpass2_a_131:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_129
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -184(%ebp)
    movzbl -184(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_142
    movzbl -184(%ebp), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_143
.Lpass2_a_142:
    pushl $0
.Lpass2_a_143:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_140
    movzbl -184(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lpass2_a_141
.Lpass2_a_140:
    movzbl -184(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_146
    movzbl -184(%ebp), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_147
.Lpass2_a_146:
    pushl $0
.Lpass2_a_147:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_144
    movzbl -184(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    jmp .Lpass2_a_145
.Lpass2_a_144:
    movzbl -184(%ebp), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
.Lpass2_a_145:
.Lpass2_a_141:
    popl %eax
    movl %eax, -176(%ebp)
    pushl -192(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_128
.Lpass2_a_129:
    jmp .Lpass2_a_123
.Lpass2_a_122:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $39
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_148
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $39
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_150
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_151
.Lpass2_a_150:
.Lpass2_a_151:
    jmp .Lpass2_a_149
.Lpass2_a_148:
.Lpass2_a_152:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_154
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_155
.Lpass2_a_154:
    pushl $0
.Lpass2_a_155:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_153
    pushl -192(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_152
.Lpass2_a_153:
.Lpass2_a_149:
.Lpass2_a_123:
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_156
    pushl -280(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lpass2_a_157
.Lpass2_a_156:
.Lpass2_a_157:
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_158
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_159
.Lpass2_a_158:
.Lpass2_a_159:
    jmp .Lpass2_a_118
.Lpass2_a_119:
    jmp .Lpass2_a_117
.Lpass2_a_116:
    leal ark_str_1016, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_162
    leal ark_str_1017, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_163
.Lpass2_a_162:
    pushl $1
.Lpass2_a_163:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_160
    leal ark_str_1018, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_164
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
.Lpass2_a_166:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_170
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_171
.Lpass2_a_170:
    pushl $0
.Lpass2_a_171:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_168
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_169
.Lpass2_a_168:
    pushl $0
.Lpass2_a_169:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_167
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_172
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    pushl $110
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_175
    pushl -176(%ebp)
    pushl $116
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_176
    pushl -176(%ebp)
    pushl $114
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_177
    pushl -176(%ebp)
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_178
    pushl -176(%ebp)
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_179
    pushl -176(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_180
    pushl -176(%ebp)
    pushl $120
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_181
    jmp .Lpass2_a_182
.Lpass2_a_175:
    pushl $10
    popl %eax
    movb %al, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_174
.Lpass2_a_176:
    pushl $9
    popl %eax
    movb %al, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_174
.Lpass2_a_177:
    pushl $13
    popl %eax
    movb %al, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_174
.Lpass2_a_178:
    pushl $92
    popl %eax
    movb %al, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_174
.Lpass2_a_179:
    pushl $34
    popl %eax
    movb %al, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_174
.Lpass2_a_180:
    pushl $0
    popl %eax
    movb %al, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_174
.Lpass2_a_181:
    pushl $0
    popl %eax
    movl %eax, -168(%ebp)
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_185
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_191
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_192
.Lpass2_a_191:
    pushl $0
.Lpass2_a_192:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_189
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_193
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_194
.Lpass2_a_193:
    pushl $0
.Lpass2_a_194:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_190
.Lpass2_a_189:
    pushl $1
.Lpass2_a_190:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_187
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_195
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $70
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_196
.Lpass2_a_195:
    pushl $0
.Lpass2_a_196:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_188
.Lpass2_a_187:
    pushl $1
.Lpass2_a_188:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_186
.Lpass2_a_185:
    pushl $0
.Lpass2_a_186:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_183
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -160(%ebp)
    movzbl -160(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_199
    movzbl -160(%ebp), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_200
.Lpass2_a_199:
    pushl $0
.Lpass2_a_200:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_197
    movzbl -160(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lpass2_a_198
.Lpass2_a_197:
    movzbl -160(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_203
    movzbl -160(%ebp), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_204
.Lpass2_a_203:
    pushl $0
.Lpass2_a_204:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_201
    movzbl -160(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    jmp .Lpass2_a_202
.Lpass2_a_201:
    movzbl -160(%ebp), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
.Lpass2_a_202:
.Lpass2_a_198:
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_207
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_213
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_214
.Lpass2_a_213:
    pushl $0
.Lpass2_a_214:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_211
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_215
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_216
.Lpass2_a_215:
    pushl $0
.Lpass2_a_216:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_212
.Lpass2_a_211:
    pushl $1
.Lpass2_a_212:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_209
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_217
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $70
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_218
.Lpass2_a_217:
    pushl $0
.Lpass2_a_218:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_210
.Lpass2_a_209:
    pushl $1
.Lpass2_a_210:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_208
.Lpass2_a_207:
    pushl $0
.Lpass2_a_208:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_205
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    pushl -168(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    movzbl -160(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_221
    movzbl -160(%ebp), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_222
.Lpass2_a_221:
    pushl $0
.Lpass2_a_222:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_219
    movzbl -160(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lpass2_a_220
.Lpass2_a_219:
    movzbl -160(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_225
    movzbl -160(%ebp), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_226
.Lpass2_a_225:
    pushl $0
.Lpass2_a_226:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_223
    movzbl -160(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    jmp .Lpass2_a_224
.Lpass2_a_223:
    movzbl -160(%ebp), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
.Lpass2_a_224:
.Lpass2_a_220:
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_206
.Lpass2_a_205:
.Lpass2_a_206:
    jmp .Lpass2_a_184
.Lpass2_a_183:
.Lpass2_a_184:
    pushl -168(%ebp)
    popl %eax
    movb %al, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_174
.Lpass2_a_182:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_174
.Lpass2_a_174:
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_173
.Lpass2_a_172:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
.Lpass2_a_173:
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_227
    pushl -280(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movzbl -184(%ebp), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lpass2_a_228
.Lpass2_a_227:
.Lpass2_a_228:
    jmp .Lpass2_a_166
.Lpass2_a_167:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_229
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_230
.Lpass2_a_229:
.Lpass2_a_230:
    jmp .Lpass2_a_165
.Lpass2_a_164:
.Lpass2_a_165:
    pushl -192(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_231
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_233
    pushl -280(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lpass2_a_234
.Lpass2_a_233:
.Lpass2_a_234:
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_235
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_237
    pushl -280(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lpass2_a_238
.Lpass2_a_237:
.Lpass2_a_238:
    jmp .Lpass2_a_236
.Lpass2_a_235:
.Lpass2_a_236:
    jmp .Lpass2_a_232
.Lpass2_a_231:
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_239
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_241
    pushl -280(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lpass2_a_242
.Lpass2_a_241:
.Lpass2_a_242:
    jmp .Lpass2_a_240
.Lpass2_a_239:
.Lpass2_a_240:
.Lpass2_a_232:
    jmp .Lpass2_a_161
.Lpass2_a_160:
    leal ark_str_1019, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_245
    leal ark_str_1020, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_246
.Lpass2_a_245:
    pushl $1
.Lpass2_a_246:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_243
    pushl $0
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_247
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_248
.Lpass2_a_247:
.Lpass2_a_248:
.Lpass2_a_249:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_251
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_252
.Lpass2_a_251:
    pushl $0
.Lpass2_a_252:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_250
    pushl -192(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_249
.Lpass2_a_250:
    pushl -192(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_253
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -192(%ebp)
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %edx
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_255
    pushl -192(%ebp)
    pushl -184(%ebp)
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
.Lpass2_a_257:
    pushl -176(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_259
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_260
.Lpass2_a_259:
    pushl $0
.Lpass2_a_260:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_258
    pushl -280(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -176(%ebp)
    pushl -176(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_257
.Lpass2_a_258:
    jmp .Lpass2_a_256
.Lpass2_a_255:
.Lpass2_a_256:
    jmp .Lpass2_a_254
.Lpass2_a_253:
.Lpass2_a_254:
    jmp .Lpass2_a_244
.Lpass2_a_243:
.Lpass2_a_244:
.Lpass2_a_161:
.Lpass2_a_117:
.Lpass2_a_47:
.Lpass2_a_31:
.Lpass2_a_27:
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_to_eol_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_261
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_262
.Lpass2_a_261:
.Lpass2_a_262:
    jmp .Lpass2_a_0
.Lpass2_a_24:
.Lpass2_a_25:
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_1021, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_263
    pushl $0
    popl %eax
    movl %eax, -192(%ebp)
    pushl $0
    popl %eax
    movl %eax, -184(%ebp)
    leal -184(%ebp), %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reglist_a
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -176(%ebp)
    pushl $7936
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_265
    pushl -192(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_267
    pushl $16384
    jmp .Lpass2_a_268
.Lpass2_a_267:
    pushl $0
.Lpass2_a_268:
    pushl -176(%ebp)
    pushl $8191
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $59693
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_266
.Lpass2_a_265:
    pushl $46080
    pushl -192(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_269
    pushl $256
    jmp .Lpass2_a_270
.Lpass2_a_269:
    pushl $0
.Lpass2_a_270:
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_266:
    jmp .Lpass2_a_264
.Lpass2_a_263:
    leal ark_str_1022, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_271
    pushl $0
    popl %eax
    movl %eax, -192(%ebp)
    pushl $0
    popl %eax
    movl %eax, -184(%ebp)
    leal -184(%ebp), %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reglist_a
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    pushl -176(%ebp)
    pushl $7936
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_273
    pushl -184(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_275
    pushl $32768
    jmp .Lpass2_a_276
.Lpass2_a_275:
    pushl $0
.Lpass2_a_276:
    pushl -176(%ebp)
    pushl $8191
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $59581
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_274
.Lpass2_a_273:
    pushl $48128
    pushl -184(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_277
    pushl $256
    jmp .Lpass2_a_278
.Lpass2_a_277:
    pushl $0
.Lpass2_a_278:
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_274:
    jmp .Lpass2_a_272
.Lpass2_a_271:
    leal ark_str_1023, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_279
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_281
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl $8192
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_282
.Lpass2_a_281:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl $17920
    pushl -192(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $7
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_282:
    jmp .Lpass2_a_280
.Lpass2_a_279:
    leal ark_str_1024, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_305
    leal ark_str_1025, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_306
.Lpass2_a_305:
    pushl $1
.Lpass2_a_306:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_303
    leal ark_str_1026, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_304
.Lpass2_a_303:
    pushl $1
.Lpass2_a_304:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_301
    leal ark_str_1027, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_302
.Lpass2_a_301:
    pushl $1
.Lpass2_a_302:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_299
    leal ark_str_1028, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_300
.Lpass2_a_299:
    pushl $1
.Lpass2_a_300:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_297
    leal ark_str_1029, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_298
.Lpass2_a_297:
    pushl $1
.Lpass2_a_298:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_295
    leal ark_str_1030, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_296
.Lpass2_a_295:
    pushl $1
.Lpass2_a_296:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_293
    leal ark_str_1031, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_294
.Lpass2_a_293:
    pushl $1
.Lpass2_a_294:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_291
    leal ark_str_1032, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_292
.Lpass2_a_291:
    pushl $1
.Lpass2_a_292:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_289
    leal ark_str_1033, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_290
.Lpass2_a_289:
    pushl $1
.Lpass2_a_290:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_287
    leal ark_str_1034, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_288
.Lpass2_a_287:
    pushl $1
.Lpass2_a_288:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_285
    leal ark_str_1035, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_286
.Lpass2_a_285:
    pushl $1
.Lpass2_a_286:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_283
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_307
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl $61519
    popl %eax
    movl %eax, -176(%ebp)
    pushl -192(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -176(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_308
.Lpass2_a_307:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl $17920
    pushl -192(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $7
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_308:
    jmp .Lpass2_a_284
.Lpass2_a_283:
    leal ark_str_1036, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_309
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    pushl $65535
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -184(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -184(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -184(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -184(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl $62016
    pushl -176(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -168(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -160(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -152(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -144(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_310
.Lpass2_a_309:
    leal ark_str_1037, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_311
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    pushl $65535
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -184(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -184(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -184(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -184(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl $62144
    pushl -176(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -168(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -160(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -152(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -144(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_312
.Lpass2_a_311:
    leal ark_str_1038, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_313
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_315
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -192(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_319
    pushl -184(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_320
.Lpass2_a_319:
    pushl $0
.Lpass2_a_320:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_317
    pushl $45056
    pushl -176(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %eax
    pushl $127
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_318
.Lpass2_a_317:
    pushl -192(%ebp)
    pushl -184(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_321
    pushl $12288
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_322
.Lpass2_a_321:
    pushl -176(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_327
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_328
.Lpass2_a_327:
    pushl $0
.Lpass2_a_328:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_325
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_326
.Lpass2_a_325:
    pushl $0
.Lpass2_a_326:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_323
    pushl $7168
    pushl -176(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_324
.Lpass2_a_323:
    pushl -176(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -176(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -176(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl $61696
    pushl -168(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -160(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -152(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_324:
.Lpass2_a_322:
.Lpass2_a_318:
    jmp .Lpass2_a_316
.Lpass2_a_315:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl $6144
    pushl -176(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_316:
    jmp .Lpass2_a_314
.Lpass2_a_313:
    leal ark_str_1039, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_329
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_331
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -192(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_335
    pushl -184(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_336
.Lpass2_a_335:
    pushl $0
.Lpass2_a_336:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_333
    pushl $45184
    pushl -176(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %eax
    pushl $127
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_334
.Lpass2_a_333:
    pushl -192(%ebp)
    pushl -184(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_337
    pushl $14336
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_338
.Lpass2_a_337:
    pushl -176(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_343
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_344
.Lpass2_a_343:
    pushl $0
.Lpass2_a_344:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_341
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_342
.Lpass2_a_341:
    pushl $0
.Lpass2_a_342:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_339
    pushl $7680
    pushl -176(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_340
.Lpass2_a_339:
    pushl -176(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -176(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -176(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl $61792
    pushl -168(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -160(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -152(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_340:
.Lpass2_a_338:
.Lpass2_a_334:
    jmp .Lpass2_a_332
.Lpass2_a_331:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl $6656
    pushl -176(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_332:
    jmp .Lpass2_a_330
.Lpass2_a_329:
    leal ark_str_1040, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_345
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl $17216
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_346
.Lpass2_a_345:
    leal ark_str_1041, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_347
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl $16704
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_348
.Lpass2_a_347:
    leal ark_str_1042, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_349
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl $16768
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_350
.Lpass2_a_349:
    leal ark_str_1043, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_351
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    pushl $64416
    pushl -176(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -192(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -168(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_352
.Lpass2_a_351:
    leal ark_str_1044, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_355
    leal ark_str_1045, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_356
.Lpass2_a_355:
    pushl $1
.Lpass2_a_356:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_353
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    leal ark_str_1046, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_357
    pushl $64400
    jmp .Lpass2_a_358
.Lpass2_a_357:
    pushl $64432
.Lpass2_a_358:
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    pushl -184(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $61680
    pushl -192(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_354
.Lpass2_a_353:
    leal ark_str_1047, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_359
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl $16384
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_360
.Lpass2_a_359:
    leal ark_str_1048, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_361
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl $17152
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_362
.Lpass2_a_361:
    leal ark_str_1049, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_363
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl $16448
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_364
.Lpass2_a_363:
    leal ark_str_1050, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_365
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_367
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_369
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    pushl $31
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_370
.Lpass2_a_369:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl $16512
    pushl -176(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_370:
    jmp .Lpass2_a_368
.Lpass2_a_367:
    pushl $16512
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_368:
    jmp .Lpass2_a_366
.Lpass2_a_365:
    leal ark_str_1051, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_371
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_373
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_375
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_377
    pushl $0
    jmp .Lpass2_a_378
.Lpass2_a_377:
    pushl -176(%ebp)
    pushl $31
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
.Lpass2_a_378:
    popl %eax
    movl %eax, -168(%ebp)
    pushl $2048
    pushl -168(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_376
.Lpass2_a_375:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl $16576
    pushl -176(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_376:
    jmp .Lpass2_a_374
.Lpass2_a_373:
    pushl $16576
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_374:
    jmp .Lpass2_a_372
.Lpass2_a_371:
    leal ark_str_1052, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_379
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_381
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_383
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_385
    pushl $0
    jmp .Lpass2_a_386
.Lpass2_a_385:
    pushl -176(%ebp)
    pushl $31
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
.Lpass2_a_386:
    popl %eax
    movl %eax, -168(%ebp)
    pushl $4096
    pushl -168(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_384
.Lpass2_a_383:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl $16640
    pushl -176(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_384:
    jmp .Lpass2_a_382
.Lpass2_a_381:
    pushl $16640
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_382:
    jmp .Lpass2_a_380
.Lpass2_a_379:
    leal ark_str_1053, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_387
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_389
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_390
.Lpass2_a_389:
.Lpass2_a_390:
    pushl $17280
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_388
.Lpass2_a_387:
    leal ark_str_1054, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_391
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl $17344
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_392
.Lpass2_a_391:
    leal ark_str_1055, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_395
    leal ark_str_1056, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_396
.Lpass2_a_395:
    pushl $1
.Lpass2_a_396:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_393
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl $16960
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_397
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_399
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_400
.Lpass2_a_399:
.Lpass2_a_400:
    jmp .Lpass2_a_398
.Lpass2_a_397:
.Lpass2_a_398:
    jmp .Lpass2_a_394
.Lpass2_a_393:
    leal ark_str_1057, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_401
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_403
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_407
    pushl -184(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_408
.Lpass2_a_407:
    pushl $0
.Lpass2_a_408:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_405
    pushl $10240
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_406
.Lpass2_a_405:
    pushl $61872
    pushl -192(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl $3840
    pushl -184(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -176(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_406:
    jmp .Lpass2_a_404
.Lpass2_a_403:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl $17024
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_404:
    jmp .Lpass2_a_402
.Lpass2_a_401:
    leal ark_str_1058, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_415
    leal ark_str_1059, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_416
.Lpass2_a_415:
    pushl $1
.Lpass2_a_416:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_413
    leal ark_str_1060, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_414
.Lpass2_a_413:
    pushl $1
.Lpass2_a_414:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_411
    leal ark_str_1061, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_412
.Lpass2_a_411:
    pushl $1
.Lpass2_a_412:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_409
    leal -264(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $76
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_417
    leal -264(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $108
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_418
.Lpass2_a_417:
    pushl $1
.Lpass2_a_418:
    popl %eax
    movl %eax, -192(%ebp)
    leal -264(%ebp), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $66
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_423
    leal -264(%ebp), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $98
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_424
.Lpass2_a_423:
    pushl $1
.Lpass2_a_424:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_421
    leal -264(%ebp), %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $66
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_422
.Lpass2_a_421:
    pushl $1
.Lpass2_a_422:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_419
    leal -264(%ebp), %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $98
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_420
.Lpass2_a_419:
    pushl $1
.Lpass2_a_420:
    popl %eax
    movl %eax, -184(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl $0
    popl %eax
    movl %eax, -160(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $61
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_425
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    pushl $64
    leal -152(%ebp), %eax
    pushl %eax
    leal -272(%ebp), %eax
    pushl %eax
    call _read_word_a
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
    pushl -80(%ebp)
    addl $4, %esp
    leal -152(%ebp), %eax
    pushl %eax
    pushl -280(%ebp)
    call _find_set_a
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    pushl -88(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_427
    jmp .Lpass2_a_428
.Lpass2_a_427:
    leal -152(%ebp), %eax
    pushl %eax
    pushl -280(%ebp)
    call _find_label_a
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    pushl -88(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_429
    leal -152(%ebp), %eax
    pushl %eax
    leal ark_str_1062, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -280(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_430
.Lpass2_a_429:
    pushl $134217728
    pushl -88(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
.Lpass2_a_430:
.Lpass2_a_428:
    pushl -88(%ebp)
    pushl $65535
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    pushl $11
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -72(%ebp)
    pushl $12
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -72(%ebp)
    pushl $8
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -72(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl $62016
    pushl -64(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -48(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl -176(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -32(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $65535
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    pushl $11
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -72(%ebp)
    pushl $12
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -72(%ebp)
    pushl $8
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -72(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl $62144
    pushl -64(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -48(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl -176(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -32(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_to_eol_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_431
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_432
.Lpass2_a_431:
.Lpass2_a_432:
    jmp .Lpass2_a_0
.Lpass2_a_425:
.Lpass2_a_426:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $91
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_433
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_434
.Lpass2_a_433:
.Lpass2_a_434:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_435
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_437
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_438
.Lpass2_a_437:
.Lpass2_a_438:
    jmp .Lpass2_a_436
.Lpass2_a_435:
.Lpass2_a_436:
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $93
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_439
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_440
.Lpass2_a_439:
.Lpass2_a_440:
    pushl $0
    pushl -184(%ebp)
    pushl -160(%ebp)
    call _ldr_str_size_a
    addl $12, %esp
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_441
    pushl -160(%ebp)
    pushl $4095
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -192(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_445
    pushl -184(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_446
.Lpass2_a_445:
    pushl $0
.Lpass2_a_446:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_443
    pushl $63696
    pushl -168(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_444
.Lpass2_a_443:
    pushl -192(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_449
    pushl -184(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_450
.Lpass2_a_449:
    pushl $0
.Lpass2_a_450:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_447
    pushl $63632
    pushl -168(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_448
.Lpass2_a_447:
    pushl -192(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_453
    pushl -184(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_454
.Lpass2_a_453:
    pushl $0
.Lpass2_a_454:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_451
    pushl $63680
    pushl -168(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_452
.Lpass2_a_451:
    pushl $63616
    pushl -168(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
.Lpass2_a_452:
.Lpass2_a_448:
.Lpass2_a_444:
    pushl -176(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    pushl -152(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_442
.Lpass2_a_441:
    pushl -184(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_455
    pushl -160(%ebp)
    pushl $31
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_456
.Lpass2_a_455:
    pushl -160(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $31
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
.Lpass2_a_456:
    pushl -192(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_457
    pushl -184(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_459
    pushl $30720
    pushl -152(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -168(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_460
.Lpass2_a_459:
    pushl $26624
    pushl -152(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -168(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_460:
    jmp .Lpass2_a_458
.Lpass2_a_457:
    pushl -184(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_461
    pushl $28672
    pushl -152(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -168(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_462
.Lpass2_a_461:
    pushl $24576
    pushl -152(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -168(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_462:
.Lpass2_a_458:
.Lpass2_a_442:
    jmp .Lpass2_a_410
.Lpass2_a_409:
    leal ark_str_1063, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_463
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    pushl $18176
    pushl -192(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_464
.Lpass2_a_463:
    leal ark_str_1064, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_465
    pushl $48896
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_466
.Lpass2_a_465:
    leal ark_str_1065, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_473
    leal ark_str_1066, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_474
.Lpass2_a_473:
    pushl $1
.Lpass2_a_474:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_471
    leal ark_str_1067, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_472
.Lpass2_a_471:
    pushl $1
.Lpass2_a_472:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_469
    leal ark_str_1068, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_470
.Lpass2_a_469:
    pushl $1
.Lpass2_a_470:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_467
    pushl $14
    popl %eax
    movl %eax, -184(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    leal -192(%ebp), %eax
    pushl %eax
    leal -272(%ebp), %eax
    pushl %eax
    call _read_word_a
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_1069, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_475
    pushl $0
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_476
.Lpass2_a_475:
    leal ark_str_1070, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_477
    pushl $1
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_478
.Lpass2_a_477:
    leal ark_str_1071, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_481
    leal ark_str_1072, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_482
.Lpass2_a_481:
    pushl $1
.Lpass2_a_482:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_479
    pushl $2
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_480
.Lpass2_a_479:
    leal ark_str_1073, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_485
    leal ark_str_1074, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_486
.Lpass2_a_485:
    pushl $1
.Lpass2_a_486:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_483
    pushl $3
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_484
.Lpass2_a_483:
    leal ark_str_1075, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_487
    pushl $4
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_488
.Lpass2_a_487:
    leal ark_str_1076, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_489
    pushl $5
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_490
.Lpass2_a_489:
    leal ark_str_1077, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_491
    pushl $6
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_492
.Lpass2_a_491:
    leal ark_str_1078, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_493
    pushl $7
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_494
.Lpass2_a_493:
    leal ark_str_1079, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_495
    pushl $8
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_496
.Lpass2_a_495:
    leal ark_str_1080, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_497
    pushl $9
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_498
.Lpass2_a_497:
    leal ark_str_1081, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_499
    pushl $10
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_500
.Lpass2_a_499:
    leal ark_str_1082, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_501
    pushl $11
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_502
.Lpass2_a_501:
    leal ark_str_1083, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_503
    pushl $12
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_504
.Lpass2_a_503:
    leal ark_str_1084, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_505
    pushl $13
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_506
.Lpass2_a_505:
.Lpass2_a_506:
.Lpass2_a_504:
.Lpass2_a_502:
.Lpass2_a_500:
.Lpass2_a_498:
.Lpass2_a_496:
.Lpass2_a_494:
.Lpass2_a_492:
.Lpass2_a_490:
.Lpass2_a_488:
.Lpass2_a_484:
.Lpass2_a_480:
.Lpass2_a_478:
.Lpass2_a_476:
    pushl -184(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    leal ark_str_1085, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_507
    pushl $8
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_508
.Lpass2_a_507:
    leal ark_str_1086, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_509
    pushl -176(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_510
.Lpass2_a_509:
    leal ark_str_1087, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_511
    pushl -176(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    xorl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_512
.Lpass2_a_511:
    pushl -176(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl -176(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
.Lpass2_a_512:
.Lpass2_a_510:
.Lpass2_a_508:
    pushl $48896
    pushl -184(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -168(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_468
.Lpass2_a_467:
    leal ark_str_1088, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_513
    pushl $64
    leal -192(%ebp), %eax
    pushl %eax
    leal -272(%ebp), %eax
    pushl %eax
    call _read_label_name_a
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal -192(%ebp), %eax
    pushl %eax
    pushl -280(%ebp)
    call _find_label_a
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_515
    pushl $1
    leal -192(%ebp), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    call _add_ref_a
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl $61440
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $53248
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_516
.Lpass2_a_515:
    pushl -128(%ebp)
    pushl -280(%ebp)
    call _emit_bl_a
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_516:
    jmp .Lpass2_a_514
.Lpass2_a_513:
    leal ark_str_1089, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_533
    leal ark_str_1090, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_534
.Lpass2_a_533:
    pushl $1
.Lpass2_a_534:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_531
    leal ark_str_1091, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_532
.Lpass2_a_531:
    pushl $1
.Lpass2_a_532:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_529
    leal ark_str_1092, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_530
.Lpass2_a_529:
    pushl $1
.Lpass2_a_530:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_527
    leal ark_str_1093, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_528
.Lpass2_a_527:
    pushl $1
.Lpass2_a_528:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_525
    leal ark_str_1094, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_526
.Lpass2_a_525:
    pushl $1
.Lpass2_a_526:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_523
    leal ark_str_1095, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_524
.Lpass2_a_523:
    pushl $1
.Lpass2_a_524:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_521
    leal ark_str_1096, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_522
.Lpass2_a_521:
    pushl $1
.Lpass2_a_522:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_519
    leal ark_str_1097, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_520
.Lpass2_a_519:
    pushl $1
.Lpass2_a_520:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_517
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    leal -264(%ebp), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_535
    leal ark_str_1098, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_537
    pushl $0
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_538
.Lpass2_a_537:
    leal ark_str_1099, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_539
    pushl $1
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_540
.Lpass2_a_539:
    leal ark_str_1100, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_541
    pushl $2
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_542
.Lpass2_a_541:
    leal ark_str_1101, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_543
    pushl $3
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_544
.Lpass2_a_543:
    leal ark_str_1102, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_545
    pushl $10
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_546
.Lpass2_a_545:
    leal ark_str_1103, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_547
    pushl $11
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_548
.Lpass2_a_547:
    leal ark_str_1104, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_549
    pushl $12
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_550
.Lpass2_a_549:
    leal ark_str_1105, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_551
    pushl $13
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_552
.Lpass2_a_551:
.Lpass2_a_552:
.Lpass2_a_550:
.Lpass2_a_548:
.Lpass2_a_546:
.Lpass2_a_544:
.Lpass2_a_542:
.Lpass2_a_540:
.Lpass2_a_538:
    jmp .Lpass2_a_536
.Lpass2_a_535:
.Lpass2_a_536:
    pushl $64
    leal -192(%ebp), %eax
    pushl %eax
    leal -272(%ebp), %eax
    pushl %eax
    call _read_label_name_a
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal -192(%ebp), %eax
    pushl %eax
    pushl -280(%ebp)
    call _find_label_a
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_553
    pushl -120(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_555
    pushl $2
    leal -192(%ebp), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    call _add_ref_a
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl $61440
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $36864
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_556
.Lpass2_a_555:
    pushl $3
    leal -192(%ebp), %eax
    pushl %eax
    pushl -280(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -280(%ebp)
    call _add_ref_a
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl $61440
    pushl -128(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $32768
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_556:
    jmp .Lpass2_a_554
.Lpass2_a_553:
    pushl -120(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_557
    pushl -112(%ebp)
    pushl -280(%ebp)
    call _emit_b_w_a
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_558
.Lpass2_a_557:
    pushl -112(%ebp)
    pushl -128(%ebp)
    pushl -280(%ebp)
    call _emit_bcond_w_a
    addl $12, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_558:
.Lpass2_a_554:
    jmp .Lpass2_a_518
.Lpass2_a_517:
    leal ark_str_1106, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_565
    leal ark_str_1107, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_566
.Lpass2_a_565:
    pushl $1
.Lpass2_a_566:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_563
    leal ark_str_1108, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_564
.Lpass2_a_563:
    pushl $1
.Lpass2_a_564:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_561
    leal ark_str_1109, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_562
.Lpass2_a_561:
    pushl $1
.Lpass2_a_562:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_559
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    pushl $0
    popl %eax
    movl %eax, -176(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $91
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_567
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_568
.Lpass2_a_567:
.Lpass2_a_568:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_569
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_571
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_572
.Lpass2_a_571:
.Lpass2_a_572:
    jmp .Lpass2_a_570
.Lpass2_a_569:
.Lpass2_a_570:
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $93
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_573
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_574
.Lpass2_a_573:
.Lpass2_a_574:
    pushl $1
    pushl $0
    pushl -176(%ebp)
    call _ldr_str_size_a
    addl $12, %esp
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_575
    pushl -176(%ebp)
    pushl $4095
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    leal ark_str_1110, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_577
    pushl $63648
    pushl -184(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_578
.Lpass2_a_577:
    leal ark_str_1111, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_579
    pushl $63664
    pushl -184(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_580
.Lpass2_a_579:
    leal ark_str_1112, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_581
    pushl $63920
    pushl -184(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_582
.Lpass2_a_581:
    pushl $63888
    pushl -184(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
.Lpass2_a_582:
.Lpass2_a_580:
.Lpass2_a_578:
    pushl -192(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl -152(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    pushl -168(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -160(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_576
.Lpass2_a_575:
    pushl -176(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $31
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    leal ark_str_1113, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_583
    pushl $32768
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_584
.Lpass2_a_583:
    leal ark_str_1114, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_585
    pushl $34816
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_586
.Lpass2_a_585:
    leal ark_str_1115, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_587
    pushl $38912
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_588
.Lpass2_a_587:
    pushl $36864
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
.Lpass2_a_588:
.Lpass2_a_586:
.Lpass2_a_584:
    pushl -160(%ebp)
    pushl -168(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_576:
    jmp .Lpass2_a_560
.Lpass2_a_559:
    leal ark_str_1116, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_591
    leal ark_str_1117, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_592
.Lpass2_a_591:
    pushl $1
.Lpass2_a_592:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_589
    leal ark_str_1118, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    pushl $0
    popl %eax
    movl %eax, -184(%ebp)
    pushl $0
    popl %eax
    movl %eax, -176(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_593:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_597
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_598
.Lpass2_a_597:
    pushl $0
.Lpass2_a_598:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_595
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $59
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_596
.Lpass2_a_595:
    pushl $0
.Lpass2_a_596:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_594
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $105
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_601
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $73
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_602
.Lpass2_a_601:
    pushl $1
.Lpass2_a_602:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_599
    pushl $1
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_600
.Lpass2_a_599:
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_605
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $70
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_606
.Lpass2_a_605:
    pushl $1
.Lpass2_a_606:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_603
    pushl $1
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_604
.Lpass2_a_603:
.Lpass2_a_604:
.Lpass2_a_600:
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_593
.Lpass2_a_594:
    pushl $46688
    pushl -192(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_607
    pushl $16
    jmp .Lpass2_a_608
.Lpass2_a_607:
    pushl $0
.Lpass2_a_608:
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_609
    pushl $2
    jmp .Lpass2_a_610
.Lpass2_a_609:
    pushl $0
.Lpass2_a_610:
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_611
    pushl $1
    jmp .Lpass2_a_612
.Lpass2_a_611:
    pushl $0
.Lpass2_a_612:
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_590
.Lpass2_a_589:
    leal ark_str_1119, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_617
    leal ark_str_1120, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_618
.Lpass2_a_617:
    pushl $1
.Lpass2_a_618:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_615
    leal ark_str_1121, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_616
.Lpass2_a_615:
    pushl $1
.Lpass2_a_616:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_613
    leal ark_str_1122, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_619
    pushl $36688
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_620
.Lpass2_a_619:
    leal ark_str_1123, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_621
    pushl $36672
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_622
.Lpass2_a_621:
    pushl $36704
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
.Lpass2_a_622:
.Lpass2_a_620:
    pushl $62399
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -192(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_614
.Lpass2_a_613:
    leal ark_str_1124, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_627
    leal ark_str_1125, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_628
.Lpass2_a_627:
    pushl $1
.Lpass2_a_628:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_625
    leal ark_str_1126, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_626
.Lpass2_a_625:
    pushl $1
.Lpass2_a_626:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_623
    leal ark_str_1127, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_629
    pushl $48960
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_630
.Lpass2_a_629:
    leal ark_str_1128, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_631
    pushl $48928
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_632
.Lpass2_a_631:
    pushl $48944
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_632:
.Lpass2_a_630:
    jmp .Lpass2_a_624
.Lpass2_a_623:
    leal ark_str_1129, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_637
    leal ark_str_1130, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_638
.Lpass2_a_637:
    pushl $1
.Lpass2_a_638:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_635
    leal ark_str_1131, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_636
.Lpass2_a_635:
    pushl $1
.Lpass2_a_636:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_633
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    leal ark_str_1132, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_639
    pushl $47616
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_640
.Lpass2_a_639:
    leal ark_str_1133, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_641
    pushl $47680
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_642
.Lpass2_a_641:
    pushl $47808
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
.Lpass2_a_642:
.Lpass2_a_640:
    pushl -176(%ebp)
    pushl -184(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_634
.Lpass2_a_633:
    leal ark_str_1134, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_643
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl $59983
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -192(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_644
.Lpass2_a_643:
    leal ark_str_1135, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_645
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $115
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_649
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $83
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_650
.Lpass2_a_649:
    pushl $1
.Lpass2_a_650:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_647
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_sreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_651
    pushl $0
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_652
.Lpass2_a_651:
.Lpass2_a_652:
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -192(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    pushl -192(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    pushl $60928
    pushl -176(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    pushl $2576
    pushl -184(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -168(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_648
.Lpass2_a_647:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_sreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -184(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_653
    pushl $0
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_654
.Lpass2_a_653:
.Lpass2_a_654:
    pushl -184(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    pushl -184(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    pushl $60944
    pushl -176(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    pushl $2576
    pushl -192(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -168(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_648:
    jmp .Lpass2_a_646
.Lpass2_a_645:
    leal ark_str_1136, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_661
    leal ark_str_1137, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_662
.Lpass2_a_661:
    pushl $1
.Lpass2_a_662:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_659
    leal ark_str_1138, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_660
.Lpass2_a_659:
    pushl $1
.Lpass2_a_660:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_657
    leal ark_str_1139, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_658
.Lpass2_a_657:
    pushl $1
.Lpass2_a_658:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_655
    pushl $16
    leal -192(%ebp), %eax
    pushl %eax
    leal -272(%ebp), %eax
    pushl %eax
    call _read_vfp_suffix_a
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_1140, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    leal ark_str_1141, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_663
    pushl -176(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_665
    pushl $-298841344
    jmp .Lpass2_a_666
.Lpass2_a_665:
    pushl $-298841600
.Lpass2_a_666:
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_664
.Lpass2_a_663:
    leal ark_str_1142, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_667
    pushl -176(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_669
    pushl $-298841280
    jmp .Lpass2_a_670
.Lpass2_a_669:
    pushl $-298841536
.Lpass2_a_670:
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_668
.Lpass2_a_667:
    leal ark_str_1143, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_671
    pushl -176(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_673
    pushl $-299889920
    jmp .Lpass2_a_674
.Lpass2_a_673:
    pushl $-299890176
.Lpass2_a_674:
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_672
.Lpass2_a_671:
    pushl -176(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_675
    pushl $-301987008
    jmp .Lpass2_a_676
.Lpass2_a_675:
    pushl $-301987264
.Lpass2_a_676:
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
.Lpass2_a_672:
.Lpass2_a_668:
.Lpass2_a_664:
    pushl -176(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_677
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_dreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_dreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_dreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_678
.Lpass2_a_677:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_sreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_sreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_sreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
.Lpass2_a_678:
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_679
    pushl $0
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_680
.Lpass2_a_679:
.Lpass2_a_680:
    pushl -152(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_681
    pushl $0
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_682
.Lpass2_a_681:
.Lpass2_a_682:
    pushl -144(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_683
    pushl $0
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_684
.Lpass2_a_683:
.Lpass2_a_684:
    pushl -160(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    pushl -152(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    pushl -152(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl -144(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -144(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    pushl -168(%ebp)
    pushl $16
    pushl -136(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -112(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    pushl -168(%ebp)
    pushl $65535
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl -128(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -104(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -96(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
    pushl -88(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_656
.Lpass2_a_655:
    leal ark_str_1144, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_685
    pushl $0
    popl %eax
    movl %eax, -152(%ebp)
    pushl $0
    popl %eax
    movl %eax, -144(%ebp)
    pushl $32
    leal -192(%ebp), %eax
    pushl %eax
    leal -272(%ebp), %eax
    pushl %eax
    call _read_vfp_suffix_a
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_1145, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_687
    pushl $-289600832
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_688
.Lpass2_a_687:
    leal ark_str_1146, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_689
    pushl $-289928512
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_690
.Lpass2_a_689:
    leal ark_str_1147, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_691
    pushl $-289600576
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_692
.Lpass2_a_691:
    leal ark_str_1148, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_693
    pushl $-289928256
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_694
.Lpass2_a_693:
    pushl $-289600832
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
.Lpass2_a_694:
.Lpass2_a_692:
.Lpass2_a_690:
.Lpass2_a_688:
    leal ark_str_1149, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_695
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_sreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_dreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_696
.Lpass2_a_695:
    leal ark_str_1150, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_697
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_dreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_sreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_698
.Lpass2_a_697:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_sreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_sreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
.Lpass2_a_698:
.Lpass2_a_696:
    pushl -152(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_699
    pushl $0
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_700
.Lpass2_a_699:
.Lpass2_a_700:
    pushl -144(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_701
    pushl $0
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_702
.Lpass2_a_701:
.Lpass2_a_702:
    pushl -152(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    pushl -152(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    pushl -144(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    pushl -144(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl $16
    pushl -136(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl $65535
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl -128(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -112(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    pushl -104(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_686
.Lpass2_a_685:
    leal ark_str_1151, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_703
    pushl $16
    leal -192(%ebp), %eax
    pushl %eax
    leal -272(%ebp), %eax
    pushl %eax
    call _read_vfp_suffix_a
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_1152, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    pushl -176(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_705
    pushl $-290190528
    jmp .Lpass2_a_706
.Lpass2_a_705:
    pushl $-290190784
.Lpass2_a_706:
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    pushl -176(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_707
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_dreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_dreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_708
.Lpass2_a_707:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_sreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_sreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
.Lpass2_a_708:
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_709
    pushl $0
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_710
.Lpass2_a_709:
.Lpass2_a_710:
    pushl -152(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_711
    pushl $0
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_712
.Lpass2_a_711:
.Lpass2_a_712:
    pushl -160(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    pushl -152(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    pushl -152(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    pushl -168(%ebp)
    pushl $16
    pushl -144(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl -168(%ebp)
    pushl $65535
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -128(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -120(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -112(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_704
.Lpass2_a_703:
    leal ark_str_1153, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_713
    pushl $65265
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $64016
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_714
.Lpass2_a_713:
    leal ark_str_1154, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_719
    leal ark_str_1155, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_720
.Lpass2_a_719:
    pushl $1
.Lpass2_a_720:
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_717
    leal ark_str_1156, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_718
.Lpass2_a_717:
    pushl $1
.Lpass2_a_718:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_715
    pushl $16
    leal -192(%ebp), %eax
    pushl %eax
    leal -272(%ebp), %eax
    pushl %eax
    call _read_vfp_suffix_a
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_1157, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    leal ark_str_1158, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_721
    pushl -176(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_723
    pushl $-290387008
    jmp .Lpass2_a_724
.Lpass2_a_723:
    pushl $-290387264
.Lpass2_a_724:
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_722
.Lpass2_a_721:
    leal ark_str_1159, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_725
    pushl -176(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_727
    pushl $-290452544
    jmp .Lpass2_a_728
.Lpass2_a_727:
    pushl $-290452800
.Lpass2_a_728:
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_726
.Lpass2_a_725:
    pushl -176(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_729
    pushl $-290382912
    jmp .Lpass2_a_730
.Lpass2_a_729:
    pushl $-290383168
.Lpass2_a_730:
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
.Lpass2_a_726:
.Lpass2_a_722:
    pushl -176(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_731
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_dreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_dreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_732
.Lpass2_a_731:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_sreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_sreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
.Lpass2_a_732:
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_733
    pushl $0
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_734
.Lpass2_a_733:
.Lpass2_a_734:
    pushl -152(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_735
    pushl $0
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_736
.Lpass2_a_735:
.Lpass2_a_736:
    pushl -160(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    pushl -152(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    pushl -152(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    pushl -168(%ebp)
    pushl $16
    pushl -144(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl -168(%ebp)
    pushl $65535
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -128(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -120(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -112(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_716
.Lpass2_a_715:
    leal ark_str_1160, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_739
    leal ark_str_1161, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lpass2_a_740
.Lpass2_a_739:
    pushl $1
.Lpass2_a_740:
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_737
    pushl $16
    leal -192(%ebp), %eax
    pushl %eax
    leal -272(%ebp), %eax
    pushl %eax
    call _read_vfp_suffix_a
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_1162, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    leal ark_str_1163, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_741
    pushl -176(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_743
    pushl $-309327104
    jmp .Lpass2_a_744
.Lpass2_a_743:
    pushl $-309327360
.Lpass2_a_744:
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_742
.Lpass2_a_741:
    pushl -176(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_745
    pushl $-310375680
    jmp .Lpass2_a_746
.Lpass2_a_745:
    pushl $-310375936
.Lpass2_a_746:
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
.Lpass2_a_742:
    pushl -176(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_747
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_dreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_748
.Lpass2_a_747:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_vfp_sreg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
.Lpass2_a_748:
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_749
    pushl $0
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_750
.Lpass2_a_749:
.Lpass2_a_750:
    leal -272(%ebp), %eax
    pushl %eax
    call _eat_comma_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $91
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_751
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_752
.Lpass2_a_751:
.Lpass2_a_752:
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_reg_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_753
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    leal -272(%ebp), %eax
    pushl %eax
    call _parse_imm_a
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_754
.Lpass2_a_753:
.Lpass2_a_754:
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_space_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $93
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_755
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_756
.Lpass2_a_755:
.Lpass2_a_756:
    pushl -160(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    pushl -144(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -168(%ebp)
    pushl $16
    pushl -136(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -152(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    pushl -168(%ebp)
    pushl $65535
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl -128(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl -104(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl -120(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -112(%ebp)
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpass2_a_738
.Lpass2_a_737:
    pushl $48896
    pushl -280(%ebp)
    call _out16
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lpass2_a_738:
.Lpass2_a_716:
.Lpass2_a_714:
.Lpass2_a_704:
.Lpass2_a_686:
.Lpass2_a_656:
.Lpass2_a_646:
.Lpass2_a_644:
.Lpass2_a_634:
.Lpass2_a_624:
.Lpass2_a_614:
.Lpass2_a_590:
.Lpass2_a_560:
.Lpass2_a_518:
.Lpass2_a_514:
.Lpass2_a_468:
.Lpass2_a_466:
.Lpass2_a_464:
.Lpass2_a_410:
.Lpass2_a_402:
.Lpass2_a_394:
.Lpass2_a_392:
.Lpass2_a_388:
.Lpass2_a_380:
.Lpass2_a_372:
.Lpass2_a_366:
.Lpass2_a_364:
.Lpass2_a_362:
.Lpass2_a_360:
.Lpass2_a_354:
.Lpass2_a_352:
.Lpass2_a_350:
.Lpass2_a_348:
.Lpass2_a_346:
.Lpass2_a_330:
.Lpass2_a_314:
.Lpass2_a_312:
.Lpass2_a_310:
.Lpass2_a_284:
.Lpass2_a_280:
.Lpass2_a_272:
.Lpass2_a_264:
    leal -272(%ebp), %eax
    pushl %eax
    call _skip_to_eol_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -272(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpass2_a_757
    pushl -272(%ebp)
    pushl -272(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    addl $4, %esp
    jmp .Lpass2_a_758
.Lpass2_a_757:
.Lpass2_a_758:
    jmp .Lpass2_a_0
.Lpass2_a_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_resolve_refs_a:
    pushl %ebp
    movl %esp, %ebp
    subl $320, %esp
    movl 8(%ebp), %eax
    movl %eax, -72(%ebp)
    pushl $0
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
.Lresolve_refs_a_0:
    pushl -64(%ebp)
    pushl -72(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lresolve_refs_a_1
    pushl -72(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -64(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -72(%ebp)
    call _find_label_a
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lresolve_refs_a_3
    pushl -56(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal ark_str_1164, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -72(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    addl $4, %esp
    jmp .Lresolve_refs_a_2
.Lresolve_refs_a_3:
.Lresolve_refs_a_4:
    pushl -56(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lresolve_refs_a_5
    pushl -72(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -72(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -48(%ebp)
    pushl -72(%ebp)
    call _emit_bl_a
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -72(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lresolve_refs_a_6
.Lresolve_refs_a_5:
    pushl -56(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lresolve_refs_a_7
    pushl -72(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -72(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -48(%ebp)
    pushl -72(%ebp)
    call _emit_b_w_a
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -72(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lresolve_refs_a_8
.Lresolve_refs_a_7:
    pushl -56(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lresolve_refs_a_9
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    pushl $6
    pushl $15
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -72(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -72(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -48(%ebp)
    pushl -32(%ebp)
    pushl -72(%ebp)
    call _emit_bcond_w_a
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -72(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lresolve_refs_a_10
.Lresolve_refs_a_9:
    pushl -56(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lresolve_refs_a_11
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lresolve_refs_a_12
.Lresolve_refs_a_11:
    pushl -48(%ebp)
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl $61440
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl $57344
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lresolve_refs_a_13
    pushl -32(%ebp)
    pushl $63488
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $2047
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lresolve_refs_a_14
.Lresolve_refs_a_13:
    pushl -32(%ebp)
    pushl $65280
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
.Lresolve_refs_a_14:
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    pushl $8
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lresolve_refs_a_12:
.Lresolve_refs_a_10:
.Lresolve_refs_a_8:
.Lresolve_refs_a_6:
.Lresolve_refs_a_2:
    pushl -64(%ebp)
    pushl -64(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    addl $4, %esp
    jmp .Lresolve_refs_a_0
.Lresolve_refs_a_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_arm_emit:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -48(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -40(%ebp)
    pushl -56(%ebp)
    call _codegen_arm
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larm_emit_0
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Larm_emit_1
.Larm_emit_0:
.Larm_emit_1:
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Larm_emit_2:
    pushl -16(%ebp)
    pushl -24(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larm_emit_3
    pushl -48(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Larm_emit_4:
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    addl $4, %esp
    jmp .Larm_emit_2
.Larm_emit_3:
    pushl -48(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_arm_assemble:
    pushl %ebp
    movl %esp, %ebp
    subl $368, %esp
    movl 8(%ebp), %eax
    movl %eax, -120(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -112(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -104(%ebp)
    leal -96(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -120(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -112(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -104(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $52
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $56
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $60
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $68
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    call _pass1_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    call _pass2_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    call _resolve_refs_a
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    call _arm_save_syms
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -96(%ebp), %eax
    pushl %eax
    call _arm_save_relocs
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_1165, %eax
    pushl %eax
    call _getenv
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larm_assemble_0
    leal -96(%ebp), %eax
    pushl %eax
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal ark_str_1166, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Larm_assemble_2:
    pushl -24(%ebp)
    leal -96(%ebp), %eax
    pushl %eax
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larm_assemble_3
    leal -96(%ebp), %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larm_assemble_5
    leal -96(%ebp), %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -96(%ebp), %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal -96(%ebp), %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal ark_str_1167, %eax
    pushl %eax
    call _ark_log
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Larm_assemble_6
.Larm_assemble_5:
.Larm_assemble_6:
.Larm_assemble_4:
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    addl $4, %esp
    jmp .Larm_assemble_2
.Larm_assemble_3:
    leal ark_str_1168, %eax
    pushl %eax
    call _ark_log
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Larm_assemble_1
.Larm_assemble_0:
.Larm_assemble_1:
    leal -96(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_arm_link:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_arm_save_syms:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_arm_sym_count
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Larm_save_syms_0:
    pushl -16(%ebp)
    pushl -24(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larm_save_syms_3
    movl _g_arm_sym_count, %eax
    pushl %eax
    pushl $4096
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larm_save_syms_4
.Larm_save_syms_3:
    pushl $0
.Larm_save_syms_4:
    popl %eax
    cmpl $0, %eax
    je .Larm_save_syms_1
    pushl -24(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larm_save_syms_7
    pushl -24(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $76
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larm_save_syms_8
.Larm_save_syms_7:
    pushl $0
.Larm_save_syms_8:
    popl %eax
    cmpl $0, %eax
    je .Larm_save_syms_5
    jmp .Larm_save_syms_2
.Larm_save_syms_5:
.Larm_save_syms_6:
    movl $_g_arm_syms, %eax
    pushl %eax
    movl _g_arm_sym_count, %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_g_arm_syms, %eax
    pushl %eax
    movl _g_arm_sym_count, %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_g_arm_syms, %eax
    pushl %eax
    movl _g_arm_sym_count, %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl _g_arm_sym_count, %eax
    pushl %eax
    movl _g_arm_sym_count, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_arm_sym_count
    addl $4, %esp
.Larm_save_syms_2:
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    addl $4, %esp
    jmp .Larm_save_syms_0
.Larm_save_syms_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_arm_save_relocs:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_arm_reloc_count
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
.Larm_save_relocs_0:
    pushl -32(%ebp)
    pushl -40(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larm_save_relocs_3
    movl _g_arm_reloc_count, %eax
    pushl %eax
    pushl $4096
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larm_save_relocs_4
.Larm_save_relocs_3:
    pushl $0
.Larm_save_relocs_4:
    popl %eax
    cmpl $0, %eax
    je .Larm_save_relocs_1
    pushl -40(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -32(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -40(%ebp)
    call _find_label_a
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larm_save_relocs_5
    movl $_g_arm_relocs, %eax
    pushl %eax
    movl _g_arm_reloc_count, %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_g_arm_relocs, %eax
    pushl %eax
    movl _g_arm_reloc_count, %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_g_arm_relocs, %eax
    pushl %eax
    movl _g_arm_reloc_count, %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl _g_arm_reloc_count, %eax
    pushl %eax
    movl _g_arm_reloc_count, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_arm_reloc_count
    addl $4, %esp
    jmp .Larm_save_relocs_6
.Larm_save_relocs_5:
.Larm_save_relocs_6:
.Larm_save_relocs_2:
    pushl -32(%ebp)
    pushl -32(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    addl $4, %esp
    jmp .Larm_save_relocs_0
.Larm_save_relocs_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _arm_get_symbol_count
_arm_get_symbol_count:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl _g_arm_sym_count, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _arm_get_symbol_name
_arm_get_symbol_name:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl $_g_arm_syms, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _arm_get_symbol_offset
_arm_get_symbol_offset:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl $_g_arm_syms, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _arm_get_symbol_type
_arm_get_symbol_type:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl $_g_arm_syms, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _arm_get_reloc_count
_arm_get_reloc_count:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl _g_arm_reloc_count, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _arm_get_reloc_name
_arm_get_reloc_name:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl $_g_arm_relocs, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _arm_get_reloc_offset
_arm_get_reloc_offset:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl $_g_arm_relocs, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _arm_get_reloc_type
_arm_get_reloc_type:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl $_g_arm_relocs, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _ark_backend_arm
_ark_backend_arm:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_g_arm_backend, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

