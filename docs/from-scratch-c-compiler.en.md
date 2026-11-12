# Writing a C compiler from scratch (English summary)

[中文全文](从零写一个C编译器.md) | English

> Status of this page: the book itself is **Chinese-only** and about **8,740 lines**. This page is an
> English summary — what the book contains, how it is organised, and how to use it — so that
> non-Chinese readers can still find their way into the material. Everything below describes the
> Chinese original; it is not a translation of it.
>
> Book scope: arkc 0.8.0. Nature: a textbook (readable in order, also usable as an implementation
> manual). Every assembly listing, every hex number and every size in the book was produced by running
> the `arkcc.exe` in this repository at the time of writing, not paraphrased from memory.

---

## 1 What the book is

The book takes **arkc** — a real C compiler of roughly 29,000 lines including headers, which can
compile itself and can run its own output on a microcontroller — as its subject, and walks from the
first 30 lines of code up to the full project structure, explaining the reason behind each design
decision.

The problem it tries to solve: plenty of people can write C, but few can explain how one line of C
becomes instructions a CPU executes. Textbooks give the principles without the implementation;
production code gives the implementation without the reasoning. This book tries to supply the missing
middle.

Prerequisites assumed by the book (only item 1 is strictly required):

1. basic C syntax: variables, functions, `if`, `for`, elementary pointer use;
2. having used a command line, e.g. `arkcc hello.c -S -o hello.s` and being able to read the result;
3. **no** compiler-theory course — every term is defined the first time it appears;
4. **no** prior ARM assembly — chapter 12 teaches the small subset that is needed;
5. no Linux required — commands were run under Git Bash on Windows; hardware chapters state their
   assumptions explicitly.

Three self-imposed rules keep the book honest: every quoted source snippet can be located in the
repository (file name + function name, deletions marked with `...`, no characters altered); every
output shown is a real run (concept-only snippets are marked as illustrative); and every number can
be reproduced, with the command list given in the appendix and the afterword — if a reader's
reproduction disagrees, the book is wrong and the reproduction wins.

## 2 Structure

The book follows the compiler's actual data flow: 19 chapters in five parts, plus four appendices and
an afterword.

```
        source ──► front end ──► IR ──► optimiser ──► ARM backend ──► assembler ──► object ──► image
```

| Part | Chapters | Content |
| --- | --- | --- |
| Part I — the big picture | 1–2 | what a compiler does (six shape changes from text to something a machine executes); how to observe it through `-E`, `-S`, `-c` and `-target c` |
| Part II — front end: text into structure | 3–9 | memory pool, diagnostics, platform layer and switches (the foundations); lexing; preprocessing; the type system; symbol table and scope; recursive-descent parsing; semantic analysis |
| Part III — middle end: IR and optimisation | 10–11 | a virtual-stack IR that decouples language from CPU; constant folding and dead-code elimination as the first optimiser |
| Part IV — back end: assembly to image | 12–15 | Thumb-2 code generation; the assembler (branch encoding is the hard part); object format and linking (symbols, relocations, patching); scatter loading and image layout |
| Part V — engineering | 16–19 | the command-line driver (two-pass argument parsing, output name derivation); how to know you got it right (differential testing, and how to localise "runs but computes the wrong answer"); putting the compiler on a microcontroller; a nine-stage exercise path |
| Appendices | A–D | enum tables and conventions; a Thumb-2 encoding quick reference with measured bytes; glossary; known limitations |
| Afterword | — | how every output in the book is reproduced |

### Chapter-by-chapter one-liners

| Ch. | One line |
|---|---|
| 1 | A compiler turns text into something a machine can execute, passing through six shape changes |
| 2 | Learn to observe the compiler's interior through its four outputs: `-E`, `-S`, `-c`, `-target c` |
| 3 | Build the four pieces of infrastructure — memory pool, diagnostics, platform layer, switches — before writing any compilation feature |
| 4 | Lexing turns a character stream into typed tokens; it is the book's first real algorithm |
| 5 | The preprocessor runs around lexing, and the rules of macro expansion are finer than they look |
| 6 | The type system decides "how many bytes a datum occupies and how it is aligned" |
| 7 | The symbol table answers "which declaration does this name refer to right now" |
| 8 | Parsing organises tokens into a syntax tree; recursive descent is the easiest scheme to hand-write |
| 9 | Semantic analysis does only three things: insert implicit conversions, fold constants, report type errors |
| 10 | An IR decouples "language" from "CPU"; a virtual stack is the simplest implementation |
| 11 | The first optimiser only needs constant folding and dead-code elimination |
| 12 | The ARM backend translates IR into Thumb-2 assembly, statement by statement |
| 13 | The assembler turns assembly text into machine code; the hard part is branch encoding |
| 14 | An object file holds code, symbols and relocations; the linker merges and patches |
| 15 | The scatter file decides which address range each piece of code lands on |
| 16 | The command-line driver parses arguments in two passes and derives output file names |
| 17 | The key to testing is differential testing plus a method for localising "runs but computes wrong" |
| 18 | Build the compiler into a firmware so it compiles its own output on a microcontroller |
| 19 | A nine-stage exercise path, and where each stage gets stuck |

## 3 Three reading routes

The book defines three routes through the material, depending on what the reader wants:

* **Full route** (all 19 chapters) — to build a compiler end to end.
* **Front-end route** (chapters 1–11) — for readers whose interest is lexing, parsing, types and IR,
  who will target a high-level backend or an interpreter.
* **Backend/porting route** (chapters 1–3, 10–15, 17–18) — for readers who already understand front
  ends and want code generation, assembly, object files, linking and bare-metal execution.

## 4 Where it connects to the rest of the documentation

| Topic | Where to look |
| --- | --- |
| The compiler as a product: options, diagnostics, targets, tests | [docs/MANUAL.md](MANUAL.en.md) |
| The x86-64 backend and its execution-level gate | [docs/X86_64_BACKEND.md](X86_64_BACKEND.en.md) |
| Building arkCC with armcc5 for the STM32H743 | [docs/STM32_BUILD.md](STM32_BUILD.en.md) |
| Atomic support and its diagnostics | [docs/ATOMIC.md](ATOMIC.en.md) |
| Diagnostic message catalogue | [docs/DIAGNOSTICS.md](DIAGNOSTICS.en.md) |
| Project overview and version history | [README.md](../README.en.md) |

## 5 If you want the full book in English

The 8,740-line original is not translated here: a faithful translation of a book-length teaching text
is a separate piece of work, and a partial or summarised translation that silently dropped sections
would be worse than none. If an English full text is needed, say so and it can be scheduled as its own
task — it would be delivered chapter by chapter, keeping every assembly listing, hex number and size
byte-identical to the Chinese original.
