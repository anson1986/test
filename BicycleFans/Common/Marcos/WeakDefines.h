//
//  WeakDefines.h
//  HangHaiMi
//
//  Created by bifen on 2020/6/30.
//  Copyright © 2020 bifen. All rights reserved.
//


/// xm_weakify
#define weakify(self)    \
@weakifyPrivate(self)   \

/// xm_strongify
#define strongify(self)  \
@strongifyPrivate(self) \
RETURN_EMPTY_IF_NIL(self)

/// xm_strongifyVariate
#define strongifyVariate(self, variate)  \
@strongifyPrivate(self) \
RETURN_IF_NIL(self,variate)

/// RETURN_EMPTY_IF_NIL
#define RETURN_EMPTY_IF_NIL(self) if (!self) { return; }

/// RETURN_IF_NIL
#define RETURN_IF_NIL(self, variate) if (!self) { return variate; }

/// weakifyPrivate ------------------------------------------------------------------------------------
#ifndef weakifyPrivate

/*- weakifyPrivate for arc -*/
#if DEBUG
#define weakifyPrivate(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakifyPrivate(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#endif
/*- weakifyPrivate for arc -*/

#endif
/// weakifyPrivate ------------------------------------------------------------------------------------

/// strongifyPrivate ------------------------------------------------------------------------------------
#ifndef strongifyPrivate

/*- strongifyPrivate for arc -*/
#if DEBUG
#define strongifyPrivate(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongifyPrivate(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#endif
/*- strongifyPrivate for arc -*/

#endif
/// strongifyPrivate ------------------------------------------------------------------------------------
