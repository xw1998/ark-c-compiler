# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .globl _g_x86_backend
_g_x86_backend:
    .long ark_str_350
    .long ark_str_351
    .long 4
    .long _x86_emit
    .long _x86_assemble
    .long _x86_link
    .section .rdata,"dr"
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
    .asciz "addl"
ark_str_8:
    .asciz "subl"
ark_str_9:
    .asciz "andl"
ark_str_10:
    .asciz "orl"
ark_str_11:
    .asciz "xorl"
ark_str_12:
    .asciz "shll"
ark_str_13:
    .asciz "shrl"
ark_str_14:
    .asciz "    .long ark_str_"
ark_str_15:
    .asciz "    .long "
ark_str_16:
    .asciz "    .long "
ark_str_17:
    .asciz "# Ark C Compiler - generated x86 (32-bit cdecl) assembly\n"
ark_str_18:
    .asciz "    .data\n"
ark_str_19:
    .asciz "    .globl "
ark_str_20:
    .asciz ":\n"
ark_str_21:
    .asciz "    .long "
ark_str_22:
    .asciz "    .long "
ark_str_23:
    .asciz "    .asciz "
ark_str_24:
    .asciz "    .zero "
ark_str_25:
    .asciz "    .long "
ark_str_26:
    .asciz "    .zero "
ark_str_27:
    .asciz "    .zero "
ark_str_28:
    .asciz "    .section .rdata,\"dr\"\n"
ark_str_29:
    .asciz "ark_str_"
ark_str_30:
    .asciz ":\n    .asciz "
ark_str_31:
    .asciz "    .text\n"
ark_str_32:
    .asciz "    .globl "
ark_str_33:
    .asciz ":\n"
ark_str_34:
    .asciz "    pushl %ebp\n"
ark_str_35:
    .asciz "    movl %esp, %ebp\n"
ark_str_36:
    .asciz "    subl $4096, %esp\n"
ark_str_37:
    .asciz "    movl $0, (%esp)\n"
ark_str_38:
    .asciz "    subl $"
ark_str_39:
    .asciz ", %esp\n"
ark_str_40:
    .asciz "    subl $"
ark_str_41:
    .asciz ", %esp\n"
ark_str_42:
    .asciz "    leal "
ark_str_43:
    .asciz "(%ebp), %eax\n"
ark_str_44:
    .asciz "    movl %eax, __ark_va_ptr\n"
ark_str_45:
    .asciz "    movl "
ark_str_46:
    .asciz "(%ebp), %eax\n    movl %eax, -"
ark_str_47:
    .asciz "(%ebp)\n"
ark_str_48:
    .asciz "    movl "
ark_str_49:
    .asciz "(%ebp), %eax\n    movl %eax, -"
ark_str_50:
    .asciz "(%ebp)\n"
ark_str_51:
    .asciz "    movl "
ark_str_52:
    .asciz "(%ebp), %eax\n    movl %eax, -"
ark_str_53:
    .asciz "(%ebp)\n"
ark_str_54:
    .asciz "    pushl $"
ark_str_55:
    .asciz "\n    pushl $"
ark_str_56:
    .asciz "    pushl $"
ark_str_57:
    .asciz "    leal ark_str_"
ark_str_58:
    .asciz ", %eax\n    pushl %eax\n"
ark_str_59:
    .asciz "    pushl -"
ark_str_60:
    .asciz "(%ebp)\n    pushl -"
ark_str_61:
    .asciz "(%ebp)\n"
ark_str_62:
    .asciz "    movzbl -"
ark_str_63:
    .asciz "(%ebp), %eax\n    pushl %eax\n"
ark_str_64:
    .asciz "    movzwl -"
ark_str_65:
    .asciz "(%ebp), %eax\n    pushl %eax\n"
ark_str_66:
    .asciz "    pushl -"
ark_str_67:
    .asciz "(%ebp)\n"
ark_str_68:
    .asciz "    leal -"
ark_str_69:
    .asciz "(%ebp), %eax\n    pushl %eax\n"
ark_str_70:
    .asciz "    movl "
ark_str_71:
    .asciz ", %eax\n    pushl %eax\n"
ark_str_72:
    .asciz "    popl %eax\n    movl %eax, "
ark_str_73:
    .asciz "    movl $"
ark_str_74:
    .asciz ", %eax\n    pushl %eax\n"
ark_str_75:
    .asciz "    popl %edx\n    popl %eax\n"
ark_str_76:
    .asciz "    movl %eax, -"
ark_str_77:
    .asciz "(%ebp)\n    movl %edx, -"
ark_str_78:
    .asciz "(%ebp)\n"
ark_str_79:
    .asciz "    popl %eax\n    movb %al, -"
ark_str_80:
    .asciz "(%ebp)\n"
ark_str_81:
    .asciz "    popl %eax\n    movw %ax, -"
ark_str_82:
    .asciz "(%ebp)\n"
ark_str_83:
    .asciz "    popl %eax\n    movl %eax, -"
ark_str_84:
    .asciz "(%ebp)\n"
ark_str_85:
    .asciz "    addl $4, %esp\n"
ark_str_86:
    .asciz "    popl %eax\n    pushl %eax\n    pushl %eax\n"
ark_str_87:
    .asciz "    popl %eax\n    popl %ecx\n    pushl %eax\n    pushl %ecx\n"
ark_str_88:
    .asciz "    popl %eax\n    movl %eax, %edx\n    sarl $31, %edx\n    pushl %edx\n    pushl %eax\n"
ark_str_89:
    .asciz "    popl %eax\n    pushl $0\n    pushl %eax\n"
ark_str_90:
    .asciz "    popl %eax\n    popl %ecx\n    pushl %eax\n    pushl %ecx\n"
ark_str_91:
    .asciz ".L"
ark_str_92:
    .asciz ":\n"
ark_str_93:
    .asciz "    jmp .L"
ark_str_94:
    .asciz "    popl %eax\n    cmpl $0, %eax\n    je .L"
ark_str_95:
    .asciz "    popl %eax\n    cmpl $0, %eax\n    jne .L"
ark_str_96:
    .asciz "    popl %ecx\n    popl %eax\n    "
ark_str_97:
    .asciz " %ecx, %eax\n    pushl %eax\n"
ark_str_98:
    .asciz "    popl %ecx\n    popl %eax\n    "
ark_str_99:
    .asciz " %cl, %eax\n    pushl %eax\n"
ark_str_100:
    .asciz "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    sete %al\n    movzbl %al, %eax\n    pushl %eax\n"
ark_str_101:
    .asciz "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    setne %al\n    movzbl %al, %eax\n    pushl %eax\n"
ark_str_102:
    .asciz "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    setb %al\n    movzbl %al, %eax\n    pushl %eax\n"
ark_str_103:
    .asciz "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    setl %al\n    movzbl %al, %eax\n    pushl %eax\n"
ark_str_104:
    .asciz "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    setbe %al\n    movzbl %al, %eax\n    pushl %eax\n"
ark_str_105:
    .asciz "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    setle %al\n    movzbl %al, %eax\n    pushl %eax\n"
ark_str_106:
    .asciz "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    seta %al\n    movzbl %al, %eax\n    pushl %eax\n"
ark_str_107:
    .asciz "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    setg %al\n    movzbl %al, %eax\n    pushl %eax\n"
ark_str_108:
    .asciz "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    setae %al\n    movzbl %al, %eax\n    pushl %eax\n"
ark_str_109:
    .asciz "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    setge %al\n    movzbl %al, %eax\n    pushl %eax\n"
ark_str_110:
    .asciz "    popl %ecx\n    popl %eax\n    testl %ecx, %ecx\n    setne %cl\n    testl %eax, %eax\n    setne %al\n    andb %cl, %al\n    movzbl %al, %eax\n    pushl %eax\n"
ark_str_111:
    .asciz "    popl %ecx\n    popl %eax\n    testl %ecx, %ecx\n    setne %cl\n    testl %eax, %eax\n    setne %al\n    orb %cl, %al\n    movzbl %al, %eax\n    pushl %eax\n"
ark_str_112:
    .asciz "    popl %ecx\n    popl %eax\n    imull %ecx, %eax\n    pushl %eax\n"
ark_str_113:
    .asciz "    popl %ecx\n    popl %eax\n    cdq\n    idivl %ecx\n    pushl %eax\n"
ark_str_114:
    .asciz "    popl %ecx\n    popl %eax\n    cdq\n    idivl %ecx\n    pushl %edx\n"
ark_str_115:
    .asciz "    popl %edx\n    popl %eax\n    negl %eax\n    adcl $0, %edx\n    negl %edx\n    pushl %eax\n    pushl %edx\n"
ark_str_116:
    .asciz "    flds (%esp)\n    fchs\n    fstps (%esp)\n"
ark_str_117:
    .asciz "    popl %eax\n    negl %eax\n    pushl %eax\n"
ark_str_118:
    .asciz "    popl %edx\n    popl %eax\n    notl %eax\n    notl %edx\n    pushl %eax\n    pushl %edx\n"
ark_str_119:
    .asciz "    popl %eax\n    notl %eax\n    pushl %eax\n"
ark_str_120:
    .asciz "    popl %edx\n    popl %eax\n    orl %edx, %eax\n    cmpl $0, %eax\n    sete %al\n    movzbl %al, %eax\n    pushl %eax\n"
ark_str_121:
    .asciz "    popl %eax\n    cmpl $0, %eax\n    sete %al\n    movzbl %al, %eax\n    pushl %eax\n"
ark_str_122:
    .asciz "    # unknown unary aux\n"
ark_str_123:
    .asciz "    popl %ecx\n    popl %eax\n"
ark_str_124:
    .asciz "    imull $"
ark_str_125:
    .asciz ", %ecx\n    addl %ecx, %eax\n"
ark_str_126:
    .asciz "    movsbl (%eax), %eax\n    pushl %eax\n"
ark_str_127:
    .asciz "    movswl (%eax), %eax\n    pushl %eax\n"
ark_str_128:
    .asciz "    movl (%eax), %ecx\n    movl 4(%eax), %edx\n    pushl %ecx\n    pushl %edx\n"
ark_str_129:
    .asciz "    movl (%eax), %eax\n    pushl %eax\n"
ark_str_130:
    .asciz "    popl %ecx\n    popl %eax\n    xorl %edx, %edx\n    divl %ecx\n    pushl %eax\n"
ark_str_131:
    .asciz "    popl %ecx\n    popl %eax\n    cdq\n    idivl %ecx\n    pushl %eax\n"
ark_str_132:
    .asciz "    popl %ecx\n    popl %eax\n    xorl %edx, %edx\n    divl %ecx\n    pushl %edx\n"
ark_str_133:
    .asciz "    popl %ecx\n    popl %eax\n    cdq\n    idivl %ecx\n    pushl %edx\n"
ark_str_134:
    .asciz "    popl %edx\n    popl %eax\n    popl %ecx\n"
ark_str_135:
    .asciz "    movl %eax, (%ecx)\n    movl %edx, 4(%ecx)\n"
ark_str_136:
    .asciz "    pushl %eax\n    pushl %edx\n"
ark_str_137:
    .asciz "    popl %edx\n    popl %eax\n"
ark_str_138:
    .asciz "    movb %dl, (%eax)\n"
ark_str_139:
    .asciz "    movw %dx, (%eax)\n"
ark_str_140:
    .asciz "    movl %edx, (%eax)\n"
ark_str_141:
    .asciz "    pushl %edx\n"
ark_str_142:
    .asciz "    popl %eax\n    call *%eax\n"
ark_str_143:
    .asciz "    call "
ark_str_144:
    .asciz "    addl $"
ark_str_145:
    .asciz ", %esp\n"
ark_str_146:
    .asciz "    pushl %eax\n"
ark_str_147:
    .asciz "    popl %eax\n    movl %ebp, %esp\n    popl %ebp\n    ret\n"
ark_str_148:
    .asciz "    popl %eax\n    addl $15, %eax\n    andl $-16, %eax\n    subl %eax, %esp\n    movl %esp, %eax\n    pushl %eax\n"
ark_str_149:
    .asciz "    popl %ecx\n    popl %eax\n"
ark_str_150:
    .asciz "    movl "
ark_str_151:
    .asciz "(%eax), %edx\n    movl %edx, "
ark_str_152:
    .asciz "(%ecx)\n"
ark_str_153:
    .asciz "    movb "
ark_str_154:
    .asciz "(%eax), %dl\n    movb %dl, "
ark_str_155:
    .asciz "(%ecx)\n"
ark_str_156:
    .asciz "    pushl %eax\n"
ark_str_157:
    .asciz "    movl .L_dbl_"
ark_str_158:
    .asciz ", %eax\n    pushl %eax\n"
ark_str_159:
    .asciz "    movl .L_dbl_"
ark_str_160:
    .asciz "+4, %eax\n    pushl %eax\n"
ark_str_161:
    .asciz "    movl .L_dbl_"
ark_str_162:
    .asciz "+8, %eax\n    pushl %eax\n"
ark_str_163:
    .asciz "    movl .L_dbl_"
ark_str_164:
    .asciz "+12, %eax\n    pushl %eax\n"
ark_str_165:
    .asciz "    movl .L_dbl_"
ark_str_166:
    .asciz ", %eax\n    pushl %eax\n"
ark_str_167:
    .asciz "    movl .L_dbl_"
ark_str_168:
    .asciz "+4, %eax\n    pushl %eax\n"
ark_str_169:
    .asciz "    movl .L_flt_"
ark_str_170:
    .asciz ", %eax\n    pushl %eax\n"
ark_str_171:
    .asciz "faddl"
ark_str_172:
    .asciz "fadds"
ark_str_173:
    .asciz "fsubl"
ark_str_174:
    .asciz "fsubs"
ark_str_175:
    .asciz "fmull"
ark_str_176:
    .asciz "fmuls"
ark_str_177:
    .asciz "fdivl"
ark_str_178:
    .asciz "fdivs"
ark_str_179:
    .asciz "    movl (%esp), %eax\n    movl 4(%esp), %ecx\n    movl %ecx, (%esp)\n    movl %eax, 4(%esp)\n"
ark_str_180:
    .asciz "    movl 8(%esp), %eax\n    movl 12(%esp), %ecx\n    movl %ecx, 8(%esp)\n    movl %eax, 12(%esp)\n"
ark_str_181:
    .asciz "    fldl 8(%esp)\n    "
ark_str_182:
    .asciz " (%esp)\n"
ark_str_183:
    .asciz "    addl $8, %esp\n    fstpl (%esp)\n"
ark_str_184:
    .asciz "    popl %eax\n    popl %ecx\n    pushl %eax\n    pushl %ecx\n"
ark_str_185:
    .asciz "    flds 4(%esp)\n    "
ark_str_186:
    .asciz " (%esp)\n    addl $4, %esp\n    fstps (%esp)\n"
ark_str_187:
    .asciz "sete"
ark_str_188:
    .asciz "sete"
ark_str_189:
    .asciz "setne"
ark_str_190:
    .asciz "setb"
ark_str_191:
    .asciz "seta"
ark_str_192:
    .asciz "setbe"
ark_str_193:
    .asciz "setae"
ark_str_194:
    .asciz "    movl (%esp), %eax\n    movl 4(%esp), %ecx\n    movl %ecx, (%esp)\n    movl %eax, 4(%esp)\n"
ark_str_195:
    .asciz "    movl 8(%esp), %eax\n    movl 12(%esp), %ecx\n    movl %ecx, 8(%esp)\n    movl %eax, 12(%esp)\n"
ark_str_196:
    .asciz "    fldl 8(%esp)\n    fcompl (%esp)\n"
ark_str_197:
    .asciz "    fstsw %ax\n    sahf\n"
ark_str_198:
    .asciz "    "
ark_str_199:
    .asciz " %al\n    leal 16(%esp), %esp\n    movzbl %al, %eax\n    pushl %eax\n"
ark_str_200:
    .asciz "    flds 4(%esp)\n    fcomps (%esp)\n"
ark_str_201:
    .asciz "    fstsw %ax\n    sahf\n"
ark_str_202:
    .asciz "    "
ark_str_203:
    .asciz " %al\n    leal 8(%esp), %esp\n    movzbl %al, %eax\n    pushl %eax\n"
ark_str_204:
    .asciz "    popl %eax\n    popl %ecx\n"
ark_str_205:
    .asciz "    pushl %eax\n    pushl %ecx\n"
ark_str_206:
    .asciz "    fldl (%esp)\n"
ark_str_207:
    .asciz "    addl $8, %esp\n"
ark_str_208:
    .asciz "    subl $4, %esp\n"
ark_str_209:
    .asciz "    fistpl (%esp)\n"
ark_str_210:
    .asciz "    flds (%esp)\n"
ark_str_211:
    .asciz "    fistpl (%esp)\n"
ark_str_212:
    .asciz "    popl %eax\n"
ark_str_213:
    .asciz "    subl $8, %esp\n"
ark_str_214:
    .asciz "    movl %eax, (%esp)\n"
ark_str_215:
    .asciz "    fildl (%esp)\n"
ark_str_216:
    .asciz "    fstpl (%esp)\n"
ark_str_217:
    .asciz "    popl %eax\n    popl %ecx\n"
ark_str_218:
    .asciz "    pushl %eax\n    pushl %ecx\n"
ark_str_219:
    .asciz "    fildl (%esp)\n"
ark_str_220:
    .asciz "    fstps (%esp)\n"
ark_str_221:
    .asciz "    popl %eax\n    popl %ecx\n"
ark_str_222:
    .asciz "    pushl %eax\n    pushl %ecx\n"
ark_str_223:
    .asciz "    fldl (%esp)\n"
ark_str_224:
    .asciz "    addl $8, %esp\n"
ark_str_225:
    .asciz "    subl $4, %esp\n"
ark_str_226:
    .asciz "    fstps (%esp)\n"
ark_str_227:
    .asciz "    flds (%esp)\n"
ark_str_228:
    .asciz "    addl $4, %esp\n"
ark_str_229:
    .asciz "    subl $8, %esp\n"
ark_str_230:
    .asciz "    fstpl (%esp)\n"
ark_str_231:
    .asciz "    popl %eax\n    popl %ecx\n"
ark_str_232:
    .asciz "    pushl %eax\n    pushl %ecx\n"
ark_str_233:
    .asciz "    pushl $0\n    pushl $"
ark_str_234:
    .asciz "    popl %ecx\n"
ark_str_235:
    .asciz "    popl %eax\n"
ark_str_236:
    .asciz "    addl %eax, 4(%esp)\n"
ark_str_237:
    .asciz "    adcl %ecx, (%esp)\n"
ark_str_238:
    .asciz "    popl %edx\n    popl %eax\n"
ark_str_239:
    .asciz "    pushl %eax\n    pushl %edx\n"
ark_str_240:
    .asciz "    popl %ecx\n"
ark_str_241:
    .asciz "    popl %eax\n"
ark_str_242:
    .asciz "    subl %eax, 4(%esp)\n"
ark_str_243:
    .asciz "    sbbl %ecx, (%esp)\n"
ark_str_244:
    .asciz "    popl %edx\n    popl %eax\n"
ark_str_245:
    .asciz "    pushl %eax\n    pushl %edx\n"
ark_str_246:
    .asciz "    popl %ecx\n    popl %eax\n"
ark_str_247:
    .asciz "    andl %eax, 4(%esp)\n    andl %ecx, (%esp)\n"
ark_str_248:
    .asciz "    popl %edx\n    popl %eax\n"
ark_str_249:
    .asciz "    pushl %eax\n    pushl %edx\n"
ark_str_250:
    .asciz "    popl %ecx\n    popl %eax\n"
ark_str_251:
    .asciz "    orl %eax, 4(%esp)\n    orl %ecx, (%esp)\n"
ark_str_252:
    .asciz "    popl %edx\n    popl %eax\n"
ark_str_253:
    .asciz "    pushl %eax\n    pushl %edx\n"
ark_str_254:
    .asciz "    popl %ecx\n    popl %eax\n"
ark_str_255:
    .asciz "    xorl %eax, 4(%esp)\n    xorl %ecx, (%esp)\n"
ark_str_256:
    .asciz "    popl %edx\n    popl %eax\n"
ark_str_257:
    .asciz "    pushl %eax\n    pushl %edx\n"
ark_str_258:
    .asciz "__muldi3"
ark_str_259:
    .asciz "__udivdi3"
ark_str_260:
    .asciz "__divdi3"
ark_str_261:
    .asciz "__umoddi3"
ark_str_262:
    .asciz "__moddi3"
ark_str_263:
    .asciz "    movl 0(%esp), %eax\n"
ark_str_264:
    .asciz "    movl 12(%esp), %edx\n"
ark_str_265:
    .asciz "    movl %edx, 0(%esp)\n"
ark_str_266:
    .asciz "    movl %eax, 12(%esp)\n"
ark_str_267:
    .asciz "    movl 4(%esp), %eax\n"
ark_str_268:
    .asciz "    movl 8(%esp), %edx\n"
ark_str_269:
    .asciz "    movl %edx, 4(%esp)\n"
ark_str_270:
    .asciz "    movl %eax, 8(%esp)\n"
ark_str_271:
    .asciz "    call "
ark_str_272:
    .asciz "    addl $16, %esp\n"
ark_str_273:
    .asciz "    pushl %eax\n    pushl %edx\n"
ark_str_274:
    .asciz "    # 64BINARY unsupported op\n"
ark_str_275:
    .asciz "    addl $8, %esp\n"
ark_str_276:
    .asciz "    popl %ecx\n"
ark_str_277:
    .asciz "    popl %eax\n"
ark_str_278:
    .asciz "    popl %edx\n"
ark_str_279:
    .asciz "f"
ark_str_280:
    .asciz "t"
ark_str_281:
    .asciz "    cmpl %ecx, %edx\n    jne .L64"
ark_str_282:
    .asciz "    cmpl %eax, (%esp)\n    jne .L64"
ark_str_283:
    .asciz "    addl $4, %esp\n    pushl $"
ark_str_284:
    .asciz "    jmp .L64e_"
ark_str_285:
    .asciz ".L64"
ark_str_286:
    .asciz ":\n    addl $4, %esp\n    pushl $"
ark_str_287:
    .asciz ".L64e_"
ark_str_288:
    .asciz ":\n"
ark_str_289:
    .asciz "jb"
ark_str_290:
    .asciz "jl"
ark_str_291:
    .asciz "ja"
ark_str_292:
    .asciz "jg"
ark_str_293:
    .asciz "jb"
ark_str_294:
    .asciz "jl"
ark_str_295:
    .asciz "ja"
ark_str_296:
    .asciz "jg"
ark_str_297:
    .asciz "jb"
ark_str_298:
    .asciz "jl"
ark_str_299:
    .asciz "ja"
ark_str_300:
    .asciz "jg"
ark_str_301:
    .asciz "jb"
ark_str_302:
    .asciz "jl"
ark_str_303:
    .asciz "ja"
ark_str_304:
    .asciz "jg"
ark_str_305:
    .asciz "jbe"
ark_str_306:
    .asciz "jle"
ark_str_307:
    .asciz "ja"
ark_str_308:
    .asciz "jg"
ark_str_309:
    .asciz "jb"
ark_str_310:
    .asciz "jl"
ark_str_311:
    .asciz "jae"
ark_str_312:
    .asciz "jge"
ark_str_313:
    .asciz "jmp"
ark_str_314:
    .asciz "    cmpl %ecx, %edx\n    "
ark_str_315:
    .asciz " .L64t_"
ark_str_316:
    .asciz "    "
ark_str_317:
    .asciz " .L64f_"
ark_str_318:
    .asciz "    cmpl %eax, (%esp)\n    "
ark_str_319:
    .asciz " .L64t_"
ark_str_320:
    .asciz "    je .L64t_"
ark_str_321:
    .asciz ".L64f_"
ark_str_322:
    .asciz ":\n    addl $4, %esp\n    pushl $0\n    jmp .L64e_"
ark_str_323:
    .asciz ".L64t_"
ark_str_324:
    .asciz ":\n    addl $4, %esp\n    pushl $1\n"
ark_str_325:
    .asciz ".L64e_"
ark_str_326:
    .asciz ":\n"
ark_str_327:
    .asciz "    fldl (%esp)\n"
ark_str_328:
    .asciz "    addl $8, %esp\n"
ark_str_329:
    .asciz "    subl $4, %esp\n"
ark_str_330:
    .asciz "    fistpl (%esp)\n"
ark_str_331:
    .asciz "    fildll (%esp)\n"
ark_str_332:
    .asciz "    fstpl (%esp)\n"
ark_str_333:
    .asciz "    # bitfield op (placeholder)\n"
ark_str_334:
    .asciz "    # ARM-specific op - not applicable on x86\n"
ark_str_335:
    .asciz ".L_"
ark_str_336:
    .asciz ":\n"
ark_str_337:
    .asciz "    jmp .L_"
ark_str_338:
    .asciz "    popl %eax\n    cmpl $"
ark_str_339:
    .asciz ", %eax\n    je .L"
ark_str_340:
    .asciz "    # unknown IR op\n"
ark_str_341:
    .asciz "    xorl %eax, %eax\n    movl %ebp, %esp\n    popl %ebp\n    ret\n\n"
ark_str_342:
    .asciz "0123456789abcdef"
ark_str_343:
    .asciz "    .section .rdata,\"dr\"\n"
ark_str_344:
    .asciz ".L_flt_"
ark_str_345:
    .asciz ":\n    .long 0x"
ark_str_346:
    .asciz ".L_dbl_"
ark_str_347:
    .asciz ":\n    .long 0x"
ark_str_348:
    .asciz "\n    .long 0x"
ark_str_349:
    .asciz "    .text\n"
ark_str_350:
    .asciz "x86_64"
ark_str_351:
    .asciz "i386-pc-mingw32-cdecl"
    .text
_emit_str_literal_x:
    pushl %ebp
    movl %esp, %ebp
    subl $320, %esp
    movl 8(%ebp), %eax
    movl %eax, -72(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -64(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl $34
    pushl -72(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Lemit_str_literal_x_0:
    pushl -48(%ebp)
    pushl -56(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lemit_str_literal_x_1
    pushl -64(%ebp)
    pushl -48(%ebp)
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
    movb %al, -40(%ebp)
    movzbl -40(%ebp), %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_str_literal_x_4
    pushl -32(%ebp)
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_str_literal_x_5
    pushl -32(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_str_literal_x_6
    pushl -32(%ebp)
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_str_literal_x_7
    pushl -32(%ebp)
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lemit_str_literal_x_8
    jmp .Lemit_str_literal_x_9
.Lemit_str_literal_x_4:
    leal ark_str_0, %eax
    pushl %eax
    pushl -72(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_str_literal_x_3
.Lemit_str_literal_x_5:
    leal ark_str_1, %eax
    pushl %eax
    pushl -72(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_str_literal_x_3
.Lemit_str_literal_x_6:
    leal ark_str_2, %eax
    pushl %eax
    pushl -72(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_str_literal_x_3
.Lemit_str_literal_x_7:
    leal ark_str_3, %eax
    pushl %eax
    pushl -72(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_str_literal_x_3
.Lemit_str_literal_x_8:
    leal ark_str_4, %eax
    pushl %eax
    pushl -72(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_str_literal_x_3
.Lemit_str_literal_x_9:
    movzbl -40(%ebp), %eax
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
    jne .Lemit_str_literal_x_12
    movzbl -40(%ebp), %eax
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
    jmp .Lemit_str_literal_x_13
.Lemit_str_literal_x_12:
    pushl $1
.Lemit_str_literal_x_13:
    popl %eax
    cmpl $0, %eax
    je .Lemit_str_literal_x_10
    leal ark_str_5, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    leal ark_str_6, %eax
    pushl %eax
    pushl -72(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    movzbl -40(%ebp), %eax
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
    pushl -72(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    movzbl -40(%ebp), %eax
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
    pushl -72(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_str_literal_x_11
.Lemit_str_literal_x_10:
    movzbl -40(%ebp), %eax
    pushl %eax
    pushl -72(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lemit_str_literal_x_11:
    jmp .Lemit_str_literal_x_3
.Lemit_str_literal_x_3:
.Lemit_str_literal_x_2:
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    addl $4, %esp
    jmp .Lemit_str_literal_x_0
.Lemit_str_literal_x_1:
    pushl $34
    pushl -72(%ebp)
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

_binop_x:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lbinop_x_1
    pushl -16(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lbinop_x_2
    pushl -16(%ebp)
    pushl $30
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lbinop_x_3
    pushl -16(%ebp)
    pushl $31
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lbinop_x_4
    pushl -16(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lbinop_x_5
    jmp .Lbinop_x_6
.Lbinop_x_1:
    leal ark_str_7, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lbinop_x_2:
    leal ark_str_8, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lbinop_x_3:
    leal ark_str_9, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lbinop_x_4:
    leal ark_str_10, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lbinop_x_5:
    leal ark_str_11, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lbinop_x_6:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lbinop_x_0:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_shiftop_x:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lshiftop_x_1
    pushl -16(%ebp)
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lshiftop_x_2
    jmp .Lshiftop_x_3
.Lshiftop_x_1:
    leal ark_str_12, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lshiftop_x_2:
    leal ark_str_13, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lshiftop_x_3:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lshiftop_x_0:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_sym:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -16(%ebp)
    pushl $95
    pushl -24(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -16(%ebp)
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

_parse_agg_list:
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
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    addl $4, %esp
.Lparse_agg_list_0:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_list_2
    pushl -24(%ebp)
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
    jmp .Lparse_agg_list_3
.Lparse_agg_list_2:
    pushl $0
.Lparse_agg_list_3:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_list_1
    pushl -24(%ebp)
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
    je .Lparse_agg_list_4
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
.Lparse_agg_list_6:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_list_8
    pushl -24(%ebp)
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
    jmp .Lparse_agg_list_9
.Lparse_agg_list_8:
    pushl $0
.Lparse_agg_list_9:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_list_7
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
    jmp .Lparse_agg_list_6
.Lparse_agg_list_7:
    pushl -24(%ebp)
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
    je .Lparse_agg_list_10
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
    jmp .Lparse_agg_list_11
.Lparse_agg_list_10:
.Lparse_agg_list_11:
    jmp .Lparse_agg_list_5
.Lparse_agg_list_4:
    pushl -24(%ebp)
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
    je .Lparse_agg_list_12
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
.Lparse_agg_list_14:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_list_16
    pushl -24(%ebp)
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
    jmp .Lparse_agg_list_17
.Lparse_agg_list_16:
    pushl $0
.Lparse_agg_list_17:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_list_15
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
    jmp .Lparse_agg_list_14
.Lparse_agg_list_15:
    pushl -24(%ebp)
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
    je .Lparse_agg_list_18
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
    jmp .Lparse_agg_list_19
.Lparse_agg_list_18:
.Lparse_agg_list_19:
    pushl -24(%ebp)
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
    je .Lparse_agg_list_20
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
    jmp .Lparse_agg_list_21
.Lparse_agg_list_20:
.Lparse_agg_list_21:
    jmp .Lparse_agg_list_13
.Lparse_agg_list_12:
.Lparse_agg_list_13:
.Lparse_agg_list_5:
    pushl -24(%ebp)
    pushl -32(%ebp)
    pushl -40(%ebp)
    call _parse_agg_value
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lparse_agg_list_22:
    pushl -24(%ebp)
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
    jne .Lparse_agg_list_24
    pushl -24(%ebp)
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
    jmp .Lparse_agg_list_25
.Lparse_agg_list_24:
    pushl $1
.Lparse_agg_list_25:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_list_23
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
    jmp .Lparse_agg_list_22
.Lparse_agg_list_23:
    pushl -24(%ebp)
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
    je .Lparse_agg_list_26
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
    jmp .Lparse_agg_list_0
.Lparse_agg_list_26:
.Lparse_agg_list_27:
    jmp .Lparse_agg_list_1
.Lparse_agg_list_1:
    pushl -24(%ebp)
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
    je .Lparse_agg_list_28
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
    jmp .Lparse_agg_list_29
.Lparse_agg_list_28:
.Lparse_agg_list_29:
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_agg_value:
    pushl %ebp
    movl %esp, %ebp
    subl $1344, %esp
    movl 8(%ebp), %eax
    movl %eax, -1096(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -1088(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -1080(%ebp)
.Lparse_agg_value_0:
    pushl -1080(%ebp)
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
    jne .Lparse_agg_value_4
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_5
.Lparse_agg_value_4:
    pushl $1
.Lparse_agg_value_5:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_agg_value_2
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_3
.Lparse_agg_value_2:
    pushl $1
.Lparse_agg_value_3:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_1
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_0
.Lparse_agg_value_1:
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_6
    pushl -1080(%ebp)
    pushl -1088(%ebp)
    pushl -1096(%ebp)
    call _parse_agg_list
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_agg_value_6:
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_8
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
.Lparse_agg_value_10:
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_14
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_15
.Lparse_agg_value_14:
    pushl $0
.Lparse_agg_value_15:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_12
    pushl -48(%ebp)
    pushl $1023
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
    jmp .Lparse_agg_value_13
.Lparse_agg_value_12:
    pushl $0
.Lparse_agg_value_13:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_11
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_16
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    pushl $110
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_agg_value_19
    pushl -40(%ebp)
    pushl $116
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_agg_value_20
    pushl -40(%ebp)
    pushl $114
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_agg_value_21
    pushl -40(%ebp)
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_agg_value_22
    pushl -40(%ebp)
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_agg_value_23
    pushl -40(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_agg_value_24
    pushl -40(%ebp)
    pushl $120
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_agg_value_25
    jmp .Lparse_agg_value_26
.Lparse_agg_value_19:
    leal -1072(%ebp), %eax
    pushl %eax
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $10
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_agg_value_18
.Lparse_agg_value_20:
    leal -1072(%ebp), %eax
    pushl %eax
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $9
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_agg_value_18
.Lparse_agg_value_21:
    leal -1072(%ebp), %eax
    pushl %eax
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $13
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_agg_value_18
.Lparse_agg_value_22:
    leal -1072(%ebp), %eax
    pushl %eax
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $34
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_agg_value_18
.Lparse_agg_value_23:
    leal -1072(%ebp), %eax
    pushl %eax
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
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
    jmp .Lparse_agg_value_18
.Lparse_agg_value_24:
    leal -1072(%ebp), %eax
    pushl %eax
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
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
    jmp .Lparse_agg_value_18
.Lparse_agg_value_25:
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_29
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_30
.Lparse_agg_value_29:
    pushl $0
.Lparse_agg_value_30:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_27
    pushl -1080(%ebp)
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
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_28
.Lparse_agg_value_27:
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_33
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_34
.Lparse_agg_value_33:
    pushl $0
.Lparse_agg_value_34:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_31
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_32
.Lparse_agg_value_31:
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_37
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_38
.Lparse_agg_value_37:
    pushl $0
.Lparse_agg_value_38:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_35
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_36
.Lparse_agg_value_35:
.Lparse_agg_value_36:
.Lparse_agg_value_32:
.Lparse_agg_value_28:
    pushl -32(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_39
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_43
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_44
.Lparse_agg_value_43:
    pushl $0
.Lparse_agg_value_44:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_41
    pushl -1080(%ebp)
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
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_42
.Lparse_agg_value_41:
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_47
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_48
.Lparse_agg_value_47:
    pushl $0
.Lparse_agg_value_48:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_45
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lparse_agg_value_46
.Lparse_agg_value_45:
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_51
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_52
.Lparse_agg_value_51:
    pushl $0
.Lparse_agg_value_52:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_49
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lparse_agg_value_50
.Lparse_agg_value_49:
.Lparse_agg_value_50:
.Lparse_agg_value_46:
.Lparse_agg_value_42:
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
    je .Lparse_agg_value_53
    leal -1072(%ebp), %eax
    pushl %eax
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
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
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_agg_value_54
.Lparse_agg_value_53:
    leal -1072(%ebp), %eax
    pushl %eax
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
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
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
.Lparse_agg_value_54:
    jmp .Lparse_agg_value_40
.Lparse_agg_value_39:
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
.Lparse_agg_value_40:
    jmp .Lparse_agg_value_18
.Lparse_agg_value_26:
    leal -1072(%ebp), %eax
    pushl %eax
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_18
.Lparse_agg_value_18:
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_17
.Lparse_agg_value_16:
    leal -1072(%ebp), %eax
    pushl %eax
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
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
.Lparse_agg_value_17:
    jmp .Lparse_agg_value_10
.Lparse_agg_value_11:
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_55
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_56
.Lparse_agg_value_55:
.Lparse_agg_value_56:
    leal -1072(%ebp), %eax
    pushl %eax
    pushl -48(%ebp)
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
    pushl -48(%ebp)
    leal -1072(%ebp), %eax
    pushl %eax
    pushl -1088(%ebp)
    call _ir_program_add_string
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    leal ark_str_14, %eax
    pushl %eax
    pushl -1096(%ebp)
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
    pushl -1096(%ebp)
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    pushl -1096(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -1080(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_agg_value_8:
    pushl -1080(%ebp)
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
    jne .Lparse_agg_value_61
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $126
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
    jmp .Lparse_agg_value_62
.Lparse_agg_value_61:
    pushl $1
.Lparse_agg_value_62:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_agg_value_59
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_63
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_64
.Lparse_agg_value_63:
    pushl $0
.Lparse_agg_value_64:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_agg_value_60
.Lparse_agg_value_59:
    pushl $1
.Lparse_agg_value_60:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_57
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
    popl %edx
    popl %eax
    movl %eax, -1072(%ebp)
    movl %edx, -1068(%ebp)
    pushl $0
    popl %eax
    movl %eax, -1064(%ebp)
    pushl $0
    popl %eax
    movl %eax, -1056(%ebp)
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_65
    pushl $1
    popl %eax
    movl %eax, -1064(%ebp)
    pushl -1064(%ebp)
    addl $4, %esp
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_66
.Lparse_agg_value_65:
.Lparse_agg_value_66:
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $126
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_67
    pushl $1
    popl %eax
    movl %eax, -1056(%ebp)
    pushl -1056(%ebp)
    addl $4, %esp
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_68
.Lparse_agg_value_67:
.Lparse_agg_value_68:
    pushl -1080(%ebp)
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_71
    pushl -1080(%ebp)
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
    jne .Lparse_agg_value_73
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_74
.Lparse_agg_value_73:
    pushl $1
.Lparse_agg_value_74:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_agg_value_72
.Lparse_agg_value_71:
    pushl $0
.Lparse_agg_value_72:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_69
    pushl -1080(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    pushl -1080(%ebp)
    addl $4, %esp
.Lparse_agg_value_75:
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_76
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -1048(%ebp)
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_79
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_80
.Lparse_agg_value_79:
    pushl $0
.Lparse_agg_value_80:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_77
    pushl -1080(%ebp)
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
    popl %eax
    movl %eax, -1048(%ebp)
    pushl -1048(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_78
.Lparse_agg_value_77:
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_83
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_84
.Lparse_agg_value_83:
    pushl $0
.Lparse_agg_value_84:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_81
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    movl %eax, -1048(%ebp)
    pushl -1048(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_82
.Lparse_agg_value_81:
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_87
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_88
.Lparse_agg_value_87:
    pushl $0
.Lparse_agg_value_88:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_85
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    movl %eax, -1048(%ebp)
    pushl -1048(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_86
.Lparse_agg_value_85:
.Lparse_agg_value_86:
.Lparse_agg_value_82:
.Lparse_agg_value_78:
    pushl -1048(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_89
    jmp .Lparse_agg_value_76
.Lparse_agg_value_89:
.Lparse_agg_value_90:
    pushl -1072(%ebp)
    pushl -1068(%ebp)
    pushl $16
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
    movl 0(%esp), %eax
    movl 12(%esp), %edx
    movl %edx, 0(%esp)
    movl %eax, 12(%esp)
    movl 4(%esp), %eax
    movl 8(%esp), %edx
    movl %edx, 4(%esp)
    movl %eax, 8(%esp)
    call ___muldi3
    addl $16, %esp
    pushl %eax
    pushl %edx
    pushl -1048(%ebp)
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
    popl %edx
    popl %eax
    movl %eax, -1072(%ebp)
    movl %edx, -1068(%ebp)
    pushl -1072(%ebp)
    addl $4, %esp
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_75
.Lparse_agg_value_76:
    jmp .Lparse_agg_value_70
.Lparse_agg_value_69:
.Lparse_agg_value_91:
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_93
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_94
.Lparse_agg_value_93:
    pushl $0
.Lparse_agg_value_94:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_92
    pushl -1072(%ebp)
    pushl -1068(%ebp)
    pushl $10
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
    movl 0(%esp), %eax
    movl 12(%esp), %edx
    movl %edx, 0(%esp)
    movl %eax, 12(%esp)
    movl 4(%esp), %eax
    movl 8(%esp), %edx
    movl %edx, 4(%esp)
    movl %eax, 8(%esp)
    call ___muldi3
    addl $16, %esp
    pushl %eax
    pushl %edx
    pushl -1080(%ebp)
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
    popl %edx
    popl %eax
    movl %eax, -1072(%ebp)
    movl %edx, -1068(%ebp)
    pushl -1072(%ebp)
    addl $4, %esp
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_91
.Lparse_agg_value_92:
.Lparse_agg_value_70:
    pushl -1064(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_95
    pushl -1072(%ebp)
    pushl -1068(%ebp)
    popl %edx
    popl %eax
    negl %eax
    adcl $0, %edx
    negl %edx
    pushl %eax
    pushl %edx
    popl %edx
    popl %eax
    movl %eax, -1072(%ebp)
    movl %edx, -1068(%ebp)
    pushl -1072(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_96
.Lparse_agg_value_95:
.Lparse_agg_value_96:
    pushl -1056(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_97
    pushl -1072(%ebp)
    pushl -1068(%ebp)
    popl %edx
    popl %eax
    notl %eax
    notl %edx
    pushl %eax
    pushl %edx
    popl %edx
    popl %eax
    movl %eax, -1072(%ebp)
    movl %edx, -1068(%ebp)
    pushl -1072(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_98
.Lparse_agg_value_97:
.Lparse_agg_value_98:
    leal ark_str_15, %eax
    pushl %eax
    pushl -1096(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -1072(%ebp)
    pushl -1068(%ebp)
    addl $4, %esp
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    pushl -1096(%ebp)
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    pushl -1096(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -1080(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_agg_value_57:
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_99
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
    pushl -1080(%ebp)
    pushl -1088(%ebp)
    pushl -1096(%ebp)
    call _parse_agg_value
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    pushl -1080(%ebp)
    addl $4, %esp
.Lparse_agg_value_101:
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_103
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $41
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
    jmp .Lparse_agg_value_104
.Lparse_agg_value_103:
    pushl $0
.Lparse_agg_value_104:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_102
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_101
.Lparse_agg_value_102:
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $41
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_105
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_106
.Lparse_agg_value_105:
.Lparse_agg_value_106:
    pushl -1080(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_agg_value_99:
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_113
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_114
.Lparse_agg_value_113:
    pushl $0
.Lparse_agg_value_114:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_agg_value_111
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_115
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_116
.Lparse_agg_value_115:
    pushl $0
.Lparse_agg_value_116:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_agg_value_112
.Lparse_agg_value_111:
    pushl $1
.Lparse_agg_value_112:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_agg_value_109
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lparse_agg_value_110
.Lparse_agg_value_109:
    pushl $1
.Lparse_agg_value_110:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_107
    pushl $0
    popl %eax
    movl %eax, -944(%ebp)
.Lparse_agg_value_117:
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_125
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_126
.Lparse_agg_value_125:
    pushl $0
.Lparse_agg_value_126:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_agg_value_123
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_127
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_128
.Lparse_agg_value_127:
    pushl $0
.Lparse_agg_value_128:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_agg_value_124
.Lparse_agg_value_123:
    pushl $1
.Lparse_agg_value_124:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_agg_value_121
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_129
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_130
.Lparse_agg_value_129:
    pushl $0
.Lparse_agg_value_130:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_agg_value_122
.Lparse_agg_value_121:
    pushl $1
.Lparse_agg_value_122:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_agg_value_119
    pushl -1080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lparse_agg_value_120
.Lparse_agg_value_119:
    pushl $1
.Lparse_agg_value_120:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_118
    pushl -944(%ebp)
    pushl $127
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_131
    leal -1072(%ebp), %eax
    pushl %eax
    pushl -944(%ebp)
    pushl -944(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -944(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -1080(%ebp)
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
    jmp .Lparse_agg_value_132
.Lparse_agg_value_131:
.Lparse_agg_value_132:
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_117
.Lparse_agg_value_118:
    leal -1072(%ebp), %eax
    pushl %eax
    pushl -944(%ebp)
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
    leal -1072(%ebp), %eax
    pushl %eax
    popl %eax
    movl %eax, -936(%ebp)
    pushl -944(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_141
    leal -1072(%ebp), %eax
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
    pushl $97
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
    jmp .Lparse_agg_value_142
.Lparse_agg_value_141:
    pushl $0
.Lparse_agg_value_142:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_139
    leal -1072(%ebp), %eax
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_agg_value_140
.Lparse_agg_value_139:
    pushl $0
.Lparse_agg_value_140:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_137
    leal -1072(%ebp), %eax
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
    pushl $107
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
    jmp .Lparse_agg_value_138
.Lparse_agg_value_137:
    pushl $0
.Lparse_agg_value_138:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_135
    leal -1072(%ebp), %eax
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
    jmp .Lparse_agg_value_136
.Lparse_agg_value_135:
    pushl $0
.Lparse_agg_value_136:
    popl %eax
    cmpl $0, %eax
    je .Lparse_agg_value_133
    leal -1072(%ebp), %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -936(%ebp)
    pushl -936(%ebp)
    addl $4, %esp
    jmp .Lparse_agg_value_134
.Lparse_agg_value_133:
.Lparse_agg_value_134:
    leal ark_str_16, %eax
    pushl %eax
    pushl -1096(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -936(%ebp)
    pushl -1096(%ebp)
    call _emit_sym
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    pushl -1096(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -1080(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_agg_value_107:
    pushl -1080(%ebp)
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
    je .Lparse_agg_value_143
    pushl -1080(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_agg_value_143:
    pushl -1080(%ebp)
    pushl -1080(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1080(%ebp)
    addl $4, %esp
    pushl -1080(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_agg_value_144:
.Lparse_agg_value_108:
.Lparse_agg_value_100:
.Lparse_agg_value_58:
.Lparse_agg_value_9:
.Lparse_agg_value_7:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_aggregate_init_x:
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
    popl %eax
    movl %eax, -16(%ebp)
.Lemit_aggregate_init_x_0:
    pushl -16(%ebp)
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
    jne .Lemit_aggregate_init_x_4
    pushl -16(%ebp)
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
    jmp .Lemit_aggregate_init_x_5
.Lemit_aggregate_init_x_4:
    pushl $1
.Lemit_aggregate_init_x_5:
    popl %eax
    cmpl $0, %eax
    jne .Lemit_aggregate_init_x_2
    pushl -16(%ebp)
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
    jmp .Lemit_aggregate_init_x_3
.Lemit_aggregate_init_x_2:
    pushl $1
.Lemit_aggregate_init_x_3:
    popl %eax
    cmpl $0, %eax
    je .Lemit_aggregate_init_x_1
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
    jmp .Lemit_aggregate_init_x_0
.Lemit_aggregate_init_x_1:
    pushl -16(%ebp)
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
    je .Lemit_aggregate_init_x_6
    pushl -16(%ebp)
    pushl -32(%ebp)
    pushl -40(%ebp)
    call _parse_agg_list
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_aggregate_init_x_7
.Lemit_aggregate_init_x_6:
    pushl -16(%ebp)
    pushl -32(%ebp)
    pushl -40(%ebp)
    call _parse_agg_value
    addl $12, %esp
    pushl %eax
    addl $4, %esp
.Lemit_aggregate_init_x_7:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_x86_emit:
    pushl %ebp
    movl %esp, %ebp
    subl $400, %esp
    movl 8(%ebp), %eax
    movl %eax, -152(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -144(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -136(%ebp)
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_init
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_17, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_18, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
.Lx86_emit_0:
    pushl -104(%ebp)
    pushl -152(%ebp)
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
    je .Lx86_emit_1
    pushl -152(%ebp)
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
    pushl -104(%ebp)
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
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
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
    je .Lx86_emit_3
    jmp .Lx86_emit_2
.Lx86_emit_3:
.Lx86_emit_4:
    leal ark_str_19, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _emit_sym
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _emit_sym
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_20, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
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
    je .Lx86_emit_7
    pushl -96(%ebp)
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
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lx86_emit_8
.Lx86_emit_7:
    pushl $0
.Lx86_emit_8:
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_5
    leal -88(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -96(%ebp)
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
    leal ark_str_21, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -88(%ebp), %eax
    pushl %eax
    pushl $0
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
    pushl $-1
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
    andl %eax, 4(%esp)
    andl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_22, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -88(%ebp), %eax
    pushl %eax
    pushl $0
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
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_6
.Lx86_emit_5:
    pushl -96(%ebp)
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
    je .Lx86_emit_11
    pushl -96(%ebp)
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
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lx86_emit_12
.Lx86_emit_11:
    pushl $0
.Lx86_emit_12:
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_9
    pushl -96(%ebp)
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
    pushl -152(%ebp)
    leal -128(%ebp), %eax
    pushl %eax
    call _emit_aggregate_init_x
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_10
.Lx86_emit_9:
    pushl -96(%ebp)
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
    je .Lx86_emit_15
    pushl -96(%ebp)
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
    jmp .Lx86_emit_16
.Lx86_emit_15:
    pushl $0
.Lx86_emit_16:
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_13
    pushl -96(%ebp)
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
    je .Lx86_emit_17
    pushl -96(%ebp)
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
    jmp .Lx86_emit_18
.Lx86_emit_17:
    pushl $0
.Lx86_emit_18:
    popl %eax
    movl %eax, -88(%ebp)
    pushl -96(%ebp)
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
    je .Lx86_emit_19
    pushl -96(%ebp)
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
    jmp .Lx86_emit_20
.Lx86_emit_19:
    pushl -88(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
.Lx86_emit_20:
    popl %eax
    movl %eax, -80(%ebp)
    leal ark_str_23, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    pushl -96(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _emit_str_literal_x
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -80(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_21
    leal ark_str_24, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl -88(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_22
.Lx86_emit_21:
.Lx86_emit_22:
    jmp .Lx86_emit_14
.Lx86_emit_13:
    pushl -96(%ebp)
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
    je .Lx86_emit_23
    pushl -96(%ebp)
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
    je .Lx86_emit_25
    pushl -96(%ebp)
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
    jmp .Lx86_emit_26
.Lx86_emit_25:
    pushl $4
.Lx86_emit_26:
    popl %eax
    movl %eax, -88(%ebp)
    leal ark_str_25, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
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
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_27
    leal ark_str_26, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_28
.Lx86_emit_27:
.Lx86_emit_28:
    jmp .Lx86_emit_24
.Lx86_emit_23:
    pushl -96(%ebp)
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
    je .Lx86_emit_29
    pushl -96(%ebp)
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
    jmp .Lx86_emit_30
.Lx86_emit_29:
    pushl $4
.Lx86_emit_30:
    popl %eax
    movl %eax, -88(%ebp)
    leal ark_str_27, %eax
    pushl %eax
    leal -128(%ebp), %eax
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_24:
.Lx86_emit_14:
.Lx86_emit_10:
.Lx86_emit_6:
.Lx86_emit_2:
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
    jmp .Lx86_emit_0
.Lx86_emit_1:
    leal ark_str_28, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
.Lx86_emit_31:
    pushl -104(%ebp)
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
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_32
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
    pushl -104(%ebp)
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
    movl %eax, -96(%ebp)
    leal ark_str_29, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_30, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
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
    pushl -96(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _emit_str_literal_x
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_33:
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
    jmp .Lx86_emit_31
.Lx86_emit_32:
    leal ark_str_31, %eax
    pushl %eax
    leal -128(%ebp), %eax
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
.Lx86_emit_34:
    pushl -112(%ebp)
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
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_35
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
    pushl -112(%ebp)
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
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
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
    pushl $15
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $15
    popl %eax
    notl %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_37
    pushl $16
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_38
.Lx86_emit_37:
.Lx86_emit_38:
    pushl -104(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_39
    leal ark_str_32, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _emit_sym
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_40
.Lx86_emit_39:
.Lx86_emit_40:
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _emit_sym
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_33, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_34, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_35, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    pushl $256
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    pushl $4096
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_41
    pushl $0
    popl %eax
    movl %eax, -72(%ebp)
.Lx86_emit_43:
    pushl -72(%ebp)
    pushl $4096
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -80(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_44
    pushl -72(%ebp)
    pushl $4096
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    addl $4, %esp
    leal ark_str_36, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_37, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_43
.Lx86_emit_44:
    leal ark_str_38, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl -72(%ebp)
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_39, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_42
.Lx86_emit_41:
    leal ark_str_40, %eax
    pushl %eax
    leal -128(%ebp), %eax
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_41, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_42:
    pushl -104(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_45
    leal ark_str_42, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_43, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_44, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_46
.Lx86_emit_45:
.Lx86_emit_46:
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
.Lx86_emit_47:
    pushl -96(%ebp)
    pushl -104(%ebp)
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
    je .Lx86_emit_48
    pushl -104(%ebp)
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
    pushl -96(%ebp)
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
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
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
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_51
    pushl -72(%ebp)
    pushl $17
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_52
    pushl -72(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_53
    pushl -72(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_54
    pushl -72(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_55
    pushl -72(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_56
    pushl -72(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_57
    pushl -72(%ebp)
    pushl $22
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_58
    pushl -72(%ebp)
    pushl $23
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_59
    pushl -72(%ebp)
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_60
    pushl -72(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_61
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_62
    pushl -72(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_63
    pushl -72(%ebp)
    pushl $56
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_64
    pushl -72(%ebp)
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_65
    pushl -72(%ebp)
    pushl $58
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_66
    pushl -72(%ebp)
    pushl $59
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_67
    pushl -72(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_68
    pushl -72(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_69
    pushl -72(%ebp)
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_70
    pushl -72(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_71
    pushl -72(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_72
    pushl -72(%ebp)
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_73
    pushl -72(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_74
    pushl -72(%ebp)
    pushl $39
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_75
    pushl -72(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_76
    pushl -72(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_77
    pushl -72(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_78
    pushl -72(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_79
    pushl -72(%ebp)
    pushl $18
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_80
    pushl -72(%ebp)
    pushl $19
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_81
    pushl -72(%ebp)
    pushl $50
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_82
    pushl -72(%ebp)
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_83
    pushl -72(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_84
    pushl -72(%ebp)
    pushl $29
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_85
    pushl -72(%ebp)
    pushl $30
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_86
    pushl -72(%ebp)
    pushl $31
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_87
    pushl -72(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_88
    pushl -72(%ebp)
    pushl $33
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_89
    pushl -72(%ebp)
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_90
    pushl -72(%ebp)
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_91
    pushl -72(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_92
    pushl -72(%ebp)
    pushl $42
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_93
    pushl -72(%ebp)
    pushl $41
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_94
    pushl -72(%ebp)
    pushl $43
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_95
    pushl -72(%ebp)
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_96
    pushl -72(%ebp)
    pushl $45
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_97
    pushl -72(%ebp)
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_98
    pushl -72(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_99
    pushl -72(%ebp)
    pushl $37
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_100
    pushl -72(%ebp)
    pushl $38
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_101
    pushl -72(%ebp)
    pushl $51
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_102
    pushl -72(%ebp)
    pushl $52
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_103
    pushl -72(%ebp)
    pushl $53
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_104
    pushl -72(%ebp)
    pushl $54
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_105
    pushl -72(%ebp)
    pushl $55
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_106
    pushl -72(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_107
    pushl -72(%ebp)
    pushl $25
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_108
    pushl -72(%ebp)
    pushl $26
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_109
    pushl -72(%ebp)
    pushl $27
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_110
    jmp .Lx86_emit_111
.Lx86_emit_51:
.Lx86_emit_52:
    jmp .Lx86_emit_50
.Lx86_emit_53:
    pushl -80(%ebp)
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
    movl %eax, -64(%ebp)
    pushl -80(%ebp)
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
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -80(%ebp)
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
    pushl $8000
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
    jg .L64t_x86_emit_960
    jl .L64f_x86_emit_960
    cmpl %eax, (%esp)
    jge .L64t_x86_emit_960
    je .L64t_x86_emit_960
.L64f_x86_emit_960:
    addl $4, %esp
    pushl $0
    jmp .L64e_x86_emit_960
.L64t_x86_emit_960:
    addl $4, %esp
    pushl $1
.L64e_x86_emit_960:
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_112
    jmp .Lx86_emit_50
.Lx86_emit_112:
.Lx86_emit_113:
    pushl -56(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_114
    leal ark_str_45, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -64(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_46, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -88(%ebp)
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
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    pushl -80(%ebp)
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
    popl %ecx
    popl %eax
    subl %eax, 4(%esp)
    sbbl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_47, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_48, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -64(%ebp)
    pushl $4
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
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_49, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -88(%ebp)
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
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    pushl -80(%ebp)
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
    popl %ecx
    popl %eax
    subl %eax, 4(%esp)
    sbbl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_50, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_115
.Lx86_emit_114:
    leal ark_str_51, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -64(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_52, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -88(%ebp)
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
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    pushl -80(%ebp)
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
    popl %ecx
    popl %eax
    subl %eax, 4(%esp)
    sbbl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_53, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_115:
    jmp .Lx86_emit_50
.Lx86_emit_54:
    pushl -80(%ebp)
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
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_116
    pushl -80(%ebp)
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
    popl %edx
    popl %eax
    movl %eax, -56(%ebp)
    movl %edx, -52(%ebp)
    leal ark_str_54, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl $-1
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
    andl %eax, 4(%esp)
    andl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_55, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    pushl -52(%ebp)
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
    pushl $-1
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
    andl %eax, 4(%esp)
    andl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_117
.Lx86_emit_116:
    pushl -80(%ebp)
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
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    leal ark_str_56, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
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
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_117:
    jmp .Lx86_emit_50
.Lx86_emit_55:
    leal ark_str_57, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_58, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_56:
    pushl -80(%ebp)
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
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_118
    leal ark_str_59, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -88(%ebp)
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
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    pushl -80(%ebp)
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
    popl %ecx
    popl %eax
    subl %eax, 4(%esp)
    sbbl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_60, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -88(%ebp)
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
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    pushl -80(%ebp)
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
    popl %ecx
    popl %eax
    subl %eax, 4(%esp)
    sbbl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_61, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_119
.Lx86_emit_118:
    pushl -64(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_120
    leal ark_str_62, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -88(%ebp)
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
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    pushl -80(%ebp)
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
    popl %ecx
    popl %eax
    subl %eax, 4(%esp)
    sbbl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_63, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_121
.Lx86_emit_120:
    pushl -64(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_122
    leal ark_str_64, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -88(%ebp)
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
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    pushl -80(%ebp)
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
    popl %ecx
    popl %eax
    subl %eax, 4(%esp)
    sbbl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_65, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_123
.Lx86_emit_122:
    leal ark_str_66, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -88(%ebp)
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
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    pushl -80(%ebp)
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
    popl %ecx
    popl %eax
    subl %eax, 4(%esp)
    sbbl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_67, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_123:
.Lx86_emit_121:
.Lx86_emit_119:
    jmp .Lx86_emit_50
.Lx86_emit_57:
    leal ark_str_68, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -88(%ebp)
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
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    pushl -80(%ebp)
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
    popl %ecx
    popl %eax
    subl %eax, 4(%esp)
    sbbl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_69, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_58:
    leal ark_str_70, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _emit_sym
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_71, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_59:
    leal ark_str_72, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _emit_sym
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_60:
    leal ark_str_73, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _emit_sym
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_74, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_61:
    pushl -80(%ebp)
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
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_124
    leal ark_str_75, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_76, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -88(%ebp)
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
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    pushl -80(%ebp)
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
    popl %ecx
    popl %eax
    subl %eax, 4(%esp)
    sbbl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_77, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -88(%ebp)
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
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    pushl -80(%ebp)
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
    popl %ecx
    popl %eax
    subl %eax, 4(%esp)
    sbbl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_78, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_125
.Lx86_emit_124:
    pushl -64(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_126
    leal ark_str_79, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -88(%ebp)
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
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    pushl -80(%ebp)
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
    popl %ecx
    popl %eax
    subl %eax, 4(%esp)
    sbbl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_80, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_127
.Lx86_emit_126:
    pushl -64(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_128
    leal ark_str_81, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -88(%ebp)
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
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    pushl -80(%ebp)
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
    popl %ecx
    popl %eax
    subl %eax, 4(%esp)
    sbbl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_82, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_129
.Lx86_emit_128:
    leal ark_str_83, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $8
    pushl -88(%ebp)
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
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    pushl -80(%ebp)
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
    popl %ecx
    popl %eax
    subl %eax, 4(%esp)
    sbbl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_84, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_129:
.Lx86_emit_127:
.Lx86_emit_125:
    jmp .Lx86_emit_50
.Lx86_emit_62:
    leal ark_str_85, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_63:
    leal ark_str_86, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_64:
    leal ark_str_87, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_65:
    leal ark_str_88, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_66:
    leal ark_str_89, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_67:
    leal ark_str_90, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_68:
    leal ark_str_91, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_92, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_69:
    leal ark_str_93, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_70:
    leal ark_str_94, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_71:
    leal ark_str_95, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_72:
    pushl -80(%ebp)
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
    call _binop_x
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_130
    leal ark_str_96, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_97, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_131
.Lx86_emit_130:
    pushl -80(%ebp)
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
    call _shiftop_x
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_132
    leal ark_str_98, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_99, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_133
.Lx86_emit_132:
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl -80(%ebp)
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_135
    pushl -40(%ebp)
    pushl $22
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_136
    pushl -40(%ebp)
    pushl $23
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_137
    pushl -40(%ebp)
    pushl $25
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_138
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_139
    pushl -40(%ebp)
    pushl $26
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_140
    pushl -40(%ebp)
    pushl $27
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_141
    pushl -40(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_142
    pushl -40(%ebp)
    pushl $17
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_143
    pushl -40(%ebp)
    pushl $18
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_144
    pushl -40(%ebp)
    pushl $19
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_145
    jmp .Lx86_emit_134
.Lx86_emit_135:
    leal ark_str_100, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_134
.Lx86_emit_136:
    leal ark_str_101, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_134
.Lx86_emit_137:
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_146
    leal ark_str_102, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_147
.Lx86_emit_146:
    leal ark_str_103, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_147:
    jmp .Lx86_emit_134
.Lx86_emit_138:
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_148
    leal ark_str_104, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_149
.Lx86_emit_148:
    leal ark_str_105, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_149:
    jmp .Lx86_emit_134
.Lx86_emit_139:
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_150
    leal ark_str_106, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_151
.Lx86_emit_150:
    leal ark_str_107, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_151:
    jmp .Lx86_emit_134
.Lx86_emit_140:
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_152
    leal ark_str_108, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_153
.Lx86_emit_152:
    leal ark_str_109, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_153:
    jmp .Lx86_emit_134
.Lx86_emit_141:
    leal ark_str_110, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_134
.Lx86_emit_142:
    leal ark_str_111, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_134
.Lx86_emit_143:
    leal ark_str_112, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_134
.Lx86_emit_144:
    leal ark_str_113, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_134
.Lx86_emit_145:
    leal ark_str_114, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_134
.Lx86_emit_134:
.Lx86_emit_133:
.Lx86_emit_131:
    jmp .Lx86_emit_50
.Lx86_emit_73:
    pushl -80(%ebp)
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
    jne .L64f_x86_emit_1985
    cmpl %eax, (%esp)
    jne .L64f_x86_emit_1985
    addl $4, %esp
    pushl $1
    jmp .L64e_x86_emit_1985
.L64f_x86_emit_1985:
    addl $4, %esp
    pushl $0
.L64e_x86_emit_1985:
    popl %eax
    movl %eax, -64(%ebp)
    pushl -80(%ebp)
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
    jne .L64f_x86_emit_1997
    cmpl %eax, (%esp)
    jne .L64f_x86_emit_1997
    addl $4, %esp
    pushl $1
    jmp .L64e_x86_emit_1997
.L64f_x86_emit_1997:
    addl $4, %esp
    pushl $0
.L64e_x86_emit_1997:
    popl %eax
    movl %eax, -56(%ebp)
    pushl -80(%ebp)
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
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_155
    pushl -48(%ebp)
    pushl $33
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_156
    pushl -48(%ebp)
    pushl $29
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_157
    jmp .Lx86_emit_158
.Lx86_emit_155:
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_159
    leal ark_str_115, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_160
.Lx86_emit_159:
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_161
    leal ark_str_116, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_162
.Lx86_emit_161:
    leal ark_str_117, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_162:
.Lx86_emit_160:
    jmp .Lx86_emit_154
.Lx86_emit_156:
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_163
    leal ark_str_118, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_164
.Lx86_emit_163:
    leal ark_str_119, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_164:
    jmp .Lx86_emit_154
.Lx86_emit_157:
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_165
    leal ark_str_120, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_166
.Lx86_emit_165:
    leal ark_str_121, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_166:
    jmp .Lx86_emit_154
.Lx86_emit_158:
    leal ark_str_122, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_154
.Lx86_emit_154:
    jmp .Lx86_emit_50
.Lx86_emit_74:
    pushl -80(%ebp)
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
    movl %eax, -64(%ebp)
    leal ark_str_123, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_167
    leal ark_str_124, %eax
    pushl %eax
    leal -128(%ebp), %eax
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_125, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_168
.Lx86_emit_167:
.Lx86_emit_168:
    pushl -64(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_169
    leal ark_str_126, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_170
.Lx86_emit_169:
    pushl -64(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_171
    leal ark_str_127, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_172
.Lx86_emit_171:
    pushl -64(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_173
    leal ark_str_128, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_174
.Lx86_emit_173:
    leal ark_str_129, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_174:
.Lx86_emit_172:
.Lx86_emit_170:
    jmp .Lx86_emit_50
.Lx86_emit_75:
    pushl -80(%ebp)
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
    je .Lx86_emit_175
    leal ark_str_130, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_176
.Lx86_emit_175:
    leal ark_str_131, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_176:
    jmp .Lx86_emit_50
.Lx86_emit_76:
    pushl -80(%ebp)
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
    je .Lx86_emit_177
    leal ark_str_132, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_178
.Lx86_emit_177:
    leal ark_str_133, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_178:
    jmp .Lx86_emit_50
.Lx86_emit_77:
    pushl -80(%ebp)
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
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_179
    leal ark_str_134, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_135, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_136, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_180
.Lx86_emit_179:
    leal ark_str_137, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_181
    leal ark_str_138, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_182
.Lx86_emit_181:
    pushl -64(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_183
    leal ark_str_139, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_184
.Lx86_emit_183:
    leal ark_str_140, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_184:
.Lx86_emit_182:
    leal ark_str_141, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_180:
    jmp .Lx86_emit_50
.Lx86_emit_78:
    pushl -80(%ebp)
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
    movl %eax, -64(%ebp)
    pushl -80(%ebp)
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
    je .Lx86_emit_185
    pushl -80(%ebp)
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
    jmp .Lx86_emit_186
.Lx86_emit_185:
    pushl $0
.Lx86_emit_186:
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_187
    pushl -64(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lx86_emit_188
.Lx86_emit_187:
    pushl -64(%ebp)
.Lx86_emit_188:
    popl %eax
    movl %eax, -48(%ebp)
    pushl -80(%ebp)
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
    movl %eax, -40(%ebp)
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_189
    leal ark_str_142, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_190
.Lx86_emit_189:
    leal ark_str_143, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _emit_sym
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_190:
    pushl -48(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_191
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lx86_emit_193:
    pushl -24(%ebp)
    pushl -48(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_194
    pushl -40(%ebp)
    pushl $1
    pushl $2
    pushl -24(%ebp)
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_196
    pushl -32(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_197
.Lx86_emit_196:
    pushl -32(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
.Lx86_emit_197:
.Lx86_emit_195:
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
    jmp .Lx86_emit_193
.Lx86_emit_194:
    leal ark_str_144, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_145, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_192
.Lx86_emit_191:
.Lx86_emit_192:
    leal ark_str_146, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_79:
    leal ark_str_147, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_80:
    jmp .Lx86_emit_50
.Lx86_emit_81:
    jmp .Lx86_emit_50
.Lx86_emit_82:
    leal ark_str_148, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_83:
    pushl -80(%ebp)
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
    movl %eax, -64(%ebp)
    leal ark_str_149, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_198
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
.Lx86_emit_200:
    pushl -56(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -64(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_201
    leal ark_str_150, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_151, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_152, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_200
.Lx86_emit_201:
.Lx86_emit_202:
    pushl -56(%ebp)
    pushl -64(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_203
    leal ark_str_153, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_154, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_155, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_202
.Lx86_emit_203:
    jmp .Lx86_emit_199
.Lx86_emit_198:
.Lx86_emit_199:
    leal ark_str_156, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_84:
    pushl -80(%ebp)
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
    movl %eax, -64(%ebp)
    pushl -80(%ebp)
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
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_204
    leal ark_str_157, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_158, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_159, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_160, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_161, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_162, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_163, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_164, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_205
.Lx86_emit_204:
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_206
    leal ark_str_165, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_166, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_167, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_168, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_207
.Lx86_emit_206:
    leal ark_str_169, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_170, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_207:
.Lx86_emit_205:
    jmp .Lx86_emit_50
.Lx86_emit_85:
.Lx86_emit_86:
.Lx86_emit_87:
.Lx86_emit_88:
    pushl -80(%ebp)
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
    movl %eax, -64(%ebp)
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
    pushl -80(%ebp)
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
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    pushl $29
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_209
    pushl -48(%ebp)
    pushl $30
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_210
    pushl -48(%ebp)
    pushl $31
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_211
    pushl -48(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_212
    jmp .Lx86_emit_213
.Lx86_emit_209:
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_214
    leal ark_str_171, %eax
    pushl %eax
    jmp .Lx86_emit_215
.Lx86_emit_214:
    leal ark_str_172, %eax
    pushl %eax
.Lx86_emit_215:
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_208
.Lx86_emit_210:
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_216
    leal ark_str_173, %eax
    pushl %eax
    jmp .Lx86_emit_217
.Lx86_emit_216:
    leal ark_str_174, %eax
    pushl %eax
.Lx86_emit_217:
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_208
.Lx86_emit_211:
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_218
    leal ark_str_175, %eax
    pushl %eax
    jmp .Lx86_emit_219
.Lx86_emit_218:
    leal ark_str_176, %eax
    pushl %eax
.Lx86_emit_219:
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_208
.Lx86_emit_212:
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_220
    leal ark_str_177, %eax
    pushl %eax
    jmp .Lx86_emit_221
.Lx86_emit_220:
    leal ark_str_178, %eax
    pushl %eax
.Lx86_emit_221:
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_208
.Lx86_emit_213:
    jmp .Lx86_emit_208
.Lx86_emit_208:
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_222
    leal ark_str_179, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_180, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_181, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_182, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_183, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_184, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_223
.Lx86_emit_222:
    leal ark_str_185, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_186, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_223:
    jmp .Lx86_emit_50
.Lx86_emit_89:
    pushl -80(%ebp)
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
    movl %eax, -64(%ebp)
    pushl -80(%ebp)
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
    movl %eax, -56(%ebp)
    leal ark_str_187, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -56(%ebp)
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_225
    pushl -40(%ebp)
    pushl $22
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_226
    pushl -40(%ebp)
    pushl $23
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_227
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_228
    pushl -40(%ebp)
    pushl $25
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_229
    pushl -40(%ebp)
    pushl $26
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_230
    jmp .Lx86_emit_231
.Lx86_emit_225:
    leal ark_str_188, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_224
.Lx86_emit_226:
    leal ark_str_189, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_224
.Lx86_emit_227:
    leal ark_str_190, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_224
.Lx86_emit_228:
    leal ark_str_191, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_224
.Lx86_emit_229:
    leal ark_str_192, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_224
.Lx86_emit_230:
    leal ark_str_193, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_224
.Lx86_emit_231:
    jmp .Lx86_emit_224
.Lx86_emit_224:
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_232
    leal ark_str_194, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_195, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_196, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_197, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_198, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -48(%ebp)
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_199, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_233
.Lx86_emit_232:
    leal ark_str_200, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_201, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_202, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -48(%ebp)
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_203, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_233:
    jmp .Lx86_emit_50
.Lx86_emit_90:
    pushl -80(%ebp)
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
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_234
    leal ark_str_204, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_205, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_206, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_207, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_208, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_209, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_235
.Lx86_emit_234:
    leal ark_str_210, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_211, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_235:
    jmp .Lx86_emit_50
.Lx86_emit_91:
    pushl -80(%ebp)
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
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_236
    leal ark_str_212, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_213, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_214, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_215, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_216, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_217, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_218, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_237
.Lx86_emit_236:
    leal ark_str_219, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_220, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_237:
    jmp .Lx86_emit_50
.Lx86_emit_92:
    pushl -80(%ebp)
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
    movl %eax, -64(%ebp)
    pushl -80(%ebp)
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
    movl %eax, -56(%ebp)
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_240
    pushl -56(%ebp)
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
    jmp .Lx86_emit_241
.Lx86_emit_240:
    pushl $0
.Lx86_emit_241:
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_238
    leal ark_str_221, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_222, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_223, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_224, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_225, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_226, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_239
.Lx86_emit_238:
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_244
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lx86_emit_245
.Lx86_emit_244:
    pushl $0
.Lx86_emit_245:
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_242
    leal ark_str_227, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_228, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_229, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_230, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_231, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_232, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_243
.Lx86_emit_242:
.Lx86_emit_243:
.Lx86_emit_239:
    jmp .Lx86_emit_50
.Lx86_emit_93:
    leal ark_str_233, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_94:
    pushl -80(%ebp)
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
    movl %eax, -64(%ebp)
    pushl -80(%ebp)
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
    movl %eax, -56(%ebp)
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
    je .Lx86_emit_246
    leal ark_str_234, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_235, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_236, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_237, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_238, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_239, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_247
.Lx86_emit_246:
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
    je .Lx86_emit_248
    leal ark_str_240, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_241, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_242, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_243, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_244, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_245, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_249
.Lx86_emit_248:
    pushl -64(%ebp)
    pushl $30
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_250
    leal ark_str_246, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_247, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_248, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_249, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_251
.Lx86_emit_250:
    pushl -64(%ebp)
    pushl $31
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_252
    leal ark_str_250, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_251, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_252, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_253, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_253
.Lx86_emit_252:
    pushl -64(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_254
    leal ark_str_254, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_255, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_256, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_257, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_255
.Lx86_emit_254:
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
    jne .Lx86_emit_260
    pushl -64(%ebp)
    pushl $18
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
    jmp .Lx86_emit_261
.Lx86_emit_260:
    pushl $1
.Lx86_emit_261:
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_258
    pushl -64(%ebp)
    pushl $19
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
    jmp .Lx86_emit_259
.Lx86_emit_258:
    pushl $1
.Lx86_emit_259:
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_256
    leal ark_str_258, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
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
    je .Lx86_emit_262
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_264
    leal ark_str_259, %eax
    pushl %eax
    jmp .Lx86_emit_265
.Lx86_emit_264:
    leal ark_str_260, %eax
    pushl %eax
.Lx86_emit_265:
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_263
.Lx86_emit_262:
.Lx86_emit_263:
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
    je .Lx86_emit_266
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_268
    leal ark_str_261, %eax
    pushl %eax
    jmp .Lx86_emit_269
.Lx86_emit_268:
    leal ark_str_262, %eax
    pushl %eax
.Lx86_emit_269:
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_267
.Lx86_emit_266:
.Lx86_emit_267:
    leal ark_str_263, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_264, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_265, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_266, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_267, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_268, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_269, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_270, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_271, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -48(%ebp)
    leal -128(%ebp), %eax
    pushl %eax
    call _emit_sym
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_272, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_273, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_257
.Lx86_emit_256:
    leal ark_str_274, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_275, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_257:
.Lx86_emit_255:
.Lx86_emit_253:
.Lx86_emit_251:
.Lx86_emit_249:
.Lx86_emit_247:
    jmp .Lx86_emit_50
.Lx86_emit_95:
    pushl -80(%ebp)
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
    movl %eax, -64(%ebp)
    pushl -80(%ebp)
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
    movl %eax, -56(%ebp)
    leal ark_str_276, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_277, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_278, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_272
    pushl -64(%ebp)
    pushl $22
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
    jmp .Lx86_emit_273
.Lx86_emit_272:
    pushl $1
.Lx86_emit_273:
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_270
    pushl -64(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_274
    leal ark_str_279, %eax
    pushl %eax
    jmp .Lx86_emit_275
.Lx86_emit_274:
    leal ark_str_280, %eax
    pushl %eax
.Lx86_emit_275:
    popl %eax
    movl %eax, -48(%ebp)
    pushl -64(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_276
    pushl $1
    jmp .Lx86_emit_277
.Lx86_emit_276:
    pushl $0
.Lx86_emit_277:
    popl %eax
    movl %eax, -40(%ebp)
    pushl -64(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_278
    pushl $0
    jmp .Lx86_emit_279
.Lx86_emit_278:
    pushl $1
.Lx86_emit_279:
    popl %eax
    movl %eax, -32(%ebp)
    leal ark_str_281, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -48(%ebp)
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_282, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -48(%ebp)
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_283, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_284, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_285, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -48(%ebp)
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_286, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_287, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_288, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_271
.Lx86_emit_270:
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -64(%ebp)
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl $23
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_281
    pushl -16(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_282
    pushl -16(%ebp)
    pushl $25
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_283
    pushl -16(%ebp)
    pushl $26
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lx86_emit_284
    jmp .Lx86_emit_285
.Lx86_emit_281:
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_286
    leal ark_str_289, %eax
    pushl %eax
    jmp .Lx86_emit_287
.Lx86_emit_286:
    leal ark_str_290, %eax
    pushl %eax
.Lx86_emit_287:
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_288
    leal ark_str_291, %eax
    pushl %eax
    jmp .Lx86_emit_289
.Lx86_emit_288:
    leal ark_str_292, %eax
    pushl %eax
.Lx86_emit_289:
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_290
    leal ark_str_293, %eax
    pushl %eax
    jmp .Lx86_emit_291
.Lx86_emit_290:
    leal ark_str_294, %eax
    pushl %eax
.Lx86_emit_291:
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_280
.Lx86_emit_282:
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_292
    leal ark_str_295, %eax
    pushl %eax
    jmp .Lx86_emit_293
.Lx86_emit_292:
    leal ark_str_296, %eax
    pushl %eax
.Lx86_emit_293:
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_294
    leal ark_str_297, %eax
    pushl %eax
    jmp .Lx86_emit_295
.Lx86_emit_294:
    leal ark_str_298, %eax
    pushl %eax
.Lx86_emit_295:
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_296
    leal ark_str_299, %eax
    pushl %eax
    jmp .Lx86_emit_297
.Lx86_emit_296:
    leal ark_str_300, %eax
    pushl %eax
.Lx86_emit_297:
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_280
.Lx86_emit_283:
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_298
    leal ark_str_301, %eax
    pushl %eax
    jmp .Lx86_emit_299
.Lx86_emit_298:
    leal ark_str_302, %eax
    pushl %eax
.Lx86_emit_299:
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_300
    leal ark_str_303, %eax
    pushl %eax
    jmp .Lx86_emit_301
.Lx86_emit_300:
    leal ark_str_304, %eax
    pushl %eax
.Lx86_emit_301:
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_302
    leal ark_str_305, %eax
    pushl %eax
    jmp .Lx86_emit_303
.Lx86_emit_302:
    leal ark_str_306, %eax
    pushl %eax
.Lx86_emit_303:
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_280
.Lx86_emit_284:
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_304
    leal ark_str_307, %eax
    pushl %eax
    jmp .Lx86_emit_305
.Lx86_emit_304:
    leal ark_str_308, %eax
    pushl %eax
.Lx86_emit_305:
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_306
    leal ark_str_309, %eax
    pushl %eax
    jmp .Lx86_emit_307
.Lx86_emit_306:
    leal ark_str_310, %eax
    pushl %eax
.Lx86_emit_307:
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_308
    leal ark_str_311, %eax
    pushl %eax
    jmp .Lx86_emit_309
.Lx86_emit_308:
    leal ark_str_312, %eax
    pushl %eax
.Lx86_emit_309:
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_280
.Lx86_emit_285:
    leal ark_str_313, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_280
.Lx86_emit_280:
    leal ark_str_314, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -48(%ebp)
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_315, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_316, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -40(%ebp)
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_317, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_318, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -32(%ebp)
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_319, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_310
    leal ark_str_320, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_311
.Lx86_emit_310:
.Lx86_emit_311:
    leal ark_str_321, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_322, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_323, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_324, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_325, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_326, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_271:
    jmp .Lx86_emit_50
.Lx86_emit_96:
    leal ark_str_327, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_328, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_329, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_330, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_97:
    leal ark_str_331, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_332, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_98:
.Lx86_emit_99:
    leal ark_str_333, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_100:
    pushl -80(%ebp)
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
    je .Lx86_emit_312
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_313
.Lx86_emit_312:
.Lx86_emit_313:
    jmp .Lx86_emit_50
.Lx86_emit_101:
.Lx86_emit_102:
.Lx86_emit_103:
.Lx86_emit_104:
.Lx86_emit_105:
.Lx86_emit_106:
    leal ark_str_334, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_107:
    jmp .Lx86_emit_50
.Lx86_emit_108:
    leal ark_str_335, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_336, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_109:
    leal ark_str_337, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_110:
    leal ark_str_338, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_339, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -104(%ebp)
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_111:
    leal ark_str_340, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_50
.Lx86_emit_50:
.Lx86_emit_49:
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
    jmp .Lx86_emit_47
.Lx86_emit_48:
    leal ark_str_341, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_36:
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
    jmp .Lx86_emit_34
.Lx86_emit_35:
    pushl -152(%ebp)
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
    je .Lx86_emit_314
    leal ark_str_342, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    leal ark_str_343, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
.Lx86_emit_316:
    pushl -104(%ebp)
    pushl -152(%ebp)
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
    je .Lx86_emit_317
    leal -88(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -104(%ebp)
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
    leal -88(%ebp), %eax
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
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    addl $4, %esp
    pushl $7
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Lx86_emit_319:
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
    je .Lx86_emit_320
    leal -64(%ebp), %eax
    pushl %eax
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -96(%ebp)
    pushl -72(%ebp)
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
    pushl -72(%ebp)
    pushl $4
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    addl $4, %esp
.Lx86_emit_321:
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_319
.Lx86_emit_320:
    leal -64(%ebp), %eax
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
    leal ark_str_344, %eax
    pushl %eax
    leal -128(%ebp), %eax
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_345, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -64(%ebp), %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -80(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -104(%ebp)
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
    leal ark_str_346, %eax
    pushl %eax
    leal -128(%ebp), %eax
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
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_347, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -80(%ebp), %eax
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
    movl %eax, -40(%ebp)
    pushl $7
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lx86_emit_322:
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_323
    leal -32(%ebp), %eax
    pushl %eax
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
    pushl -96(%ebp)
    pushl -40(%ebp)
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
    pushl -40(%ebp)
    pushl $4
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lx86_emit_324:
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_322
.Lx86_emit_323:
    leal -32(%ebp), %eax
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
    leal -32(%ebp), %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_348, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -80(%ebp), %eax
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
    movl %eax, -40(%ebp)
    pushl $7
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lx86_emit_325:
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_326
    leal -32(%ebp), %eax
    pushl %eax
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
    pushl -96(%ebp)
    pushl -40(%ebp)
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
    pushl -40(%ebp)
    pushl $4
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lx86_emit_327:
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_325
.Lx86_emit_326:
    leal -32(%ebp), %eax
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
    leal -32(%ebp), %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lx86_emit_318:
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
    jmp .Lx86_emit_316
.Lx86_emit_317:
    leal ark_str_349, %eax
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lx86_emit_315
.Lx86_emit_314:
.Lx86_emit_315:
    leal -128(%ebp), %eax
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
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_328
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lx86_emit_329
.Lx86_emit_328:
.Lx86_emit_329:
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
.Lx86_emit_330:
    pushl -96(%ebp)
    pushl -104(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_emit_331
    pushl -144(%ebp)
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
    leal -128(%ebp), %eax
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
.Lx86_emit_332:
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
    jmp .Lx86_emit_330
.Lx86_emit_331:
    pushl -144(%ebp)
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
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -104(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_x86_assemble:
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
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl -40(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_assemble_0
    pushl -40(%ebp)
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lx86_assemble_1
.Lx86_assemble_0:
.Lx86_assemble_1:
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lx86_assemble_2:
    pushl -24(%ebp)
    pushl -32(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lx86_assemble_3
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
    pushl -56(%ebp)
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
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lx86_assemble_4:
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
    jmp .Lx86_assemble_2
.Lx86_assemble_3:
    pushl -32(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_x86_link:
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

    .globl _ark_backend_x86_64
_ark_backend_x86_64:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_g_x86_backend, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

