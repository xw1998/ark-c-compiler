# Ark C Compiler - generated x86 32-bit (cdecl) assembly
    .intel_syntax noprefix
    .section .rodata
ark_str_0:
    .asciz "\\n"
ark_str_1:
    .asciz "\\t"
ark_str_2:
    .asciz "\\r"
ark_str_3:
    .asciz "\\\\"
ark_str_4:
    .asciz "\\\""
ark_str_5:
    .asciz "0123456789abcdef"
ark_str_6:
    .asciz "\\x"
ark_str_7:
    .asciz "add"
ark_str_8:
    .asciz "sub"
ark_str_9:
    .asciz "and"
ark_str_10:
    .asciz "or"
ark_str_11:
    .asciz "xor"
ark_str_12:
    .asciz ".byte"
ark_str_13:
    .asciz ".word"
ark_str_14:
    .asciz ".long"
ark_str_15:
    .asciz ".quad"
ark_str_16:
    .asciz "    "
ark_str_17:
    .asciz " "
ark_str_18:
    .asciz ".byte"
ark_str_19:
    .asciz ".word"
ark_str_20:
    .asciz ".long"
ark_str_21:
    .asciz ".quad"
ark_str_22:
    .asciz "    "
ark_str_23:
    .asciz " "
ark_str_24:
    .asciz "# Ark C Compiler - generated x86 32-bit (cdecl) assembly\n"
ark_str_25:
    .asciz "    .intel_syntax noprefix\n"
ark_str_26:
    .asciz "    .section .rodata\n"
ark_str_27:
    .asciz "ark_str_"
ark_str_28:
    .asciz ":\n    .asciz "
ark_str_29:
    .asciz "    .data\n"
ark_str_30:
    .asciz "    .globl "
ark_str_31:
    .asciz "    .local "
ark_str_32:
    .asciz ":\n"
ark_str_33:
    .asciz "    .long "
ark_str_34:
    .asciz "    .quad "
ark_str_35:
    .asciz "    .long 0\n"
ark_str_36:
    .asciz ".long"
ark_str_37:
    .asciz ".byte"
ark_str_38:
    .asciz ".word"
ark_str_39:
    .asciz ".long"
ark_str_40:
    .asciz ".quad"
ark_str_41:
    .asciz "    "
ark_str_42:
    .asciz " "
ark_str_43:
    .asciz ".quad"
ark_str_44:
    .asciz ".byte"
ark_str_45:
    .asciz ".word"
ark_str_46:
    .asciz ".long"
ark_str_47:
    .asciz "    "
ark_str_48:
    .asciz " 0\n"
ark_str_49:
    .asciz "    .text\n"
ark_str_50:
    .asciz "    .globl "
ark_str_51:
    .asciz ":\n"
ark_str_52:
    .asciz "    push ebp\n"
ark_str_53:
    .asciz "    mov ebp, esp\n"
ark_str_54:
    .asciz "    push ebx\n    push esi\n    push edi\n"
ark_str_55:
    .asciz "    sub esp, "
ark_str_56:
    .asciz "    mov eax, [ebp+8]\n    mov [ebp-"
ark_str_57:
    .asciz "], eax\n"
ark_str_58:
    .asciz "    mov eax, [ebp+"
ark_str_59:
    .asciz "]\n    mov [ebp-"
ark_str_60:
    .asciz "], eax\n"
ark_str_61:
    .asciz "    mov eax, [ebp+"
ark_str_62:
    .asciz "]\n    mov [ebp-"
ark_str_63:
    .asciz "], eax\n"
ark_str_64:
    .asciz "    push "
ark_str_65:
    .asciz "    lea eax, [ark_str_"
ark_str_66:
    .asciz "]\n    push eax\n"
ark_str_67:
    .asciz "    push dword ptr [ebp-"
ark_str_68:
    .asciz "]\n"
ark_str_69:
    .asciz "    lea eax, [ebp-"
ark_str_70:
    .asciz "]\n    push eax\n"
ark_str_71:
    .asciz "_ark_va_ptr"
ark_str_72:
    .asciz "    lea eax, [ebp+"
ark_str_73:
    .asciz "]\n    push eax\n"
ark_str_74:
    .asciz "    mov eax, ["
ark_str_75:
    .asciz "]\n    push eax\n"
ark_str_76:
    .asciz "    pop eax\n    mov ["
ark_str_77:
    .asciz "], eax\n"
ark_str_78:
    .asciz "    add esp, 4\n"
ark_str_79:
    .asciz "    mov eax, [esp]\n    push eax\n"
ark_str_80:
    .asciz "    pop eax\n    pop ecx\n    push eax\n    push ecx\n"
ark_str_81:
    .asciz "    pop eax\n    mov [ebp-"
ark_str_82:
    .asciz "], eax\n"
ark_str_83:
    .asciz "    pop ecx\n    pop eax\n"
ark_str_84:
    .asciz "    imul ecx, "
ark_str_85:
    .asciz "\n    add eax, ecx\n"
ark_str_86:
    .asciz "    movzx eax, byte ptr [eax]\n"
ark_str_87:
    .asciz "    movsx eax, byte ptr [eax]\n"
ark_str_88:
    .asciz "    movzx eax, word ptr [eax]\n"
ark_str_89:
    .asciz "    movsx eax, word ptr [eax]\n"
ark_str_90:
    .asciz "    mov edx, dword ptr [eax+4]\n"
ark_str_91:
    .asciz "    push edx\n"
ark_str_92:
    .asciz "    mov eax, dword ptr [eax]\n"
ark_str_93:
    .asciz "    push eax\n"
ark_str_94:
    .asciz "    mov eax, dword ptr [eax]\n"
ark_str_95:
    .asciz "    movsx eax, dword ptr [eax]\n"
ark_str_96:
    .asciz "    push eax\n"
ark_str_97:
    .asciz "    pop edx\n    pop ecx\n    pop eax\n"
ark_str_98:
    .asciz "    mov dword ptr [eax], edx\n"
ark_str_99:
    .asciz "    mov dword ptr [eax+4], ecx\n"
ark_str_100:
    .asciz "    push edx\n"
ark_str_101:
    .asciz "    pop edx\n    pop eax\n"
ark_str_102:
    .asciz "    mov byte ptr [eax], dl\n"
ark_str_103:
    .asciz "    mov word ptr [eax], dx\n"
ark_str_104:
    .asciz "    mov dword ptr [eax], edx\n"
ark_str_105:
    .asciz "    push edx\n"
ark_str_106:
    .asciz "    pop ecx\n    pop eax\n    "
ark_str_107:
    .asciz " eax, ecx\n    push eax\n"
ark_str_108:
    .asciz "    pop ecx\n    pop eax\n    imul eax, ecx\n    push eax\n"
ark_str_109:
    .asciz "    pop ecx\n    pop eax\n    cdq\n    idiv ecx\n    push eax\n"
ark_str_110:
    .asciz "    pop ecx\n    pop eax\n    cdq\n    idiv ecx\n    push edx\n"
ark_str_111:
    .asciz "    pop ecx\n    pop eax\n    shl eax, cl\n    push eax\n"
ark_str_112:
    .asciz "    pop ecx\n    pop eax\n    sar eax, cl\n    push eax\n"
ark_str_113:
    .asciz "sete"
ark_str_114:
    .asciz "setne"
ark_str_115:
    .asciz "setl"
ark_str_116:
    .asciz "setg"
ark_str_117:
    .asciz "setle"
ark_str_118:
    .asciz "setge"
ark_str_119:
    .asciz "sete"
ark_str_120:
    .asciz "    pop ecx\n    pop eax\n    cmp eax, ecx\n    "
ark_str_121:
    .asciz " al\n    movzx eax, al\n    push eax\n"
ark_str_122:
    .asciz "    pop eax\n"
ark_str_123:
    .asciz "    neg eax\n"
ark_str_124:
    .asciz "    not eax\n"
ark_str_125:
    .asciz "    test eax, eax\n    sete al\n    movzx eax, al\n"
ark_str_126:
    .asciz "    push eax\n"
ark_str_127:
    .asciz ".L"
ark_str_128:
    .asciz ":\n"
ark_str_129:
    .asciz ".LN_"
ark_str_130:
    .asciz ":\n"
ark_str_131:
    .asciz "    jmp .L"
ark_str_132:
    .asciz "    jmp .LN_"
ark_str_133:
    .asciz "    pop eax\n    test eax, eax\n    jz .L"
ark_str_134:
    .asciz "    pop eax\n    test eax, eax\n    jnz .L"
ark_str_135:
    .asciz "    mov eax, [esp]\n    cmp eax, "
ark_str_136:
    .asciz "\n    jne 1f\n    add esp, 4\n    jmp .L"
ark_str_137:
    .asciz "\n1:\n"
ark_str_138:
    .asciz "    pop ecx\n"
ark_str_139:
    .asciz "    pop eax\n    mov [ebp-"
ark_str_140:
    .asciz "], eax\n"
ark_str_141:
    .asciz "    mov [ebp-"
ark_str_142:
    .asciz "], esp\n"
ark_str_143:
    .asciz "    push dword ptr [ebp-"
ark_str_144:
    .asciz "]\n"
ark_str_145:
    .asciz "    and esp, -16\n"
ark_str_146:
    .asciz "    call ecx\n"
ark_str_147:
    .asciz "    call "
ark_str_148:
    .asciz "    mov esp, [ebp-"
ark_str_149:
    .asciz "]\n"
ark_str_150:
    .asciz "    push eax\n"
ark_str_151:
    .asciz "    pop eax\n    mov eax, [ebp-"
ark_str_152:
    .asciz "]\n    lea esp, [ebp-12]\n    pop edi\n    pop esi\n    pop ebx\n    pop ebp\n    ret\n"
ark_str_153:
    .asciz "    pop eax\n    lea esp, [ebp-12]\n    pop edi\n    pop esi\n    pop ebx\n    pop ebp\n    ret\n"
ark_str_154:
    .asciz "    lea eax, ["
ark_str_155:
    .asciz "]\n    push eax\n"
ark_str_156:
    .asciz "    pop edi\n    pop esi\n    mov ecx, "
ark_str_157:
    .asciz "\n    rep movsb\n"
ark_str_158:
    .asciz "    pop eax\n    add eax, 15\n    and eax, -16\n"
ark_str_159:
    .asciz "    sub esp, eax\n    mov eax, esp\n    push eax\n"
ark_str_160:
    .asciz "    pop ecx\n    pop eax\n"
ark_str_161:
    .asciz "    xor edx, edx\n    div ecx\n    push eax\n"
ark_str_162:
    .asciz "    cdq\n    idiv ecx\n    push eax\n"
ark_str_163:
    .asciz "    pop ecx\n    pop eax\n"
ark_str_164:
    .asciz "    xor edx, edx\n    div ecx\n    push edx\n"
ark_str_165:
    .asciz "    cdq\n    idiv ecx\n    push edx\n"
ark_str_166:
    .asciz "    mov eax, "
ark_str_167:
    .asciz "\n    push eax\n"
ark_str_168:
    .asciz "    mov eax, "
ark_str_169:
    .asciz "\n    push eax\n"
ark_str_170:
    .asciz "    mov eax, "
ark_str_171:
    .asciz "\n    push eax\n"
ark_str_172:
    .asciz "    mov eax, "
ark_str_173:
    .asciz "\n    push eax\n"
ark_str_174:
    .asciz "    push 0\n    push 0\n    push 0\n    push 0\n"
ark_str_175:
    .asciz "    mov eax, "
ark_str_176:
    .asciz "\n    push eax\n"
ark_str_177:
    .asciz "    mov eax, "
ark_str_178:
    .asciz "\n    push eax\n"
ark_str_179:
    .asciz "    mov eax, "
ark_str_180:
    .asciz "\n    push eax\n"
ark_str_181:
    .asciz "    mov eax, "
ark_str_182:
    .asciz "\n    push eax\n"
ark_str_183:
    .asciz "addsd"
ark_str_184:
    .asciz "subsd"
ark_str_185:
    .asciz "mulsd"
ark_str_186:
    .asciz "divsd"
ark_str_187:
    .asciz "    movq xmm1, [esp]\n    add esp, 8\n"
ark_str_188:
    .asciz "    movq xmm3, [esp]\n    add esp, 8\n"
ark_str_189:
    .asciz "    movq xmm2, [esp]\n    add esp, 8\n"
ark_str_190:
    .asciz "    movq xmm0, [esp]\n    add esp, 8\n"
ark_str_191:
    .asciz "    "
ark_str_192:
    .asciz " xmm0, xmm3\n    "
ark_str_193:
    .asciz " xmm2, xmm1\n"
ark_str_194:
    .asciz "    sub esp, 8\n    movq [esp], xmm0\n"
ark_str_195:
    .asciz "    sub esp, 8\n    movq [esp], xmm2\n"
ark_str_196:
    .asciz "    movq xmm1, [esp]\n    add esp, 8\n"
ark_str_197:
    .asciz "    movq xmm0, [esp]\n    add esp, 8\n    "
ark_str_198:
    .asciz " xmm0, xmm1\n    sub esp, 8\n    movq [esp], xmm0\n"
ark_str_199:
    .asciz "    mov edx, [esp]\n    add esp, 4\n"
ark_str_200:
    .asciz "    pop ecx\n"
ark_str_201:
    .asciz "    pop esi\n"
ark_str_202:
    .asciz "    pop edi\n"
ark_str_203:
    .asciz "    xor eax, eax\n    cmp edi, edx\n    sete al\n"
ark_str_204:
    .asciz "    mov ebx, eax\n    cmp esi, ecx\n    sete al\n"
ark_str_205:
    .asciz "    and eax, ebx\n"
ark_str_206:
    .asciz "    xor eax, 1\n"
ark_str_207:
    .asciz "    movzx eax, al\n    push eax\n"
ark_str_208:
    .asciz "sete"
ark_str_209:
    .asciz "setne"
ark_str_210:
    .asciz "setb"
ark_str_211:
    .asciz "seta"
ark_str_212:
    .asciz "setbe"
ark_str_213:
    .asciz "setae"
ark_str_214:
    .asciz "sete"
ark_str_215:
    .asciz "    movq xmm1, [esp]\n    add esp, 8\n"
ark_str_216:
    .asciz "    movq xmm0, [esp]\n    add esp, 8\n"
ark_str_217:
    .asciz "    ucomisd xmm0, xmm1\n    "
ark_str_218:
    .asciz " al\n    movzx eax, al\n    push eax\n"
ark_str_219:
    .asciz "    movq xmm0, [esp]\n    add esp, 8\n"
ark_str_220:
    .asciz "    cvttsd2si eax, xmm0\n    push eax\n"
ark_str_221:
    .asciz "    pop eax\n    cvtsi2sd xmm0, eax\n"
ark_str_222:
    .asciz "    cvtsd2ss xmm0, xmm0\n    cvtss2sd xmm0, xmm0\n"
ark_str_223:
    .asciz "    sub esp, 8\n    movq [esp], xmm0\n"
ark_str_224:
    .asciz "    mov eax, "
ark_str_225:
    .asciz "\n    push eax\n"
ark_str_226:
    .asciz "    mov eax, "
ark_str_227:
    .asciz "\n    push eax\n"
ark_str_228:
    .asciz "    pop ecx\n    pop ebx\n"
ark_str_229:
    .asciz "    pop eax\n    pop edx\n"
ark_str_230:
    .asciz "    "
ark_str_231:
    .asciz " eax, ecx\n    "
ark_str_232:
    .asciz " edx, ebx\n"
ark_str_233:
    .asciz "    push edx\n    push eax\n"
ark_str_234:
    .asciz "    pop ecx\n    add esp, 4\n"
ark_str_235:
    .asciz "    pop eax\n    pop edx\n"
ark_str_236:
    .asciz "    shld edx, eax, cl\n    shl eax, cl\n"
ark_str_237:
    .asciz "    push edx\n    push eax\n"
ark_str_238:
    .asciz "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    imul eax, ecx\n    push 0\n    push eax\n"
ark_str_239:
    .asciz "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    xor edx, edx\n    div ecx\n    push 0\n    push eax\n"
ark_str_240:
    .asciz "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    cdq\n    idiv ecx\n    push edx\n    push eax\n"
ark_str_241:
    .asciz "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    xor edx, edx\n    div ecx\n    push 0\n    push edx\n"
ark_str_242:
    .asciz "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    cdq\n    idiv ecx\n    push 0\n    push edx\n"
ark_str_243:
    .asciz "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    shr eax, cl\n    push 0\n    push eax\n"
ark_str_244:
    .asciz "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    sar eax, cl\n    push edx\n    push eax\n"
ark_str_245:
    .asciz "sete"
ark_str_246:
    .asciz "setne"
ark_str_247:
    .asciz "setb"
ark_str_248:
    .asciz "setl"
ark_str_249:
    .asciz "seta"
ark_str_250:
    .asciz "setg"
ark_str_251:
    .asciz "setbe"
ark_str_252:
    .asciz "setle"
ark_str_253:
    .asciz "setae"
ark_str_254:
    .asciz "setge"
ark_str_255:
    .asciz "sete"
ark_str_256:
    .asciz "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    cmp eax, ecx\n    "
ark_str_257:
    .asciz " al\n    movzx eax, al\n    push eax\n"
ark_str_258:
    .asciz "sete"
ark_str_259:
    .asciz "setne"
ark_str_260:
    .asciz "setb"
ark_str_261:
    .asciz "setl"
ark_str_262:
    .asciz "seta"
ark_str_263:
    .asciz "setg"
ark_str_264:
    .asciz "setbe"
ark_str_265:
    .asciz "setle"
ark_str_266:
    .asciz "setae"
ark_str_267:
    .asciz "setge"
ark_str_268:
    .asciz "sete"
ark_str_269:
    .asciz "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    cmp eax, ecx\n    "
ark_str_270:
    .asciz " al\n    movzx eax, al\n    push eax\n"
ark_str_271:
    .asciz "    movq xmm0, [esp]\n    add esp, 8\n"
ark_str_272:
    .asciz "    cvttsd2si eax, xmm0\n    push 0\n    push eax\n"
ark_str_273:
    .asciz "    pop eax\n    add esp, 4\n    cvtsi2sd xmm0, eax\n"
ark_str_274:
    .asciz "    sub esp, 8\n    movq [esp], xmm0\n"
ark_str_275:
    .asciz "    pop eax\n    pop ecx\n"
ark_str_276:
    .asciz "    mov edx, dword ptr [ecx]\n"
ark_str_277:
    .asciz "    and eax, "
ark_str_278:
    .asciz "\n"
ark_str_279:
    .asciz "    shl eax, "
ark_str_280:
    .asciz "\n"
ark_str_281:
    .asciz "    shl edx, "
ark_str_282:
    .asciz "\n    shr edx, "
ark_str_283:
    .asciz "\n    or eax, edx\n"
ark_str_284:
    .asciz "    and edx, "
ark_str_285:
    .asciz "\n    or eax, edx\n"
ark_str_286:
    .asciz "    mov dword ptr [ecx], eax\n    push eax\n"
ark_str_287:
    .asciz "    pop eax\n    mov eax, dword ptr [eax]\n"
ark_str_288:
    .asciz "    shr eax, "
ark_str_289:
    .asciz "\n"
ark_str_290:
    .asciz "    and eax, "
ark_str_291:
    .asciz "\n    push eax\n"
ark_str_292:
    .asciz "    # ARM-specific op ("
ark_str_293:
    .asciz ") - not applicable on x86\n"
ark_str_294:
    .asciz "    # unknown IR op: "
ark_str_295:
    .asciz "\n"
ark_str_296:
    .asciz "    mov eax, [ebp-"
ark_str_297:
    .asciz "]\n    lea esp, [ebp-12]\n    pop edi\n    pop esi\n    pop ebx\n    pop ebp\n    ret\n\n"
ark_str_298:
    .asciz "    xor eax, eax\n    lea esp, [ebp-12]\n    pop edi\n    pop esi\n    pop ebx\n    pop ebp\n    ret\n\n"
    .data
    .globl g_x86_backend
    .local g_x86_backend
g_x86_backend:
    .quad 3906929202812041336
    .quad 8461816662453125124
    .long ark_x86_assemble
    .long ark_x86_link
    .long 0
    .text
    .globl arg_reg
arg_reg:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-56]
    add esp, 4
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl arg_reg_count
arg_reg_count:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl stack_arg_offset
stack_arg_offset:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    push 8
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl emit_str_literal_x
emit_str_literal_x:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 364
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    push 34
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-112]
    push eax
    push 0
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lemit_str_literal_x_0:
    push dword ptr [ebp-72]
    push dword ptr [ebp-64]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_str_literal_x_1
    push dword ptr [ebp-56]
    push dword ptr [ebp-72]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lemit_str_literal_x_4
    push dword ptr [ebp-88]
    push 9
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lemit_str_literal_x_5
    push dword ptr [ebp-88]
    push 13
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lemit_str_literal_x_6
    push dword ptr [ebp-88]
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lemit_str_literal_x_7
    push dword ptr [ebp-88]
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lemit_str_literal_x_8
    jmp .Lemit_str_literal_x_9
.Lemit_str_literal_x_4:
    lea eax, [ark_str_0]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-112]
    push eax
    jmp .Lemit_str_literal_x_3
.Lemit_str_literal_x_5:
    lea eax, [ark_str_1]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-112]
    push eax
    jmp .Lemit_str_literal_x_3
.Lemit_str_literal_x_6:
    lea eax, [ark_str_2]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-112]
    push eax
    jmp .Lemit_str_literal_x_3
.Lemit_str_literal_x_7:
    lea eax, [ark_str_3]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-112]
    push eax
    jmp .Lemit_str_literal_x_3
.Lemit_str_literal_x_8:
    lea eax, [ark_str_4]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-112]
    push eax
    jmp .Lemit_str_literal_x_3
.Lemit_str_literal_x_9:
    push dword ptr [ebp-80]
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lemit_str_literal_x_12
    push dword ptr [ebp-80]
    push 127
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lemit_str_literal_x_13
.Lemit_str_literal_x_12:
    push 1
.Lemit_str_literal_x_13:
    pop eax
    test eax, eax
    jz .Lemit_str_literal_x_10
    lea eax, [ark_str_5]
    push eax
    pop eax
    mov [ebp-96], eax
    lea eax, [ark_str_6]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-112]
    push eax
    push dword ptr [ebp-96]
    push dword ptr [ebp-80]
    push 4
    pop ecx
    pop eax
    sar eax, cl
    push eax
    push 15
    pop ecx
    pop eax
    and eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-112]
    push eax
    push dword ptr [ebp-96]
    push dword ptr [ebp-80]
    push 15
    pop ecx
    pop eax
    and eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-112]
    push eax
    jmp .Lemit_str_literal_x_11
.Lemit_str_literal_x_10:
    push dword ptr [ebp-80]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-112]
    push eax
.Lemit_str_literal_x_11:
    jmp .Lemit_str_literal_x_3
.Lemit_str_literal_x_3:
.Lemit_str_literal_x_2:
    push dword ptr [ebp-72]
    push dword ptr [ebp-72]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    add esp, 4
    jmp .Lemit_str_literal_x_0
.Lemit_str_literal_x_1:
    push 34
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-112]
    push eax
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl binop_x
binop_x:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    push 15
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lbinop_x_1
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lbinop_x_2
    push dword ptr [ebp-56]
    push 30
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lbinop_x_3
    push dword ptr [ebp-56]
    push 31
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lbinop_x_4
    push dword ptr [ebp-56]
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lbinop_x_5
    jmp .Lbinop_x_6
.Lbinop_x_1:
    lea eax, [ark_str_7]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lbinop_x_2:
    lea eax, [ark_str_8]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lbinop_x_3:
    lea eax, [ark_str_9]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lbinop_x_4:
    lea eax, [ark_str_10]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lbinop_x_5:
    lea eax, [ark_str_11]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lbinop_x_6:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lbinop_x_0:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl agg_is_ident_start
agg_is_ident_start:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    push 97
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_is_ident_start_4
    push dword ptr [ebp-48]
    push 122
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_is_ident_start_5
.Lagg_is_ident_start_4:
    push 0
.Lagg_is_ident_start_5:
    pop eax
    test eax, eax
    jnz .Lagg_is_ident_start_2
    push dword ptr [ebp-48]
    push 65
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_is_ident_start_6
    push dword ptr [ebp-48]
    push 90
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_is_ident_start_7
.Lagg_is_ident_start_6:
    push 0
.Lagg_is_ident_start_7:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_is_ident_start_3
.Lagg_is_ident_start_2:
    push 1
.Lagg_is_ident_start_3:
    pop eax
    test eax, eax
    jnz .Lagg_is_ident_start_0
    push dword ptr [ebp-48]
    push 95
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_is_ident_start_1
.Lagg_is_ident_start_0:
    push 1
.Lagg_is_ident_start_1:
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl agg_is_ident
agg_is_ident:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call agg_is_ident_start
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_is_ident_0
    push dword ptr [ebp-48]
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_is_ident_2
    push dword ptr [ebp-48]
    push 57
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_is_ident_3
.Lagg_is_ident_2:
    push 0
.Lagg_is_ident_3:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_is_ident_1
.Lagg_is_ident_0:
    push 1
.Lagg_is_ident_1:
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl agg_skip_ws
agg_skip_ws:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
.Lagg_skip_ws_0:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_ws_2
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_skip_ws_8
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 9
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_skip_ws_9
.Lagg_skip_ws_8:
    push 1
.Lagg_skip_ws_9:
    pop eax
    test eax, eax
    jnz .Lagg_skip_ws_6
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_skip_ws_7
.Lagg_skip_ws_6:
    push 1
.Lagg_skip_ws_7:
    pop eax
    test eax, eax
    jnz .Lagg_skip_ws_4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 13
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_skip_ws_5
.Lagg_skip_ws_4:
    push 1
.Lagg_skip_ws_5:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_skip_ws_3
.Lagg_skip_ws_2:
    push 0
.Lagg_skip_ws_3:
    pop eax
    test eax, eax
    jz .Lagg_skip_ws_1
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_skip_ws_0
.Lagg_skip_ws_1:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl agg_parse_primary
agg_parse_primary:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call agg_skip_ws
    mov esp, [ebp-96]
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_0
    push dword ptr [ebp-48]
    push 524
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_parse_primary_1
.Lagg_parse_primary_0:
.Lagg_parse_primary_1:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    push 40
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_2
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call agg_parse_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call agg_skip_ws
    mov esp, [ebp-96]
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_6
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 41
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_primary_7
.Lagg_parse_primary_6:
    push 0
.Lagg_parse_primary_7:
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_primary_5
.Lagg_parse_primary_4:
.Lagg_parse_primary_5:
    push dword ptr [ebp-64]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_parse_primary_3
.Lagg_parse_primary_2:
.Lagg_parse_primary_3:
    push dword ptr [ebp-56]
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_10
    push dword ptr [ebp-56]
    push 57
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_primary_11
.Lagg_parse_primary_10:
    push 0
.Lagg_parse_primary_11:
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_8
    push 0
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-56]
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_16
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_primary_17
.Lagg_parse_primary_16:
    push 0
.Lagg_parse_primary_17:
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_14
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 120
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_parse_primary_18
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 88
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_primary_19
.Lagg_parse_primary_18:
    push 1
.Lagg_parse_primary_19:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_primary_15
.Lagg_parse_primary_14:
    push 0
.Lagg_parse_primary_15:
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_12
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Lagg_parse_primary_20:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_21
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_24
    push dword ptr [ebp-72]
    push 57
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_primary_25
.Lagg_parse_primary_24:
    push 0
.Lagg_parse_primary_25:
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_22
    push dword ptr [ebp-72]
    push 48
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    jmp .Lagg_parse_primary_23
.Lagg_parse_primary_22:
    push dword ptr [ebp-72]
    push 97
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_28
    push dword ptr [ebp-72]
    push 102
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_primary_29
.Lagg_parse_primary_28:
    push 0
.Lagg_parse_primary_29:
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_26
    push dword ptr [ebp-72]
    push 97
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push 10
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    jmp .Lagg_parse_primary_27
.Lagg_parse_primary_26:
    push dword ptr [ebp-72]
    push 65
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_32
    push dword ptr [ebp-72]
    push 70
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_primary_33
.Lagg_parse_primary_32:
    push 0
.Lagg_parse_primary_33:
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_30
    push dword ptr [ebp-72]
    push 65
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push 10
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    jmp .Lagg_parse_primary_31
.Lagg_parse_primary_30:
    jmp .Lagg_parse_primary_21
.Lagg_parse_primary_31:
.Lagg_parse_primary_27:
.Lagg_parse_primary_23:
    push dword ptr [ebp-64]
    push 16
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    imul eax, ecx
    push 0
    push eax
    push dword ptr [ebp-80]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_primary_20
.Lagg_parse_primary_21:
    jmp .Lagg_parse_primary_13
.Lagg_parse_primary_12:
.Lagg_parse_primary_34:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_38
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_primary_39
.Lagg_parse_primary_38:
    push 0
.Lagg_parse_primary_39:
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_36
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 57
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_primary_37
.Lagg_parse_primary_36:
    push 0
.Lagg_parse_primary_37:
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_35
    push dword ptr [ebp-64]
    push 10
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    imul eax, ecx
    push 0
    push eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 48
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_primary_34
.Lagg_parse_primary_35:
.Lagg_parse_primary_13:
.Lagg_parse_primary_40:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_42
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 117
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_parse_primary_48
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 85
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_primary_49
.Lagg_parse_primary_48:
    push 1
.Lagg_parse_primary_49:
    pop eax
    test eax, eax
    jnz .Lagg_parse_primary_46
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 108
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_primary_47
.Lagg_parse_primary_46:
    push 1
.Lagg_parse_primary_47:
    pop eax
    test eax, eax
    jnz .Lagg_parse_primary_44
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 76
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_primary_45
.Lagg_parse_primary_44:
    push 1
.Lagg_parse_primary_45:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_primary_43
.Lagg_parse_primary_42:
    push 0
.Lagg_parse_primary_43:
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_41
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_primary_40
.Lagg_parse_primary_41:
    push dword ptr [ebp-64]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_parse_primary_9
.Lagg_parse_primary_8:
.Lagg_parse_primary_9:
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call agg_is_ident_start
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_50
.Lagg_parse_primary_52:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_54
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call agg_is_ident
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_primary_55
.Lagg_parse_primary_54:
    push 0
.Lagg_parse_primary_55:
    pop eax
    test eax, eax
    jz .Lagg_parse_primary_53
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_primary_52
.Lagg_parse_primary_53:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_parse_primary_51
.Lagg_parse_primary_50:
.Lagg_parse_primary_51:
    push dword ptr [ebp-48]
    push 524
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl agg_parse_unary
agg_parse_unary:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call agg_skip_ws
    mov esp, [ebp-64]
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_unary_0
    push dword ptr [ebp-48]
    push 524
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_parse_unary_1
.Lagg_parse_unary_0:
.Lagg_parse_unary_1:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    push 45
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_unary_2
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call agg_parse_unary
    mov esp, [ebp-64]
    push eax
    pop eax
    neg eax
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_parse_unary_3
.Lagg_parse_unary_2:
.Lagg_parse_unary_3:
    push dword ptr [ebp-56]
    push 43
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_unary_4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call agg_parse_unary
    mov esp, [ebp-64]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_parse_unary_5
.Lagg_parse_unary_4:
.Lagg_parse_unary_5:
    push dword ptr [ebp-56]
    push 126
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_unary_6
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call agg_parse_unary
    mov esp, [ebp-64]
    push eax
    pop eax
    not eax
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_parse_unary_7
.Lagg_parse_unary_6:
.Lagg_parse_unary_7:
    push dword ptr [ebp-56]
    push 33
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_unary_8
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call agg_parse_unary
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_parse_unary_9
.Lagg_parse_unary_8:
.Lagg_parse_unary_9:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call agg_parse_primary
    mov esp, [ebp-64]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl agg_parse_mul
agg_parse_mul:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_parse_unary
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-56], eax
.Lagg_parse_mul_0:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_skip_ws
    mov esp, [ebp-80]
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_mul_3
    jmp .Lagg_parse_mul_1
    jmp .Lagg_parse_mul_4
.Lagg_parse_mul_3:
.Lagg_parse_mul_4:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 42
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_mul_5
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-56]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_parse_unary
    mov esp, [ebp-80]
    push eax
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    imul eax, ecx
    push 0
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_mul_6
.Lagg_parse_mul_5:
    push dword ptr [ebp-64]
    push 47
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_mul_7
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_parse_unary
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_mul_9
    push dword ptr [ebp-56]
    push dword ptr [ebp-72]
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cdq
    idiv ecx
    push edx
    push eax
    jmp .Lagg_parse_mul_10
.Lagg_parse_mul_9:
    push 0
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
.Lagg_parse_mul_10:
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_mul_8
.Lagg_parse_mul_7:
    push dword ptr [ebp-64]
    push 37
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_mul_11
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_parse_unary
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_mul_13
    push dword ptr [ebp-56]
    push dword ptr [ebp-72]
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cdq
    idiv ecx
    push 0
    push edx
    jmp .Lagg_parse_mul_14
.Lagg_parse_mul_13:
    push 0
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
.Lagg_parse_mul_14:
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_mul_12
.Lagg_parse_mul_11:
    jmp .Lagg_parse_mul_1
.Lagg_parse_mul_12:
.Lagg_parse_mul_8:
.Lagg_parse_mul_6:
.Lagg_parse_mul_2:
    jmp .Lagg_parse_mul_0
.Lagg_parse_mul_1:
    push dword ptr [ebp-56]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl agg_parse_add
agg_parse_add:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_parse_mul
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-56], eax
.Lagg_parse_add_0:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_skip_ws
    mov esp, [ebp-80]
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_add_3
    jmp .Lagg_parse_add_1
    jmp .Lagg_parse_add_4
.Lagg_parse_add_3:
.Lagg_parse_add_4:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 43
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_add_5
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-56]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_parse_mul
    mov esp, [ebp-80]
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_add_6
.Lagg_parse_add_5:
    push dword ptr [ebp-64]
    push 45
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_add_7
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-56]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_parse_mul
    mov esp, [ebp-80]
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    sub eax, ecx
    sub edx, ebx
    push edx
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_add_8
.Lagg_parse_add_7:
    jmp .Lagg_parse_add_1
.Lagg_parse_add_8:
.Lagg_parse_add_6:
.Lagg_parse_add_2:
    jmp .Lagg_parse_add_0
.Lagg_parse_add_1:
    push dword ptr [ebp-56]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl agg_parse_shift
agg_parse_shift:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_parse_add
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-56], eax
.Lagg_parse_shift_0:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_skip_ws
    mov esp, [ebp-80]
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_shift_3
    jmp .Lagg_parse_shift_1
    jmp .Lagg_parse_shift_4
.Lagg_parse_shift_3:
.Lagg_parse_shift_4:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 60
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_shift_7
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 60
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_shift_8
.Lagg_parse_shift_7:
    push 0
.Lagg_parse_shift_8:
    pop eax
    test eax, eax
    jz .Lagg_parse_shift_5
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_parse_add
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    push 63
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    and eax, ecx
    and edx, ebx
    push edx
    push eax
    pop ecx
    pop eax
    shl eax, cl
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_shift_6
.Lagg_parse_shift_5:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 62
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_shift_11
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 62
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_shift_12
.Lagg_parse_shift_11:
    push 0
.Lagg_parse_shift_12:
    pop eax
    test eax, eax
    jz .Lagg_parse_shift_9
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_parse_add
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 64
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_shift_13
    push 0
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    jmp .Lagg_parse_shift_14
.Lagg_parse_shift_13:
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    pop ecx
    pop eax
    sar eax, cl
    push eax
.Lagg_parse_shift_14:
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_shift_10
.Lagg_parse_shift_9:
    jmp .Lagg_parse_shift_1
.Lagg_parse_shift_10:
.Lagg_parse_shift_6:
.Lagg_parse_shift_2:
    jmp .Lagg_parse_shift_0
.Lagg_parse_shift_1:
    push dword ptr [ebp-56]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl agg_parse_expr
agg_parse_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_parse_shift
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-56], eax
.Lagg_parse_expr_0:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_skip_ws
    mov esp, [ebp-80]
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_expr_3
    jmp .Lagg_parse_expr_1
    jmp .Lagg_parse_expr_4
.Lagg_parse_expr_3:
.Lagg_parse_expr_4:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 38
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_expr_5
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-56]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_parse_shift
    mov esp, [ebp-80]
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    and eax, ecx
    and edx, ebx
    push edx
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_expr_6
.Lagg_parse_expr_5:
    push dword ptr [ebp-64]
    push 124
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_expr_7
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-56]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_parse_shift
    mov esp, [ebp-80]
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    or eax, ecx
    or edx, ebx
    push edx
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_expr_8
.Lagg_parse_expr_7:
    push dword ptr [ebp-64]
    push 94
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_expr_9
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-56]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_parse_shift
    mov esp, [ebp-80]
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    xor eax, ecx
    xor edx, ebx
    push edx
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_expr_10
.Lagg_parse_expr_9:
    jmp .Lagg_parse_expr_1
.Lagg_parse_expr_10:
.Lagg_parse_expr_8:
.Lagg_parse_expr_6:
.Lagg_parse_expr_2:
    jmp .Lagg_parse_expr_0
.Lagg_parse_expr_1:
    push dword ptr [ebp-56]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl agg_put_val
agg_put_val:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    mov eax, [ebp+20]
    mov [ebp-72], eax
    mov eax, [ebp+24]
    mov [ebp-80], eax
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_put_val_2
    push dword ptr [ebp-64]
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_put_val_3
.Lagg_put_val_2:
    push 1
.Lagg_put_val_3:
    pop eax
    test eax, eax
    jz .Lagg_put_val_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_put_val_1
.Lagg_put_val_0:
.Lagg_put_val_1:
    push 0
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
.Lagg_put_val_4:
    push dword ptr [ebp-88]
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_put_val_5
    push dword ptr [ebp-48]
    push dword ptr [ebp-64]
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    push 8
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop eax
    sar eax, cl
    push eax
    push 255
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    and eax, ecx
    and edx, ebx
    push edx
    push eax
    add esp, 4
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
.Lagg_put_val_6:
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
    jmp .Lagg_put_val_4
.Lagg_put_val_5:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl agg_skip_value
agg_skip_value:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call agg_skip_ws
    mov esp, [ebp-80]
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_skip_value_1
.Lagg_skip_value_0:
.Lagg_skip_value_1:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 123
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_2
    push 0
    pop eax
    mov [ebp-56], eax
.Lagg_skip_value_4:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_5
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 123
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_6
    push dword ptr [ebp-56]
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-56], eax
    add esp, 4
    jmp .Lagg_skip_value_7
.Lagg_skip_value_6:
    push dword ptr [ebp-64]
    push 125
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_8
    push dword ptr [ebp-56]
    push dword ptr [ebp-56]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-56], eax
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-56]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_10
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_skip_value_11
.Lagg_skip_value_10:
.Lagg_skip_value_11:
    jmp .Lagg_skip_value_9
.Lagg_skip_value_8:
    push dword ptr [ebp-64]
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_12
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
.Lagg_skip_value_14:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_16
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_skip_value_17
.Lagg_skip_value_16:
    push 0
.Lagg_skip_value_17:
    pop eax
    test eax, eax
    jz .Lagg_skip_value_15
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_20
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_skip_value_21
.Lagg_skip_value_20:
    push 0
.Lagg_skip_value_21:
    pop eax
    test eax, eax
    jz .Lagg_skip_value_18
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lagg_skip_value_19
.Lagg_skip_value_18:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
.Lagg_skip_value_19:
    jmp .Lagg_skip_value_14
.Lagg_skip_value_15:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_22
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_skip_value_23
.Lagg_skip_value_22:
.Lagg_skip_value_23:
    jmp .Lagg_skip_value_4
    jmp .Lagg_skip_value_13
.Lagg_skip_value_12:
.Lagg_skip_value_13:
.Lagg_skip_value_9:
.Lagg_skip_value_7:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_skip_value_4
.Lagg_skip_value_5:
    jmp .Lagg_skip_value_3
.Lagg_skip_value_2:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_24
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
.Lagg_skip_value_26:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_28
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_skip_value_29
.Lagg_skip_value_28:
    push 0
.Lagg_skip_value_29:
    pop eax
    test eax, eax
    jz .Lagg_skip_value_27
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_32
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_skip_value_33
.Lagg_skip_value_32:
    push 0
.Lagg_skip_value_33:
    pop eax
    test eax, eax
    jz .Lagg_skip_value_30
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lagg_skip_value_31
.Lagg_skip_value_30:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
.Lagg_skip_value_31:
    jmp .Lagg_skip_value_26
.Lagg_skip_value_27:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_34
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_skip_value_35
.Lagg_skip_value_34:
.Lagg_skip_value_35:
    jmp .Lagg_skip_value_25
.Lagg_skip_value_24:
    push 0
    pop eax
    mov [ebp-56], eax
.Lagg_skip_value_36:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_37
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 40
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_38
    push dword ptr [ebp-56]
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-56], eax
    add esp, 4
    jmp .Lagg_skip_value_39
.Lagg_skip_value_38:
    push dword ptr [ebp-64]
    push 41
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_40
    push dword ptr [ebp-56]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_42
    push dword ptr [ebp-56]
    push dword ptr [ebp-56]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-56], eax
    add esp, 4
    jmp .Lagg_skip_value_43
.Lagg_skip_value_42:
.Lagg_skip_value_43:
    jmp .Lagg_skip_value_41
.Lagg_skip_value_40:
    push dword ptr [ebp-64]
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_44
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
.Lagg_skip_value_46:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_48
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_skip_value_49
.Lagg_skip_value_48:
    push 0
.Lagg_skip_value_49:
    pop eax
    test eax, eax
    jz .Lagg_skip_value_47
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_52
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_skip_value_53
.Lagg_skip_value_52:
    push 0
.Lagg_skip_value_53:
    pop eax
    test eax, eax
    jz .Lagg_skip_value_50
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lagg_skip_value_51
.Lagg_skip_value_50:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
.Lagg_skip_value_51:
    jmp .Lagg_skip_value_46
.Lagg_skip_value_47:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_54
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_skip_value_55
.Lagg_skip_value_54:
.Lagg_skip_value_55:
    jmp .Lagg_skip_value_36
    jmp .Lagg_skip_value_45
.Lagg_skip_value_44:
    push dword ptr [ebp-56]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_skip_value_58
    push dword ptr [ebp-64]
    push 44
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_skip_value_60
    push dword ptr [ebp-64]
    push 125
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_skip_value_61
.Lagg_skip_value_60:
    push 1
.Lagg_skip_value_61:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_skip_value_59
.Lagg_skip_value_58:
    push 0
.Lagg_skip_value_59:
    pop eax
    test eax, eax
    jz .Lagg_skip_value_56
    jmp .Lagg_skip_value_37
    jmp .Lagg_skip_value_57
.Lagg_skip_value_56:
.Lagg_skip_value_57:
.Lagg_skip_value_45:
.Lagg_skip_value_41:
.Lagg_skip_value_39:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_skip_value_36
.Lagg_skip_value_37:
.Lagg_skip_value_25:
.Lagg_skip_value_3:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl agg_parse_scalar
agg_parse_scalar:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    mov eax, [ebp+20]
    mov [ebp-72], eax
    mov eax, [ebp+24]
    mov [ebp-80], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call agg_skip_ws
    mov esp, [ebp-96]
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_scalar_0
    push dword ptr [ebp-48]
    push 524
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_parse_scalar_1
.Lagg_parse_scalar_0:
.Lagg_parse_scalar_1:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call agg_is_ident_start
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_scalar_2
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-88], eax
.Lagg_parse_scalar_4:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_scalar_6
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call agg_is_ident
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_scalar_7
.Lagg_parse_scalar_6:
    push 0
.Lagg_parse_scalar_7:
    pop eax
    test eax, eax
    jz .Lagg_parse_scalar_5
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_scalar_4
.Lagg_parse_scalar_5:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call agg_skip_ws
    mov esp, [ebp-96]
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_scalar_10
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 40
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_scalar_11
.Lagg_parse_scalar_10:
    push 0
.Lagg_parse_scalar_11:
    pop eax
    test eax, eax
    jz .Lagg_parse_scalar_8
    push 0
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    pop eax
    mov [ebp-128], eax
    mov [ebp-96], esp
    push dword ptr [ebp-128]
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call agg_put_val
    mov esp, [ebp-96]
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_parse_scalar_9
.Lagg_parse_scalar_8:
.Lagg_parse_scalar_9:
    push dword ptr [ebp-48]
    push 520
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_scalar_12
    push dword ptr [ebp-48]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 520
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 16
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 520
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 16
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 520
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 16
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 520
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 16
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 520
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_scalar_13
.Lagg_parse_scalar_12:
.Lagg_parse_scalar_13:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_parse_scalar_3
.Lagg_parse_scalar_2:
.Lagg_parse_scalar_3:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call agg_parse_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    # unknown IR op: CDECL64
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    pop eax
    mov [ebp-128], eax
    mov [ebp-96], esp
    push dword ptr [ebp-128]
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call agg_put_val
    mov esp, [ebp-96]
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl agg_parse_type
agg_parse_type:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 428
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    mov eax, [ebp+20]
    mov [ebp-72], eax
    mov eax, [ebp+24]
    mov [ebp-80], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call agg_skip_ws
    mov esp, [ebp-176]
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_parse_type_1
.Lagg_parse_type_0:
.Lagg_parse_type_1:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 123
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_2
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lagg_parse_type_6
    push dword ptr [ebp-56]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_7
.Lagg_parse_type_6:
    push 0
.Lagg_parse_type_7:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_4
    push dword ptr [ebp-56]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call type_size
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-56]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-96], eax
    push 0
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-88]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_8
    push 1
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Lagg_parse_type_9
.Lagg_parse_type_8:
.Lagg_parse_type_9:
.Lagg_parse_type_10:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call agg_skip_ws
    mov esp, [ebp-176]
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_parse_type_15
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 125
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_16
.Lagg_parse_type_15:
    push 1
.Lagg_parse_type_16:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_13
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_17
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_type_18
.Lagg_parse_type_17:
.Lagg_parse_type_18:
    jmp .Lagg_parse_type_11
    jmp .Lagg_parse_type_14
.Lagg_parse_type_13:
.Lagg_parse_type_14:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 44
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_19
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_type_12
    jmp .Lagg_parse_type_20
.Lagg_parse_type_19:
.Lagg_parse_type_20:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 91
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_21
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call agg_parse_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call agg_skip_ws
    mov esp, [ebp-176]
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_25
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 93
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_26
.Lagg_parse_type_25:
    push 0
.Lagg_parse_type_26:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_23
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_type_24
.Lagg_parse_type_23:
.Lagg_parse_type_24:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_29
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 61
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_30
.Lagg_parse_type_29:
    push 0
.Lagg_parse_type_30:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_27
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_type_28
.Lagg_parse_type_27:
.Lagg_parse_type_28:
    jmp .Lagg_parse_type_22
.Lagg_parse_type_21:
.Lagg_parse_type_22:
    push dword ptr [ebp-104]
    push dword ptr [ebp-96]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_31
    push dword ptr [ebp-80]
    push dword ptr [ebp-104]
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    pop eax
    mov [ebp-204], eax
    pop eax
    mov [ebp-208], eax
    mov [ebp-176], esp
    push dword ptr [ebp-208]
    push dword ptr [ebp-204]
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call agg_parse_type
    mov esp, [ebp-176]
    jmp .Lagg_parse_type_32
.Lagg_parse_type_31:
.Lagg_parse_type_32:
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    add esp, 4
.Lagg_parse_type_12:
    jmp .Lagg_parse_type_10
.Lagg_parse_type_11:
    jmp .Lagg_parse_type_5
.Lagg_parse_type_4:
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lagg_parse_type_35
    push dword ptr [ebp-56]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 11
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_parse_type_37
    push dword ptr [ebp-56]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_38
.Lagg_parse_type_37:
    push 1
.Lagg_parse_type_38:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_36
.Lagg_parse_type_35:
    push 0
.Lagg_parse_type_36:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_33
    push dword ptr [ebp-56]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-88], eax
.Lagg_parse_type_39:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call agg_skip_ws
    mov esp, [ebp-176]
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_parse_type_44
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 125
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_45
.Lagg_parse_type_44:
    push 1
.Lagg_parse_type_45:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_42
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_46
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_type_47
.Lagg_parse_type_46:
.Lagg_parse_type_47:
    jmp .Lagg_parse_type_40
    jmp .Lagg_parse_type_43
.Lagg_parse_type_42:
.Lagg_parse_type_43:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 44
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_48
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_type_41
    jmp .Lagg_parse_type_49
.Lagg_parse_type_48:
.Lagg_parse_type_49:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 46
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_50
    push 0
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
.Lagg_parse_type_52:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_56
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call agg_is_ident
    mov esp, [ebp-176]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_57
.Lagg_parse_type_56:
    push 0
.Lagg_parse_type_57:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_54
    push dword ptr [ebp-160]
    push 63
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_55
.Lagg_parse_type_54:
    push 0
.Lagg_parse_type_55:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_53
    lea eax, [ebp-96]
    push eax
    push dword ptr [ebp-160]
    push dword ptr [ebp-160]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-160], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lagg_parse_type_52
.Lagg_parse_type_53:
    lea eax, [ebp-96]
    push eax
    push dword ptr [ebp-160]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call agg_skip_ws
    mov esp, [ebp-176]
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_60
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 61
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_61
.Lagg_parse_type_60:
    push 0
.Lagg_parse_type_61:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_58
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_type_59
.Lagg_parse_type_58:
.Lagg_parse_type_59:
    lea eax, [ebp-96]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call type_find_field
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Lagg_parse_type_51
.Lagg_parse_type_50:
.Lagg_parse_type_51:
    push dword ptr [ebp-88]
    pop eax
    test eax, eax
    jz .Lagg_parse_type_62
    push dword ptr [ebp-80]
    push dword ptr [ebp-88]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
    push dword ptr [ebp-64]
    push dword ptr [ebp-88]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    pop eax
    mov [ebp-204], eax
    pop eax
    mov [ebp-208], eax
    mov [ebp-176], esp
    push dword ptr [ebp-208]
    push dword ptr [ebp-204]
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call agg_parse_type
    mov esp, [ebp-176]
    push dword ptr [ebp-56]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_64
    push dword ptr [ebp-88]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Lagg_parse_type_65
.Lagg_parse_type_64:
.Lagg_parse_type_65:
    jmp .Lagg_parse_type_63
.Lagg_parse_type_62:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call agg_skip_value
    mov esp, [ebp-176]
.Lagg_parse_type_63:
.Lagg_parse_type_41:
    jmp .Lagg_parse_type_39
.Lagg_parse_type_40:
    jmp .Lagg_parse_type_34
.Lagg_parse_type_33:
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    pop eax
    mov [ebp-204], eax
    pop eax
    mov [ebp-208], eax
    mov [ebp-176], esp
    push dword ptr [ebp-208]
    push dword ptr [ebp-204]
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call agg_parse_type
    mov esp, [ebp-176]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call agg_skip_ws
    mov esp, [ebp-176]
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_68
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 125
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_69
.Lagg_parse_type_68:
    push 0
.Lagg_parse_type_69:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_66
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_type_67
.Lagg_parse_type_66:
.Lagg_parse_type_67:
.Lagg_parse_type_34:
.Lagg_parse_type_5:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_parse_type_3
.Lagg_parse_type_2:
.Lagg_parse_type_3:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_70
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lagg_parse_type_76
    push dword ptr [ebp-56]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_77
.Lagg_parse_type_76:
    push 0
.Lagg_parse_type_77:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_74
    push dword ptr [ebp-56]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_75
.Lagg_parse_type_74:
    push 0
.Lagg_parse_type_75:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_72
    push dword ptr [ebp-56]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call type_size
    mov esp, [ebp-176]
    push eax
    jmp .Lagg_parse_type_73
.Lagg_parse_type_72:
    push 1
.Lagg_parse_type_73:
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lagg_parse_type_80
    push dword ptr [ebp-56]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_81
.Lagg_parse_type_80:
    push 0
.Lagg_parse_type_81:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_78
    push dword ptr [ebp-56]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    jmp .Lagg_parse_type_79
.Lagg_parse_type_78:
    push 0
.Lagg_parse_type_79:
    pop eax
    mov [ebp-96], eax
    push 0
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
.Lagg_parse_type_82:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_84
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_85
.Lagg_parse_type_84:
    push 0
.Lagg_parse_type_85:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_83
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_88
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_89
.Lagg_parse_type_88:
    push 0
.Lagg_parse_type_89:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_86
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    push 110
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_parse_type_91
    push dword ptr [ebp-120]
    push 116
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_parse_type_92
    push dword ptr [ebp-120]
    push 114
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_parse_type_93
    push dword ptr [ebp-120]
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_parse_type_94
    push dword ptr [ebp-120]
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_parse_type_95
    push dword ptr [ebp-120]
    push 39
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_parse_type_96
    push dword ptr [ebp-120]
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_parse_type_97
    push dword ptr [ebp-120]
    push 120
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_parse_type_98
    jmp .Lagg_parse_type_99
.Lagg_parse_type_91:
    push 10
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lagg_parse_type_90
.Lagg_parse_type_92:
    push 9
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lagg_parse_type_90
.Lagg_parse_type_93:
    push 13
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lagg_parse_type_90
.Lagg_parse_type_94:
    push 0
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lagg_parse_type_90
.Lagg_parse_type_95:
    push 92
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lagg_parse_type_90
.Lagg_parse_type_96:
    push 39
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lagg_parse_type_90
.Lagg_parse_type_97:
    push 34
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lagg_parse_type_90
.Lagg_parse_type_98:
    push 0
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
.Lagg_parse_type_100:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_101
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_104
    push dword ptr [ebp-136]
    push 57
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_105
.Lagg_parse_type_104:
    push 0
.Lagg_parse_type_105:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_102
    push dword ptr [ebp-136]
    push 48
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    jmp .Lagg_parse_type_103
.Lagg_parse_type_102:
    push dword ptr [ebp-136]
    push 97
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_108
    push dword ptr [ebp-136]
    push 102
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_109
.Lagg_parse_type_108:
    push 0
.Lagg_parse_type_109:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_106
    push dword ptr [ebp-136]
    push 97
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push 10
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    jmp .Lagg_parse_type_107
.Lagg_parse_type_106:
    push dword ptr [ebp-136]
    push 65
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_112
    push dword ptr [ebp-136]
    push 70
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_113
.Lagg_parse_type_112:
    push 0
.Lagg_parse_type_113:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_110
    push dword ptr [ebp-136]
    push 65
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push 10
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    jmp .Lagg_parse_type_111
.Lagg_parse_type_110:
    jmp .Lagg_parse_type_101
.Lagg_parse_type_111:
.Lagg_parse_type_107:
.Lagg_parse_type_103:
    push dword ptr [ebp-128]
    push 16
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-144]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_type_100
.Lagg_parse_type_101:
    push dword ptr [ebp-128]
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .LN_agg_parse_type_put_char
.Lagg_parse_type_99:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lagg_parse_type_90
.Lagg_parse_type_90:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_type_87
.Lagg_parse_type_86:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
.Lagg_parse_type_87:
.LN_agg_parse_type_put_char:
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lagg_parse_type_116
    push dword ptr [ebp-104]
    push dword ptr [ebp-96]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_117
.Lagg_parse_type_116:
    push 1
.Lagg_parse_type_117:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_114
    push dword ptr [ebp-112]
    push 0
    # unknown IR op: CDECL64
    push dword ptr [ebp-88]
    push dword ptr [ebp-80]
    push dword ptr [ebp-104]
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    pop eax
    mov [ebp-204], eax
    pop eax
    mov [ebp-208], eax
    mov [ebp-176], esp
    push dword ptr [ebp-208]
    push dword ptr [ebp-204]
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call agg_put_val
    mov esp, [ebp-176]
    jmp .Lagg_parse_type_115
.Lagg_parse_type_114:
.Lagg_parse_type_115:
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    add esp, 4
    jmp .Lagg_parse_type_82
.Lagg_parse_type_83:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_120
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lagg_parse_type_121
.Lagg_parse_type_120:
    push 0
.Lagg_parse_type_121:
    pop eax
    test eax, eax
    jz .Lagg_parse_type_118
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lagg_parse_type_119
.Lagg_parse_type_118:
.Lagg_parse_type_119:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lagg_parse_type_71
.Lagg_parse_type_70:
.Lagg_parse_type_71:
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call type_size
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lagg_parse_type_122
    push 4
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Lagg_parse_type_123
.Lagg_parse_type_122:
.Lagg_parse_type_123:
    push dword ptr [ebp-88]
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    push dword ptr [ebp-64]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    pop eax
    mov [ebp-204], eax
    pop eax
    mov [ebp-208], eax
    mov [ebp-176], esp
    push dword ptr [ebp-208]
    push dword ptr [ebp-204]
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call agg_parse_scalar
    mov esp, [ebp-176]
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl emit_aggregate_init
emit_aggregate_init:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 924
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-688], eax
    mov [ebp-672], esp
    push dword ptr [ebp-688]
    and esp, -16
    call type_size
    mov esp, [ebp-672]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_0
    push 4
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Lemit_aggregate_init_1
.Lemit_aggregate_init_0:
.Lemit_aggregate_init_1:
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-688], eax
    mov [ebp-672], esp
    push dword ptr [ebp-688]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-672]
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    push 0
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
.Lemit_aggregate_init_2:
    push dword ptr [ebp-88]
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_3
    push dword ptr [ebp-96]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
.Lemit_aggregate_init_4:
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
    jmp .Lemit_aggregate_init_2
.Lemit_aggregate_init_3:
    lea eax, [ebp-104]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [ebp-104]
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-688], eax
    mov [ebp-672], esp
    push dword ptr [ebp-688]
    and esp, -16
    call ark_strlen
    mov esp, [ebp-672]
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [ebp-104]
    push eax
    push 520
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [ebp-104]
    push eax
    push 524
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 0
    push dword ptr [ebp-72]
    push dword ptr [ebp-96]
    push dword ptr [ebp-56]
    lea eax, [ebp-104]
    push eax
    pop eax
    mov [ebp-688], eax
    pop eax
    mov [ebp-692], eax
    pop eax
    mov [ebp-696], eax
    pop eax
    mov [ebp-700], eax
    pop eax
    mov [ebp-704], eax
    mov [ebp-672], esp
    push dword ptr [ebp-704]
    push dword ptr [ebp-700]
    push dword ptr [ebp-696]
    push dword ptr [ebp-692]
    push dword ptr [ebp-688]
    and esp, -16
    call agg_parse_type
    mov esp, [ebp-672]
    push 0
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
.Lemit_aggregate_init_5:
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_6
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-640], eax
    push 0
    pop eax
    mov [ebp-632], eax
    push dword ptr [ebp-632]
    add esp, 4
.Lemit_aggregate_init_7:
    push dword ptr [ebp-632]
    lea eax, [ebp-104]
    push eax
    push 520
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_8
    lea eax, [ebp-104]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-632]
    push 16
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-80]
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_10
    push dword ptr [ebp-632]
    pop eax
    mov [ebp-640], eax
    push dword ptr [ebp-640]
    add esp, 4
    jmp .Lemit_aggregate_init_8
    jmp .Lemit_aggregate_init_11
.Lemit_aggregate_init_10:
.Lemit_aggregate_init_11:
.Lemit_aggregate_init_9:
    push dword ptr [ebp-632]
    push dword ptr [ebp-632]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-632], eax
    add esp, 4
    jmp .Lemit_aggregate_init_7
.Lemit_aggregate_init_8:
    push dword ptr [ebp-640]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_12
    lea eax, [ebp-104]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-640]
    push 16
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-648], eax
    push dword ptr [ebp-648]
    add esp, 4
    push dword ptr [ebp-648]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_14
    push 4
    pop eax
    mov [ebp-648], eax
    push dword ptr [ebp-648]
    add esp, 4
    jmp .Lemit_aggregate_init_15
.Lemit_aggregate_init_14:
.Lemit_aggregate_init_15:
    push dword ptr [ebp-648]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_16
    lea eax, [ark_str_12]
    push eax
    jmp .Lemit_aggregate_init_17
.Lemit_aggregate_init_16:
    push dword ptr [ebp-648]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_18
    lea eax, [ark_str_13]
    push eax
    jmp .Lemit_aggregate_init_19
.Lemit_aggregate_init_18:
    push dword ptr [ebp-648]
    push 4
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_20
    lea eax, [ark_str_14]
    push eax
    jmp .Lemit_aggregate_init_21
.Lemit_aggregate_init_20:
    lea eax, [ark_str_15]
    push eax
.Lemit_aggregate_init_21:
.Lemit_aggregate_init_19:
.Lemit_aggregate_init_17:
    pop eax
    mov [ebp-656], eax
    push dword ptr [ebp-656]
    add esp, 4
    lea eax, [ark_str_16]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-688], eax
    pop eax
    mov [ebp-692], eax
    mov [ebp-672], esp
    push dword ptr [ebp-692]
    push dword ptr [ebp-688]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-672]
    push eax
    push dword ptr [ebp-656]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-688], eax
    pop eax
    mov [ebp-692], eax
    mov [ebp-672], esp
    push dword ptr [ebp-692]
    push dword ptr [ebp-688]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-672]
    push eax
    lea eax, [ark_str_17]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-688], eax
    pop eax
    mov [ebp-692], eax
    mov [ebp-672], esp
    push dword ptr [ebp-692]
    push dword ptr [ebp-688]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-672]
    push eax
    push 0
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
.Lemit_aggregate_init_22:
    push dword ptr [ebp-88]
    lea eax, [ebp-104]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-640]
    push 16
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_23
    lea eax, [ebp-104]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-640]
    push 16
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-688], eax
    pop eax
    mov [ebp-692], eax
    mov [ebp-672], esp
    push dword ptr [ebp-692]
    push dword ptr [ebp-688]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-672]
    push eax
.Lemit_aggregate_init_24:
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
    jmp .Lemit_aggregate_init_22
.Lemit_aggregate_init_23:
    push 10
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-688], eax
    pop eax
    mov [ebp-692], eax
    mov [ebp-672], esp
    push dword ptr [ebp-692]
    push dword ptr [ebp-688]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-672]
    push eax
    lea eax, [ebp-104]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-640]
    push 16
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop eax
    neg eax
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lemit_aggregate_init_13
.Lemit_aggregate_init_12:
    push dword ptr [ebp-80]
    push 8
    pop ecx
    pop eax
    cdq
    idiv ecx
    push edx
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_27
    push dword ptr [ebp-80]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lemit_aggregate_init_28
.Lemit_aggregate_init_27:
    push 0
.Lemit_aggregate_init_28:
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_25
    push 8
    pop eax
    mov [ebp-648], eax
    push dword ptr [ebp-648]
    add esp, 4
    jmp .Lemit_aggregate_init_26
.Lemit_aggregate_init_25:
    push dword ptr [ebp-80]
    push 4
    pop ecx
    pop eax
    cdq
    idiv ecx
    push edx
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_31
    push dword ptr [ebp-80]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lemit_aggregate_init_32
.Lemit_aggregate_init_31:
    push 0
.Lemit_aggregate_init_32:
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_29
    push 4
    pop eax
    mov [ebp-648], eax
    push dword ptr [ebp-648]
    add esp, 4
    jmp .Lemit_aggregate_init_30
.Lemit_aggregate_init_29:
    push dword ptr [ebp-80]
    push 2
    pop ecx
    pop eax
    cdq
    idiv ecx
    push edx
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_35
    push dword ptr [ebp-80]
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lemit_aggregate_init_36
.Lemit_aggregate_init_35:
    push 0
.Lemit_aggregate_init_36:
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_33
    push 2
    pop eax
    mov [ebp-648], eax
    push dword ptr [ebp-648]
    add esp, 4
    jmp .Lemit_aggregate_init_34
.Lemit_aggregate_init_33:
    push 1
    pop eax
    mov [ebp-648], eax
    push dword ptr [ebp-648]
    add esp, 4
.Lemit_aggregate_init_34:
.Lemit_aggregate_init_30:
.Lemit_aggregate_init_26:
    push dword ptr [ebp-648]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_37
    lea eax, [ark_str_18]
    push eax
    jmp .Lemit_aggregate_init_38
.Lemit_aggregate_init_37:
    push dword ptr [ebp-648]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_39
    lea eax, [ark_str_19]
    push eax
    jmp .Lemit_aggregate_init_40
.Lemit_aggregate_init_39:
    push dword ptr [ebp-648]
    push 4
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_41
    lea eax, [ark_str_20]
    push eax
    jmp .Lemit_aggregate_init_42
.Lemit_aggregate_init_41:
    lea eax, [ark_str_21]
    push eax
.Lemit_aggregate_init_42:
.Lemit_aggregate_init_40:
.Lemit_aggregate_init_38:
    pop eax
    mov [ebp-656], eax
    push dword ptr [ebp-656]
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-664], eax
    push 0
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
.Lemit_aggregate_init_43:
    push dword ptr [ebp-88]
    push dword ptr [ebp-648]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lemit_aggregate_init_44
    push dword ptr [ebp-664]
    push dword ptr [ebp-96]
    push dword ptr [ebp-80]
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 0
    push 8
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop eax
    shl eax, cl
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    or eax, ecx
    or edx, ebx
    push edx
    push eax
    pop eax
    mov [ebp-664], eax
    push dword ptr [ebp-664]
    add esp, 4
    add esp, 4
.Lemit_aggregate_init_45:
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
    jmp .Lemit_aggregate_init_43
.Lemit_aggregate_init_44:
    lea eax, [ark_str_22]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-688], eax
    pop eax
    mov [ebp-692], eax
    mov [ebp-672], esp
    push dword ptr [ebp-692]
    push dword ptr [ebp-688]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-672]
    push eax
    push dword ptr [ebp-656]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-688], eax
    pop eax
    mov [ebp-692], eax
    mov [ebp-672], esp
    push dword ptr [ebp-692]
    push dword ptr [ebp-688]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-672]
    push eax
    lea eax, [ark_str_23]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-688], eax
    pop eax
    mov [ebp-692], eax
    mov [ebp-672], esp
    push dword ptr [ebp-692]
    push dword ptr [ebp-688]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-672]
    push eax
    push dword ptr [ebp-664]
    # unknown IR op: CDECL64
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-688], eax
    pop eax
    mov [ebp-692], eax
    mov [ebp-672], esp
    push dword ptr [ebp-692]
    push dword ptr [ebp-688]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-672]
    push eax
    push 10
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-688], eax
    pop eax
    mov [ebp-692], eax
    mov [ebp-672], esp
    push dword ptr [ebp-692]
    push dword ptr [ebp-688]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-672]
    push eax
.Lemit_aggregate_init_13:
    push dword ptr [ebp-80]
    push dword ptr [ebp-648]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    jmp .Lemit_aggregate_init_5
.Lemit_aggregate_init_6:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl x86_emit_internal
x86_emit_internal:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 492
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    mov eax, [ebp+20]
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_init
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_24]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_25]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_26]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 0
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
.Lx86_emit_internal_0:
    push dword ptr [ebp-104]
    push dword ptr [ebp-48]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_1
    push dword ptr [ebp-48]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-104]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-112], eax
    lea eax, [ark_str_27]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-112]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_28]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-112]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-112]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    pop eax
    mov [ebp-264], eax
    mov [ebp-240], esp
    push dword ptr [ebp-264]
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call emit_str_literal_x
    mov esp, [ebp-240]
    push 10
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_2:
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    add esp, 4
    jmp .Lx86_emit_internal_0
.Lx86_emit_internal_1:
    lea eax, [ark_str_29]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 0
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
.Lx86_emit_internal_3:
    push dword ptr [ebp-104]
    push dword ptr [ebp-48]
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_4
    push dword ptr [ebp-48]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-104]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_6
    jmp .Lx86_emit_internal_5
    jmp .Lx86_emit_internal_7
.Lx86_emit_internal_6:
.Lx86_emit_internal_7:
    lea eax, [ark_str_30]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-112]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 10
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-112]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_8
    lea eax, [ark_str_31]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-112]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 10
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_9
.Lx86_emit_internal_8:
.Lx86_emit_internal_9:
    push dword ptr [ebp-112]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_32]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-112]
    push 48
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_12
    push dword ptr [ebp-112]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lx86_emit_internal_13
.Lx86_emit_internal_12:
    push 0
.Lx86_emit_internal_13:
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_10
    push dword ptr [ebp-112]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_14
    push dword ptr [ebp-112]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call type_size
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_15
.Lx86_emit_internal_14:
    push 8
.Lx86_emit_internal_15:
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    push 4
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_16
    lea eax, [ebp-128]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-112]
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: F2F
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [ark_str_33]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ebp-128]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    push 10
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_17
.Lx86_emit_internal_16:
    lea eax, [ebp-128]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-112]
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    lea eax, [ark_str_34]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ebp-128]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    push 10
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_17:
    jmp .Lx86_emit_internal_11
.Lx86_emit_internal_10:
    push dword ptr [ebp-112]
    push 36
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_20
    push dword ptr [ebp-112]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lx86_emit_internal_21
.Lx86_emit_internal_20:
    push 0
.Lx86_emit_internal_21:
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_18
    push dword ptr [ebp-112]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_22
    push dword ptr [ebp-112]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    jmp .Lx86_emit_internal_23
.Lx86_emit_internal_22:
    push 0
.Lx86_emit_internal_23:
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_24
    push dword ptr [ebp-112]
    push 36
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-120]
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    pop eax
    mov [ebp-264], eax
    mov [ebp-240], esp
    push dword ptr [ebp-264]
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call emit_aggregate_init
    mov esp, [ebp-240]
    jmp .Lx86_emit_internal_25
.Lx86_emit_internal_24:
    push 4
    pop eax
    mov [ebp-128], eax
    push 0
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
.Lx86_emit_internal_26:
    push dword ptr [ebp-136]
    push dword ptr [ebp-128]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_27
    lea eax, [ark_str_35]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_28:
    push dword ptr [ebp-136]
    push dword ptr [ebp-136]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-136], eax
    add esp, 4
    jmp .Lx86_emit_internal_26
.Lx86_emit_internal_27:
.Lx86_emit_internal_25:
    jmp .Lx86_emit_internal_19
.Lx86_emit_internal_18:
    push dword ptr [ebp-112]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_29
    push dword ptr [ebp-112]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call type_size
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_30
.Lx86_emit_internal_29:
    push 4
.Lx86_emit_internal_30:
    pop eax
    mov [ebp-120], eax
    lea eax, [ark_str_36]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-120]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_31
    lea eax, [ark_str_37]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    jmp .Lx86_emit_internal_32
.Lx86_emit_internal_31:
    push dword ptr [ebp-120]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_33
    lea eax, [ark_str_38]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    jmp .Lx86_emit_internal_34
.Lx86_emit_internal_33:
    push dword ptr [ebp-120]
    push 4
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_35
    lea eax, [ark_str_39]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    jmp .Lx86_emit_internal_36
.Lx86_emit_internal_35:
    lea eax, [ark_str_40]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
.Lx86_emit_internal_36:
.Lx86_emit_internal_34:
.Lx86_emit_internal_32:
    lea eax, [ark_str_41]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-128]
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_42]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-112]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_37
    push dword ptr [ebp-112]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    jmp .Lx86_emit_internal_38
.Lx86_emit_internal_37:
    push 0
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
.Lx86_emit_internal_38:
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    push 10
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-120]
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_39
    push 8
    pop eax
    mov [ebp-136], eax
.Lx86_emit_internal_41:
    push dword ptr [ebp-136]
    push dword ptr [ebp-120]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_42
    push dword ptr [ebp-120]
    push dword ptr [ebp-136]
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_43
    push 8
    jmp .Lx86_emit_internal_44
.Lx86_emit_internal_43:
    push dword ptr [ebp-120]
    push dword ptr [ebp-136]
    pop ecx
    pop eax
    sub eax, ecx
    push eax
.Lx86_emit_internal_44:
    pop eax
    mov [ebp-144], eax
    lea eax, [ark_str_43]
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-144]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_45
    lea eax, [ark_str_44]
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
    jmp .Lx86_emit_internal_46
.Lx86_emit_internal_45:
    push dword ptr [ebp-144]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_47
    lea eax, [ark_str_45]
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
    jmp .Lx86_emit_internal_48
.Lx86_emit_internal_47:
    push dword ptr [ebp-144]
    push 4
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_49
    lea eax, [ark_str_46]
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
    jmp .Lx86_emit_internal_50
.Lx86_emit_internal_49:
.Lx86_emit_internal_50:
.Lx86_emit_internal_48:
.Lx86_emit_internal_46:
    lea eax, [ark_str_47]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_48]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-136]
    push dword ptr [ebp-144]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Lx86_emit_internal_41
.Lx86_emit_internal_42:
    jmp .Lx86_emit_internal_40
.Lx86_emit_internal_39:
.Lx86_emit_internal_40:
.Lx86_emit_internal_19:
.Lx86_emit_internal_11:
.Lx86_emit_internal_5:
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    add esp, 4
    jmp .Lx86_emit_internal_3
.Lx86_emit_internal_4:
    lea eax, [ark_str_49]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 0
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
.Lx86_emit_internal_51:
    push dword ptr [ebp-96]
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_52
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-96]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 15
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 15
    pop eax
    not eax
    push eax
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_54
    push 16
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    jmp .Lx86_emit_internal_55
.Lx86_emit_internal_54:
.Lx86_emit_internal_55:
    push 0
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-104]
    push 120
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_60
    push dword ptr [ebp-104]
    push 120
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 11
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_62
    push dword ptr [ebp-104]
    push 120
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lx86_emit_internal_63
.Lx86_emit_internal_62:
    push 1
.Lx86_emit_internal_63:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lx86_emit_internal_61
.Lx86_emit_internal_60:
    push 0
.Lx86_emit_internal_61:
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_58
    push dword ptr [ebp-104]
    push 120
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call type_size
    mov esp, [ebp-240]
    push eax
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lx86_emit_internal_59
.Lx86_emit_internal_58:
    push 0
.Lx86_emit_internal_59:
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_56
    push dword ptr [ebp-120]
    push 48
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 200
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    jmp .Lx86_emit_internal_57
.Lx86_emit_internal_56:
.Lx86_emit_internal_57:
    lea eax, [ark_str_50]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 10
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_51]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_52]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_53]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_54]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_55]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-120]
    push 300
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    push 10
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-128]
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_64
    lea eax, [ark_str_56]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-128]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_57]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_65
.Lx86_emit_internal_64:
.Lx86_emit_internal_65:
    push dword ptr [ebp-128]
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_66
    push 1
    jmp .Lx86_emit_internal_67
.Lx86_emit_internal_66:
    push 0
.Lx86_emit_internal_67:
    pop eax
    mov [ebp-136], eax
    push 0
    pop eax
    mov [ebp-144], eax
    push 0
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
.Lx86_emit_internal_68:
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_69
    push dword ptr [ebp-104]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-112]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-160]
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_72
    push dword ptr [ebp-160]
    push 17
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_73
    push dword ptr [ebp-160]
    push 20
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_74
    push dword ptr [ebp-160]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_75
    push dword ptr [ebp-160]
    push 21
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_76
    push dword ptr [ebp-160]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_77
    push dword ptr [ebp-160]
    push 3
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_78
    push dword ptr [ebp-160]
    push 22
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_79
    push dword ptr [ebp-160]
    push 23
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_80
    push dword ptr [ebp-160]
    push 4
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_81
    push dword ptr [ebp-160]
    push 24
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_82
    push dword ptr [ebp-160]
    push 56
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_83
    push dword ptr [ebp-160]
    push 5
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_84
    push dword ptr [ebp-160]
    push 7
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_85
    push dword ptr [ebp-160]
    push 6
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_86
    push dword ptr [ebp-160]
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_87
    push dword ptr [ebp-160]
    push 9
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_88
    push dword ptr [ebp-160]
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_89
    push dword ptr [ebp-160]
    push 25
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_90
    push dword ptr [ebp-160]
    push 13
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_91
    push dword ptr [ebp-160]
    push 26
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_92
    push dword ptr [ebp-160]
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_93
    push dword ptr [ebp-160]
    push 15
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_94
    push dword ptr [ebp-160]
    push 27
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_95
    push dword ptr [ebp-160]
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_96
    push dword ptr [ebp-160]
    push 11
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_97
    push dword ptr [ebp-160]
    push 18
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_98
    push dword ptr [ebp-160]
    push 19
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_99
    push dword ptr [ebp-160]
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_100
    push dword ptr [ebp-160]
    push 46
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_101
    push dword ptr [ebp-160]
    push 50
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_102
    push dword ptr [ebp-160]
    push 39
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_103
    push dword ptr [ebp-160]
    push 40
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_104
    push dword ptr [ebp-160]
    push 28
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_105
    push dword ptr [ebp-160]
    push 29
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_106
    push dword ptr [ebp-160]
    push 30
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_107
    push dword ptr [ebp-160]
    push 31
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_108
    push dword ptr [ebp-160]
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_109
    push dword ptr [ebp-160]
    push 33
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_110
    push dword ptr [ebp-160]
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_111
    push dword ptr [ebp-160]
    push 35
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_112
    push dword ptr [ebp-160]
    push 42
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_113
    push dword ptr [ebp-160]
    push 41
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_114
    push dword ptr [ebp-160]
    push 43
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_115
    push dword ptr [ebp-160]
    push 44
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_116
    push dword ptr [ebp-160]
    push 45
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_117
    push dword ptr [ebp-160]
    push 47
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_118
    push dword ptr [ebp-160]
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_119
    push dword ptr [ebp-160]
    push 37
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_120
    push dword ptr [ebp-160]
    push 38
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_121
    push dword ptr [ebp-160]
    push 51
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_122
    push dword ptr [ebp-160]
    push 52
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_123
    push dword ptr [ebp-160]
    push 53
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_124
    push dword ptr [ebp-160]
    push 54
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_125
    push dword ptr [ebp-160]
    push 55
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_126
    jmp .Lx86_emit_internal_127
.Lx86_emit_internal_72:
.Lx86_emit_internal_73:
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_74:
    push 0
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call arg_reg_count
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 8000
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_128
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 255
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    push dword ptr [ebp-176]
    push dword ptr [ebp-184]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_130
    jmp .Lx86_emit_internal_71
    jmp .Lx86_emit_internal_131
.Lx86_emit_internal_130:
    push dword ptr [ebp-72]
    push dword ptr [ebp-176]
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call stack_arg_offset
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-192], eax
    lea eax, [ark_str_58]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-192]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_59]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 48
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_60]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_131:
    jmp .Lx86_emit_internal_71
    jmp .Lx86_emit_internal_129
.Lx86_emit_internal_128:
.Lx86_emit_internal_129:
    push dword ptr [ebp-104]
    push 116
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_134
    push dword ptr [ebp-144]
    push dword ptr [ebp-104]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lx86_emit_internal_135
.Lx86_emit_internal_134:
    push 0
.Lx86_emit_internal_135:
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_132
    push dword ptr [ebp-104]
    push 116
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-144]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lx86_emit_internal_133
.Lx86_emit_internal_132:
.Lx86_emit_internal_133:
    push dword ptr [ebp-144]
    push dword ptr [ebp-144]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-144], eax
    add esp, 4
    push dword ptr [ebp-136]
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    push dword ptr [ebp-136]
    push dword ptr [ebp-136]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-136], eax
    add esp, 4
    push dword ptr [ebp-72]
    push dword ptr [ebp-176]
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call stack_arg_offset
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-192], eax
    lea eax, [ark_str_61]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-192]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_62]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 48
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_63]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_75:
    lea eax, [ark_str_64]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    push 10
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_76:
    lea eax, [ark_str_65]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_66]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_77:
    lea eax, [ark_str_67]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 48
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_68]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_78:
    lea eax, [ark_str_69]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 48
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_70]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_79:
    push dword ptr [ebp-104]
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_140
    push dword ptr [ebp-152]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lx86_emit_internal_141
.Lx86_emit_internal_140:
    push 0
.Lx86_emit_internal_141:
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_138
    lea eax, [ark_str_71]
    push eax
    push dword ptr [ebp-152]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call ark_streq
    mov esp, [ebp-240]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lx86_emit_internal_139
.Lx86_emit_internal_138:
    push 0
.Lx86_emit_internal_139:
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_136
    lea eax, [ark_str_72]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 8
    push dword ptr [ebp-104]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_73]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_137
.Lx86_emit_internal_136:
    lea eax, [ark_str_74]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_75]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_137:
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_80:
    lea eax, [ark_str_76]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_77]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_81:
    lea eax, [ark_str_78]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_82:
    lea eax, [ark_str_79]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_83:
    lea eax, [ark_str_80]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_84:
    lea eax, [ark_str_81]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 48
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_82]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_85:
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    and eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    mov [ebp-176], eax
    lea eax, [ark_str_83]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_142
    lea eax, [ark_str_84]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_85]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_143
.Lx86_emit_internal_142:
.Lx86_emit_internal_143:
    push dword ptr [ebp-168]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_144
    push dword ptr [ebp-176]
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_146
    lea eax, [ark_str_86]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_147
.Lx86_emit_internal_146:
    lea eax, [ark_str_87]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_147:
    jmp .Lx86_emit_internal_145
.Lx86_emit_internal_144:
    push dword ptr [ebp-168]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_148
    push dword ptr [ebp-176]
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_150
    lea eax, [ark_str_88]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_151
.Lx86_emit_internal_150:
    lea eax, [ark_str_89]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_151:
    jmp .Lx86_emit_internal_149
.Lx86_emit_internal_148:
    push dword ptr [ebp-168]
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_152
    lea eax, [ark_str_90]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_91]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_92]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_93]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
    jmp .Lx86_emit_internal_153
.Lx86_emit_internal_152:
    push dword ptr [ebp-176]
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_154
    lea eax, [ark_str_94]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_155
.Lx86_emit_internal_154:
    lea eax, [ark_str_95]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_155:
.Lx86_emit_internal_153:
.Lx86_emit_internal_149:
.Lx86_emit_internal_145:
    lea eax, [ark_str_96]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_86:
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_156
    lea eax, [ark_str_97]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_98]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_99]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_100]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_157
.Lx86_emit_internal_156:
    lea eax, [ark_str_101]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_158
    lea eax, [ark_str_102]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_159
.Lx86_emit_internal_158:
    push dword ptr [ebp-168]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_160
    lea eax, [ark_str_103]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_161
.Lx86_emit_internal_160:
    lea eax, [ark_str_104]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_161:
.Lx86_emit_internal_159:
    lea eax, [ark_str_105]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_157:
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_87:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call binop_x
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_162
    lea eax, [ark_str_106]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_107]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_163
.Lx86_emit_internal_162:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 17
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_164
    lea eax, [ark_str_108]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_165
.Lx86_emit_internal_164:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 18
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_166
    lea eax, [ark_str_109]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_167
.Lx86_emit_internal_166:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 19
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_168
    lea eax, [ark_str_110]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_169
.Lx86_emit_internal_168:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_170
    lea eax, [ark_str_111]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_171
.Lx86_emit_internal_170:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 35
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_172
    lea eax, [ark_str_112]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_173
.Lx86_emit_internal_172:
    push 0
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    push 21
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_175
    push dword ptr [ebp-184]
    push 22
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_176
    push dword ptr [ebp-184]
    push 23
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_177
    push dword ptr [ebp-184]
    push 24
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_178
    push dword ptr [ebp-184]
    push 25
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_179
    push dword ptr [ebp-184]
    push 26
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_180
    jmp .Lx86_emit_internal_181
.Lx86_emit_internal_175:
    lea eax, [ark_str_113]
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lx86_emit_internal_174
.Lx86_emit_internal_176:
    lea eax, [ark_str_114]
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lx86_emit_internal_174
.Lx86_emit_internal_177:
    lea eax, [ark_str_115]
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lx86_emit_internal_174
.Lx86_emit_internal_178:
    lea eax, [ark_str_116]
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lx86_emit_internal_174
.Lx86_emit_internal_179:
    lea eax, [ark_str_117]
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lx86_emit_internal_174
.Lx86_emit_internal_180:
    lea eax, [ark_str_118]
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lx86_emit_internal_174
.Lx86_emit_internal_181:
    lea eax, [ark_str_119]
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lx86_emit_internal_174
.Lx86_emit_internal_174:
    lea eax, [ark_str_120]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-176]
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_121]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_173:
.Lx86_emit_internal_171:
.Lx86_emit_internal_169:
.Lx86_emit_internal_167:
.Lx86_emit_internal_165:
.Lx86_emit_internal_163:
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_88:
    lea eax, [ark_str_122]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_182
    lea eax, [ark_str_123]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_183
.Lx86_emit_internal_182:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 33
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_184
    lea eax, [ark_str_124]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_185
.Lx86_emit_internal_184:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 29
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_186
    lea eax, [ark_str_125]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_187
.Lx86_emit_internal_186:
.Lx86_emit_internal_187:
.Lx86_emit_internal_185:
.Lx86_emit_internal_183:
    lea eax, [ark_str_126]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_89:
    lea eax, [ark_str_127]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 95
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_128]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_90:
    lea eax, [ark_str_129]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 95
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_130]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_91:
    lea eax, [ark_str_131]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 95
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    push 10
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_92:
    lea eax, [ark_str_132]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 95
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 10
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_93:
    lea eax, [ark_str_133]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 95
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    push 10
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_94:
    lea eax, [ark_str_134]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 95
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    push 10
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_95:
    lea eax, [ark_str_135]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_136]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 95
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_137]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_96:
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-152]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_188
    push dword ptr [ebp-152]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 63
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lx86_emit_internal_189
.Lx86_emit_internal_188:
    push 0
.Lx86_emit_internal_189:
    pop eax
    mov [ebp-184], eax
    push 0
    pop eax
    mov [ebp-200], eax
    push 48
    push dword ptr [ebp-120]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-208], eax
    push 0
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-176]
    add esp, 4
    push dword ptr [ebp-184]
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_190
    lea eax, [ark_str_138]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lx86_emit_internal_191
.Lx86_emit_internal_190:
.Lx86_emit_internal_191:
    push 0
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    add esp, 4
.Lx86_emit_internal_192:
    push dword ptr [ebp-192]
    push dword ptr [ebp-168]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_193
    lea eax, [ark_str_139]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-208]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    push dword ptr [ebp-200]
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_140]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-200]
    push dword ptr [ebp-200]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-200], eax
    add esp, 4
.Lx86_emit_internal_194:
    push dword ptr [ebp-192]
    push dword ptr [ebp-192]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-192], eax
    add esp, 4
    jmp .Lx86_emit_internal_192
.Lx86_emit_internal_193:
    lea eax, [ark_str_141]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-208]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_142]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-200]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    add esp, 4
.Lx86_emit_internal_195:
    push dword ptr [ebp-192]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_196
    lea eax, [ark_str_143]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-208]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    push dword ptr [ebp-192]
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_144]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_197:
    push dword ptr [ebp-192]
    push dword ptr [ebp-192]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-192], eax
    add esp, 4
    jmp .Lx86_emit_internal_195
.Lx86_emit_internal_196:
    lea eax, [ark_str_145]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-184]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_198
    push 0
    pop eax
    mov [ebp-224], eax
    push dword ptr [ebp-224]
    add esp, 4
.Lx86_emit_internal_200:
    push dword ptr [ebp-224]
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_201
    push dword ptr [ebp-152]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-224]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call ark_streq
    mov esp, [ebp-240]
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_203
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-224]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 120
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-232], eax
    push dword ptr [ebp-232]
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_207
    push dword ptr [ebp-232]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lx86_emit_internal_208
.Lx86_emit_internal_207:
    push 0
.Lx86_emit_internal_208:
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_205
    push 1
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-216]
    add esp, 4
    jmp .Lx86_emit_internal_206
.Lx86_emit_internal_205:
.Lx86_emit_internal_206:
    jmp .Lx86_emit_internal_201
    jmp .Lx86_emit_internal_204
.Lx86_emit_internal_203:
.Lx86_emit_internal_204:
.Lx86_emit_internal_202:
    push dword ptr [ebp-224]
    push dword ptr [ebp-224]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-224], eax
    add esp, 4
    jmp .Lx86_emit_internal_200
.Lx86_emit_internal_201:
    jmp .Lx86_emit_internal_199
.Lx86_emit_internal_198:
.Lx86_emit_internal_199:
    push dword ptr [ebp-184]
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_209
    lea eax, [ark_str_146]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_210
.Lx86_emit_internal_209:
    lea eax, [ark_str_147]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 10
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_210:
    lea eax, [ark_str_148]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-208]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_149]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-216]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_211
    lea eax, [ark_str_150]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_212
.Lx86_emit_internal_211:
.Lx86_emit_internal_212:
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_97:
    push dword ptr [ebp-128]
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_213
    lea eax, [ark_str_151]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-128]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_152]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_214
.Lx86_emit_internal_213:
    lea eax, [ark_str_153]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_214:
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_98:
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_99:
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_100:
    lea eax, [ark_str_154]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_155]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_101:
    lea eax, [ark_str_156]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_157]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_102:
    lea eax, [ark_str_158]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_159]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_103:
    lea eax, [ark_str_160]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_215
    lea eax, [ark_str_161]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_216
.Lx86_emit_internal_215:
    lea eax, [ark_str_162]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_216:
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_104:
    lea eax, [ark_str_163]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_217
    lea eax, [ark_str_164]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_218
.Lx86_emit_internal_217:
    lea eax, [ark_str_165]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_218:
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_105:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 512
    pop ecx
    pop eax
    and eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1024
    pop ecx
    pop eax
    and eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_219
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_223
    push dword ptr [ebp-184]
    push dword ptr [ebp-48]
    push 52
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lx86_emit_internal_224
.Lx86_emit_internal_223:
    push 0
.Lx86_emit_internal_224:
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_221
    push dword ptr [ebp-48]
    push 48
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-184]
    push 16
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-48]
    push 48
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-184]
    push 16
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-200], eax
    lea eax, [ebp-208]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-192]
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    lea eax, [ebp-216]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-200]
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    lea eax, [ark_str_166]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ebp-208]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 4294967295
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    and eax, ecx
    and edx, ebx
    push edx
    push eax
    add esp, 4
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_167]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_168]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ebp-208]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 32
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop eax
    sar eax, cl
    push eax
    push 4294967295
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    and eax, ecx
    and edx, ebx
    push edx
    push eax
    add esp, 4
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_169]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_170]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ebp-216]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 4294967295
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    and eax, ecx
    and edx, ebx
    push edx
    push eax
    add esp, 4
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_171]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_172]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ebp-216]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 32
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop eax
    sar eax, cl
    push eax
    push 4294967295
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    and eax, ecx
    and edx, ebx
    push edx
    push eax
    add esp, 4
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_173]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_222
.Lx86_emit_internal_221:
    lea eax, [ark_str_174]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_222:
    jmp .Lx86_emit_internal_220
.Lx86_emit_internal_219:
    push dword ptr [ebp-168]
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_225
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 0
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_229
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lx86_emit_internal_230
.Lx86_emit_internal_229:
    push 0
.Lx86_emit_internal_230:
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_227
    push dword ptr [ebp-48]
    push 36
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 8
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    jmp .Lx86_emit_internal_228
.Lx86_emit_internal_227:
    mov eax, 0
    push eax
    mov eax, 0
    push eax
.Lx86_emit_internal_228:
    pop eax
    mov [ebp-184], eax
    lea eax, [ebp-192]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-184]
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    lea eax, [ark_str_175]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ebp-192]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 32
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop eax
    sar eax, cl
    push eax
    push 4294967295
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    and eax, ecx
    and edx, ebx
    push edx
    push eax
    add esp, 4
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_176]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_177]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ebp-192]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 4294967295
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    and eax, ecx
    and edx, ebx
    push edx
    push eax
    add esp, 4
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_178]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_226
.Lx86_emit_internal_225:
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 0
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_233
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lx86_emit_internal_234
.Lx86_emit_internal_233:
    push 0
.Lx86_emit_internal_234:
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_231
    push dword ptr [ebp-48]
    push 36
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 8
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    jmp .Lx86_emit_internal_232
.Lx86_emit_internal_231:
    mov eax, 0
    push eax
    mov eax, 0
    push eax
.Lx86_emit_internal_232:
    # unknown IR op: F2F
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    # unknown IR op: F2F
    pop eax
    mov [ebp-192], eax
    lea eax, [ebp-200]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-192]
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    lea eax, [ark_str_179]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ebp-200]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 32
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop eax
    sar eax, cl
    push eax
    push 4294967295
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    and eax, ecx
    and edx, ebx
    push edx
    push eax
    add esp, 4
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_180]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_181]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ebp-200]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 4294967295
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    and eax, ecx
    and edx, ebx
    push edx
    push eax
    add esp, 4
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_182]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_226:
.Lx86_emit_internal_220:
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_106:
.Lx86_emit_internal_107:
.Lx86_emit_internal_108:
.Lx86_emit_internal_109:
    push 0
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-152]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    push 29
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_236
    push dword ptr [ebp-176]
    push 30
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_237
    push dword ptr [ebp-176]
    push 31
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_238
    push dword ptr [ebp-176]
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_239
    jmp .Lx86_emit_internal_240
.Lx86_emit_internal_236:
    lea eax, [ark_str_183]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lx86_emit_internal_235
.Lx86_emit_internal_237:
    lea eax, [ark_str_184]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lx86_emit_internal_235
.Lx86_emit_internal_238:
    lea eax, [ark_str_185]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lx86_emit_internal_235
.Lx86_emit_internal_239:
    lea eax, [ark_str_186]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lx86_emit_internal_235
.Lx86_emit_internal_240:
    jmp .Lx86_emit_internal_235
.Lx86_emit_internal_235:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1024
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_241
    lea eax, [ark_str_187]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_188]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_189]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_190]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_191]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_192]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_193]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_194]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_195]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_242
.Lx86_emit_internal_241:
    lea eax, [ark_str_196]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_197]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_198]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_242:
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_110:
    push 0
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1024
    pop ecx
    pop eax
    and eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 255
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-176]
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_243
    lea eax, [ark_str_199]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_200]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_201]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_202]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_203]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_204]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_205]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-184]
    push 15
    pop ecx
    pop eax
    and eax, ecx
    push eax
    push 22
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_245
    lea eax, [ark_str_206]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_246
.Lx86_emit_internal_245:
.Lx86_emit_internal_246:
    lea eax, [ark_str_207]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_244
.Lx86_emit_internal_243:
    push dword ptr [ebp-184]
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    push 21
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_248
    push dword ptr [ebp-192]
    push 22
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_249
    push dword ptr [ebp-192]
    push 23
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_250
    push dword ptr [ebp-192]
    push 24
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_251
    push dword ptr [ebp-192]
    push 25
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_252
    push dword ptr [ebp-192]
    push 26
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_253
    jmp .Lx86_emit_internal_254
.Lx86_emit_internal_248:
    lea eax, [ark_str_208]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lx86_emit_internal_247
.Lx86_emit_internal_249:
    lea eax, [ark_str_209]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lx86_emit_internal_247
.Lx86_emit_internal_250:
    lea eax, [ark_str_210]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lx86_emit_internal_247
.Lx86_emit_internal_251:
    lea eax, [ark_str_211]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lx86_emit_internal_247
.Lx86_emit_internal_252:
    lea eax, [ark_str_212]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lx86_emit_internal_247
.Lx86_emit_internal_253:
    lea eax, [ark_str_213]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lx86_emit_internal_247
.Lx86_emit_internal_254:
    lea eax, [ark_str_214]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lx86_emit_internal_247
.Lx86_emit_internal_247:
    lea eax, [ark_str_215]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_216]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_217]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_218]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_244:
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_111:
    lea eax, [ark_str_219]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_220]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_112:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 512
    pop ecx
    pop eax
    and eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    mov [ebp-168], eax
    lea eax, [ark_str_221]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_255
    lea eax, [ark_str_222]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_256
.Lx86_emit_internal_255:
.Lx86_emit_internal_256:
    lea eax, [ark_str_223]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_113:
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    push 32
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop eax
    shl eax, cl
    push eax
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop ebx
    pop eax
    pop edx
    or eax, ecx
    or edx, ebx
    push edx
    push eax
    pop eax
    mov [ebp-168], eax
    lea eax, [ark_str_224]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    push 32
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop eax
    sar eax, cl
    push eax
    push 4294967295
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    and eax, ecx
    and edx, ebx
    push edx
    push eax
    add esp, 4
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_225]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_226]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    push 4294967295
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    and eax, ecx
    and edx, ebx
    push edx
    push eax
    add esp, 4
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_227]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_114:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 255
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call binop_x
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_257
    lea eax, [ark_str_228]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_229]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_230]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-176]
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_231]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-176]
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_232]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_233]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_258
.Lx86_emit_internal_257:
    push dword ptr [ebp-168]
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_259
    lea eax, [ark_str_234]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_235]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_236]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_237]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_260
.Lx86_emit_internal_259:
    push 0
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-168]
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    push 17
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_262
    push dword ptr [ebp-192]
    push 18
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_263
    push dword ptr [ebp-192]
    push 19
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_264
    push dword ptr [ebp-192]
    push 35
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_265
    push dword ptr [ebp-192]
    push 21
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_266
    push dword ptr [ebp-192]
    push 22
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_267
    push dword ptr [ebp-192]
    push 23
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_268
    push dword ptr [ebp-192]
    push 24
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_269
    push dword ptr [ebp-192]
    push 25
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_270
    push dword ptr [ebp-192]
    push 26
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_271
    jmp .Lx86_emit_internal_272
.Lx86_emit_internal_262:
    lea eax, [ark_str_238]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_261
.Lx86_emit_internal_263:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 256
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_273
    lea eax, [ark_str_239]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_274
.Lx86_emit_internal_273:
    lea eax, [ark_str_240]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_274:
    jmp .Lx86_emit_internal_261
.Lx86_emit_internal_264:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 256
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_275
    lea eax, [ark_str_241]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_276
.Lx86_emit_internal_275:
    lea eax, [ark_str_242]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_276:
    jmp .Lx86_emit_internal_261
.Lx86_emit_internal_265:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 256
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_277
    lea eax, [ark_str_243]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_278
.Lx86_emit_internal_277:
    lea eax, [ark_str_244]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_278:
    jmp .Lx86_emit_internal_261
.Lx86_emit_internal_266:
    lea eax, [ark_str_245]
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    jmp .LN_x86_emit_internal_cmp64
.Lx86_emit_internal_267:
    lea eax, [ark_str_246]
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    jmp .LN_x86_emit_internal_cmp64
.Lx86_emit_internal_268:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 256
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_279
    lea eax, [ark_str_247]
    push eax
    jmp .Lx86_emit_internal_280
.Lx86_emit_internal_279:
    lea eax, [ark_str_248]
    push eax
.Lx86_emit_internal_280:
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    jmp .LN_x86_emit_internal_cmp64
.Lx86_emit_internal_269:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 256
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_281
    lea eax, [ark_str_249]
    push eax
    jmp .Lx86_emit_internal_282
.Lx86_emit_internal_281:
    lea eax, [ark_str_250]
    push eax
.Lx86_emit_internal_282:
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    jmp .LN_x86_emit_internal_cmp64
.Lx86_emit_internal_270:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 256
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_283
    lea eax, [ark_str_251]
    push eax
    jmp .Lx86_emit_internal_284
.Lx86_emit_internal_283:
    lea eax, [ark_str_252]
    push eax
.Lx86_emit_internal_284:
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    jmp .LN_x86_emit_internal_cmp64
.Lx86_emit_internal_271:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 256
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_285
    lea eax, [ark_str_253]
    push eax
    jmp .Lx86_emit_internal_286
.Lx86_emit_internal_285:
    lea eax, [ark_str_254]
    push eax
.Lx86_emit_internal_286:
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    jmp .LN_x86_emit_internal_cmp64
.Lx86_emit_internal_272:
    lea eax, [ark_str_255]
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    jmp .LN_x86_emit_internal_cmp64
.LN_x86_emit_internal_cmp64:
    lea eax, [ark_str_256]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-184]
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_257]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_261
.Lx86_emit_internal_261:
.Lx86_emit_internal_260:
.Lx86_emit_internal_258:
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_115:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 255
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    mov [ebp-168], eax
    push 0
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-168]
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    push 21
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_288
    push dword ptr [ebp-184]
    push 22
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_289
    push dword ptr [ebp-184]
    push 23
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_290
    push dword ptr [ebp-184]
    push 24
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_291
    push dword ptr [ebp-184]
    push 25
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_292
    push dword ptr [ebp-184]
    push 26
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_293
    jmp .Lx86_emit_internal_294
.Lx86_emit_internal_288:
    lea eax, [ark_str_258]
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lx86_emit_internal_287
.Lx86_emit_internal_289:
    lea eax, [ark_str_259]
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lx86_emit_internal_287
.Lx86_emit_internal_290:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 256
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_295
    lea eax, [ark_str_260]
    push eax
    jmp .Lx86_emit_internal_296
.Lx86_emit_internal_295:
    lea eax, [ark_str_261]
    push eax
.Lx86_emit_internal_296:
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lx86_emit_internal_287
.Lx86_emit_internal_291:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 256
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_297
    lea eax, [ark_str_262]
    push eax
    jmp .Lx86_emit_internal_298
.Lx86_emit_internal_297:
    lea eax, [ark_str_263]
    push eax
.Lx86_emit_internal_298:
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lx86_emit_internal_287
.Lx86_emit_internal_292:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 256
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_299
    lea eax, [ark_str_264]
    push eax
    jmp .Lx86_emit_internal_300
.Lx86_emit_internal_299:
    lea eax, [ark_str_265]
    push eax
.Lx86_emit_internal_300:
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lx86_emit_internal_287
.Lx86_emit_internal_293:
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 256
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_301
    lea eax, [ark_str_266]
    push eax
    jmp .Lx86_emit_internal_302
.Lx86_emit_internal_301:
    lea eax, [ark_str_267]
    push eax
.Lx86_emit_internal_302:
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lx86_emit_internal_287
.Lx86_emit_internal_294:
    lea eax, [ark_str_268]
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lx86_emit_internal_287
.Lx86_emit_internal_287:
    lea eax, [ark_str_269]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-176]
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_270]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_116:
    lea eax, [ark_str_271]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_272]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_117:
    lea eax, [ark_str_273]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_274]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_118:
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_303
    push 4294967295
    jmp .Lx86_emit_internal_304
.Lx86_emit_internal_303:
    push 1
    push dword ptr [ebp-176]
    pop ecx
    pop eax
    shl eax, cl
    push eax
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
.Lx86_emit_internal_304:
    pop eax
    mov [ebp-184], eax
    lea eax, [ark_str_275]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_276]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_277]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-184]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_278]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_305
    lea eax, [ark_str_279]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_280]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_281]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 32
    push dword ptr [ebp-168]
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_282]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push 32
    push dword ptr [ebp-168]
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_283]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_306
.Lx86_emit_internal_305:
    lea eax, [ark_str_284]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-184]
    pop eax
    not eax
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_285]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_306:
    lea eax, [ark_str_286]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_119:
    push dword ptr [ebp-152]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-152]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_307
    push 4294967295
    jmp .Lx86_emit_internal_308
.Lx86_emit_internal_307:
    push 1
    push dword ptr [ebp-176]
    pop ecx
    pop eax
    shl eax, cl
    push eax
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
.Lx86_emit_internal_308:
    pop eax
    mov [ebp-184], eax
    lea eax, [ark_str_287]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_309
    lea eax, [ark_str_288]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_289]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_310
.Lx86_emit_internal_309:
.Lx86_emit_internal_310:
    lea eax, [ark_str_290]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-184]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_291]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_120:
    push dword ptr [ebp-152]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_311
    push dword ptr [ebp-152]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 64
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_313
    push dword ptr [ebp-168]
    push dword ptr [ebp-168]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-168], eax
    add esp, 4
.Lx86_emit_internal_315:
    push dword ptr [ebp-168]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lx86_emit_internal_317
    push dword ptr [ebp-168]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 9
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lx86_emit_internal_318
.Lx86_emit_internal_317:
    push 1
.Lx86_emit_internal_318:
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_316
    push dword ptr [ebp-168]
    push dword ptr [ebp-168]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-168], eax
    add esp, 4
    jmp .Lx86_emit_internal_315
.Lx86_emit_internal_316:
    push dword ptr [ebp-168]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_319
    push dword ptr [ebp-168]
    push dword ptr [ebp-168]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-168], eax
    add esp, 4
.Lx86_emit_internal_321:
    push dword ptr [ebp-168]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_323
    push dword ptr [ebp-168]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lx86_emit_internal_324
.Lx86_emit_internal_323:
    push 0
.Lx86_emit_internal_324:
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_322
    push dword ptr [ebp-168]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-168]
    push dword ptr [ebp-168]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-168], eax
    add esp, 4
    jmp .Lx86_emit_internal_321
.Lx86_emit_internal_322:
    jmp .Lx86_emit_internal_320
.Lx86_emit_internal_319:
.Lx86_emit_internal_320:
    jmp .Lx86_emit_internal_314
.Lx86_emit_internal_313:
    push dword ptr [ebp-168]
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_314:
    push 10
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_312
.Lx86_emit_internal_311:
.Lx86_emit_internal_312:
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_121:
.Lx86_emit_internal_122:
.Lx86_emit_internal_123:
.Lx86_emit_internal_124:
.Lx86_emit_internal_125:
.Lx86_emit_internal_126:
    lea eax, [ark_str_292]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call ir_op_name
    mov esp, [ebp-240]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_293]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_127:
    lea eax, [ark_str_294]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-152]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call ir_op_name
    mov esp, [ebp-240]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_295]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_71
.Lx86_emit_internal_71:
.Lx86_emit_internal_70:
    push dword ptr [ebp-112]
    push dword ptr [ebp-112]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-112], eax
    add esp, 4
    jmp .Lx86_emit_internal_68
.Lx86_emit_internal_69:
    push dword ptr [ebp-128]
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_325
    lea eax, [ark_str_296]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-128]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-240]
    push eax
    lea eax, [ark_str_297]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
    jmp .Lx86_emit_internal_326
.Lx86_emit_internal_325:
    lea eax, [ark_str_298]
    push eax
    lea eax, [ebp-80]
    push eax
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-240]
    push eax
.Lx86_emit_internal_326:
.Lx86_emit_internal_53:
    push dword ptr [ebp-96]
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-96], eax
    add esp, 4
    jmp .Lx86_emit_internal_51
.Lx86_emit_internal_52:
    lea eax, [ebp-80]
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_327
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lx86_emit_internal_328
.Lx86_emit_internal_327:
.Lx86_emit_internal_328:
    push 0
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
.Lx86_emit_internal_329:
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_emit_internal_330
    push dword ptr [ebp-56]
    push dword ptr [ebp-112]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-80]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-112]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
.Lx86_emit_internal_331:
    push dword ptr [ebp-112]
    push dword ptr [ebp-112]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-112], eax
    add esp, 4
    jmp .Lx86_emit_internal_329
.Lx86_emit_internal_330:
    push dword ptr [ebp-56]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-104]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl x86_assemble
x86_assemble:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call ark_strlen
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push dword ptr [ebp-64]
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_assemble_0
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Lx86_assemble_1
.Lx86_assemble_0:
.Lx86_assemble_1:
    push 0
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
.Lx86_assemble_2:
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lx86_assemble_3
    push dword ptr [ebp-56]
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
.Lx86_assemble_4:
    push dword ptr [ebp-80]
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    add esp, 4
    jmp .Lx86_assemble_2
.Lx86_assemble_3:
    push dword ptr [ebp-72]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl x86_link
x86_link:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-56]
    add esp, 4
    push dword ptr [ebp-64]
    add esp, 4
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl x86_emit_sysv
x86_emit_sysv:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    push 0
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    pop eax
    mov [ebp-104], eax
    pop eax
    mov [ebp-108], eax
    mov [ebp-80], esp
    push dword ptr [ebp-108]
    push dword ptr [ebp-104]
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call x86_emit_internal
    mov esp, [ebp-80]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl ark_backend_x86_64
ark_backend_x86_64:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [g_x86_backend]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl ark_backend_x86_64_msvc
ark_backend_x86_64_msvc:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [g_x86_backend]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

