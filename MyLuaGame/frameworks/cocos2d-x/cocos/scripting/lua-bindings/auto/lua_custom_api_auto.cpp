#include "lua_custom_api_auto.hpp"
#include "FileUnit.h"
#include "tolua_fix.h"
#include "LuaBasicConversions.h"



int lua_custom_api_celldef_geturl(lua_State* tolua_S)
{
    int argc = 0;
    celldef* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"celldef",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (celldef*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_celldef_geturl'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        std::string ret = cobj->geturl();
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "geturl",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_celldef_geturl'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_celldef_getrowname(lua_State* tolua_S)
{
    int argc = 0;
    celldef* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"celldef",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (celldef*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_celldef_getrowname'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        std::string ret = cobj->getrowname();
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getrowname",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_celldef_getrowname'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_celldef_seturl(lua_State* tolua_S)
{
    int argc = 0;
    celldef* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"celldef",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (celldef*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_celldef_seturl'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->seturl(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "seturl",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_celldef_seturl'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_celldef_setrowname(lua_State* tolua_S)
{
    int argc = 0;
    celldef* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"celldef",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (celldef*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_celldef_setrowname'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->setrowname(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setrowname",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_celldef_setrowname'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_celldef_getcontent(lua_State* tolua_S)
{
    int argc = 0;
    celldef* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"celldef",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (celldef*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_celldef_getcontent'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        std::string ret = cobj->getcontent();
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getcontent",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_celldef_getcontent'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_celldef_setcontent(lua_State* tolua_S)
{
    int argc = 0;
    celldef* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"celldef",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (celldef*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_celldef_setcontent'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->setcontent(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setcontent",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_celldef_setcontent'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_celldef_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"celldef",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
            return 0;
        celldef* ret = celldef::create();
        object_to_luaval<celldef>(tolua_S, "celldef",(celldef*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "create",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_celldef_create'.",&tolua_err);
#endif
    return 0;
}
static int lua_custom_api_celldef_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (celldef)");
    return 0;
}

int lua_register_custom_api_celldef(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"celldef");
    tolua_cclass(tolua_S,"celldef","celldef","cc.Ref",nullptr);

    tolua_beginmodule(tolua_S,"celldef");
        tolua_function(tolua_S,"geturl",lua_custom_api_celldef_geturl);
        tolua_function(tolua_S,"getrowname",lua_custom_api_celldef_getrowname);
        tolua_function(tolua_S,"seturl",lua_custom_api_celldef_seturl);
        tolua_function(tolua_S,"setrowname",lua_custom_api_celldef_setrowname);
        tolua_function(tolua_S,"getcontent",lua_custom_api_celldef_getcontent);
        tolua_function(tolua_S,"setcontent",lua_custom_api_celldef_setcontent);
        tolua_function(tolua_S,"create", lua_custom_api_celldef_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(celldef).name();
    g_luaType[typeName] = "celldef";
    g_typeCast["celldef"] = "celldef";
    return 1;
}

int lua_custom_api_FileUnit_setbaseurl(lua_State* tolua_S)
{
    int argc = 0;
    FileUnit* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"FileUnit",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (FileUnit*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_setbaseurl'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->setbaseurl(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setbaseurl",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_setbaseurl'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_getbaseurl(lua_State* tolua_S)
{
    int argc = 0;
    FileUnit* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"FileUnit",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (FileUnit*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_getbaseurl'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        std::string ret = cobj->getbaseurl();
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getbaseurl",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_getbaseurl'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_isrowexist(lua_State* tolua_S)
{
    int argc = 0;
    FileUnit* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"FileUnit",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (FileUnit*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_isrowexist'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        bool ret = cobj->isrowexist(arg0);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "isrowexist",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_isrowexist'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_clear(lua_State* tolua_S)
{
    int argc = 0;
    FileUnit* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"FileUnit",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (FileUnit*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_clear'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->clear();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "clear",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_clear'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_savedata(lua_State* tolua_S)
{
    int argc = 0;
    FileUnit* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"FileUnit",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (FileUnit*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_savedata'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->savedata();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "savedata",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_savedata'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_testchangefile(lua_State* tolua_S)
{
    int argc = 0;
    FileUnit* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"FileUnit",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (FileUnit*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_testchangefile'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->testchangefile();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "testchangefile",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_testchangefile'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_getrowcontent(lua_State* tolua_S)
{
    int argc = 0;
    FileUnit* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"FileUnit",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (FileUnit*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_getrowcontent'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        std::string ret = cobj->getrowcontent(arg0);
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getrowcontent",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_getrowcontent'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_getcelllist(lua_State* tolua_S)
{
    int argc = 0;
    FileUnit* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"FileUnit",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (FileUnit*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_getcelllist'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cocos2d::Vector<celldef *>& ret = cobj->getcelllist();
        ccvector_to_luaval(tolua_S, ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getcelllist",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_getcelllist'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_addrow(lua_State* tolua_S)
{
    int argc = 0;
    FileUnit* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"FileUnit",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (FileUnit*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_addrow'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 3) 
    {
        std::string arg0;
        std::string arg1;
        std::string arg2;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_std_string(tolua_S, 3,&arg1);

        ok &= luaval_to_std_string(tolua_S, 4,&arg2);
        if(!ok)
            return 0;
        cobj->addrow(arg0, arg1, arg2);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "addrow",argc, 3);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_addrow'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_gettitle(lua_State* tolua_S)
{
    int argc = 0;
    FileUnit* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"FileUnit",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (FileUnit*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_gettitle'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        std::string ret = cobj->gettitle();
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "gettitle",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_gettitle'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_isfileexit(lua_State* tolua_S)
{
    int argc = 0;
    FileUnit* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"FileUnit",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (FileUnit*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_isfileexit'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        bool ret = cobj->isfileexit();
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "isfileexit",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_isfileexit'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_destroy(lua_State* tolua_S)
{
    int argc = 0;
    FileUnit* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"FileUnit",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (FileUnit*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_destroy'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->destroy();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "destroy",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_destroy'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_setrow(lua_State* tolua_S)
{
    int argc = 0;
    FileUnit* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"FileUnit",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (FileUnit*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_setrow'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        std::string arg0;
        std::string arg1;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_std_string(tolua_S, 3,&arg1);
        if(!ok)
            return 0;
        cobj->setrow(arg0, arg1);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setrow",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_setrow'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_settitle(lua_State* tolua_S)
{
    int argc = 0;
    FileUnit* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"FileUnit",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (FileUnit*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_settitle'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->settitle(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "settitle",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_settitle'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_settestdata(lua_State* tolua_S)
{
    int argc = 0;
    FileUnit* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"FileUnit",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (FileUnit*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_settestdata'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->settestdata();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "settestdata",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_settestdata'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_constructor(lua_State* tolua_S)
{
    int argc = 0;
    FileUnit* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif



    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj = new FileUnit(arg0);
        tolua_pushusertype(tolua_S,(void*)cobj,"FileUnit");
        tolua_register_gc(tolua_S,lua_gettop(tolua_S));
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "FileUnit",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_custom_api_FileUnit_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (FileUnit)");
    return 0;
}

int lua_register_custom_api_FileUnit(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"FileUnit");
    tolua_cclass(tolua_S,"FileUnit","FileUnit","",nullptr);

    tolua_beginmodule(tolua_S,"FileUnit");
        tolua_function(tolua_S,"new",lua_custom_api_FileUnit_constructor);
        tolua_function(tolua_S,"setbaseurl",lua_custom_api_FileUnit_setbaseurl);
        tolua_function(tolua_S,"getbaseurl",lua_custom_api_FileUnit_getbaseurl);
        tolua_function(tolua_S,"isrowexist",lua_custom_api_FileUnit_isrowexist);
        tolua_function(tolua_S,"clear",lua_custom_api_FileUnit_clear);
        tolua_function(tolua_S,"savedata",lua_custom_api_FileUnit_savedata);
        tolua_function(tolua_S,"testchangefile",lua_custom_api_FileUnit_testchangefile);
        tolua_function(tolua_S,"getrowcontent",lua_custom_api_FileUnit_getrowcontent);
        tolua_function(tolua_S,"getcelllist",lua_custom_api_FileUnit_getcelllist);
        tolua_function(tolua_S,"addrow",lua_custom_api_FileUnit_addrow);
        tolua_function(tolua_S,"gettitle",lua_custom_api_FileUnit_gettitle);
        tolua_function(tolua_S,"isfileexit",lua_custom_api_FileUnit_isfileexit);
        tolua_function(tolua_S,"destroy",lua_custom_api_FileUnit_destroy);
        tolua_function(tolua_S,"setrow",lua_custom_api_FileUnit_setrow);
        tolua_function(tolua_S,"settitle",lua_custom_api_FileUnit_settitle);
        tolua_function(tolua_S,"settestdata",lua_custom_api_FileUnit_settestdata);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(FileUnit).name();
    g_luaType[typeName] = "FileUnit";
    g_typeCast["FileUnit"] = "FileUnit";
    return 1;
}
TOLUA_API int register_all_custom_api(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,"my",0);
	tolua_beginmodule(tolua_S,"my");

	lua_register_custom_api_FileUnit(tolua_S);
	lua_register_custom_api_celldef(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

