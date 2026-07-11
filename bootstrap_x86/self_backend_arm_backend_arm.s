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
    .long ark_str_1017
    .long ark_str_1018
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
    .asciz ".L_"
ark_str_11:
    .asciz ":\n"
ark_str_12:
    .asciz "    "
ark_str_13:
    .asciz " .L_"
ark_str_14:
    .asciz "ADD r0, r0, r1"
ark_str_15:
    .asciz "SUB r0, r0, r1"
ark_str_16:
    .asciz "MUL r0, r1"
ark_str_17:
    .asciz "SDIV r0, r0, r1"
ark_str_18:
    .asciz "SDIV r2, r0, r1"
ark_str_19:
    .asciz "MUL r2, r1"
ark_str_20:
    .asciz "SUB r0, r0, r2"
ark_str_21:
    .asciz "AND r0, r1"
ark_str_22:
    .asciz "ORR r0, r1"
ark_str_23:
    .asciz "EOR r0, r1"
ark_str_24:
    .asciz "LSL r0, r1"
ark_str_25:
    .asciz "LSR r0, r1"
ark_str_26:
    .asciz "ASR r0, r1"
ark_str_27:
    .asciz "CMP r0, r1"
ark_str_28:
    .asciz "ITE EQ"
ark_str_29:
    .asciz "MOVEQ r0, #1"
ark_str_30:
    .asciz "MOVNE r0, #0"
ark_str_31:
    .asciz "CMP r0, r1"
ark_str_32:
    .asciz "ITE NE"
ark_str_33:
    .asciz "MOVNE r0, #1"
ark_str_34:
    .asciz "MOVEQ r0, #0"
ark_str_35:
    .asciz "CMP r0, r1"
ark_str_36:
    .asciz "ITE LO"
ark_str_37:
    .asciz "MOVLO r0, #1"
ark_str_38:
    .asciz "MOVHS r0, #0"
ark_str_39:
    .asciz "ITE LT"
ark_str_40:
    .asciz "MOVLT r0, #1"
ark_str_41:
    .asciz "MOVGE r0, #0"
ark_str_42:
    .asciz "CMP r0, r1"
ark_str_43:
    .asciz "ITE HI"
ark_str_44:
    .asciz "MOVHI r0, #1"
ark_str_45:
    .asciz "MOVLS r0, #0"
ark_str_46:
    .asciz "ITE GT"
ark_str_47:
    .asciz "MOVGT r0, #1"
ark_str_48:
    .asciz "MOVLE r0, #0"
ark_str_49:
    .asciz "CMP r0, r1"
ark_str_50:
    .asciz "ITE LS"
ark_str_51:
    .asciz "MOVLS r0, #1"
ark_str_52:
    .asciz "MOVHI r0, #0"
ark_str_53:
    .asciz "ITE LE"
ark_str_54:
    .asciz "MOVLE r0, #1"
ark_str_55:
    .asciz "MOVGT r0, #0"
ark_str_56:
    .asciz "CMP r0, r1"
ark_str_57:
    .asciz "ITE HS"
ark_str_58:
    .asciz "MOVHS r0, #1"
ark_str_59:
    .asciz "MOVLO r0, #0"
ark_str_60:
    .asciz "ITE GE"
ark_str_61:
    .asciz "MOVGE r0, #1"
ark_str_62:
    .asciz "MOVLT r0, #0"
ark_str_63:
    .asciz "; unknown binary op"
ark_str_64:
    .asciz "NEG r0, r0"
ark_str_65:
    .asciz "MVN r0, r0"
ark_str_66:
    .asciz "CMP r0, #0"
ark_str_67:
    .asciz "MOV r0, #0"
ark_str_68:
    .asciz "IT EQ"
ark_str_69:
    .asciz "MOVEQ r0, #1"
ark_str_70:
    .asciz "; unknown unary op"
ark_str_71:
    .asciz ":\n"
ark_str_72:
    .asciz ".cfi_startproc"
ark_str_73:
    .asciz "PUSH {r5, r6, r7, lr}"
ark_str_74:
    .asciz "PUSH {r5, r6, r7, lr}"
ark_str_75:
    .asciz "    SUB sp, sp, #"
ark_str_76:
    .asciz "MOV r6, sp"
ark_str_77:
    .asciz "BX lr"
ark_str_78:
    .asciz "MOV sp, r6"
ark_str_79:
    .asciz "    ADD sp, sp, #"
ark_str_80:
    .asciz "POP {r5, r6, r7, pc}"
ark_str_81:
    .asciz "POP {r5, r6, r7, pc}"
ark_str_82:
    .asciz "; Ark C Compiler - generated Thumb-2 assembly\n"
ark_str_83:
    .asciz ".thumb\n"
ark_str_84:
    .asciz ".text\n\n"
ark_str_85:
    .asciz ".section .rodata\n"
ark_str_86:
    .asciz ".L_str_"
ark_str_87:
    .asciz ":\n    .asciz \""
ark_str_88:
    .asciz "\\n"
ark_str_89:
    .asciz "\\t"
ark_str_90:
    .asciz "\\\\"
ark_str_91:
    .asciz "\\\""
ark_str_92:
    .asciz "\"\n"
ark_str_93:
    .asciz ".text\n\n"
ark_str_94:
    .asciz ".section .rodata\n"
ark_str_95:
    .asciz "0123456789abcdef"
ark_str_96:
    .asciz ".L_flt_"
ark_str_97:
    .asciz ":\n    .word 0x"
ark_str_98:
    .asciz ".L_dbl_"
ark_str_99:
    .asciz ":\n    .word 0x"
ark_str_100:
    .asciz "\n    .word 0x"
ark_str_101:
    .asciz ".text\n\n"
ark_str_102:
    .asciz ".global "
ark_str_103:
    .asciz ".set "
ark_str_104:
    .asciz ", "
ark_str_105:
    .asciz "\n\n"
ark_str_106:
    .asciz ".section .text."
ark_str_107:
    .asciz ", \"ax\", %progbits\n"
ark_str_108:
    .asciz ".global "
ark_str_109:
    .asciz ".weak "
ark_str_110:
    .asciz "@ __attribute__((used))\n"
ark_str_111:
    .asciz ":\n"
ark_str_112:
    .asciz "    "
ark_str_113:
    .asciz "Reset_Handler"
ark_str_114:
    .asciz "    BL __arkcc_init_globals\n"
ark_str_115:
    .asciz "    STR r0, [r6, #"
ark_str_116:
    .asciz "]\n"
ark_str_117:
    .asciz "    MOV r3, r"
ark_str_118:
    .asciz "\n"
ark_str_119:
    .asciz "    LDR r3, [r6, #"
ark_str_120:
    .asciz "]\n"
ark_str_121:
    .asciz "    LDR r0, [r3, #"
ark_str_122:
    .asciz "]\n"
ark_str_123:
    .asciz "    STR r0, [r6, #"
ark_str_124:
    .asciz "]\n"
ark_str_125:
    .asciz "    ADD r0, r6, #"
ark_str_126:
    .asciz "\n    MOV r1, r3\n"
ark_str_127:
    .asciz "    PUSH {lr}\n    BL memcpy\n    POP {r0}\n"
ark_str_128:
    .asciz "    STR r"
ark_str_129:
    .asciz ", [r6, #"
ark_str_130:
    .asciz "]\n"
ark_str_131:
    .asciz "    LDR r0, [r6, #"
ark_str_132:
    .asciz "]\n"
ark_str_133:
    .asciz "    STR r0, [r6, #"
ark_str_134:
    .asciz "]\n"
ark_str_135:
    .asciz "    LDR r0, =.L_str_"
ark_str_136:
    .asciz "    LDRB r0, [r6, #"
ark_str_137:
    .asciz "    LDRSB r0, [r6, #"
ark_str_138:
    .asciz "]\n"
ark_str_139:
    .asciz "    LDRH r0, [r6, #"
ark_str_140:
    .asciz "    LDRSH r0, [r6, #"
ark_str_141:
    .asciz "]\n"
ark_str_142:
    .asciz "    LDR r0, [r6, #"
ark_str_143:
    .asciz "]\n    LDR r1, [r6, #"
ark_str_144:
    .asciz "]\n"
ark_str_145:
    .asciz "    PUSH {r1}\n"
ark_str_146:
    .asciz "    LDR r0, [r6, #"
ark_str_147:
    .asciz "]\n"
ark_str_148:
    .asciz "    ADD r0, r6, #"
ark_str_149:
    .asciz "    LDR r0, [r1, #0]\n"
ark_str_150:
    .asciz "    LDR r2, [r1, #4]\n"
ark_str_151:
    .asciz "    PUSH {r2}\n"
ark_str_152:
    .asciz "LDR r0, [r0]"
ark_str_153:
    .asciz "    POP {r1}\n"
ark_str_154:
    .asciz "    STR r0, [r2, #0]\n"
ark_str_155:
    .asciz "    STR r1, [r2, #4]\n"
ark_str_156:
    .asciz "STR r0, [r1]"
ark_str_157:
    .asciz "    POP {r1}\n"
ark_str_158:
    .asciz "    PUSH {r1}\n"
ark_str_159:
    .asciz "    STRB r0, [r6, #"
ark_str_160:
    .asciz "]\n"
ark_str_161:
    .asciz "    STRH r0, [r6, #"
ark_str_162:
    .asciz "]\n"
ark_str_163:
    .asciz "    POP {r1}\n"
ark_str_164:
    .asciz "    STR r0, [r6, #"
ark_str_165:
    .asciz "]\n"
ark_str_166:
    .asciz "    STR r1, [r6, #"
ark_str_167:
    .asciz "]\n"
ark_str_168:
    .asciz "    POP {r1}\n"
ark_str_169:
    .asciz "    STR r0, [r6, #"
ark_str_170:
    .asciz "]\n"
ark_str_171:
    .asciz "    STR r1, [r6, #"
ark_str_172:
    .asciz "]\n"
ark_str_173:
    .asciz "    STR r0, [r6, #"
ark_str_174:
    .asciz "]\n"
ark_str_175:
    .asciz "MUL r1, r2"
ark_str_176:
    .asciz "ADD r0, r0, r1"
ark_str_177:
    .asciz "LDRB r0, [r0, #0]"
ark_str_178:
    .asciz "LDRSH r0, [r0, #0]"
ark_str_179:
    .asciz "LDRB r2, [r0, #0]"
ark_str_180:
    .asciz "LDRB r3, [r0, #1]"
ark_str_181:
    .asciz "LSL r3, r3, #8"
ark_str_182:
    .asciz "ORR r0, r2, r3"
ark_str_183:
    .asciz "LDRB r2, [r0, #0]"
ark_str_184:
    .asciz "LDRB r3, [r0, #1]"
ark_str_185:
    .asciz "LSL r3, r3, #8"
ark_str_186:
    .asciz "ORR r2, r2, r3"
ark_str_187:
    .asciz "LDRB r3, [r0, #2]"
ark_str_188:
    .asciz "LSL r3, r3, #16"
ark_str_189:
    .asciz "ORR r2, r2, r3"
ark_str_190:
    .asciz "LDRB r3, [r0, #3]"
ark_str_191:
    .asciz "LSL r3, r3, #24"
ark_str_192:
    .asciz "ORR r0, r2, r3"
ark_str_193:
    .asciz "LDR r2, [r0, #0]"
ark_str_194:
    .asciz "LDR r3, [r0, #4]"
ark_str_195:
    .asciz "PUSH {r2}"
ark_str_196:
    .asciz "PUSH {r3}"
ark_str_197:
    .asciz "LDR r0, [r0, #0]"
ark_str_198:
    .asciz "POP {r1}"
ark_str_199:
    .asciz "POP {r2}"
ark_str_200:
    .asciz "STR r0, [r2, #0]"
ark_str_201:
    .asciz "STR r1, [r2, #4]"
ark_str_202:
    .asciz "PUSH {r0}"
ark_str_203:
    .asciz "PUSH {r1}"
ark_str_204:
    .asciz "STRB r0, [r1, #0]"
ark_str_205:
    .asciz "STRH r0, [r1, #0]"
ark_str_206:
    .asciz "STRB r0, [r1, #0]"
ark_str_207:
    .asciz "LSR r2, r0, #8"
ark_str_208:
    .asciz "STRB r2, [r1, #1]"
ark_str_209:
    .asciz "STRB r0, [r1, #0]"
ark_str_210:
    .asciz "LSR r2, r0, #8"
ark_str_211:
    .asciz "STRB r2, [r1, #1]"
ark_str_212:
    .asciz "LSR r2, r0, #16"
ark_str_213:
    .asciz "STRB r2, [r1, #2]"
ark_str_214:
    .asciz "LSR r2, r0, #24"
ark_str_215:
    .asciz "STRB r2, [r1, #3]"
ark_str_216:
    .asciz "STR r0, [r1, #0]"
ark_str_217:
    .asciz ".L_"
ark_str_218:
    .asciz ":\n"
ark_str_219:
    .asciz "B"
ark_str_220:
    .asciz "    B .L_"
ark_str_221:
    .asciz "CMP r0, #0"
ark_str_222:
    .asciz "BEQ"
ark_str_223:
    .asciz "CMP r0, #0"
ark_str_224:
    .asciz "BNE"
ark_str_225:
    .asciz "CMP r0, r1"
ark_str_226:
    .asciz "BEQ"
ark_str_227:
    .asciz "    LDR r0, =.L_dbl_"
ark_str_228:
    .asciz "LDR r1, [r0]"
ark_str_229:
    .asciz "LDR r2, [r0, #4]"
ark_str_230:
    .asciz "    PUSH {r1}\n"
ark_str_231:
    .asciz "    PUSH {r2}\n"
ark_str_232:
    .asciz "    LDR r0, =.L_flt_"
ark_str_233:
    .asciz "LDR r0, [r0]"
ark_str_234:
    .asciz "POP {r3}"
ark_str_235:
    .asciz "POP {r2}"
ark_str_236:
    .asciz "POP {r1}"
ark_str_237:
    .asciz "POP {r0}"
ark_str_238:
    .asciz "BL __aeabi_dadd"
ark_str_239:
    .asciz "    PUSH {r1}\n"
ark_str_240:
    .asciz "BL __aeabi_fadd"
ark_str_241:
    .asciz "POP {r3}"
ark_str_242:
    .asciz "POP {r2}"
ark_str_243:
    .asciz "POP {r1}"
ark_str_244:
    .asciz "POP {r0}"
ark_str_245:
    .asciz "BL __aeabi_dsub"
ark_str_246:
    .asciz "    PUSH {r1}\n"
ark_str_247:
    .asciz "BL __aeabi_fsub"
ark_str_248:
    .asciz "POP {r3}"
ark_str_249:
    .asciz "POP {r2}"
ark_str_250:
    .asciz "POP {r1}"
ark_str_251:
    .asciz "POP {r0}"
ark_str_252:
    .asciz "BL __aeabi_dmul"
ark_str_253:
    .asciz "    PUSH {r1}\n"
ark_str_254:
    .asciz "BL __aeabi_fmul"
ark_str_255:
    .asciz "POP {r3}"
ark_str_256:
    .asciz "POP {r2}"
ark_str_257:
    .asciz "POP {r1}"
ark_str_258:
    .asciz "POP {r0}"
ark_str_259:
    .asciz "BL __aeabi_ddiv"
ark_str_260:
    .asciz "    PUSH {r1}\n"
ark_str_261:
    .asciz "BL __aeabi_fdiv"
ark_str_262:
    .asciz "POP {r1}"
ark_str_263:
    .asciz "POP {r0}"
ark_str_264:
    .asciz "BL __aeabi_d2uiz"
ark_str_265:
    .asciz "BL __aeabi_d2iz"
ark_str_266:
    .asciz "BL __aeabi_f2uiz"
ark_str_267:
    .asciz "BL __aeabi_f2iz"
ark_str_268:
    .asciz "BL __aeabi_ui2d"
ark_str_269:
    .asciz "BL __aeabi_i2d"
ark_str_270:
    .asciz "    PUSH {r1}\n"
ark_str_271:
    .asciz "BL __aeabi_ui2f"
ark_str_272:
    .asciz "BL __aeabi_i2f"
ark_str_273:
    .asciz "BL __aeabi_d2f"
ark_str_274:
    .asciz "BL __aeabi_f2d"
ark_str_275:
    .asciz "    PUSH {r1}\n"
ark_str_276:
    .asciz "__aeabi_fcmpeq"
ark_str_277:
    .asciz "__aeabi_dcmpeq"
ark_str_278:
    .asciz "__aeabi_fcmpeq"
ark_str_279:
    .asciz "__aeabi_dcmpeq"
ark_str_280:
    .asciz "__aeabi_fcmpeq"
ark_str_281:
    .asciz "__aeabi_dcmplt"
ark_str_282:
    .asciz "__aeabi_fcmplt"
ark_str_283:
    .asciz "__aeabi_dcmpgt"
ark_str_284:
    .asciz "__aeabi_fcmpgt"
ark_str_285:
    .asciz "__aeabi_dcmple"
ark_str_286:
    .asciz "__aeabi_fcmple"
ark_str_287:
    .asciz "__aeabi_dcmpge"
ark_str_288:
    .asciz "__aeabi_fcmpge"
ark_str_289:
    .asciz "POP {r3}"
ark_str_290:
    .asciz "POP {r2}"
ark_str_291:
    .asciz "POP {r1}"
ark_str_292:
    .asciz "POP {r0}"
ark_str_293:
    .asciz "    BL "
ark_str_294:
    .asciz "EOR r0, r0, #1"
ark_str_295:
    .asciz "    "
ark_str_296:
    .asciz "    "
ark_str_297:
    .asciz "    "
ark_str_298:
    .asciz "__nop"
ark_str_299:
    .asciz "__isb"
ark_str_300:
    .asciz "__dsb"
ark_str_301:
    .asciz "__dmb"
ark_str_302:
    .asciz "__memory_changed"
ark_str_303:
    .asciz "__disable_irq"
ark_str_304:
    .asciz "__enable_irq"
ark_str_305:
    .asciz "__wfi"
ark_str_306:
    .asciz "__wfe"
ark_str_307:
    .asciz "__sev"
ark_str_308:
    .asciz "__clz"
ark_str_309:
    .asciz "    POP {r"
ark_str_310:
    .asciz "}\n"
ark_str_311:
    .asciz "    ADD sp, sp, #"
ark_str_312:
    .asciz "__nop"
ark_str_313:
    .asciz "    NOP\n"
ark_str_314:
    .asciz "__isb"
ark_str_315:
    .asciz "    ISB SY\n"
ark_str_316:
    .asciz "__dsb"
ark_str_317:
    .asciz "    DSB SY\n"
ark_str_318:
    .asciz "__dmb"
ark_str_319:
    .asciz "    DMB SY\n"
ark_str_320:
    .asciz "__memory_changed"
ark_str_321:
    .asciz "__disable_irq"
ark_str_322:
    .asciz "    CPSID i\n"
ark_str_323:
    .asciz "__enable_irq"
ark_str_324:
    .asciz "    CPSIE i\n"
ark_str_325:
    .asciz "__wfi"
ark_str_326:
    .asciz "    WFI\n"
ark_str_327:
    .asciz "__wfe"
ark_str_328:
    .asciz "    WFE\n"
ark_str_329:
    .asciz "__sev"
ark_str_330:
    .asciz "    SEV\n"
ark_str_331:
    .asciz "__clz"
ark_str_332:
    .asciz "    CLZ r0, r0\n"
ark_str_333:
    .asciz "    POP {r"
ark_str_334:
    .asciz "}\n"
ark_str_335:
    .asciz "    SUB sp, sp, #"
ark_str_336:
    .asciz "    MOV r0, sp\n"
ark_str_337:
    .asciz "    BL "
ark_str_338:
    .asciz "    ADD sp, sp, #"
ark_str_339:
    .asciz "    POP {ip}\n"
ark_str_340:
    .asciz "    ORR ip, ip, #1\n"
ark_str_341:
    .asciz "    POP {r"
ark_str_342:
    .asciz "}\n"
ark_str_343:
    .asciz "    SUB sp, sp, #4\n"
ark_str_344:
    .asciz "    BLX ip\n"
ark_str_345:
    .asciz "    BL "
ark_str_346:
    .asciz "    ADD sp, sp, #4\n"
ark_str_347:
    .asciz "    ADD sp, sp, #"
ark_str_348:
    .asciz "    PUSH {r1}\n"
ark_str_349:
    .asciz "    SVC #"
ark_str_350:
    .asciz "    UDIV r0, r0, r1\n"
ark_str_351:
    .asciz "    SDIV r0, r0, r1\n"
ark_str_352:
    .asciz "    UDIV r2, r0, r1\n"
ark_str_353:
    .asciz "    SDIV r2, r0, r1\n"
ark_str_354:
    .asciz "MUL r2, r2, r1"
ark_str_355:
    .asciz "SUB r0, r0, r2"
ark_str_356:
    .asciz "__aeabi_ladd"
ark_str_357:
    .asciz "__aeabi_lsub"
ark_str_358:
    .asciz "__aeabi_lmul"
ark_str_359:
    .asciz "__aeabi_uldivmod"
ark_str_360:
    .asciz "__aeabi_ldivmod"
ark_str_361:
    .asciz "__aeabi_uldivmod"
ark_str_362:
    .asciz "__aeabi_ldivmod"
ark_str_363:
    .asciz "POP {r3}"
ark_str_364:
    .asciz "POP {r2}"
ark_str_365:
    .asciz "POP {r1}"
ark_str_366:
    .asciz "POP {r0}"
ark_str_367:
    .asciz "    BL "
ark_str_368:
    .asciz "MOV r0, r2"
ark_str_369:
    .asciz "MOV r1, r3"
ark_str_370:
    .asciz "    PUSH {r1}\n"
ark_str_371:
    .asciz "__aeabi_ulcmp"
ark_str_372:
    .asciz "__aeabi_lcmp"
ark_str_373:
    .asciz "POP {r3}"
ark_str_374:
    .asciz "POP {r2}"
ark_str_375:
    .asciz "POP {r1}"
ark_str_376:
    .asciz "POP {r0}"
ark_str_377:
    .asciz "    BL "
ark_str_378:
    .asciz "CMP r0, #0"
ark_str_379:
    .asciz "ITE EQ"
ark_str_380:
    .asciz "MOVEQ r0, #1"
ark_str_381:
    .asciz "MOVNE r0, #0"
ark_str_382:
    .asciz "ITE NE"
ark_str_383:
    .asciz "MOVNE r0, #1"
ark_str_384:
    .asciz "MOVEQ r0, #0"
ark_str_385:
    .asciz "ITE LT"
ark_str_386:
    .asciz "MOVLT r0, #1"
ark_str_387:
    .asciz "MOVGE r0, #0"
ark_str_388:
    .asciz "ITE GT"
ark_str_389:
    .asciz "MOVGT r0, #1"
ark_str_390:
    .asciz "MOVLE r0, #0"
ark_str_391:
    .asciz "ITE LE"
ark_str_392:
    .asciz "MOVLE r0, #1"
ark_str_393:
    .asciz "MOVGT r0, #0"
ark_str_394:
    .asciz "ITE GE"
ark_str_395:
    .asciz "MOVGE r0, #1"
ark_str_396:
    .asciz "MOVLT r0, #0"
ark_str_397:
    .asciz "BL memcpy"
ark_str_398:
    .asciz "AND r0, r2"
ark_str_399:
    .asciz "    LSL r0, r0, #"
ark_str_400:
    .asciz "    LSL r2, r2, #"
ark_str_401:
    .asciz "LDR r3, [r1]"
ark_str_402:
    .asciz "BIC r3, r2"
ark_str_403:
    .asciz "ORR r3, r0"
ark_str_404:
    .asciz "STR r3, [r1]"
ark_str_405:
    .asciz "LDR r0, [r0]"
ark_str_406:
    .asciz "    LSR r0, r0, #"
ark_str_407:
    .asciz "    LSL r0, r0, #"
ark_str_408:
    .asciz "    ASR r0, r0, #"
ark_str_409:
    .asciz "AND r0, r2"
ark_str_410:
    .asciz "    LDR r0, [r6, #"
ark_str_411:
    .asciz "]\n"
ark_str_412:
    .asciz "    LDR r2, [r1, #"
ark_str_413:
    .asciz "]\n"
ark_str_414:
    .asciz "    STR r2, [r0, #"
ark_str_415:
    .asciz "]\n"
ark_str_416:
    .asciz "MOV sp, r6"
ark_str_417:
    .asciz "    ADD sp, sp, #"
ark_str_418:
    .asciz "POP {r5, r6, r7, pc}"
ark_str_419:
    .asciz "POP {r5, r6, r7, pc}"
ark_str_420:
    .asciz "ADD r0, r0, #7"
ark_str_421:
    .asciz "BIC r0, r0, #7"
ark_str_422:
    .asciz "SUB sp, sp, r0"
ark_str_423:
    .asciz "MOV r0, sp"
ark_str_424:
    .asciz "SADD16 r0, r0, r1"
ark_str_425:
    .asciz "SSUB16 r0, r0, r1"
ark_str_426:
    .asciz "SADD8 r0, r0, r1"
ark_str_427:
    .asciz "SSUB8 r0, r0, r1"
ark_str_428:
    .asciz "    ; unknown ir op "
ark_str_429:
    .asciz ".section .init_array, \"aw\"\n"
ark_str_430:
    .asciz ".align 2\n"
ark_str_431:
    .asciz ".word "
ark_str_432:
    .asciz ".text\n"
ark_str_433:
    .asciz ".section .fini_array, \"aw\"\n"
ark_str_434:
    .asciz ".align 2\n"
ark_str_435:
    .asciz ".word "
ark_str_436:
    .asciz ".text\n"
ark_str_437:
    .asciz ".global __arkcc_init_globals\n"
ark_str_438:
    .asciz ".thumb_func\n"
ark_str_439:
    .asciz "__arkcc_init_globals:\n"
ark_str_440:
    .asciz "    PUSH {lr}\n"
ark_str_441:
    .asciz "    STR r0, [r1]\n"
ark_str_442:
    .asciz "    STR r0, [r1, #4]\n"
ark_str_443:
    .asciz "    STR r0, [r1]\n"
ark_str_444:
    .asciz "    STRB r0, [r1]\n"
ark_str_445:
    .asciz "    STRH r0, [r1]\n"
ark_str_446:
    .asciz "    STR r0, [r1]\n"
ark_str_447:
    .asciz "    STRB r0, [r1]\n"
ark_str_448:
    .asciz "    STRB r0, [r1]\n"
ark_str_449:
    .asciz "    STRH r0, [r1]\n"
ark_str_450:
    .asciz "    STR r0, [r1]\n"
ark_str_451:
    .asciz "    STR r0, [r1, #4]\n"
ark_str_452:
    .asciz "    STR r0, [r1]\n"
ark_str_453:
    .asciz "    CMP r0, r1\n"
ark_str_454:
    .asciz "    BEQ .L_bss_done\n"
ark_str_455:
    .asciz "    MOV r2, #0\n"
ark_str_456:
    .asciz ".L_bss_loop:\n"
ark_str_457:
    .asciz "    STR r2, [r0]\n"
ark_str_458:
    .asciz "    ADD r0, r0, #4\n"
ark_str_459:
    .asciz "    CMP r0, r1\n"
ark_str_460:
    .asciz "    BNE .L_bss_loop\n"
ark_str_461:
    .asciz ".L_bss_done:\n"
ark_str_462:
    .asciz "    POP {r0}\n"
ark_str_463:
    .asciz "    BX r0\n\n"
ark_str_464:
    .asciz ".global __aeabi_ladd\n"
ark_str_465:
    .asciz ".thumb_func\n"
ark_str_466:
    .asciz "__aeabi_ladd:\n"
ark_str_467:
    .asciz "    ADD r0, r0, r2\n"
ark_str_468:
    .asciz "    ADC r1, r3\n"
ark_str_469:
    .asciz "    BX lr\n\n"
ark_str_470:
    .asciz ".global __aeabi_lsub\n"
ark_str_471:
    .asciz ".thumb_func\n"
ark_str_472:
    .asciz "__aeabi_lsub:\n"
ark_str_473:
    .asciz "    SUB r0, r0, r2\n"
ark_str_474:
    .asciz "    SBC r1, r3\n"
ark_str_475:
    .asciz "    BX lr\n\n"
ark_str_476:
    .asciz ".global __aeabi_lmul\n"
ark_str_477:
    .asciz ".thumb_func\n"
ark_str_478:
    .asciz "__aeabi_lmul:\n"
ark_str_479:
    .asciz "    PUSH {r4, r5, lr}\n"
ark_str_480:
    .asciz "    MOV r4, r3\n"
ark_str_481:
    .asciz "    MUL r4, r0\n"
ark_str_482:
    .asciz "    MOV r5, r1\n"
ark_str_483:
    .asciz "    MUL r5, r2\n"
ark_str_484:
    .asciz "    UMULL r0, r1, r0, r2\n"
ark_str_485:
    .asciz "    ADD r1, r4\n"
ark_str_486:
    .asciz "    ADD r1, r5\n"
ark_str_487:
    .asciz "    POP {r4, r5, pc}\n\n"
ark_str_488:
    .asciz ".global __aeabi_lcmp\n"
ark_str_489:
    .asciz ".thumb_func\n"
ark_str_490:
    .asciz "__aeabi_lcmp:\n"
ark_str_491:
    .asciz "    CMP r1, r3\n"
ark_str_492:
    .asciz "    BGT .L_lcmp_gt\n"
ark_str_493:
    .asciz "    BLT .L_lcmp_lt\n"
ark_str_494:
    .asciz "    CMP r0, r2\n"
ark_str_495:
    .asciz "    BHI .L_lcmp_gt\n"
ark_str_496:
    .asciz "    BCC .L_lcmp_lt\n"
ark_str_497:
    .asciz "    MOV r0, #0\n"
ark_str_498:
    .asciz "    BX lr\n"
ark_str_499:
    .asciz ".L_lcmp_lt:\n"
ark_str_500:
    .asciz "    MOV r0, #0\n"
ark_str_501:
    .asciz "    MVN r0, r0\n"
ark_str_502:
    .asciz "    BX lr\n"
ark_str_503:
    .asciz ".L_lcmp_gt:\n"
ark_str_504:
    .asciz "    MOV r0, #1\n"
ark_str_505:
    .asciz "    BX lr\n\n"
ark_str_506:
    .asciz ".global __aeabi_ulcmp\n"
ark_str_507:
    .asciz ".thumb_func\n"
ark_str_508:
    .asciz "__aeabi_ulcmp:\n"
ark_str_509:
    .asciz "    CMP r1, r3\n"
ark_str_510:
    .asciz "    BHI .L_ulcmp_gt\n"
ark_str_511:
    .asciz "    BCC .L_ulcmp_lt\n"
ark_str_512:
    .asciz "    CMP r0, r2\n"
ark_str_513:
    .asciz "    BHI .L_ulcmp_gt\n"
ark_str_514:
    .asciz "    BCC .L_ulcmp_lt\n"
ark_str_515:
    .asciz "    MOV r0, #0\n"
ark_str_516:
    .asciz "    BX lr\n"
ark_str_517:
    .asciz ".L_ulcmp_lt:\n"
ark_str_518:
    .asciz "    MOV r0, #0\n"
ark_str_519:
    .asciz "    MVN r0, r0\n"
ark_str_520:
    .asciz "    BX lr\n"
ark_str_521:
    .asciz ".L_ulcmp_gt:\n"
ark_str_522:
    .asciz "    MOV r0, #1\n"
ark_str_523:
    .asciz "    BX lr\n\n"
ark_str_524:
    .asciz ".global __aeabi_uldivmod\n"
ark_str_525:
    .asciz ".thumb_func\n"
ark_str_526:
    .asciz "__aeabi_uldivmod:\n"
ark_str_527:
    .asciz "    Push {r4, r5, r6, r7, lr}\n"
ark_str_528:
    .asciz "    MOV r6, r2\n"
ark_str_529:
    .asciz "    MOV r7, r3\n"
ark_str_530:
    .asciz "    MOV r2, #0\n"
ark_str_531:
    .asciz "    MOV r3, #0\n"
ark_str_532:
    .asciz "    MOV r4, #64\n"
ark_str_533:
    .asciz "    MOV r5, r6\n"
ark_str_534:
    .asciz "    ORR r5, r7\n"
ark_str_535:
    .asciz "    CMP r5, #0\n"
ark_str_536:
    .asciz "    BEQ .L_uldiv_zero\n"
ark_str_537:
    .asciz ".L_uldiv_loop:\n"
ark_str_538:
    .asciz "    LSR r5, r1, #31\n"
ark_str_539:
    .asciz "    Push {r5}\n"
ark_str_540:
    .asciz "    LSR r5, r0, #31\n"
ark_str_541:
    .asciz "    LSL r0, r0, #1\n"
ark_str_542:
    .asciz "    LSL r1, r1, #1\n"
ark_str_543:
    .asciz "    ORR r1, r5\n"
ark_str_544:
    .asciz "    Pop {r5}\n"
ark_str_545:
    .asciz "    Push {r4}\n"
ark_str_546:
    .asciz "    LSR r4, r2, #31\n"
ark_str_547:
    .asciz "    LSL r2, r2, #1\n"
ark_str_548:
    .asciz "    ORR r2, r5\n"
ark_str_549:
    .asciz "    LSL r3, r3, #1\n"
ark_str_550:
    .asciz "    ORR r3, r4\n"
ark_str_551:
    .asciz "    Pop {r4}\n"
ark_str_552:
    .asciz "    CMP r3, r7\n"
ark_str_553:
    .asciz "    BHI .L_uldiv_sub\n"
ark_str_554:
    .asciz "    BCC .L_uldiv_skip\n"
ark_str_555:
    .asciz "    CMP r2, r6\n"
ark_str_556:
    .asciz "    BCC .L_uldiv_skip\n"
ark_str_557:
    .asciz ".L_uldiv_sub:\n"
ark_str_558:
    .asciz "    SUB r2, r2, r6\n"
ark_str_559:
    .asciz "    SBC r3, r7\n"
ark_str_560:
    .asciz "    MOV r5, #1\n"
ark_str_561:
    .asciz "    ORR r0, r5\n"
ark_str_562:
    .asciz ".L_uldiv_skip:\n"
ark_str_563:
    .asciz "    SUB r4, r4, #1\n"
ark_str_564:
    .asciz "    BNE .L_uldiv_loop\n"
ark_str_565:
    .asciz "    Pop {r4, r5, r6, r7, pc}\n"
ark_str_566:
    .asciz ".L_uldiv_zero:\n"
ark_str_567:
    .asciz "    MOV r0, #0\n"
ark_str_568:
    .asciz "    MOV r1, #0\n"
ark_str_569:
    .asciz "    MOV r2, #0\n"
ark_str_570:
    .asciz "    MOV r3, #0\n"
ark_str_571:
    .asciz "    Pop {r4, r5, r6, r7, pc}\n\n"
ark_str_572:
    .asciz ".global __aeabi_ldivmod\n"
ark_str_573:
    .asciz ".thumb_func\n"
ark_str_574:
    .asciz "__aeabi_ldivmod:\n"
ark_str_575:
    .asciz "    Push {r4, r5, r6, r7, lr}\n"
ark_str_576:
    .asciz "    ASR r5, r1, #31\n"
ark_str_577:
    .asciz "    MOV r6, r5\n"
ark_str_578:
    .asciz "    CMP r5, #0\n"
ark_str_579:
    .asciz "    BEQ .L_ldiv_posd\n"
ark_str_580:
    .asciz "    CMP r0, #0\n"
ark_str_581:
    .asciz "    BEQ .L_ldiv_neg_d_hi\n"
ark_str_582:
    .asciz "    RSB r0, r0\n"
ark_str_583:
    .asciz "    MVN r1, r1\n"
ark_str_584:
    .asciz "    B .L_ldiv_posd\n"
ark_str_585:
    .asciz ".L_ldiv_neg_d_hi:\n"
ark_str_586:
    .asciz "    RSB r1, r1\n"
ark_str_587:
    .asciz ".L_ldiv_posd:\n"
ark_str_588:
    .asciz "    ASR r5, r3, #31\n"
ark_str_589:
    .asciz "    CMP r5, #0\n"
ark_str_590:
    .asciz "    BEQ .L_ldiv_posb\n"
ark_str_591:
    .asciz "    CMP r2, #0\n"
ark_str_592:
    .asciz "    BEQ .L_ldiv_neg_b_hi\n"
ark_str_593:
    .asciz "    RSB r2, r2\n"
ark_str_594:
    .asciz "    MVN r3, r3\n"
ark_str_595:
    .asciz "    B .L_ldiv_posb\n"
ark_str_596:
    .asciz ".L_ldiv_neg_b_hi:\n"
ark_str_597:
    .asciz "    RSB r3, r3\n"
ark_str_598:
    .asciz ".L_ldiv_posb:\n"
ark_str_599:
    .asciz "    BL __aeabi_uldivmod\n"
ark_str_600:
    .asciz "    MOV r4, r6\n"
ark_str_601:
    .asciz "    EOR r4, r5\n"
ark_str_602:
    .asciz "    CMP r4, #0\n"
ark_str_603:
    .asciz "    BEQ .L_ldiv_qpos\n"
ark_str_604:
    .asciz "    CMP r0, #0\n"
ark_str_605:
    .asciz "    BEQ .L_ldiv_neg_q_hi\n"
ark_str_606:
    .asciz "    RSB r0, r0\n"
ark_str_607:
    .asciz "    MVN r1, r1\n"
ark_str_608:
    .asciz "    B .L_ldiv_qpos\n"
ark_str_609:
    .asciz ".L_ldiv_neg_q_hi:\n"
ark_str_610:
    .asciz "    RSB r1, r1\n"
ark_str_611:
    .asciz ".L_ldiv_qpos:\n"
ark_str_612:
    .asciz "    CMP r6, #0\n"
ark_str_613:
    .asciz "    BEQ .L_ldiv_rpos\n"
ark_str_614:
    .asciz "    CMP r2, #0\n"
ark_str_615:
    .asciz "    BEQ .L_ldiv_neg_r_hi\n"
ark_str_616:
    .asciz "    RSB r2, r2\n"
ark_str_617:
    .asciz "    MVN r3, r3\n"
ark_str_618:
    .asciz "    B .L_ldiv_rpos\n"
ark_str_619:
    .asciz ".L_ldiv_neg_r_hi:\n"
ark_str_620:
    .asciz "    RSB r3, r3\n"
ark_str_621:
    .asciz ".L_ldiv_rpos:\n"
ark_str_622:
    .asciz "    Pop {r4, r5, r6, r7, pc}\n\n"
ark_str_623:
    .asciz ".global __aeabi_f2iz\n.thumb_func\n__aeabi_f2iz:\n"
ark_str_624:
    .asciz "    LSR r1, r0, #23\n"
ark_str_625:
    .asciz "    LSL r1, r1, #1\n"
ark_str_626:
    .asciz "    LSR r1, r1, #1\n"
ark_str_627:
    .asciz "    CMP r1, #150\n"
ark_str_628:
    .asciz "    BGE .L_f2iz_shl\n"
ark_str_629:
    .asciz "    CMP r1, #126\n"
ark_str_630:
    .asciz "    BLT .L_f2iz_zero\n"
ark_str_631:
    .asciz "    SUB r2, r1, #127\n"
ark_str_632:
    .asciz "    LSL r0, r0, #9\n"
ark_str_633:
    .asciz "    LSR r0, r0, r2\n"
ark_str_634:
    .asciz "    B .L_f2iz_sign\n"
ark_str_635:
    .asciz ".L_f2iz_shl:\n"
ark_str_636:
    .asciz "    SUB r2, r1, #150\n"
ark_str_637:
    .asciz "    MOV r0, #0x800000\n"
ark_str_638:
    .asciz "    LSL r0, r0, r2\n"
ark_str_639:
    .asciz ".L_f2iz_sign:\n"
ark_str_640:
    .asciz "    LSR r1, r0, #31\n"
ark_str_641:
    .asciz "    CMP r1, #0\n"
ark_str_642:
    .asciz "    BEQ .L_f2iz_done\n"
ark_str_643:
    .asciz "    RSB r0, r0, #0\n"
ark_str_644:
    .asciz ".L_f2iz_done:\n"
ark_str_645:
    .asciz "    BX lr\n"
ark_str_646:
    .asciz ".L_f2iz_zero:\n"
ark_str_647:
    .asciz "    MOV r0, #0\n"
ark_str_648:
    .asciz "    BX lr\n\n"
ark_str_649:
    .asciz ".global __aeabi_f2uiz\n.thumb_func\n__aeabi_f2uiz:\n"
ark_str_650:
    .asciz "    PUSH {lr}\n"
ark_str_651:
    .asciz "    BL __aeabi_f2iz\n"
ark_str_652:
    .asciz "    POP {r0}\n"
ark_str_653:
    .asciz "    BX r0\n\n"
ark_str_654:
    .asciz ".global __aeabi_i2f\n.thumb_func\n__aeabi_i2f:\n"
ark_str_655:
    .asciz "    PUSH {lr}\n"
ark_str_656:
    .asciz "    CMP r0, #0\n"
ark_str_657:
    .asciz "    BGE .L_i2f_pos\n"
ark_str_658:
    .asciz "    RSB r0, r0, #0\n"
ark_str_659:
    .asciz "    MOV r1, #1\n"
ark_str_660:
    .asciz "    B .L_i2f_conv\n"
ark_str_661:
    .asciz ".L_i2f_pos:\n"
ark_str_662:
    .asciz "    MOV r1, #0\n"
ark_str_663:
    .asciz ".L_i2f_conv:\n"
ark_str_664:
    .asciz "    CLZ r2, r0\n"
ark_str_665:
    .asciz "    RSB r2, r2, #31\n"
ark_str_666:
    .asciz "    MOV r3, #127\n"
ark_str_667:
    .asciz "    ADD r3, r3, r2\n"
ark_str_668:
    .asciz "    LSL r3, r3, #23\n"
ark_str_669:
    .asciz "    LSL r0, r0, r2\n"
ark_str_670:
    .asciz "    LSL r0, r0, #1\n"
ark_str_671:
    .asciz "    LSR r0, r0, #9\n"
ark_str_672:
    .asciz "    ORR r0, r0, r3\n"
ark_str_673:
    .asciz "    CMP r1, #0\n"
ark_str_674:
    .asciz "    BEQ .L_i2f_done\n"
ark_str_675:
    .asciz "    MOV r1, #1\n"
ark_str_676:
    .asciz "    LSL r1, r1, #31\n"
ark_str_677:
    .asciz "    ORR r0, r0, r1\n"
ark_str_678:
    .asciz ".L_i2f_done:\n"
ark_str_679:
    .asciz "    POP {r0}\n"
ark_str_680:
    .asciz "    BX r0\n\n"
ark_str_681:
    .asciz ".global __aeabi_ui2f\n.thumb_func\n__aeabi_ui2f:\n"
ark_str_682:
    .asciz "    PUSH {lr}\n"
ark_str_683:
    .asciz "    MOV r1, #0\n"
ark_str_684:
    .asciz "    B .L_i2f_conv\n\n"
ark_str_685:
    .asciz ".global __aeabi_fadd\n.thumb_func\n__aeabi_fadd:\n"
ark_str_686:
    .asciz "    BX lr\n\n"
ark_str_687:
    .asciz ".global __aeabi_fsub\n.thumb_func\n__aeabi_fsub:\n"
ark_str_688:
    .asciz "    BX lr\n\n"
ark_str_689:
    .asciz ".global __aeabi_fmul\n.thumb_func\n__aeabi_fmul:\n"
ark_str_690:
    .asciz "    BX lr\n\n"
ark_str_691:
    .asciz ".global __aeabi_fdiv\n.thumb_func\n__aeabi_fdiv:\n"
ark_str_692:
    .asciz "    BX lr\n\n"
ark_str_693:
    .asciz ".global __aeabi_d2iz\n.thumb_func\n__aeabi_d2iz:\n"
ark_str_694:
    .asciz "    POP {r1}\n"
ark_str_695:
    .asciz "    PUSH {lr}\n"
ark_str_696:
    .asciz "    BL __aeabi_f2iz\n"
ark_str_697:
    .asciz "    POP {r0}\n"
ark_str_698:
    .asciz "    BX r0\n\n"
ark_str_699:
    .asciz ".global __aeabi_d2uiz\n.thumb_func\n__aeabi_d2uiz:\n"
ark_str_700:
    .asciz "    POP {r1}\n"
ark_str_701:
    .asciz "    PUSH {lr}\n"
ark_str_702:
    .asciz "    BL __aeabi_f2uiz\n"
ark_str_703:
    .asciz "    POP {r0}\n"
ark_str_704:
    .asciz "    BX r0\n\n"
ark_str_705:
    .asciz ".global __aeabi_i2d\n.thumb_func\n__aeabi_i2d:\n"
ark_str_706:
    .asciz "    PUSH {lr}\n"
ark_str_707:
    .asciz "    BL __aeabi_i2f\n"
ark_str_708:
    .asciz "    MOV r1, #0\n"
ark_str_709:
    .asciz "    POP {r0}\n"
ark_str_710:
    .asciz "    BX r0\n\n"
ark_str_711:
    .asciz ".global __aeabi_ui2d\n.thumb_func\n__aeabi_ui2d:\n"
ark_str_712:
    .asciz "    PUSH {lr}\n"
ark_str_713:
    .asciz "    BL __aeabi_ui2f\n"
ark_str_714:
    .asciz "    MOV r1, #0\n"
ark_str_715:
    .asciz "    POP {r0}\n"
ark_str_716:
    .asciz "    BX r0\n\n"
ark_str_717:
    .asciz ".global __aeabi_dadd\n.thumb_func\n__aeabi_dadd:\n"
ark_str_718:
    .asciz "    BX lr\n\n"
ark_str_719:
    .asciz ".global __aeabi_dsub\n.thumb_func\n__aeabi_dsub:\n"
ark_str_720:
    .asciz "    BX lr\n\n"
ark_str_721:
    .asciz ".global __aeabi_dmul\n.thumb_func\n__aeabi_dmul:\n"
ark_str_722:
    .asciz "    BX lr\n\n"
ark_str_723:
    .asciz ".global __aeabi_ddiv\n.thumb_func\n__aeabi_ddiv:\n"
ark_str_724:
    .asciz "    BX lr\n\n"
ark_str_725:
    .asciz ".global __aeabi_fcmpeq\n.thumb_func\n__aeabi_fcmpeq:\n"
ark_str_726:
    .asciz "    CMP r0, r1\n"
ark_str_727:
    .asciz "    ITE EQ\n"
ark_str_728:
    .asciz "    MOVEQ r0, #1\n"
ark_str_729:
    .asciz "    MOVNE r0, #0\n"
ark_str_730:
    .asciz "    BX lr\n\n"
ark_str_731:
    .asciz ".global __aeabi_fcmplt\n.thumb_func\n__aeabi_fcmplt:\n"
ark_str_732:
    .asciz "    CMP r0, r1\n"
ark_str_733:
    .asciz "    ITE LT\n"
ark_str_734:
    .asciz "    MOVLT r0, #1\n"
ark_str_735:
    .asciz "    MOVGE r0, #0\n"
ark_str_736:
    .asciz "    BX lr\n\n"
ark_str_737:
    .asciz ".global __aeabi_fcmpgt\n.thumb_func\n__aeabi_fcmpgt:\n"
ark_str_738:
    .asciz "    CMP r0, r1\n"
ark_str_739:
    .asciz "    ITE GT\n"
ark_str_740:
    .asciz "    MOVGT r0, #1\n"
ark_str_741:
    .asciz "    MOVLE r0, #0\n"
ark_str_742:
    .asciz "    BX lr\n\n"
ark_str_743:
    .asciz ".global __aeabi_fcmple\n.thumb_func\n__aeabi_fcmple:\n"
ark_str_744:
    .asciz "    CMP r0, r1\n"
ark_str_745:
    .asciz "    ITE LE\n"
ark_str_746:
    .asciz "    MOVLE r0, #1\n"
ark_str_747:
    .asciz "    MOVGT r0, #0\n"
ark_str_748:
    .asciz "    BX lr\n\n"
ark_str_749:
    .asciz ".global __aeabi_fcmpge\n.thumb_func\n__aeabi_fcmpge:\n"
ark_str_750:
    .asciz "    CMP r0, r1\n"
ark_str_751:
    .asciz "    ITE GE\n"
ark_str_752:
    .asciz "    MOVGE r0, #1\n"
ark_str_753:
    .asciz "    MOVLT r0, #0\n"
ark_str_754:
    .asciz "    BX lr\n\n"
ark_str_755:
    .asciz ".global "
ark_str_756:
    .asciz ".set "
ark_str_757:
    .asciz ", 0x"
ark_str_758:
    .asciz "0123456789abcdef"
ark_str_759:
    .asciz ".section \""
ark_str_760:
    .asciz "\"\n"
ark_str_761:
    .asciz ".data\n"
ark_str_762:
    .asciz ".bss\n"
ark_str_763:
    .asciz ".section .rodata\n"
ark_str_764:
    .asciz ".global "
ark_str_765:
    .asciz ".balign "
ark_str_766:
    .asciz ".align 4\n"
ark_str_767:
    .asciz ":\n"
ark_str_768:
    .asciz "    .zero "
ark_str_769:
    .asciz "0123456789abcdef"
ark_str_770:
    .asciz "    .word 0x"
ark_str_771:
    .asciz "    .asciz \""
ark_str_772:
    .asciz "\\n"
ark_str_773:
    .asciz "\\t"
ark_str_774:
    .asciz "\\\\"
ark_str_775:
    .asciz "\\\""
ark_str_776:
    .asciz "0123456789abcdef"
ark_str_777:
    .asciz "\"\n"
ark_str_778:
    .asciz "    .zero "
ark_str_779:
    .asciz "    .word "
ark_str_780:
    .asciz "    .zero "
ark_str_781:
    .asciz ".text\n\n"
ark_str_782:
    .asciz "BL"
ark_str_783:
    .asciz "MOVW"
ark_str_784:
    .asciz "MOVT"
ark_str_785:
    .asciz "SDIV"
ark_str_786:
    .asciz "UDIV"
ark_str_787:
    .asciz "UMULL"
ark_str_788:
    .asciz "B.W"
ark_str_789:
    .asciz "B"
ark_str_790:
    .asciz "BEQ"
ark_str_791:
    .asciz "BNE"
ark_str_792:
    .asciz "BCS"
ark_str_793:
    .asciz "BCC"
ark_str_794:
    .asciz "BGE"
ark_str_795:
    .asciz "BLT"
ark_str_796:
    .asciz "BGT"
ark_str_797:
    .asciz "BLE"
ark_str_798:
    .asciz "DMB"
ark_str_799:
    .asciz "DSB"
ark_str_800:
    .asciz "ISB"
ark_str_801:
    .asciz "RRX"
ark_str_802:
    .asciz "VMOV"
ark_str_803:
    .asciz "VADD"
ark_str_804:
    .asciz "VSUB"
ark_str_805:
    .asciz "VMUL"
ark_str_806:
    .asciz "VDIV"
ark_str_807:
    .asciz "VCVT"
ark_str_808:
    .asciz "VCMP"
ark_str_809:
    .asciz "VMRS"
ark_str_810:
    .asciz "VSTR"
ark_str_811:
    .asciz "VLDR"
ark_str_812:
    .asciz "VNEG"
ark_str_813:
    .asciz "VABS"
ark_str_814:
    .asciz "VSQRT"
ark_str_815:
    .asciz ".set"
ark_str_816:
    .asciz ".equ"
ark_str_817:
    .asciz ".zero"
ark_str_818:
    .asciz ".skip"
ark_str_819:
    .asciz ".space"
ark_str_820:
    .asciz ".word"
ark_str_821:
    .asciz ".long"
ark_str_822:
    .asciz ".byte"
ark_str_823:
    .asciz ".asciz"
ark_str_824:
    .asciz ".ascii"
ark_str_825:
    .asciz ".align"
ark_str_826:
    .asciz ".balign"
ark_str_827:
    .asciz "LDR"
ark_str_828:
    .asciz "LDRB"
ark_str_829:
    .asciz "STR"
ark_str_830:
    .asciz "STRB"
ark_str_831:
    .asciz "LDRH"
ark_str_832:
    .asciz "STRH"
ark_str_833:
    .asciz "LDRSH"
ark_str_834:
    .asciz "LDRSB"
ark_str_835:
    .asciz "LDRH"
ark_str_836:
    .asciz "STRH"
ark_str_837:
    .asciz "LDRSH"
ark_str_838:
    .asciz "LDRSB"
ark_str_839:
    .asciz "PUSH"
ark_str_840:
    .asciz "POP"
ark_str_841:
    .asciz "ADD"
ark_str_842:
    .asciz "SUB"
ark_str_843:
    .asciz "CMP"
ark_str_844:
    .asciz "MOVEQ"
ark_str_845:
    .asciz "MOVNE"
ark_str_846:
    .asciz "MOVLT"
ark_str_847:
    .asciz "MOVGT"
ark_str_848:
    .asciz "MOVLE"
ark_str_849:
    .asciz "MOVGE"
ark_str_850:
    .asciz "MOVLO"
ark_str_851:
    .asciz "MOVHI"
ark_str_852:
    .asciz "MOVLS"
ark_str_853:
    .asciz "MOVHS"
ark_str_854:
    .asciz "MOVCS"
ark_str_855:
    .asciz "MOVCC"
ark_str_856:
    .asciz ".set"
ark_str_857:
    .asciz ".equ"
ark_str_858:
    .asciz ".zero"
ark_str_859:
    .asciz ".skip"
ark_str_860:
    .asciz ".space"
ark_str_861:
    .asciz ".word"
ark_str_862:
    .asciz ".long"
ark_str_863:
    .asciz ".byte"
ark_str_864:
    .asciz ".asciz"
ark_str_865:
    .asciz ".ascii"
ark_str_866:
    .asciz ".asciz"
ark_str_867:
    .asciz ".align"
ark_str_868:
    .asciz ".balign"
ark_str_869:
    .asciz "PUSH"
ark_str_870:
    .asciz "POP"
ark_str_871:
    .asciz "MOV"
ark_str_872:
    .asciz "MOVEQ"
ark_str_873:
    .asciz "MOVNE"
ark_str_874:
    .asciz "MOVLT"
ark_str_875:
    .asciz "MOVGT"
ark_str_876:
    .asciz "MOVLE"
ark_str_877:
    .asciz "MOVGE"
ark_str_878:
    .asciz "MOVLO"
ark_str_879:
    .asciz "MOVHI"
ark_str_880:
    .asciz "MOVLS"
ark_str_881:
    .asciz "MOVHS"
ark_str_882:
    .asciz "MOVCS"
ark_str_883:
    .asciz "MOVCC"
ark_str_884:
    .asciz "MOVW"
ark_str_885:
    .asciz "MOVT"
ark_str_886:
    .asciz "ADD"
ark_str_887:
    .asciz "SUB"
ark_str_888:
    .asciz "MUL"
ark_str_889:
    .asciz "ADC"
ark_str_890:
    .asciz "SBC"
ark_str_891:
    .asciz "UMULL"
ark_str_892:
    .asciz "SDIV"
ark_str_893:
    .asciz "UDIV"
ark_str_894:
    .asciz "SDIV"
ark_str_895:
    .asciz "AND"
ark_str_896:
    .asciz "ORR"
ark_str_897:
    .asciz "EOR"
ark_str_898:
    .asciz "LSL"
ark_str_899:
    .asciz "LSR"
ark_str_900:
    .asciz "ASR"
ark_str_901:
    .asciz "BIC"
ark_str_902:
    .asciz "MVN"
ark_str_903:
    .asciz "NEG"
ark_str_904:
    .asciz "RSB"
ark_str_905:
    .asciz "CMP"
ark_str_906:
    .asciz "LDR"
ark_str_907:
    .asciz "LDRB"
ark_str_908:
    .asciz "STR"
ark_str_909:
    .asciz "STRB"
ark_str_910:
    .asciz "[asm-arm] unresolved symbol '%s' in LDR =label\n"
ark_str_911:
    .asciz "BX"
ark_str_912:
    .asciz "NOP"
ark_str_913:
    .asciz "IT"
ark_str_914:
    .asciz "ITT"
ark_str_915:
    .asciz "ITE"
ark_str_916:
    .asciz "ITTT"
ark_str_917:
    .asciz "EQ"
ark_str_918:
    .asciz "NE"
ark_str_919:
    .asciz "HS"
ark_str_920:
    .asciz "CS"
ark_str_921:
    .asciz "LO"
ark_str_922:
    .asciz "CC"
ark_str_923:
    .asciz "MI"
ark_str_924:
    .asciz "PL"
ark_str_925:
    .asciz "VS"
ark_str_926:
    .asciz "VC"
ark_str_927:
    .asciz "HI"
ark_str_928:
    .asciz "LS"
ark_str_929:
    .asciz "GE"
ark_str_930:
    .asciz "LT"
ark_str_931:
    .asciz "GT"
ark_str_932:
    .asciz "LE"
ark_str_933:
    .asciz "IT"
ark_str_934:
    .asciz "ITT"
ark_str_935:
    .asciz "ITE"
ark_str_936:
    .asciz "BL"
ark_str_937:
    .asciz "B"
ark_str_938:
    .asciz "BEQ"
ark_str_939:
    .asciz "BNE"
ark_str_940:
    .asciz "BLT"
ark_str_941:
    .asciz "BGT"
ark_str_942:
    .asciz "BLE"
ark_str_943:
    .asciz "BGE"
ark_str_944:
    .asciz "BCC"
ark_str_945:
    .asciz "BCS"
ark_str_946:
    .asciz "BEQ"
ark_str_947:
    .asciz "BNE"
ark_str_948:
    .asciz "BCS"
ark_str_949:
    .asciz "BCC"
ark_str_950:
    .asciz "BGE"
ark_str_951:
    .asciz "BLT"
ark_str_952:
    .asciz "BGT"
ark_str_953:
    .asciz "BLE"
ark_str_954:
    .asciz "STRH"
ark_str_955:
    .asciz "LDRH"
ark_str_956:
    .asciz "LDRSH"
ark_str_957:
    .asciz "LDRSB"
ark_str_958:
    .asciz "STRH"
ark_str_959:
    .asciz "LDRH"
ark_str_960:
    .asciz "LDRSH"
ark_str_961:
    .asciz "STRH"
ark_str_962:
    .asciz "LDRH"
ark_str_963:
    .asciz "LDRSH"
ark_str_964:
    .asciz "CPSID"
ark_str_965:
    .asciz "CPSIE"
ark_str_966:
    .asciz "CPSID"
ark_str_967:
    .asciz "DMB"
ark_str_968:
    .asciz "DSB"
ark_str_969:
    .asciz "ISB"
ark_str_970:
    .asciz "DMB"
ark_str_971:
    .asciz "DSB"
ark_str_972:
    .asciz "SEV"
ark_str_973:
    .asciz "WFE"
ark_str_974:
    .asciz "WFI"
ark_str_975:
    .asciz "SEV"
ark_str_976:
    .asciz "WFE"
ark_str_977:
    .asciz "REV"
ark_str_978:
    .asciz "REV16"
ark_str_979:
    .asciz "REVSH"
ark_str_980:
    .asciz "REV"
ark_str_981:
    .asciz "REV16"
ark_str_982:
    .asciz "RRX"
ark_str_983:
    .asciz "VMOV"
ark_str_984:
    .asciz "VADD"
ark_str_985:
    .asciz "VSUB"
ark_str_986:
    .asciz "VMUL"
ark_str_987:
    .asciz "VDIV"
ark_str_988:
    .asciz "F64"
ark_str_989:
    .asciz "VADD"
ark_str_990:
    .asciz "VSUB"
ark_str_991:
    .asciz "VMUL"
ark_str_992:
    .asciz "VCVT"
ark_str_993:
    .asciz "S32F32"
ark_str_994:
    .asciz "F32S32"
ark_str_995:
    .asciz "S32F64"
ark_str_996:
    .asciz "F64S32"
ark_str_997:
    .asciz "S32F64"
ark_str_998:
    .asciz "F64S32"
ark_str_999:
    .asciz "VCMP"
ark_str_1000:
    .asciz "F64"
ark_str_1001:
    .asciz "VMRS"
ark_str_1002:
    .asciz "VNEG"
ark_str_1003:
    .asciz "VABS"
ark_str_1004:
    .asciz "VSQRT"
ark_str_1005:
    .asciz "F64"
ark_str_1006:
    .asciz "VNEG"
ark_str_1007:
    .asciz "VABS"
ark_str_1008:
    .asciz "VLDR"
ark_str_1009:
    .asciz "VSTR"
ark_str_1010:
    .asciz "F64"
ark_str_1011:
    .asciz "VLDR"
ark_str_1012:
    .asciz "[asm-arm] unresolved label '%s'\n"
ark_str_1013:
    .asciz "ARKCC_DUMP_SYMS"
ark_str_1014:
    .asciz "=== ARM Symbol Map (%d labels) ===\n"
ark_str_1015:
    .asciz "  %-40s 0x%04X (%d)\n"
ark_str_1016:
    .asciz "=== End Symbol Map ===\n"
ark_str_1017:
    .asciz "arm"
ark_str_1018:
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
    leal ark_str_10, %eax
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
    leal ark_str_11, %eax
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
    leal ark_str_12, %eax
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
    leal ark_str_13, %eax
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
    leal ark_str_14, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_2:
    leal ark_str_15, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_3:
    leal ark_str_16, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_4:
    leal ark_str_17, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_5:
    leal ark_str_18, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_19, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_20, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_6:
    leal ark_str_21, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_7:
    leal ark_str_22, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_8:
    leal ark_str_23, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_9:
    leal ark_str_24, %eax
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
    leal ark_str_25, %eax
    pushl %eax
    jmp .Lemit_binary_19
.Lemit_binary_18:
    leal ark_str_26, %eax
    pushl %eax
.Lemit_binary_19:
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_11:
    leal ark_str_27, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_28, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_29, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_30, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_12:
    leal ark_str_31, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_32, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_33, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_34, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_0
.Lemit_binary_13:
    leal ark_str_35, %eax
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
    jmp .Lemit_binary_21
.Lemit_binary_20:
    leal ark_str_39, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_40, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_41, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lemit_binary_21:
    jmp .Lemit_binary_0
.Lemit_binary_14:
    leal ark_str_42, %eax
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
    leal ark_str_43, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_44, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_45, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_binary_23
.Lemit_binary_22:
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
.Lemit_binary_23:
    jmp .Lemit_binary_0
.Lemit_binary_15:
    leal ark_str_49, %eax
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
    jmp .Lemit_binary_25
.Lemit_binary_24:
    leal ark_str_53, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
.Lemit_binary_25:
    jmp .Lemit_binary_0
.Lemit_binary_16:
    leal ark_str_56, %eax
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
    jmp .Lemit_binary_27
.Lemit_binary_26:
    leal ark_str_60, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
.Lemit_binary_27:
    jmp .Lemit_binary_0
.Lemit_binary_17:
    leal ark_str_63, %eax
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
    leal ark_str_64, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_unary_0
.Lemit_unary_2:
    leal ark_str_65, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_unary_0
.Lemit_unary_3:
    leal ark_str_66, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_67, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_68, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_69, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_unary_0
.Lemit_unary_4:
    leal ark_str_70, %eax
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
    leal ark_str_71, %eax
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
    leal ark_str_72, %eax
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
    leal ark_str_73, %eax
    pushl %eax
    pushl -56(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_prologue_5
.Lemit_prologue_4:
    leal ark_str_74, %eax
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
    leal ark_str_75, %eax
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
    leal ark_str_76, %eax
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
    leal ark_str_77, %eax
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
    leal ark_str_78, %eax
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
    leal ark_str_79, %eax
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
    leal ark_str_80, %eax
    pushl %eax
    pushl -40(%ebp)
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_epilogue_return_5
.Lemit_epilogue_return_4:
    leal ark_str_81, %eax
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
    pushl $0
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
    leal ark_str_82, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_83, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_84, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    je .Lcodegen_arm_0
    leal ark_str_85, %eax
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
.Lcodegen_arm_2:
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
    je .Lcodegen_arm_3
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
    leal ark_str_86, %eax
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
    leal ark_str_87, %eax
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
.Lcodegen_arm_5:
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
    je .Lcodegen_arm_6
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
    je .Lcodegen_arm_8
    leal ark_str_88, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_9
.Lcodegen_arm_8:
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
    je .Lcodegen_arm_10
    leal ark_str_89, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_11
.Lcodegen_arm_10:
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
    je .Lcodegen_arm_12
    leal ark_str_90, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_13
.Lcodegen_arm_12:
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
    je .Lcodegen_arm_14
    leal ark_str_91, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_15
.Lcodegen_arm_14:
    movzbl -2200(%ebp), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_15:
.Lcodegen_arm_13:
.Lcodegen_arm_11:
.Lcodegen_arm_9:
.Lcodegen_arm_7:
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
    jmp .Lcodegen_arm_5
.Lcodegen_arm_6:
    leal ark_str_92, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_4:
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
    jmp .Lcodegen_arm_2
.Lcodegen_arm_3:
    leal ark_str_93, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_1
.Lcodegen_arm_0:
.Lcodegen_arm_1:
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
    je .Lcodegen_arm_16
    leal ark_str_94, %eax
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
.Lcodegen_arm_18:
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
    je .Lcodegen_arm_19
    leal ark_str_95, %eax
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
.Lcodegen_arm_21:
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
    je .Lcodegen_arm_22
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
.Lcodegen_arm_23:
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
    jmp .Lcodegen_arm_21
.Lcodegen_arm_22:
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
    leal ark_str_96, %eax
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
    leal ark_str_97, %eax
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
    leal ark_str_98, %eax
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
    leal ark_str_99, %eax
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
.Lcodegen_arm_24:
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
    je .Lcodegen_arm_25
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
.Lcodegen_arm_26:
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
    jmp .Lcodegen_arm_24
.Lcodegen_arm_25:
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
    leal ark_str_100, %eax
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
.Lcodegen_arm_27:
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
    je .Lcodegen_arm_28
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
.Lcodegen_arm_29:
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
    jmp .Lcodegen_arm_27
.Lcodegen_arm_28:
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
.Lcodegen_arm_20:
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
    jmp .Lcodegen_arm_18
.Lcodegen_arm_19:
    leal ark_str_101, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_17
.Lcodegen_arm_16:
.Lcodegen_arm_17:
    pushl $0
    popl %eax
    movl %eax, -176(%ebp)
    pushl $0
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
.Lcodegen_arm_30:
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
    je .Lcodegen_arm_33
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
    jmp .Lcodegen_arm_34
.Lcodegen_arm_33:
    pushl $0
.Lcodegen_arm_34:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_31
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
    je .Lcodegen_arm_37
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
    jne .Lcodegen_arm_39
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
    jmp .Lcodegen_arm_40
.Lcodegen_arm_39:
    pushl $1
.Lcodegen_arm_40:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_38
.Lcodegen_arm_37:
    pushl $0
.Lcodegen_arm_38:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_35
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
    je .Lcodegen_arm_41
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
    jmp .Lcodegen_arm_42
.Lcodegen_arm_41:
.Lcodegen_arm_42:
    jmp .Lcodegen_arm_36
.Lcodegen_arm_35:
.Lcodegen_arm_36:
.Lcodegen_arm_32:
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
    jmp .Lcodegen_arm_30
.Lcodegen_arm_31:
    pushl $0
    popl %eax
    movl %eax, -2240(%ebp)
    pushl -2240(%ebp)
    addl $4, %esp
.Lcodegen_arm_43:
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
    je .Lcodegen_arm_44
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
    je .Lcodegen_arm_50
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
    jne .Lcodegen_arm_52
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
    jmp .Lcodegen_arm_53
.Lcodegen_arm_52:
    pushl $1
.Lcodegen_arm_53:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_51
.Lcodegen_arm_50:
    pushl $0
.Lcodegen_arm_51:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_48
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
    jmp .Lcodegen_arm_49
.Lcodegen_arm_48:
    pushl $0
.Lcodegen_arm_49:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_46
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
    jmp .Lcodegen_arm_47
.Lcodegen_arm_46:
.Lcodegen_arm_47:
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
    je .Lcodegen_arm_54
    leal ark_str_102, %eax
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
    leal ark_str_103, %eax
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
    leal ark_str_104, %eax
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
    leal ark_str_105, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_45
.Lcodegen_arm_54:
.Lcodegen_arm_55:
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
    je .Lcodegen_arm_58
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
    jmp .Lcodegen_arm_59
.Lcodegen_arm_58:
    pushl $0
.Lcodegen_arm_59:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_56
    leal ark_str_106, %eax
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
    leal ark_str_107, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_57
.Lcodegen_arm_56:
.Lcodegen_arm_57:
    leal ark_str_108, %eax
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
    je .Lcodegen_arm_60
    leal ark_str_109, %eax
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
    jmp .Lcodegen_arm_61
.Lcodegen_arm_60:
.Lcodegen_arm_61:
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
    je .Lcodegen_arm_62
    leal ark_str_110, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_63
.Lcodegen_arm_62:
.Lcodegen_arm_63:
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
    je .Lcodegen_arm_64
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
    leal ark_str_111, %eax
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
    je .Lcodegen_arm_66
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
.Lcodegen_arm_68:
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_69
    pushl -120(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_70
.Lcodegen_arm_72:
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
    jne .Lcodegen_arm_76
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
    jmp .Lcodegen_arm_77
.Lcodegen_arm_76:
    pushl $1
.Lcodegen_arm_77:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_74
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
    jmp .Lcodegen_arm_75
.Lcodegen_arm_74:
    pushl $1
.Lcodegen_arm_75:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_73
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
    jmp .Lcodegen_arm_72
.Lcodegen_arm_73:
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
    je .Lcodegen_arm_78
    jmp .Lcodegen_arm_69
.Lcodegen_arm_78:
.Lcodegen_arm_79:
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
    je .Lcodegen_arm_80
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
    jmp .Lcodegen_arm_68
.Lcodegen_arm_80:
.Lcodegen_arm_81:
    leal ark_str_112, %eax
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
    jmp .Lcodegen_arm_71
.Lcodegen_arm_70:
.Lcodegen_arm_71:
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
    je .Lcodegen_arm_82
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
    jmp .Lcodegen_arm_68
.Lcodegen_arm_82:
.Lcodegen_arm_83:
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
    jmp .Lcodegen_arm_68
.Lcodegen_arm_69:
    pushl -120(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_84
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_85
.Lcodegen_arm_84:
.Lcodegen_arm_85:
    jmp .Lcodegen_arm_67
.Lcodegen_arm_66:
.Lcodegen_arm_67:
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_45
.Lcodegen_arm_64:
.Lcodegen_arm_65:
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
    leal ark_str_113, %eax
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
    je .Lcodegen_arm_88
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
    jne .Lcodegen_arm_90
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
    jmp .Lcodegen_arm_91
.Lcodegen_arm_90:
    pushl $1
.Lcodegen_arm_91:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_89
.Lcodegen_arm_88:
    pushl $0
.Lcodegen_arm_89:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_86
    leal ark_str_114, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_87
.Lcodegen_arm_86:
.Lcodegen_arm_87:
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_92
    leal ark_str_115, %eax
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
    leal ark_str_116, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_93
.Lcodegen_arm_92:
.Lcodegen_arm_93:
    pushl $0
    popl %eax
    movl %eax, -128(%ebp)
    pushl $0
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
.Lcodegen_arm_94:
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
    je .Lcodegen_arm_95
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
    jne .Lcodegen_arm_98
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
    jne .Lcodegen_arm_99
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
    jne .Lcodegen_arm_100
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
    jne .Lcodegen_arm_101
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
    jne .Lcodegen_arm_102
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
    jne .Lcodegen_arm_103
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
    jne .Lcodegen_arm_104
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
    jne .Lcodegen_arm_105
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
    jne .Lcodegen_arm_106
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
    jne .Lcodegen_arm_107
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
    jne .Lcodegen_arm_108
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
    jne .Lcodegen_arm_109
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
    jne .Lcodegen_arm_110
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
    jne .Lcodegen_arm_111
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
    jne .Lcodegen_arm_112
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
    jne .Lcodegen_arm_113
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
    jne .Lcodegen_arm_114
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
    jne .Lcodegen_arm_115
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
    jne .Lcodegen_arm_116
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
    jne .Lcodegen_arm_117
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
    jne .Lcodegen_arm_118
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
    jne .Lcodegen_arm_119
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
    jne .Lcodegen_arm_120
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
    jne .Lcodegen_arm_121
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
    jne .Lcodegen_arm_122
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
    jne .Lcodegen_arm_123
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
    jne .Lcodegen_arm_124
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
    jne .Lcodegen_arm_125
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
    jne .Lcodegen_arm_126
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
    jne .Lcodegen_arm_127
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
    jne .Lcodegen_arm_128
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
    jne .Lcodegen_arm_129
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
    jne .Lcodegen_arm_130
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
    jne .Lcodegen_arm_131
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
    jne .Lcodegen_arm_132
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
    jne .Lcodegen_arm_133
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
    jne .Lcodegen_arm_134
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
    jne .Lcodegen_arm_135
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
    jne .Lcodegen_arm_136
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
    jne .Lcodegen_arm_137
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
    jne .Lcodegen_arm_138
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
    jne .Lcodegen_arm_139
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
    jne .Lcodegen_arm_140
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
    jne .Lcodegen_arm_141
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
    jne .Lcodegen_arm_142
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
    jne .Lcodegen_arm_143
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
    jne .Lcodegen_arm_144
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
    jne .Lcodegen_arm_145
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
    jne .Lcodegen_arm_146
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
    jne .Lcodegen_arm_147
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
    jne .Lcodegen_arm_148
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
    jne .Lcodegen_arm_149
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
    jne .Lcodegen_arm_150
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
    jne .Lcodegen_arm_151
    jmp .Lcodegen_arm_152
.Lcodegen_arm_98:
.Lcodegen_arm_99:
    jmp .Lcodegen_arm_97
.Lcodegen_arm_100:
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
    je .Lcodegen_arm_153
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
    jmp .Lcodegen_arm_154
.Lcodegen_arm_153:
.Lcodegen_arm_154:
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
    je .Lcodegen_arm_155
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
    je .Lcodegen_arm_157
    leal ark_str_117, %eax
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
    leal ark_str_118, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_158
.Lcodegen_arm_157:
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
    leal ark_str_119, %eax
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
    leal ark_str_120, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_158:
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
    je .Lcodegen_arm_159
    pushl $0
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
.Lcodegen_arm_161:
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
    je .Lcodegen_arm_162
    leal ark_str_121, %eax
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
    leal ark_str_122, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
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
    leal ark_str_124, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_163:
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
    jmp .Lcodegen_arm_161
.Lcodegen_arm_162:
    jmp .Lcodegen_arm_160
.Lcodegen_arm_159:
    pushl $0
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
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
    leal ark_str_126, %eax
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
    leal ark_str_127, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_160:
    jmp .Lcodegen_arm_156
.Lcodegen_arm_155:
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
    je .Lcodegen_arm_164
    leal ark_str_128, %eax
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
    leal ark_str_129, %eax
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
    leal ark_str_130, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_165
.Lcodegen_arm_164:
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
    leal ark_str_131, %eax
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
    leal ark_str_132, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_133, %eax
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
    leal ark_str_134, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_165:
.Lcodegen_arm_156:
    jmp .Lcodegen_arm_97
.Lcodegen_arm_101:
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_102:
    leal ark_str_135, %eax
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_103:
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
    je .Lcodegen_arm_166
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_168
    leal ark_str_136, %eax
    pushl %eax
    jmp .Lcodegen_arm_169
.Lcodegen_arm_168:
    leal ark_str_137, %eax
    pushl %eax
.Lcodegen_arm_169:
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
    leal ark_str_138, %eax
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
    jmp .Lcodegen_arm_167
.Lcodegen_arm_166:
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
    je .Lcodegen_arm_170
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_172
    leal ark_str_139, %eax
    pushl %eax
    jmp .Lcodegen_arm_173
.Lcodegen_arm_172:
    leal ark_str_140, %eax
    pushl %eax
.Lcodegen_arm_173:
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
    leal ark_str_141, %eax
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
    jmp .Lcodegen_arm_171
.Lcodegen_arm_170:
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
    je .Lcodegen_arm_174
    leal ark_str_142, %eax
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
    leal ark_str_143, %eax
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
    leal ark_str_144, %eax
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
    leal ark_str_145, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_175
.Lcodegen_arm_174:
    leal ark_str_146, %eax
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
    leal ark_str_147, %eax
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
.Lcodegen_arm_175:
.Lcodegen_arm_171:
.Lcodegen_arm_167:
    jmp .Lcodegen_arm_97
.Lcodegen_arm_104:
    leal ark_str_148, %eax
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_105:
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
    je .Lcodegen_arm_176
    pushl -104(%ebp)
    pushl $1
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
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
    leal ark_str_150, %eax
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
    leal ark_str_151, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_177
.Lcodegen_arm_176:
    pushl -104(%ebp)
    pushl $0
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_152, %eax
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
.Lcodegen_arm_177:
    jmp .Lcodegen_arm_97
.Lcodegen_arm_106:
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_107:
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
    je .Lcodegen_arm_178
    leal ark_str_153, %eax
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
    leal ark_str_154, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
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
    jmp .Lcodegen_arm_179
.Lcodegen_arm_178:
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
    leal ark_str_156, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_179:
    jmp .Lcodegen_arm_97
.Lcodegen_arm_108:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
.Lcodegen_arm_109:
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_110:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
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
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_111:
.Lcodegen_arm_112:
.Lcodegen_arm_113:
    jmp .Lcodegen_arm_97
.Lcodegen_arm_114:
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
    je .Lcodegen_arm_180
    pushl $4
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_181
.Lcodegen_arm_180:
.Lcodegen_arm_181:
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
    je .Lcodegen_arm_182
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_159, %eax
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
    leal ark_str_160, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_183
.Lcodegen_arm_182:
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
    je .Lcodegen_arm_184
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
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
    leal ark_str_162, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_185
.Lcodegen_arm_184:
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
    je .Lcodegen_arm_186
    leal ark_str_163, %eax
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
    leal ark_str_167, %eax
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
    je .Lcodegen_arm_188
    leal ark_str_168, %eax
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
    leal ark_str_169, %eax
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
    leal ark_str_170, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_171, %eax
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
    leal ark_str_172, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_189
.Lcodegen_arm_188:
.Lcodegen_arm_189:
    jmp .Lcodegen_arm_187
.Lcodegen_arm_186:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
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
.Lcodegen_arm_187:
.Lcodegen_arm_185:
.Lcodegen_arm_183:
    jmp .Lcodegen_arm_97
.Lcodegen_arm_115:
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
    je .Lcodegen_arm_190
    pushl $1
    jmp .Lcodegen_arm_191
.Lcodegen_arm_190:
    pushl $0
.Lcodegen_arm_191:
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
    je .Lcodegen_arm_192
    pushl -104(%ebp)
    pushl $2
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_175, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_193
.Lcodegen_arm_192:
.Lcodegen_arm_193:
    leal ark_str_176, %eax
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
    je .Lcodegen_arm_194
    leal ark_str_177, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_195
.Lcodegen_arm_194:
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
    je .Lcodegen_arm_198
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
    jmp .Lcodegen_arm_199
.Lcodegen_arm_198:
    pushl $0
.Lcodegen_arm_199:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_196
    leal ark_str_178, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_197
.Lcodegen_arm_196:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_200
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
    je .Lcodegen_arm_202
    leal ark_str_179, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_180, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_181, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_182, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_203
.Lcodegen_arm_202:
    leal ark_str_183, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_184, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_185, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_186, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
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
    leal ark_str_188, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_189, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_190, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_191, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_192, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_203:
    jmp .Lcodegen_arm_201
.Lcodegen_arm_200:
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
    je .Lcodegen_arm_204
    leal ark_str_193, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_194, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_195, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_196, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
.Lcodegen_arm_204:
    leal ark_str_197, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_205:
.Lcodegen_arm_201:
.Lcodegen_arm_197:
.Lcodegen_arm_195:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
.Lcodegen_arm_116:
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
    je .Lcodegen_arm_206
    pushl $1
    jmp .Lcodegen_arm_207
.Lcodegen_arm_206:
    pushl $0
.Lcodegen_arm_207:
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
    je .Lcodegen_arm_208
    leal ark_str_198, %eax
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
    leal ark_str_199, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_200, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_201, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_202, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_203, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
.Lcodegen_arm_208:
.Lcodegen_arm_209:
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
    je .Lcodegen_arm_210
    leal ark_str_204, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_211
.Lcodegen_arm_210:
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
    je .Lcodegen_arm_214
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
    jmp .Lcodegen_arm_215
.Lcodegen_arm_214:
    pushl $0
.Lcodegen_arm_215:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_212
    leal ark_str_205, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_213
.Lcodegen_arm_212:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_216
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
    je .Lcodegen_arm_218
    leal ark_str_206, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_207, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_208, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_219
.Lcodegen_arm_218:
    leal ark_str_209, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
.Lcodegen_arm_219:
    jmp .Lcodegen_arm_217
.Lcodegen_arm_216:
    leal ark_str_216, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_217:
.Lcodegen_arm_213:
.Lcodegen_arm_211:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
.Lcodegen_arm_117:
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_118:
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_119:
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_120:
    leal ark_str_217, %eax
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
    leal ark_str_218, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
.Lcodegen_arm_121:
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
    leal ark_str_219, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_b_label
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
.Lcodegen_arm_122:
    leal ark_str_220, %eax
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_123:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
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
    leal ark_str_222, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_b_label
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
.Lcodegen_arm_124:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
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
    leal ark_str_224, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_b_label
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
.Lcodegen_arm_125:
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
    leal ark_str_225, %eax
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
    leal ark_str_226, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_b_label
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
.Lcodegen_arm_126:
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
    je .Lcodegen_arm_220
    leal ark_str_227, %eax
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
    leal ark_str_228, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_229, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_230, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_231, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_221
.Lcodegen_arm_220:
    leal ark_str_232, %eax
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
    leal ark_str_233, %eax
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
.Lcodegen_arm_221:
    jmp .Lcodegen_arm_97
.Lcodegen_arm_127:
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
    je .Lcodegen_arm_222
    leal ark_str_234, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_235, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_236, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_239, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_223
.Lcodegen_arm_222:
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
    leal ark_str_240, %eax
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
.Lcodegen_arm_223:
    jmp .Lcodegen_arm_97
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
    je .Lcodegen_arm_224
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
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_246, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_225
.Lcodegen_arm_224:
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
    leal ark_str_247, %eax
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
.Lcodegen_arm_225:
    jmp .Lcodegen_arm_97
.Lcodegen_arm_129:
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
    je .Lcodegen_arm_226
    leal ark_str_248, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_249, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_250, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_251, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
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
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_253, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_227
.Lcodegen_arm_226:
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
    leal ark_str_254, %eax
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
.Lcodegen_arm_227:
    jmp .Lcodegen_arm_97
.Lcodegen_arm_130:
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
    je .Lcodegen_arm_228
    leal ark_str_255, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
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
    leal ark_str_257, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_258, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
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
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_260, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_229
.Lcodegen_arm_228:
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
    leal ark_str_261, %eax
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
.Lcodegen_arm_229:
    jmp .Lcodegen_arm_97
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
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_230
    leal ark_str_262, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_263, %eax
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
    je .Lcodegen_arm_232
    leal ark_str_264, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_233
.Lcodegen_arm_232:
    leal ark_str_265, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_233:
    jmp .Lcodegen_arm_231
.Lcodegen_arm_230:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_234
    leal ark_str_266, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_235
.Lcodegen_arm_234:
    leal ark_str_267, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_235:
.Lcodegen_arm_231:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
.Lcodegen_arm_132:
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
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_236
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_238
    leal ark_str_268, %eax
    pushl %eax
    jmp .Lcodegen_arm_239
.Lcodegen_arm_238:
    leal ark_str_269, %eax
    pushl %eax
.Lcodegen_arm_239:
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
    leal ark_str_270, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_237
.Lcodegen_arm_236:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_240
    leal ark_str_271, %eax
    pushl %eax
    jmp .Lcodegen_arm_241
.Lcodegen_arm_240:
    leal ark_str_272, %eax
    pushl %eax
.Lcodegen_arm_241:
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
.Lcodegen_arm_237:
    jmp .Lcodegen_arm_97
.Lcodegen_arm_133:
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
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_244
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
    jmp .Lcodegen_arm_245
.Lcodegen_arm_244:
    pushl $0
.Lcodegen_arm_245:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_242
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
    jmp .Lcodegen_arm_243
.Lcodegen_arm_242:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_248
    pushl -96(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_249
.Lcodegen_arm_248:
    pushl $0
.Lcodegen_arm_249:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_246
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_274, %eax
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
    leal ark_str_275, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_247
.Lcodegen_arm_246:
.Lcodegen_arm_247:
.Lcodegen_arm_243:
    jmp .Lcodegen_arm_97
.Lcodegen_arm_134:
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
    leal ark_str_276, %eax
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
    jne .Lcodegen_arm_251
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
    jne .Lcodegen_arm_252
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
    jne .Lcodegen_arm_253
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
    jne .Lcodegen_arm_254
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
    jne .Lcodegen_arm_255
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
    jne .Lcodegen_arm_256
    jmp .Lcodegen_arm_257
.Lcodegen_arm_251:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_258
    leal ark_str_277, %eax
    pushl %eax
    jmp .Lcodegen_arm_259
.Lcodegen_arm_258:
    leal ark_str_278, %eax
    pushl %eax
.Lcodegen_arm_259:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_250
.Lcodegen_arm_252:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_260
    leal ark_str_279, %eax
    pushl %eax
    jmp .Lcodegen_arm_261
.Lcodegen_arm_260:
    leal ark_str_280, %eax
    pushl %eax
.Lcodegen_arm_261:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_250
.Lcodegen_arm_253:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_262
    leal ark_str_281, %eax
    pushl %eax
    jmp .Lcodegen_arm_263
.Lcodegen_arm_262:
    leal ark_str_282, %eax
    pushl %eax
.Lcodegen_arm_263:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_250
.Lcodegen_arm_254:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_264
    leal ark_str_283, %eax
    pushl %eax
    jmp .Lcodegen_arm_265
.Lcodegen_arm_264:
    leal ark_str_284, %eax
    pushl %eax
.Lcodegen_arm_265:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_250
.Lcodegen_arm_255:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_266
    leal ark_str_285, %eax
    pushl %eax
    jmp .Lcodegen_arm_267
.Lcodegen_arm_266:
    leal ark_str_286, %eax
    pushl %eax
.Lcodegen_arm_267:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_250
.Lcodegen_arm_256:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_268
    leal ark_str_287, %eax
    pushl %eax
    jmp .Lcodegen_arm_269
.Lcodegen_arm_268:
    leal ark_str_288, %eax
    pushl %eax
.Lcodegen_arm_269:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_250
.Lcodegen_arm_257:
    jmp .Lcodegen_arm_250
.Lcodegen_arm_250:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_270
    leal ark_str_289, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_290, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
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
    leal ark_str_292, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_271
.Lcodegen_arm_270:
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
.Lcodegen_arm_271:
    leal ark_str_293, %eax
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
    je .Lcodegen_arm_272
    leal ark_str_294, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_273
.Lcodegen_arm_272:
.Lcodegen_arm_273:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
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
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_276
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
    jmp .Lcodegen_arm_277
.Lcodegen_arm_276:
    pushl $0
.Lcodegen_arm_277:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_274
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
.Lcodegen_arm_278:
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
    jne .Lcodegen_arm_280
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
    jmp .Lcodegen_arm_281
.Lcodegen_arm_280:
    pushl $1
.Lcodegen_arm_281:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_279
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
    jmp .Lcodegen_arm_278
.Lcodegen_arm_279:
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
    je .Lcodegen_arm_282
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
    leal ark_str_295, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_284:
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_286
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
    jmp .Lcodegen_arm_287
.Lcodegen_arm_286:
    pushl $0
.Lcodegen_arm_287:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_285
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
    je .Lcodegen_arm_290
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
    jmp .Lcodegen_arm_291
.Lcodegen_arm_290:
    pushl $0
.Lcodegen_arm_291:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_288
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
    je .Lcodegen_arm_292
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_296, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_293
.Lcodegen_arm_292:
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
    je .Lcodegen_arm_294
    pushl $9
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_295
.Lcodegen_arm_294:
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
    je .Lcodegen_arm_296
    pushl $92
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_297
.Lcodegen_arm_296:
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
    je .Lcodegen_arm_298
    pushl $34
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_299
.Lcodegen_arm_298:
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
.Lcodegen_arm_299:
.Lcodegen_arm_297:
.Lcodegen_arm_295:
.Lcodegen_arm_293:
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
    jmp .Lcodegen_arm_289
.Lcodegen_arm_288:
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
    je .Lcodegen_arm_304
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
    jmp .Lcodegen_arm_305
.Lcodegen_arm_304:
    pushl $0
.Lcodegen_arm_305:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_302
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
    jmp .Lcodegen_arm_303
.Lcodegen_arm_302:
    pushl $0
.Lcodegen_arm_303:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_300
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
    jmp .Lcodegen_arm_301
.Lcodegen_arm_300:
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
.Lcodegen_arm_301:
.Lcodegen_arm_289:
    jmp .Lcodegen_arm_284
.Lcodegen_arm_285:
    pushl $10
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_283
.Lcodegen_arm_282:
.Lcodegen_arm_283:
    jmp .Lcodegen_arm_275
.Lcodegen_arm_274:
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
    je .Lcodegen_arm_306
    leal ark_str_297, %eax
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
    jmp .Lcodegen_arm_307
.Lcodegen_arm_306:
.Lcodegen_arm_307:
.Lcodegen_arm_275:
    jmp .Lcodegen_arm_97
.Lcodegen_arm_136:
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
    je .Lcodegen_arm_308
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
    jmp .Lcodegen_arm_309
.Lcodegen_arm_308:
    pushl $0
.Lcodegen_arm_309:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_310
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lcodegen_arm_311
.Lcodegen_arm_310:
    pushl -104(%ebp)
.Lcodegen_arm_311:
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
    je .Lcodegen_arm_312
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
    jmp .Lcodegen_arm_313
.Lcodegen_arm_312:
    pushl $0
.Lcodegen_arm_313:
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
    je .Lcodegen_arm_316
    leal ark_str_298, %eax
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
    jne .Lcodegen_arm_336
    leal ark_str_299, %eax
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
    jmp .Lcodegen_arm_337
.Lcodegen_arm_336:
    pushl $1
.Lcodegen_arm_337:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_334
    leal ark_str_300, %eax
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
    jmp .Lcodegen_arm_335
.Lcodegen_arm_334:
    pushl $1
.Lcodegen_arm_335:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_332
    leal ark_str_301, %eax
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
    jmp .Lcodegen_arm_333
.Lcodegen_arm_332:
    pushl $1
.Lcodegen_arm_333:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_330
    leal ark_str_302, %eax
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
    jmp .Lcodegen_arm_331
.Lcodegen_arm_330:
    pushl $1
.Lcodegen_arm_331:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_328
    leal ark_str_303, %eax
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
    jmp .Lcodegen_arm_329
.Lcodegen_arm_328:
    pushl $1
.Lcodegen_arm_329:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_326
    leal ark_str_304, %eax
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
    jmp .Lcodegen_arm_327
.Lcodegen_arm_326:
    pushl $1
.Lcodegen_arm_327:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_324
    leal ark_str_305, %eax
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
    jmp .Lcodegen_arm_325
.Lcodegen_arm_324:
    pushl $1
.Lcodegen_arm_325:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_322
    leal ark_str_306, %eax
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
    jmp .Lcodegen_arm_323
.Lcodegen_arm_322:
    pushl $1
.Lcodegen_arm_323:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_320
    leal ark_str_307, %eax
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
    jmp .Lcodegen_arm_321
.Lcodegen_arm_320:
    pushl $1
.Lcodegen_arm_321:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_318
    leal ark_str_308, %eax
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
    jmp .Lcodegen_arm_319
.Lcodegen_arm_318:
    pushl $1
.Lcodegen_arm_319:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_317
.Lcodegen_arm_316:
    pushl $0
.Lcodegen_arm_317:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_314
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
    je .Lcodegen_arm_338
    pushl $4
    jmp .Lcodegen_arm_339
.Lcodegen_arm_338:
    pushl -80(%ebp)
.Lcodegen_arm_339:
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
    je .Lcodegen_arm_340
    pushl -80(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lcodegen_arm_341
.Lcodegen_arm_340:
    pushl $0
.Lcodegen_arm_341:
    popl %eax
    movl %eax, -56(%ebp)
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
.Lcodegen_arm_342:
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
    je .Lcodegen_arm_343
    leal ark_str_309, %eax
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
    leal ark_str_310, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_344:
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
    jmp .Lcodegen_arm_342
.Lcodegen_arm_343:
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
    je .Lcodegen_arm_345
    leal ark_str_311, %eax
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
    jmp .Lcodegen_arm_346
.Lcodegen_arm_345:
.Lcodegen_arm_346:
    leal ark_str_312, %eax
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
    je .Lcodegen_arm_347
    leal ark_str_313, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_348
.Lcodegen_arm_347:
    leal ark_str_314, %eax
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
    je .Lcodegen_arm_349
    leal ark_str_315, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_350
.Lcodegen_arm_349:
    leal ark_str_316, %eax
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
    je .Lcodegen_arm_351
    leal ark_str_317, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_352
.Lcodegen_arm_351:
    leal ark_str_318, %eax
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
    je .Lcodegen_arm_353
    leal ark_str_319, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_354
.Lcodegen_arm_353:
    leal ark_str_320, %eax
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
    je .Lcodegen_arm_355
    jmp .Lcodegen_arm_356
.Lcodegen_arm_355:
    leal ark_str_321, %eax
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
    je .Lcodegen_arm_357
    leal ark_str_322, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_358
.Lcodegen_arm_357:
    leal ark_str_323, %eax
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
    je .Lcodegen_arm_359
    leal ark_str_324, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_360
.Lcodegen_arm_359:
    leal ark_str_325, %eax
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
    je .Lcodegen_arm_361
    leal ark_str_326, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_362
.Lcodegen_arm_361:
    leal ark_str_327, %eax
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
    je .Lcodegen_arm_363
    leal ark_str_328, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_364
.Lcodegen_arm_363:
    leal ark_str_329, %eax
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
    je .Lcodegen_arm_365
    leal ark_str_330, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_366
.Lcodegen_arm_365:
    leal ark_str_331, %eax
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
    je .Lcodegen_arm_367
    leal ark_str_332, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_368
.Lcodegen_arm_367:
.Lcodegen_arm_368:
.Lcodegen_arm_366:
.Lcodegen_arm_364:
.Lcodegen_arm_362:
.Lcodegen_arm_360:
.Lcodegen_arm_358:
.Lcodegen_arm_356:
.Lcodegen_arm_354:
.Lcodegen_arm_352:
.Lcodegen_arm_350:
.Lcodegen_arm_348:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
.Lcodegen_arm_314:
.Lcodegen_arm_315:
    pushl -72(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_369
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
    je .Lcodegen_arm_371
    pushl $3
    jmp .Lcodegen_arm_372
.Lcodegen_arm_371:
    pushl -80(%ebp)
.Lcodegen_arm_372:
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
    je .Lcodegen_arm_373
    pushl -80(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lcodegen_arm_374
.Lcodegen_arm_373:
    pushl $0
.Lcodegen_arm_374:
    popl %eax
    movl %eax, -48(%ebp)
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
.Lcodegen_arm_375:
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
    je .Lcodegen_arm_376
    leal ark_str_333, %eax
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
    leal ark_str_334, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_377:
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
    jmp .Lcodegen_arm_375
.Lcodegen_arm_376:
    leal ark_str_335, %eax
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
    leal ark_str_336, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_337, %eax
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
    leal ark_str_338, %eax
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_369:
.Lcodegen_arm_370:
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
    je .Lcodegen_arm_378
    pushl $4
    jmp .Lcodegen_arm_379
.Lcodegen_arm_378:
    pushl -80(%ebp)
.Lcodegen_arm_379:
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
    je .Lcodegen_arm_380
    pushl -80(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lcodegen_arm_381
.Lcodegen_arm_380:
    pushl $0
.Lcodegen_arm_381:
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
    je .Lcodegen_arm_382
    leal ark_str_339, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
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
    jmp .Lcodegen_arm_383
.Lcodegen_arm_382:
.Lcodegen_arm_383:
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
.Lcodegen_arm_384:
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
    je .Lcodegen_arm_385
    leal ark_str_341, %eax
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
    leal ark_str_342, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_386:
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
    jmp .Lcodegen_arm_384
.Lcodegen_arm_385:
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_387
    leal ark_str_343, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_388
.Lcodegen_arm_387:
.Lcodegen_arm_388:
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_389
    leal ark_str_344, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_390
.Lcodegen_arm_389:
    leal ark_str_345, %eax
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
.Lcodegen_arm_390:
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_391
    leal ark_str_346, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_392
.Lcodegen_arm_391:
.Lcodegen_arm_392:
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
    je .Lcodegen_arm_393
    leal ark_str_347, %eax
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
    jmp .Lcodegen_arm_394
.Lcodegen_arm_393:
.Lcodegen_arm_394:
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
    je .Lcodegen_arm_395
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
.Lcodegen_arm_397:
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
    je .Lcodegen_arm_398
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
    je .Lcodegen_arm_400
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
    je .Lcodegen_arm_404
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
    jne .Lcodegen_arm_406
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
    jmp .Lcodegen_arm_407
.Lcodegen_arm_406:
    pushl $1
.Lcodegen_arm_407:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_405
.Lcodegen_arm_404:
    pushl $0
.Lcodegen_arm_405:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_402
    pushl $1
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_403
.Lcodegen_arm_402:
.Lcodegen_arm_403:
    jmp .Lcodegen_arm_398
.Lcodegen_arm_400:
.Lcodegen_arm_401:
.Lcodegen_arm_399:
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
    jmp .Lcodegen_arm_397
.Lcodegen_arm_398:
    jmp .Lcodegen_arm_396
.Lcodegen_arm_395:
.Lcodegen_arm_396:
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_408
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_348, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_409
.Lcodegen_arm_408:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_409:
    jmp .Lcodegen_arm_97
.Lcodegen_arm_137:
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
    leal ark_str_349, %eax
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_138:
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
    je .Lcodegen_arm_410
    leal ark_str_350, %eax
    pushl %eax
    jmp .Lcodegen_arm_411
.Lcodegen_arm_410:
    leal ark_str_351, %eax
    pushl %eax
.Lcodegen_arm_411:
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_139:
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
    je .Lcodegen_arm_412
    leal ark_str_352, %eax
    pushl %eax
    jmp .Lcodegen_arm_413
.Lcodegen_arm_412:
    leal ark_str_353, %eax
    pushl %eax
.Lcodegen_arm_413:
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
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
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
.Lcodegen_arm_140:
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_141:
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
    jne .Lcodegen_arm_415
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
    jne .Lcodegen_arm_416
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
    jne .Lcodegen_arm_417
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
    jne .Lcodegen_arm_418
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
    jne .Lcodegen_arm_419
    jmp .Lcodegen_arm_420
.Lcodegen_arm_415:
    leal ark_str_356, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_414
.Lcodegen_arm_416:
    leal ark_str_357, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_414
.Lcodegen_arm_417:
    leal ark_str_358, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_414
.Lcodegen_arm_418:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_421
    leal ark_str_359, %eax
    pushl %eax
    jmp .Lcodegen_arm_422
.Lcodegen_arm_421:
    leal ark_str_360, %eax
    pushl %eax
.Lcodegen_arm_422:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_414
.Lcodegen_arm_419:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_423
    leal ark_str_361, %eax
    pushl %eax
    jmp .Lcodegen_arm_424
.Lcodegen_arm_423:
    leal ark_str_362, %eax
    pushl %eax
.Lcodegen_arm_424:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_414
.Lcodegen_arm_420:
    jmp .Lcodegen_arm_414
.Lcodegen_arm_414:
    leal ark_str_363, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_364, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_365, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_366, %eax
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
    je .Lcodegen_arm_425
    leal ark_str_367, %eax
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
    jmp .Lcodegen_arm_426
.Lcodegen_arm_425:
.Lcodegen_arm_426:
    pushl -72(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_427
    leal ark_str_368, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_369, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_428
.Lcodegen_arm_427:
.Lcodegen_arm_428:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_370, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
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
    je .Lcodegen_arm_429
    leal ark_str_371, %eax
    pushl %eax
    jmp .Lcodegen_arm_430
.Lcodegen_arm_429:
    leal ark_str_372, %eax
    pushl %eax
.Lcodegen_arm_430:
    popl %eax
    movl %eax, -88(%ebp)
    leal ark_str_373, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_374, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_375, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_376, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_377, %eax
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
    leal ark_str_378, %eax
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
    jne .Lcodegen_arm_432
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
    jne .Lcodegen_arm_433
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
    jne .Lcodegen_arm_434
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
    jne .Lcodegen_arm_435
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
    jne .Lcodegen_arm_436
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
    jne .Lcodegen_arm_437
    jmp .Lcodegen_arm_438
.Lcodegen_arm_432:
    leal ark_str_379, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_380, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_381, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_431
.Lcodegen_arm_433:
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
    jmp .Lcodegen_arm_431
.Lcodegen_arm_434:
    leal ark_str_385, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_386, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_387, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_431
.Lcodegen_arm_435:
    leal ark_str_388, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_389, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_390, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_431
.Lcodegen_arm_436:
    leal ark_str_391, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_392, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_393, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_431
.Lcodegen_arm_437:
    leal ark_str_394, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_395, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_396, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_431
.Lcodegen_arm_438:
    jmp .Lcodegen_arm_431
.Lcodegen_arm_431:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
.Lcodegen_arm_143:
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
    leal ark_str_397, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
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
    je .Lcodegen_arm_439
    pushl $-1
    jmp .Lcodegen_arm_440
.Lcodegen_arm_439:
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
.Lcodegen_arm_440:
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
    leal ark_str_398, %eax
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
    je .Lcodegen_arm_441
    leal ark_str_399, %eax
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
    leal ark_str_400, %eax
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
    jmp .Lcodegen_arm_442
.Lcodegen_arm_441:
.Lcodegen_arm_442:
    leal ark_str_401, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_402, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_403, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_404, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
.Lcodegen_arm_145:
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
    je .Lcodegen_arm_443
    pushl $-1
    jmp .Lcodegen_arm_444
.Lcodegen_arm_443:
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
.Lcodegen_arm_444:
    popl %eax
    movl %eax, -80(%ebp)
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_405, %eax
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
    je .Lcodegen_arm_445
    leal ark_str_406, %eax
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
    jmp .Lcodegen_arm_446
.Lcodegen_arm_445:
.Lcodegen_arm_446:
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_449
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
    jmp .Lcodegen_arm_450
.Lcodegen_arm_449:
    pushl $0
.Lcodegen_arm_450:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_447
    pushl $32
    pushl -96(%ebp)
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    leal ark_str_407, %eax
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
    leal ark_str_408, %eax
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
    jmp .Lcodegen_arm_448
.Lcodegen_arm_447:
    pushl -80(%ebp)
    pushl $2
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_mov_imm
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_409, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_448:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_push_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_97
.Lcodegen_arm_146:
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_451
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
    leal ark_str_410, %eax
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
    leal ark_str_411, %eax
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
.Lcodegen_arm_453:
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
    je .Lcodegen_arm_454
    leal ark_str_412, %eax
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
    leal ark_str_413, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_414, %eax
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
    leal ark_str_415, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_455:
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
    jmp .Lcodegen_arm_453
.Lcodegen_arm_454:
    leal ark_str_416, %eax
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
    je .Lcodegen_arm_456
    leal ark_str_417, %eax
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
    jmp .Lcodegen_arm_457
.Lcodegen_arm_456:
.Lcodegen_arm_457:
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
    je .Lcodegen_arm_458
    leal ark_str_418, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_459
.Lcodegen_arm_458:
    leal ark_str_419, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_459:
    jmp .Lcodegen_arm_452
.Lcodegen_arm_451:
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
.Lcodegen_arm_452:
    jmp .Lcodegen_arm_97
.Lcodegen_arm_147:
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_pop_r0
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_420, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_421, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_422, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _emit_line
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_423, %eax
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_148:
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
    leal ark_str_424, %eax
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_149:
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
    leal ark_str_425, %eax
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_150:
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
    leal ark_str_426, %eax
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_151:
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
    leal ark_str_427, %eax
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_152:
    leal ark_str_428, %eax
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
    jmp .Lcodegen_arm_97
.Lcodegen_arm_97:
.Lcodegen_arm_96:
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
    jmp .Lcodegen_arm_94
.Lcodegen_arm_95:
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
    je .Lcodegen_arm_462
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
    jmp .Lcodegen_arm_463
.Lcodegen_arm_462:
    pushl $0
.Lcodegen_arm_463:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_460
    leal ark_str_429, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
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
    leal ark_str_431, %eax
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
    leal ark_str_432, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_461
.Lcodegen_arm_460:
.Lcodegen_arm_461:
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
    je .Lcodegen_arm_466
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
    jmp .Lcodegen_arm_467
.Lcodegen_arm_466:
    pushl $0
.Lcodegen_arm_467:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_464
    leal ark_str_433, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
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
    leal ark_str_435, %eax
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
    leal ark_str_436, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_465
.Lcodegen_arm_464:
.Lcodegen_arm_465:
.Lcodegen_arm_45:
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
    jmp .Lcodegen_arm_43
.Lcodegen_arm_44:
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
    jne .Lcodegen_arm_470
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
    jmp .Lcodegen_arm_471
.Lcodegen_arm_470:
    pushl $1
.Lcodegen_arm_471:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_468
    leal ark_str_437, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_438, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_439, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
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
    pushl $0
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
.Lcodegen_arm_472:
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
    je .Lcodegen_arm_473
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
    jne .Lcodegen_arm_477
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
    jmp .Lcodegen_arm_478
.Lcodegen_arm_477:
    pushl $1
.Lcodegen_arm_478:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_475
    jmp .Lcodegen_arm_474
.Lcodegen_arm_475:
.Lcodegen_arm_476:
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
    je .Lcodegen_arm_479
    jmp .Lcodegen_arm_474
.Lcodegen_arm_479:
.Lcodegen_arm_480:
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
    je .Lcodegen_arm_487
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
    jmp .Lcodegen_arm_488
.Lcodegen_arm_487:
    pushl $0
.Lcodegen_arm_488:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_485
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
    jmp .Lcodegen_arm_486
.Lcodegen_arm_485:
    pushl $0
.Lcodegen_arm_486:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_483
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
    jne .L64f_codegen_arm_5703
    cmpl %eax, (%esp)
    jne .L64f_codegen_arm_5703
    addl $4, %esp
    pushl $1
    jmp .L64e_codegen_arm_5703
.L64f_codegen_arm_5703:
    addl $4, %esp
    pushl $0
.L64e_codegen_arm_5703:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_484
.Lcodegen_arm_483:
    pushl $0
.Lcodegen_arm_484:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_481
    jmp .Lcodegen_arm_474
.Lcodegen_arm_481:
.Lcodegen_arm_482:
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
    je .Lcodegen_arm_489
    jmp .Lcodegen_arm_474
.Lcodegen_arm_489:
.Lcodegen_arm_490:
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
    je .Lcodegen_arm_491
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
    jmp .Lcodegen_arm_492
.Lcodegen_arm_491:
    pushl $4
.Lcodegen_arm_492:
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
    je .Lcodegen_arm_493
    pushl $4
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_494
.Lcodegen_arm_493:
.Lcodegen_arm_494:
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
    je .Lcodegen_arm_495
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
    je .Lcodegen_arm_497
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
    jmp .Lcodegen_arm_498
.Lcodegen_arm_497:
    pushl $0
.Lcodegen_arm_498:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_499
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
    leal ark_str_441, %eax
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
    leal ark_str_442, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_500
.Lcodegen_arm_499:
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
    leal ark_str_443, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_500:
    jmp .Lcodegen_arm_496
.Lcodegen_arm_495:
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
    je .Lcodegen_arm_501
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
    je .Lcodegen_arm_507
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
    jmp .Lcodegen_arm_508
.Lcodegen_arm_507:
    pushl $0
.Lcodegen_arm_508:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_505
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
    jmp .Lcodegen_arm_506
.Lcodegen_arm_505:
    pushl $0
.Lcodegen_arm_506:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_503
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
    je .Lcodegen_arm_509
    pushl $4
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_510
.Lcodegen_arm_509:
.Lcodegen_arm_510:
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
    jmp .Lcodegen_arm_504
.Lcodegen_arm_503:
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
.Lcodegen_arm_504:
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
    je .Lcodegen_arm_511
    pushl -144(%ebp)
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_512
.Lcodegen_arm_511:
.Lcodegen_arm_512:
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
    je .Lcodegen_arm_513
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
    jmp .Lcodegen_arm_514
.Lcodegen_arm_513:
.Lcodegen_arm_514:
    pushl $0
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
.Lcodegen_arm_515:
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
    je .Lcodegen_arm_516
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
.Lcodegen_arm_518:
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
    jne .Lcodegen_arm_524
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
    jmp .Lcodegen_arm_525
.Lcodegen_arm_524:
    pushl $1
.Lcodegen_arm_525:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_522
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
    jmp .Lcodegen_arm_523
.Lcodegen_arm_522:
    pushl $1
.Lcodegen_arm_523:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_520
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
    jmp .Lcodegen_arm_521
.Lcodegen_arm_520:
    pushl $1
.Lcodegen_arm_521:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_519
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
    jmp .Lcodegen_arm_518
.Lcodegen_arm_519:
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
    je .Lcodegen_arm_526
.Lcodegen_arm_528:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_530
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
    jmp .Lcodegen_arm_531
.Lcodegen_arm_530:
    pushl $0
.Lcodegen_arm_531:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_529
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
    jmp .Lcodegen_arm_528
.Lcodegen_arm_529:
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
    je .Lcodegen_arm_532
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
    jmp .Lcodegen_arm_533
.Lcodegen_arm_532:
.Lcodegen_arm_533:
.Lcodegen_arm_534:
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
    jne .Lcodegen_arm_536
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
    jmp .Lcodegen_arm_537
.Lcodegen_arm_536:
    pushl $1
.Lcodegen_arm_537:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_535
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
    jmp .Lcodegen_arm_534
.Lcodegen_arm_535:
    jmp .Lcodegen_arm_527
.Lcodegen_arm_526:
.Lcodegen_arm_527:
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
    je .Lcodegen_arm_538
.Lcodegen_arm_540:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_542
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
    jmp .Lcodegen_arm_543
.Lcodegen_arm_542:
    pushl $0
.Lcodegen_arm_543:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_541
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
    jmp .Lcodegen_arm_540
.Lcodegen_arm_541:
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
    je .Lcodegen_arm_544
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
    jmp .Lcodegen_arm_545
.Lcodegen_arm_544:
.Lcodegen_arm_545:
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
    je .Lcodegen_arm_546
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
    jmp .Lcodegen_arm_547
.Lcodegen_arm_546:
.Lcodegen_arm_547:
.Lcodegen_arm_548:
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
    jne .Lcodegen_arm_550
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
    jmp .Lcodegen_arm_551
.Lcodegen_arm_550:
    pushl $1
.Lcodegen_arm_551:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_549
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
    jmp .Lcodegen_arm_548
.Lcodegen_arm_549:
    jmp .Lcodegen_arm_539
.Lcodegen_arm_538:
.Lcodegen_arm_539:
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
    je .Lcodegen_arm_552
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
.Lcodegen_arm_554:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_556
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
    jmp .Lcodegen_arm_557
.Lcodegen_arm_556:
    pushl $0
.Lcodegen_arm_557:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_555
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
    jmp .Lcodegen_arm_554
.Lcodegen_arm_555:
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
    je .Lcodegen_arm_558
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
    jmp .Lcodegen_arm_559
.Lcodegen_arm_558:
.Lcodegen_arm_559:
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
    jmp .Lcodegen_arm_553
.Lcodegen_arm_552:
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
    je .Lcodegen_arm_560
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
    jmp .Lcodegen_arm_561
.Lcodegen_arm_560:
.Lcodegen_arm_561:
.Lcodegen_arm_553:
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_562
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
    je .Lcodegen_arm_566
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
    jne .Lcodegen_arm_568
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
    jmp .Lcodegen_arm_569
.Lcodegen_arm_568:
    pushl $1
.Lcodegen_arm_569:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_567
.Lcodegen_arm_566:
    pushl $0
.Lcodegen_arm_567:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_564
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
.Lcodegen_arm_570:
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
    je .Lcodegen_arm_576
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
    jmp .Lcodegen_arm_577
.Lcodegen_arm_576:
    pushl $0
.Lcodegen_arm_577:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_574
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
    je .Lcodegen_arm_578
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
    jmp .Lcodegen_arm_579
.Lcodegen_arm_578:
    pushl $0
.Lcodegen_arm_579:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_575
.Lcodegen_arm_574:
    pushl $1
.Lcodegen_arm_575:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_572
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
    je .Lcodegen_arm_580
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
    jmp .Lcodegen_arm_581
.Lcodegen_arm_580:
    pushl $0
.Lcodegen_arm_581:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_573
.Lcodegen_arm_572:
    pushl $1
.Lcodegen_arm_573:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_571
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
    je .Lcodegen_arm_584
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
    jmp .Lcodegen_arm_585
.Lcodegen_arm_584:
    pushl $0
.Lcodegen_arm_585:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_582
    movzbl -80(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lcodegen_arm_583
.Lcodegen_arm_582:
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
    je .Lcodegen_arm_588
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
    jmp .Lcodegen_arm_589
.Lcodegen_arm_588:
    pushl $0
.Lcodegen_arm_589:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_586
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
    jmp .Lcodegen_arm_587
.Lcodegen_arm_586:
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
.Lcodegen_arm_587:
.Lcodegen_arm_583:
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
    jmp .Lcodegen_arm_570
.Lcodegen_arm_571:
    pushl $1
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_565
.Lcodegen_arm_564:
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
    je .Lcodegen_arm_592
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
    jmp .Lcodegen_arm_593
.Lcodegen_arm_592:
    pushl $0
.Lcodegen_arm_593:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_590
.Lcodegen_arm_594:
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
    je .Lcodegen_arm_596
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
    jmp .Lcodegen_arm_597
.Lcodegen_arm_596:
    pushl $0
.Lcodegen_arm_597:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_595
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
    jmp .Lcodegen_arm_594
.Lcodegen_arm_595:
    pushl $1
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_591
.Lcodegen_arm_590:
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
    je .Lcodegen_arm_600
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
    jne .Lcodegen_arm_603
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
    jne .Lcodegen_arm_604
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
    jne .Lcodegen_arm_605
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
    jne .Lcodegen_arm_606
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
    jne .Lcodegen_arm_607
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
    jne .Lcodegen_arm_608
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
    jne .Lcodegen_arm_609
    jmp .Lcodegen_arm_610
.Lcodegen_arm_603:
    pushl $10
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_602
.Lcodegen_arm_604:
    pushl $9
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_602
.Lcodegen_arm_605:
    pushl $13
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_602
.Lcodegen_arm_606:
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_602
.Lcodegen_arm_607:
    pushl $92
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_602
.Lcodegen_arm_608:
    pushl $39
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_602
.Lcodegen_arm_609:
    pushl $34
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_602
.Lcodegen_arm_610:
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
    jmp .Lcodegen_arm_602
.Lcodegen_arm_602:
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
    jmp .Lcodegen_arm_601
.Lcodegen_arm_600:
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
.Lcodegen_arm_601:
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
    je .Lcodegen_arm_611
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
    jmp .Lcodegen_arm_612
.Lcodegen_arm_611:
.Lcodegen_arm_612:
    pushl $1
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_599
.Lcodegen_arm_598:
.Lcodegen_arm_599:
.Lcodegen_arm_591:
.Lcodegen_arm_565:
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
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
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_619
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
    jmp .Lcodegen_arm_620
.Lcodegen_arm_619:
    pushl $0
.Lcodegen_arm_620:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_617
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
    je .Lcodegen_arm_621
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
    jmp .Lcodegen_arm_622
.Lcodegen_arm_621:
    pushl $0
.Lcodegen_arm_622:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_618
.Lcodegen_arm_617:
    pushl $1
.Lcodegen_arm_618:
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
    je .Lcodegen_arm_613
.Lcodegen_arm_623:
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
    je .Lcodegen_arm_635
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
    jmp .Lcodegen_arm_636
.Lcodegen_arm_635:
    pushl $0
.Lcodegen_arm_636:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_633
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
    je .Lcodegen_arm_637
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
    jmp .Lcodegen_arm_638
.Lcodegen_arm_637:
    pushl $0
.Lcodegen_arm_638:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_634
.Lcodegen_arm_633:
    pushl $1
.Lcodegen_arm_634:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_631
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
    je .Lcodegen_arm_639
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
    jmp .Lcodegen_arm_640
.Lcodegen_arm_639:
    pushl $0
.Lcodegen_arm_640:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcodegen_arm_632
.Lcodegen_arm_631:
    pushl $1
.Lcodegen_arm_632:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_629
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
    jmp .Lcodegen_arm_630
.Lcodegen_arm_629:
    pushl $1
.Lcodegen_arm_630:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_627
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
    jmp .Lcodegen_arm_628
.Lcodegen_arm_627:
    pushl $1
.Lcodegen_arm_628:
    popl %eax
    cmpl $0, %eax
    jne .Lcodegen_arm_625
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
    jmp .Lcodegen_arm_626
.Lcodegen_arm_625:
    pushl $1
.Lcodegen_arm_626:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_624
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
    jmp .Lcodegen_arm_623
.Lcodegen_arm_624:
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
    jmp .Lcodegen_arm_614
.Lcodegen_arm_613:
.Lcodegen_arm_614:
    jmp .Lcodegen_arm_563
.Lcodegen_arm_562:
.Lcodegen_arm_563:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_641
    pushl -104(%ebp)
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_642
.Lcodegen_arm_641:
.Lcodegen_arm_642:
    pushl $0
    popl %eax
    movl %eax, -80(%ebp)
.Lcodegen_arm_643:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_649
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
    jmp .Lcodegen_arm_650
.Lcodegen_arm_649:
    pushl $0
.Lcodegen_arm_650:
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
    jmp .Lcodegen_arm_648
.Lcodegen_arm_647:
    pushl $0
.Lcodegen_arm_648:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_645
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
    je .Lcodegen_arm_651
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
    jmp .Lcodegen_arm_652
.Lcodegen_arm_651:
    pushl $0
.Lcodegen_arm_652:
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
    jmp .Lcodegen_arm_646
.Lcodegen_arm_645:
    pushl $0
.Lcodegen_arm_646:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_644
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
    je .Lcodegen_arm_653
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
    jmp .Lcodegen_arm_654
.Lcodegen_arm_653:
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
    je .Lcodegen_arm_655
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
    jmp .Lcodegen_arm_656
.Lcodegen_arm_655:
.Lcodegen_arm_656:
.Lcodegen_arm_654:
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
    jmp .Lcodegen_arm_643
.Lcodegen_arm_644:
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
    je .Lcodegen_arm_657
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
    jmp .Lcodegen_arm_658
.Lcodegen_arm_657:
.Lcodegen_arm_658:
.Lcodegen_arm_659:
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
    je .Lcodegen_arm_660
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
    jmp .Lcodegen_arm_659
.Lcodegen_arm_660:
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
    je .Lcodegen_arm_661
    leal ark_str_444, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_662
.Lcodegen_arm_661:
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
    je .Lcodegen_arm_663
    leal ark_str_445, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_664
.Lcodegen_arm_663:
    leal ark_str_446, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_664:
.Lcodegen_arm_662:
.Lcodegen_arm_517:
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
    jmp .Lcodegen_arm_515
.Lcodegen_arm_516:
    jmp .Lcodegen_arm_502
.Lcodegen_arm_501:
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
    je .Lcodegen_arm_665
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
.Lcodegen_arm_667:
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
    je .Lcodegen_arm_670
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
    jmp .Lcodegen_arm_671
.Lcodegen_arm_670:
    pushl $0
.Lcodegen_arm_671:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_668
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
    leal ark_str_447, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_669:
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
    jmp .Lcodegen_arm_667
.Lcodegen_arm_668:
    jmp .Lcodegen_arm_666
.Lcodegen_arm_665:
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
    je .Lcodegen_arm_672
    leal ark_str_448, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_673
.Lcodegen_arm_672:
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
    je .Lcodegen_arm_674
    leal ark_str_449, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_675
.Lcodegen_arm_674:
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
    je .Lcodegen_arm_676
    leal ark_str_450, %eax
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
    leal ark_str_451, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_677
.Lcodegen_arm_676:
    leal ark_str_452, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_677:
.Lcodegen_arm_675:
.Lcodegen_arm_673:
.Lcodegen_arm_666:
.Lcodegen_arm_502:
.Lcodegen_arm_496:
.Lcodegen_arm_474:
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
    jmp .Lcodegen_arm_472
.Lcodegen_arm_473:
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
    je .Lcodegen_arm_678
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
    leal ark_str_453, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_454, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_455, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_456, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_457, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_458, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_459, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_460, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_461, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_679
.Lcodegen_arm_678:
.Lcodegen_arm_679:
    leal ark_str_462, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
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
    jmp .Lcodegen_arm_469
.Lcodegen_arm_468:
.Lcodegen_arm_469:
    leal ark_str_464, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_465, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_466, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_467, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_468, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_469, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
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
    leal ark_str_471, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_472, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_473, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_474, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_475, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_476, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_477, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_478, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_479, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_480, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_481, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_482, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_483, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_484, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_485, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_486, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_487, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_488, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_489, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_490, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_491, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_492, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
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
    leal ark_str_494, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_495, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_496, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_497, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_498, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_499, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_500, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
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
    leal ark_str_502, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
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
    leal ark_str_504, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_505, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
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
    leal ark_str_508, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_509, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_510, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_511, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_512, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_513, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_514, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_515, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_516, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_517, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_518, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_519, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_520, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_521, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_522, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
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
    leal ark_str_524, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    leal ark_str_528, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    leal ark_str_532, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    leal ark_str_537, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
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
    leal ark_str_539, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_540, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_541, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_542, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
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
    leal ark_str_544, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_545, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_546, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
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
    leal ark_str_548, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
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
    pushl $0
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_682
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
    jmp .Lcodegen_arm_683
.Lcodegen_arm_682:
    pushl $0
.Lcodegen_arm_683:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_680
    pushl $0
    popl %eax
    movl %eax, -160(%ebp)
    pushl $0
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
.Lcodegen_arm_684:
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
    je .Lcodegen_arm_685
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
    je .Lcodegen_arm_687
    jmp .Lcodegen_arm_686
.Lcodegen_arm_687:
.Lcodegen_arm_688:
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
    je .Lcodegen_arm_689
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
    je .Lcodegen_arm_691
    leal ark_str_755, %eax
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
    jmp .Lcodegen_arm_692
.Lcodegen_arm_691:
.Lcodegen_arm_692:
    leal ark_str_756, %eax
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
    leal ark_str_757, %eax
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
    leal ark_str_758, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl $7
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
.Lcodegen_arm_693:
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
    je .Lcodegen_arm_694
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
.Lcodegen_arm_695:
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
    jmp .Lcodegen_arm_693
.Lcodegen_arm_694:
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
    jmp .Lcodegen_arm_686
.Lcodegen_arm_689:
.Lcodegen_arm_690:
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
    je .Lcodegen_arm_696
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
    jmp .Lcodegen_arm_697
.Lcodegen_arm_696:
    pushl $4
.Lcodegen_arm_697:
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
    je .Lcodegen_arm_698
    pushl $4
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_699
.Lcodegen_arm_698:
.Lcodegen_arm_699:
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
    je .Lcodegen_arm_700
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
    jmp .Lcodegen_arm_701
.Lcodegen_arm_700:
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
    je .Lcodegen_arm_702
    pushl $2
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_703
.Lcodegen_arm_702:
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
    je .Lcodegen_arm_704
    pushl $3
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_705
.Lcodegen_arm_704:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
.Lcodegen_arm_705:
.Lcodegen_arm_703:
.Lcodegen_arm_701:
    pushl -128(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_706
    leal ark_str_759, %eax
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
    leal ark_str_760, %eax
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
    jmp .Lcodegen_arm_707
.Lcodegen_arm_706:
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
    je .Lcodegen_arm_708
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
    je .Lcodegen_arm_710
    leal ark_str_761, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_711
.Lcodegen_arm_710:
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
    je .Lcodegen_arm_712
    leal ark_str_762, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_713
.Lcodegen_arm_712:
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
    je .Lcodegen_arm_714
    leal ark_str_763, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_715
.Lcodegen_arm_714:
.Lcodegen_arm_715:
.Lcodegen_arm_713:
.Lcodegen_arm_711:
    pushl -136(%ebp)
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lcodegen_arm_709
.Lcodegen_arm_708:
.Lcodegen_arm_709:
.Lcodegen_arm_707:
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
    je .Lcodegen_arm_716
    leal ark_str_764, %eax
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
    jmp .Lcodegen_arm_717
.Lcodegen_arm_716:
.Lcodegen_arm_717:
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
    je .Lcodegen_arm_718
    leal ark_str_765, %eax
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
    jmp .Lcodegen_arm_719
.Lcodegen_arm_718:
    leal ark_str_766, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_719:
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
    leal ark_str_767, %eax
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
    jne .Lcodegen_arm_722
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
    jmp .Lcodegen_arm_723
.Lcodegen_arm_722:
    pushl $1
.Lcodegen_arm_723:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_720
    leal ark_str_768, %eax
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
    jmp .Lcodegen_arm_721
.Lcodegen_arm_720:
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
    je .Lcodegen_arm_724
    leal ark_str_769, %eax
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
.Lcodegen_arm_726:
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
    je .Lcodegen_arm_727
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
.Lcodegen_arm_728:
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
    jmp .Lcodegen_arm_726
.Lcodegen_arm_727:
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
    leal ark_str_770, %eax
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
    jmp .Lcodegen_arm_725
.Lcodegen_arm_724:
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
    je .Lcodegen_arm_729
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
    leal ark_str_771, %eax
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
.Lcodegen_arm_731:
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
    je .Lcodegen_arm_732
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
    je .Lcodegen_arm_734
    leal ark_str_772, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_735
.Lcodegen_arm_734:
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
    je .Lcodegen_arm_736
    leal ark_str_773, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_737
.Lcodegen_arm_736:
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
    je .Lcodegen_arm_738
    leal ark_str_774, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_739
.Lcodegen_arm_738:
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
    je .Lcodegen_arm_740
    leal ark_str_775, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_741
.Lcodegen_arm_740:
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
    jne .Lcodegen_arm_744
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
    jmp .Lcodegen_arm_745
.Lcodegen_arm_744:
    pushl $1
.Lcodegen_arm_745:
    popl %eax
    cmpl $0, %eax
    je .Lcodegen_arm_742
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
    leal ark_str_776, %eax
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
    jmp .Lcodegen_arm_743
.Lcodegen_arm_742:
    movzbl -104(%ebp), %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcodegen_arm_743:
.Lcodegen_arm_741:
.Lcodegen_arm_739:
.Lcodegen_arm_737:
.Lcodegen_arm_735:
.Lcodegen_arm_733:
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
    jmp .Lcodegen_arm_731
.Lcodegen_arm_732:
    leal ark_str_777, %eax
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
    je .Lcodegen_arm_746
    leal ark_str_778, %eax
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
    jmp .Lcodegen_arm_747
.Lcodegen_arm_746:
.Lcodegen_arm_747:
    jmp .Lcodegen_arm_730
.Lcodegen_arm_729:
    leal ark_str_779, %eax
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
    je .Lcodegen_arm_748
    leal ark_str_780, %eax
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
    jmp .Lcodegen_arm_749
.Lcodegen_arm_748:
.Lcodegen_arm_749:
.Lcodegen_arm_730:
.Lcodegen_arm_725:
.Lcodegen_arm_721:
.Lcodegen_arm_686:
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
    jmp .Lcodegen_arm_684
.Lcodegen_arm_685:
    leal ark_str_781, %eax
    pushl %eax
    leal -2256(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcodegen_arm_681
.Lcodegen_arm_680:
.Lcodegen_arm_681:
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
    leal ark_str_782, %eax
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
    leal ark_str_783, %eax
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
    leal ark_str_784, %eax
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
    leal ark_str_785, %eax
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
    leal ark_str_786, %eax
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
    leal ark_str_787, %eax
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
    leal ark_str_788, %eax
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
    leal ark_str_789, %eax
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
    leal ark_str_790, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_30
    leal ark_str_791, %eax
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
    leal ark_str_792, %eax
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
    leal ark_str_793, %eax
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
    leal ark_str_794, %eax
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
    leal ark_str_795, %eax
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
    leal ark_str_796, %eax
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
    leal ark_str_797, %eax
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
    leal ark_str_798, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_36
    leal ark_str_799, %eax
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
    leal ark_str_800, %eax
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
    leal ark_str_801, %eax
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
    leal ark_str_802, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lop_size_a_64
    leal ark_str_803, %eax
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
    leal ark_str_804, %eax
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
    leal ark_str_805, %eax
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
    leal ark_str_806, %eax
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
    leal ark_str_807, %eax
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
    leal ark_str_808, %eax
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
    leal ark_str_809, %eax
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
    leal ark_str_810, %eax
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
    leal ark_str_811, %eax
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
    leal ark_str_812, %eax
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
    leal ark_str_813, %eax
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
    leal ark_str_814, %eax
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
    leal ark_str_815, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_28
    leal ark_str_816, %eax
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
    leal ark_str_817, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_64
    leal ark_str_818, %eax
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
    leal ark_str_819, %eax
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
    leal ark_str_820, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_74
    leal ark_str_821, %eax
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
    leal ark_str_822, %eax
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
    leal ark_str_823, %eax
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
    leal ark_str_824, %eax
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
    leal ark_str_825, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_128
    leal ark_str_826, %eax
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
    leal ark_str_827, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_154
    leal ark_str_828, %eax
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
    leal ark_str_829, %eax
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
    leal ark_str_830, %eax
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
    leal ark_str_831, %eax
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
    leal ark_str_832, %eax
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
    leal ark_str_833, %eax
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
    leal ark_str_834, %eax
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
    leal ark_str_835, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_170
    leal ark_str_836, %eax
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
    leal ark_str_837, %eax
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
    leal ark_str_838, %eax
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
    leal ark_str_839, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_184
    leal ark_str_840, %eax
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
    leal ark_str_841, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_190
    leal ark_str_842, %eax
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
    leal ark_str_843, %eax
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
    leal ark_str_844, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass1_a_242
    leal ark_str_845, %eax
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
    leal ark_str_846, %eax
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
    leal ark_str_847, %eax
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
    leal ark_str_848, %eax
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
    leal ark_str_849, %eax
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
    leal ark_str_850, %eax
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
    leal ark_str_851, %eax
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
    leal ark_str_852, %eax
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
    leal ark_str_853, %eax
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
    leal ark_str_854, %eax
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
    leal ark_str_855, %eax
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
    leal ark_str_856, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_28
    leal ark_str_857, %eax
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
    leal ark_str_858, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_34
    leal ark_str_859, %eax
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
    leal ark_str_860, %eax
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
    leal ark_str_861, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_48
    leal ark_str_862, %eax
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
    leal ark_str_863, %eax
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
    leal ark_str_864, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_162
    leal ark_str_865, %eax
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
    leal ark_str_866, %eax
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
    leal ark_str_867, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_245
    leal ark_str_868, %eax
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
    leal ark_str_869, %eax
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
    leal ark_str_870, %eax
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
    leal ark_str_871, %eax
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
    leal ark_str_872, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_305
    leal ark_str_873, %eax
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
    leal ark_str_874, %eax
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
    leal ark_str_875, %eax
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
    leal ark_str_876, %eax
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
    leal ark_str_877, %eax
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
    leal ark_str_878, %eax
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
    leal ark_str_879, %eax
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
    leal ark_str_880, %eax
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
    leal ark_str_881, %eax
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
    leal ark_str_882, %eax
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
    leal ark_str_883, %eax
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
    leal ark_str_884, %eax
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
    leal ark_str_885, %eax
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
    leal ark_str_886, %eax
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
    leal ark_str_887, %eax
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
    leal ark_str_888, %eax
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
    leal ark_str_889, %eax
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
    leal ark_str_890, %eax
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
    leal ark_str_891, %eax
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
    leal ark_str_892, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_355
    leal ark_str_893, %eax
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
    leal ark_str_894, %eax
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
    leal ark_str_895, %eax
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
    leal ark_str_896, %eax
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
    leal ark_str_897, %eax
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
    leal ark_str_898, %eax
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
    leal ark_str_899, %eax
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
    leal ark_str_900, %eax
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
    leal ark_str_901, %eax
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
    leal ark_str_902, %eax
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
    leal ark_str_903, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_395
    leal ark_str_904, %eax
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
    leal ark_str_905, %eax
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
    leal ark_str_906, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_415
    leal ark_str_907, %eax
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
    leal ark_str_908, %eax
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
    leal ark_str_909, %eax
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
    leal ark_str_910, %eax
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
    leal ark_str_911, %eax
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
    leal ark_str_912, %eax
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
    leal ark_str_913, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_473
    leal ark_str_914, %eax
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
    leal ark_str_915, %eax
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
    leal ark_str_916, %eax
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
    leal ark_str_917, %eax
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
    leal ark_str_918, %eax
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
    leal ark_str_919, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_481
    leal ark_str_920, %eax
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
    leal ark_str_921, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_485
    leal ark_str_922, %eax
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
    leal ark_str_923, %eax
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
    leal ark_str_924, %eax
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
    leal ark_str_925, %eax
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
    leal ark_str_926, %eax
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
    leal ark_str_927, %eax
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
    leal ark_str_928, %eax
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
    leal ark_str_929, %eax
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
    leal ark_str_930, %eax
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
    leal ark_str_931, %eax
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
    leal ark_str_932, %eax
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
    leal ark_str_933, %eax
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
    leal ark_str_934, %eax
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
    leal ark_str_935, %eax
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
    leal ark_str_936, %eax
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
    leal ark_str_937, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_533
    leal ark_str_938, %eax
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
    leal ark_str_939, %eax
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
    leal ark_str_940, %eax
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
    leal ark_str_941, %eax
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
    leal ark_str_942, %eax
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
    leal ark_str_943, %eax
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
    leal ark_str_944, %eax
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
    leal ark_str_945, %eax
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
    leal ark_str_946, %eax
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
    leal ark_str_947, %eax
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
    leal ark_str_948, %eax
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
    leal ark_str_949, %eax
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
    leal ark_str_950, %eax
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
    leal ark_str_951, %eax
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
    leal ark_str_952, %eax
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
    leal ark_str_953, %eax
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
    leal ark_str_954, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_565
    leal ark_str_955, %eax
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
    leal ark_str_956, %eax
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
    leal ark_str_957, %eax
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
    leal ark_str_958, %eax
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
    leal ark_str_959, %eax
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
    leal ark_str_960, %eax
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
    leal ark_str_961, %eax
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
    leal ark_str_962, %eax
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
    leal ark_str_963, %eax
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
    leal ark_str_964, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_591
    leal ark_str_965, %eax
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
    leal ark_str_966, %eax
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
    leal ark_str_967, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_617
    leal ark_str_968, %eax
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
    leal ark_str_969, %eax
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
    leal ark_str_970, %eax
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
    leal ark_str_971, %eax
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
    leal ark_str_972, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_627
    leal ark_str_973, %eax
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
    leal ark_str_974, %eax
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
    leal ark_str_975, %eax
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
    leal ark_str_976, %eax
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
    leal ark_str_977, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_637
    leal ark_str_978, %eax
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
    leal ark_str_979, %eax
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
    leal ark_str_980, %eax
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
    leal ark_str_981, %eax
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
    leal ark_str_982, %eax
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
    leal ark_str_983, %eax
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
    leal ark_str_984, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_661
    leal ark_str_985, %eax
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
    leal ark_str_986, %eax
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
    leal ark_str_987, %eax
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
    leal ark_str_988, %eax
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
    leal ark_str_989, %eax
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
    leal ark_str_990, %eax
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
    leal ark_str_991, %eax
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
    leal ark_str_992, %eax
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
    leal ark_str_993, %eax
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
    leal ark_str_994, %eax
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
    leal ark_str_995, %eax
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
    leal ark_str_996, %eax
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
    leal ark_str_997, %eax
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
    leal ark_str_998, %eax
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
    leal ark_str_999, %eax
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
    leal ark_str_1000, %eax
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
    leal ark_str_1001, %eax
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
    leal ark_str_1002, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_719
    leal ark_str_1003, %eax
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
    leal ark_str_1004, %eax
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
    leal ark_str_1005, %eax
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
    leal ark_str_1006, %eax
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
    leal ark_str_1007, %eax
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
    leal ark_str_1008, %eax
    pushl %eax
    leal -264(%ebp), %eax
    pushl %eax
    call _strieq_a
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lpass2_a_739
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
    leal ark_str_1010, %eax
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
    leal ark_str_1011, %eax
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
    leal ark_str_1012, %eax
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
    leal ark_str_1013, %eax
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
    leal ark_str_1014, %eax
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
    leal ark_str_1015, %eax
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
    leal ark_str_1016, %eax
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

