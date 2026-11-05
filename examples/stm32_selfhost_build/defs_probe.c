#include "probe.h"
#ifdef ARKMAKE_DEFS_PROBE
int probe(void) { return PROBE_FROM_HEADER; }
#else
int probe(void) { return 7; }
#endif
