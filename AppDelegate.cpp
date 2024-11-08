/****************************************************************************
 Copyright (c) 2017-2018 Xiamen Yaji Software Co., Ltd.
 
 http://www.cocos2d-x.org
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 ****************************************************************************/

#include "AppDelegate.h"
#include "scripting/lua-bindings/manual/CCLuaEngine.h"
#include "cocos2d.h"
#include "scripting/lua-bindings/manual/lua_module_register.h"
#include "json/stream.h"
#include "json/document.h"

// #define USE_AUDIO_ENGINE 1
// #define USE_SIMPLE_AUDIO_ENGINE 1

#if USE_AUDIO_ENGINE && USE_SIMPLE_AUDIO_ENGINE
#error "Don't use AudioEngine and SimpleAudioEngine at the same time. Please just select one in your game!"
#endif

#if USE_AUDIO_ENGINE
#include "audio/include/AudioEngine.h"
using namespace cocos2d::experimental;
#elif USE_SIMPLE_AUDIO_ENGINE
#include "audio/include/SimpleAudioEngine.h"
using namespace CocosDenshion;
#endif

USING_NS_CC;
using namespace std;

AppDelegate::AppDelegate() {
}

AppDelegate::~AppDelegate() {
#if USE_AUDIO_ENGINE
    AudioEngine::end();
#elif USE_SIMPLE_AUDIO_ENGINE
    SimpleAudioEngine::end();
#endif

#if (COCOS2D_DEBUG > 0) && (CC_CODE_IDE_DEBUG_SUPPORT > 0)
    // NOTE:Please don't remove this call if you want to debug with Cocos Code IDE
    RuntimeEngine::getInstance()->end();
#endif

}

// if you want a different context, modify the value of glContextAttrs
// it will affect all platforms
void AppDelegate::initGLContextAttrs() {
    // set OpenGL context attributes: red,green,blue,alpha,depth,stencil,multisamplesCount
    GLContextAttrs glContextAttrs = {8, 8, 8, 8, 24, 8, 0};

    GLView::setGLContextAttrs(glContextAttrs);
}

// if you want to use the package manager to install more packages, 
// don't modify or remove this function
static int register_all_packages() {
    return 0; //flag for packages manager
}

static void loadRepoMappingFile() {
    CCLOG("idk load repo.mapping file");
    std::string filename = "repository/repo.mapping";
    auto fs = FileUtils::getInstance();

    if (!fs->isFileExist(filename)) {
        CCLOGERROR("Wanted file %s not existed", filename.c_str());
        return;
    }

    std::string contentStr;
    fs->getContents(filename, &contentStr);
    rapidjson::Document json;
    rapidjson::StringStream stream(contentStr.c_str());
    json.ParseStream<0>(stream);
    if (json.HasParseError()) {
        CCLOGERROR("GetParseError %d\n", json.GetParseError());
        return;
    }

//    static const char *kTypeNames[] =
//            {"Null", "False", "True", "Object", "Array", "String", "Number"};

    cocos2d::ValueMap filenameLookupDict;

    //idk convert json to ValueMap
    for (auto &m: json.GetObject()) {
//        CCLOG("Type of member %s is %s\n",
//              m.name.GetString(), m.value.GetObject()["mapping"].GetString());
        std::string key = m.name.GetString();
        //replace dot to slash for easier map
        if (key.find("res/") == std::string::npos)
        {
            std::replace(key.begin(), key.end(), '.', '/');
        }

        filenameLookupDict.emplace(
                key, m.value.GetObject()["mapping"].GetString()
        );
    }

    // save to fileutils
    fs->setFilenameLookupDictionary(filenameLookupDict);
}

bool AppDelegate::applicationDidFinishLaunching() {
    // set default FPS
    Director::getInstance()->setAnimationInterval(1.0 / 60.0f);

    // register lua module
    auto engine = LuaEngine::getInstance();
    ScriptEngineManager::getInstance()->setScriptEngine(engine);
    lua_State *L = engine->getLuaStack()->getLuaState();
    lua_module_register(L);

    register_all_packages();

    LuaStack *stack = engine->getLuaStack();
    stack->setXXTEAKeyAndSign("2dxLua", strlen("2dxLua"), "XXTEA", strlen("XXTEA"));

    //register custom function
    //LuaStack* stack = engine->getLuaStack();
    //register_custom_function(stack->getLuaState());

    //idk load repo.mapping file
    loadRepoMappingFile();

#if CC_64BITS
    FileUtils::getInstance()->addSearchPath("src/64bit");
#endif
    FileUtils::getInstance()->addSearchPath("cocos");
    FileUtils::getInstance()->addSearchPath("updater");
    FileUtils::getInstance()->addSearchPath("src");
    FileUtils::getInstance()->addSearchPath("res");
    FileUtils::getInstance()->addSearchPath("res/uijson");
    FileUtils::getInstance()->addSearchPath("res/spine");

    // run main
    if (engine->executeScriptFile("main")) {
        return false;
    }

    return true;
}

// This function will be called when the app is inactive. Note, when receiving a phone call it is invoked.
void AppDelegate::applicationDidEnterBackground() {
    Director::getInstance()->stopAnimation();

#if USE_AUDIO_ENGINE
    AudioEngine::pauseAll();
#elif USE_SIMPLE_AUDIO_ENGINE
    SimpleAudioEngine::getInstance()->pauseBackgroundMusic();
    SimpleAudioEngine::getInstance()->pauseAllEffects();
#endif
}

// this function will be called when the app is active again
void AppDelegate::applicationWillEnterForeground() {
    Director::getInstance()->startAnimation();

#if USE_AUDIO_ENGINE
    AudioEngine::resumeAll();
#elif USE_SIMPLE_AUDIO_ENGINE
    SimpleAudioEngine::getInstance()->resumeBackgroundMusic();
    SimpleAudioEngine::getInstance()->resumeAllEffects();
#endif
}
