#include "base/ccConfig.h"
#ifndef __custom_api_h__
#define __custom_api_h__

#ifdef __cplusplus
extern "C" {
#endif
#include "tolua++.h"
#ifdef __cplusplus
}
#endif

int register_all_custom_api(lua_State* tolua_S);



































#endif // __custom_api_h__
