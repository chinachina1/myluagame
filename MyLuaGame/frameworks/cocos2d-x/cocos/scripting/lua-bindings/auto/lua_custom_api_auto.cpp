#include "lua_custom_api_auto.hpp"
#include "FileUnit.h"
#include "tolua_fix.h"
#include "LuaBasicConversions.h"



int lua_custom_api_celldef_settitle(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_celldef_settitle'", nullptr);
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
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_celldef_settitle'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_celldef_getpath(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_celldef_getpath'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        std::string ret = cobj->getpath();
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getpath",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_celldef_getpath'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_celldef_gettitle(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_celldef_gettitle'", nullptr);
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
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_celldef_gettitle'.",&tolua_err);
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
int lua_custom_api_celldef_setpath(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_celldef_setpath'", nullptr);
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
        cobj->setpath(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setpath",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_celldef_setpath'.",&tolua_err);
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
        tolua_function(tolua_S,"settitle",lua_custom_api_celldef_settitle);
        tolua_function(tolua_S,"getpath",lua_custom_api_celldef_getpath);
        tolua_function(tolua_S,"gettitle",lua_custom_api_celldef_gettitle);
        tolua_function(tolua_S,"getcontent",lua_custom_api_celldef_getcontent);
        tolua_function(tolua_S,"setpath",lua_custom_api_celldef_setpath);
        tolua_function(tolua_S,"setcontent",lua_custom_api_celldef_setcontent);
        tolua_function(tolua_S,"create", lua_custom_api_celldef_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(celldef).name();
    g_luaType[typeName] = "celldef";
    g_typeCast["celldef"] = "celldef";
    return 1;
}

int lua_custom_api_FileUnit_createdir(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_createdir'", nullptr);
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
        bool ret = cobj->createdir(arg0);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "createdir",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_createdir'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_gotorootdir(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_gotorootdir'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->gotorootdir();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "gotorootdir",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_gotorootdir'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_openfile(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_openfile'", nullptr);
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
        bool ret = cobj->openfile(arg0);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "openfile",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_openfile'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_gotoupdir(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_gotoupdir'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->gotoupdir();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "gotoupdir",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_gotoupdir'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_getfilelist(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_getfilelist'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cocos2d::Vector<celldef *>& ret = cobj->getfilelist();
        ccvector_to_luaval(tolua_S, ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getfilelist",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_getfilelist'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_createfile(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_createfile'", nullptr);
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
        bool ret = cobj->createfile(arg0, arg1);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "createfile",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_createfile'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_getcurfile(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_getcurfile'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        std::string ret = cobj->getcurfile();
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getcurfile",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_getcurfile'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_opendir(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_opendir'", nullptr);
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
        bool ret = cobj->opendir(arg0);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "opendir",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_opendir'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_runcommand(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_FileUnit_runcommand'", nullptr);
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
        cobj->runcommand(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "runcommand",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_runcommand'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_FileUnit_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"FileUnit",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        std::string arg0;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        FileUnit* ret = FileUnit::create(arg0);
        object_to_luaval<FileUnit>(tolua_S, "FileUnit",(FileUnit*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "create",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_FileUnit_create'.",&tolua_err);
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
    tolua_cclass(tolua_S,"FileUnit","FileUnit","cc.Ref",nullptr);

    tolua_beginmodule(tolua_S,"FileUnit");
        tolua_function(tolua_S,"createdir",lua_custom_api_FileUnit_createdir);
        tolua_function(tolua_S,"gotorootdir",lua_custom_api_FileUnit_gotorootdir);
        tolua_function(tolua_S,"openfile",lua_custom_api_FileUnit_openfile);
        tolua_function(tolua_S,"gotoupdir",lua_custom_api_FileUnit_gotoupdir);
        tolua_function(tolua_S,"getfilelist",lua_custom_api_FileUnit_getfilelist);
        tolua_function(tolua_S,"createfile",lua_custom_api_FileUnit_createfile);
        tolua_function(tolua_S,"getcurfile",lua_custom_api_FileUnit_getcurfile);
        tolua_function(tolua_S,"opendir",lua_custom_api_FileUnit_opendir);
        tolua_function(tolua_S,"runcommand",lua_custom_api_FileUnit_runcommand);
        tolua_function(tolua_S,"create", lua_custom_api_FileUnit_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(FileUnit).name();
    g_luaType[typeName] = "FileUnit";
    g_typeCast["FileUnit"] = "FileUnit";
    return 1;
}

int lua_custom_api_pingpong_destroy(lua_State* tolua_S)
{
    int argc = 0;
    pingpong* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"pingpong",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (pingpong*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_custom_api_pingpong_destroy'", nullptr);
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
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_pingpong_destroy'.",&tolua_err);
#endif

    return 0;
}
int lua_custom_api_pingpong_constructor(lua_State* tolua_S)
{
    int argc = 0;
    pingpong* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif



    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj = new pingpong();
        tolua_pushusertype(tolua_S,(void*)cobj,"pingpong");
        tolua_register_gc(tolua_S,lua_gettop(tolua_S));
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "pingpong",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_custom_api_pingpong_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_custom_api_pingpong_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (pingpong)");
    return 0;
}

int lua_register_custom_api_pingpong(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"pingpong");
    tolua_cclass(tolua_S,"pingpong","pingpong","",nullptr);

    tolua_beginmodule(tolua_S,"pingpong");
        tolua_function(tolua_S,"new",lua_custom_api_pingpong_constructor);
        tolua_function(tolua_S,"destroy",lua_custom_api_pingpong_destroy);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(pingpong).name();
    g_luaType[typeName] = "pingpong";
    g_typeCast["pingpong"] = "pingpong";
    return 1;
}
TOLUA_API int register_all_custom_api(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,"my",0);
	tolua_beginmodule(tolua_S,"my");

	lua_register_custom_api_FileUnit(tolua_S);
	lua_register_custom_api_pingpong(tolua_S);
	lua_register_custom_api_celldef(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

