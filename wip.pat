diff --git a/frameworks/cocos2d-x/cocos/platform/CCFileUtils.cpp b/frameworks/cocos2d-x/cocos/platform/CCFileUtils.cpp
index c60d023..bba29cb 100644
--- a/frameworks/cocos2d-x/cocos/platform/CCFileUtils.cpp
+++ b/frameworks/cocos2d-x/cocos/platform/CCFileUtils.cpp
@@ -777,19 +777,19 @@ bool FileUtils::writeToFile(const ValueMap& /*dict*/, const std::string &/*fullP
         if (iter == _filenameLookupDict.end())
         {
             //idk
-            CCLOG("idk [getNewFilename] %s not found normally", filename.c_str());
+//            CCLOG("idk [getNewFilename] %s not found normally", filename.c_str());
             std::string query;
             ValueMap::const_iterator foundIt;
 
             for (const auto& searchIt : _searchPathArray)
             {
                 query = searchIt.substr(7) + filename;  //remove 'assets/' prefix
-                CCLOG("idk [getNewFilename] try append searchIt: %s", query.c_str());
+//                CCLOG("idk [getNewFilename] try append searchIt: %s", query.c_str());
                 foundIt = _filenameLookupDict.find(query);
 
                 if (foundIt != _filenameLookupDict.end())
                 {
-                    CCLOG("idk [getNewFilename] ... and %s found", query.c_str());
+//                    CCLOG("idk [getNewFilename] ... and %s found", query.c_str());
                     newFileName = foundIt->second.asString();
                     break;
                 }
@@ -833,7 +833,7 @@ bool FileUtils::writeToFile(const ValueMap& /*dict*/, const std::string &/*fullP
         {
             return "";
         }
-        CCLOG("idk fullPathForFilename: want %s", filename.c_str());
+//        CCLOG("idk fullPathForFilename: want %s", filename.c_str());
         if (isAbsolutePath(filename))
         {
             return filename;
@@ -846,23 +846,23 @@ bool FileUtils::writeToFile(const ValueMap& /*dict*/, const std::string &/*fullP
             return cacheIter->second;
         }
 
-        CCLOG("idk fullPathForFilename: not cached");
+//        CCLOG("idk fullPathForFilename: not cached");
         // Get the new file name.
         const std::string newFilename( getNewFilename(filename) );
-        CCLOG("idk fullPathForFilename: get newFilename: %s", newFilename.c_str());
+//        CCLOG("idk fullPathForFilename: get newFilename: %s", newFilename.c_str());
         std::string fullpath;
 
         for (const auto& searchIt : _searchPathArray)
         {
-            CCLOG("idk fullPathForFilename: searchIt: %s", searchIt.c_str());
+//            CCLOG("idk fullPathForFilename: searchIt: %s", searchIt.c_str());
             for (const auto& resolutionIt : _searchResolutionsOrderArray)
             {
-                CCLOG("idk fullPathForFilename: resolutionIt: %s", resolutionIt.c_str());
+//                CCLOG("idk fullPathForFilename: resolutionIt: %s", resolutionIt.c_str());
                 fullpath = this->getPathForFilename(newFilename, resolutionIt, searchIt);
 
                 if (!fullpath.empty())
                 {
-                    CCLOG("idk fullPathForFilename: fullpath: %s", fullpath.c_str());
+//                    CCLOG("idk fullPathForFilename: fullpath: %s", fullpath.c_str());
                     // Using the filename passed in as key.
                     _fullPathCache.emplace(filename, fullpath);
                     return fullpath;
diff --git a/frameworks/cocos2d-x/cocos/scripting/lua-bindings/auto/lua_cocos2dx_extension_auto.cpp b/frameworks/cocos2d-x/cocos/scripting/lua-bindings/auto/lua_cocos2dx_extension_auto.cpp
index ff77733..02cb73e 100644
--- a/frameworks/cocos2d-x/cocos/scripting/lua-bindings/auto/lua_cocos2dx_extension_auto.cpp
+++ b/frameworks/cocos2d-x/cocos/scripting/lua-bindings/auto/lua_cocos2dx_extension_auto.cpp
@@ -13147,6 +13147,36 @@ int lua_cocos2dx_extension_AssetsManagerEx_create(lua_State* tolua_S)
 #endif
     return 0;
 }
+//idk
+int lua_cocos2dx_extension_AssetsManagerEx_getInstance(lua_State* tolua_S)
+{
+    int argc = 0;
+    bool ok  = true;
+
+#if COCOS2D_DEBUG >= 1
+    tolua_Error tolua_err;
+#endif
+
+#if COCOS2D_DEBUG >= 1
+    if (!tolua_isusertable(tolua_S,1,"cc.AssetsManagerEx",0,&tolua_err)) goto tolua_lerror;
+#endif
+
+    argc = lua_gettop(tolua_S) - 1;
+
+    if (argc == 0)
+    {
+        cocos2d::extension::AssetsManagerEx* ret = cocos2d::extension::AssetsManagerEx::getInstance();
+        object_to_luaval<cocos2d::extension::AssetsManagerEx>(tolua_S, "cc.AssetsManagerEx",(cocos2d::extension::AssetsManagerEx*)ret);
+        return 1;
+    }
+    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "cc.AssetsManagerEx:getInstance",argc, 0);
+    return 0;
+#if COCOS2D_DEBUG >= 1
+    tolua_lerror:
+    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_extension_AssetsManagerEx_getInstance'.",&tolua_err);
+#endif
+    return 0;
+}
 int lua_cocos2dx_extension_AssetsManagerEx_constructor(lua_State* tolua_S)
 {
     int argc = 0;
@@ -13215,6 +13245,8 @@ int lua_register_cocos2dx_extension_AssetsManagerEx(lua_State* tolua_S)
         tolua_function(tolua_S,"getRemoteManifest",lua_cocos2dx_extension_AssetsManagerEx_getRemoteManifest);
         tolua_function(tolua_S,"downloadFailedAssets",lua_cocos2dx_extension_AssetsManagerEx_downloadFailedAssets);
         tolua_function(tolua_S,"create", lua_cocos2dx_extension_AssetsManagerEx_create);
+        //idk
+        tolua_function(tolua_S, "getInstance", lua_cocos2dx_extension_AssetsManagerEx_getInstance);
     tolua_endmodule(tolua_S);
     std::string typeName = typeid(cocos2d::extension::AssetsManagerEx).name();
     g_luaType[typeName] = "cc.AssetsManagerEx";
diff --git a/frameworks/cocos2d-x/cocos/scripting/lua-bindings/manual/spine/LuaSkeletonAnimation.cpp b/frameworks/cocos2d-x/cocos/scripting/lua-bindings/manual/spine/LuaSkeletonAnimation.cpp
index 8049c39..306c05f 100644
--- a/frameworks/cocos2d-x/cocos/scripting/lua-bindings/manual/spine/LuaSkeletonAnimation.cpp
+++ b/frameworks/cocos2d-x/cocos/scripting/lua-bindings/manual/spine/LuaSkeletonAnimation.cpp
@@ -49,7 +49,7 @@ LuaSkeletonAnimation* LuaSkeletonAnimation::createWithFile (const char* skeleton
 {
 	LuaSkeletonAnimation* node = new (std::nothrow) LuaSkeletonAnimation();
     spAtlas* atlas = spAtlas_createFromFile(atlasFile, nullptr);
-    node->initWithJsonFile(skeletonDataFile, atlas, scale);
+    node->initWithBinaryFile(skeletonDataFile, atlas, scale);
 	node->autorelease();
 	return node;
 }
diff --git a/frameworks/cocos2d-x/extensions/assets-manager/AssetsManagerEx.cpp b/frameworks/cocos2d-x/extensions/assets-manager/AssetsManagerEx.cpp
index 381686b..a6b7306 100644
--- a/frameworks/cocos2d-x/extensions/assets-manager/AssetsManagerEx.cpp
+++ b/frameworks/cocos2d-x/extensions/assets-manager/AssetsManagerEx.cpp
@@ -54,6 +54,7 @@ const std::string AssetsManagerEx::VERSION_ID = "@version";
 const std::string AssetsManagerEx::MANIFEST_ID = "@manifest";
 
 // Implementation of AssetsManagerEx
+AssetsManagerEx* AssetsManagerEx::s_sharedAssetsManagerEx = nullptr;
 
 AssetsManagerEx::AssetsManagerEx(const std::string& manifestUrl, const std::string& storagePath)
 : _updateState(State::UNCHECKED)
@@ -78,6 +79,7 @@ AssetsManagerEx::AssetsManagerEx(const std::string& manifestUrl, const std::stri
 , _verifyCallback(nullptr)
 , _inited(false)
 {
+    CCLOG("AssetsManagerEx : Init variables");
     // Init variables
     _eventDispatcher = Director::getInstance()->getEventDispatcher();
     std::string pointer = StringUtils::format("%p", this);
@@ -123,8 +125,19 @@ AssetsManagerEx::~AssetsManagerEx()
     CC_SAFE_RELEASE(_remoteManifest);
 }
 
+//idk
+AssetsManagerEx* AssetsManagerEx::getInstance()
+{
+    if (s_sharedAssetsManagerEx == nullptr)
+    {
+        CCLOG("ERROR: Had not create AssetsManagerEx");
+    }
+    return s_sharedAssetsManagerEx;
+}
+
 AssetsManagerEx* AssetsManagerEx::create(const std::string& manifestUrl, const std::string& storagePath)
 {
+    CCLOG("AssetsManagerEx :: create");
     AssetsManagerEx* ret = new (std::nothrow) AssetsManagerEx(manifestUrl, storagePath);
     if (ret)
     {
@@ -134,18 +147,21 @@ AssetsManagerEx* AssetsManagerEx::create(const std::string& manifestUrl, const s
     {
         CC_SAFE_DELETE(ret);
     }
+    s_sharedAssetsManagerEx = ret;
+
     return ret;
 }
 
 void AssetsManagerEx::initManifests(const std::string& manifestUrl)
 {
+    CCLOG("AssetsManagerEx : initManifests");
     _inited = true;
     // Init and load local manifest
     _localManifest = new (std::nothrow) Manifest();
     if (_localManifest)
     {
         loadLocalManifest(manifestUrl);
-        
+
         // Init and load temporary manifest
         _tempManifest = new (std::nothrow) Manifest();
         if (_tempManifest)
@@ -167,7 +183,7 @@ void AssetsManagerEx::initManifests(const std::string& manifestUrl)
         {
             _inited = false;
         }
-        
+
         // Init remote manifest for future usage
         _remoteManifest = new (std::nothrow) Manifest();
         if (!_remoteManifest)
@@ -179,7 +195,7 @@ void AssetsManagerEx::initManifests(const std::string& manifestUrl)
     {
         _inited = false;
     }
-    
+
     if (!_inited)
     {
         CC_SAFE_RELEASE(_localManifest);
@@ -217,7 +233,7 @@ void AssetsManagerEx::loadLocalManifest(const std::string& /*manifestUrl*/)
             }
         }
     }
-    
+
     // Ensure no search path of cached manifest is used to load this manifest
     std::vector<std::string> searchPaths = _fileUtils->getSearchPaths();
     if (cachedManifest)
@@ -272,7 +288,7 @@ void AssetsManagerEx::loadLocalManifest(const std::string& /*manifestUrl*/)
 std::string AssetsManagerEx::basename(const std::string& path) const
 {
     size_t found = path.find_last_of("/\\");
-    
+
     if (std::string::npos != found)
     {
         return path.substr(0, found);
@@ -312,7 +328,7 @@ void AssetsManagerEx::setStoragePath(const std::string& storagePath)
     _storagePath = storagePath;
     adjustPath(_storagePath);
     _fileUtils->createDirectory(_storagePath);
-    
+
     _tempStoragePath = _storagePath;
     _tempStoragePath.insert(_storagePath.size() - 1, TEMP_PACKAGE_SUFFIX);
     _fileUtils->createDirectory(_tempStoragePath);
@@ -336,7 +352,7 @@ bool AssetsManagerEx::decompress(const std::string &zip)
         return false;
     }
     const std::string rootPath = zip.substr(0, pos+1);
-    
+
     // Open the zip file
     unzFile zipfile = unzOpen(FileUtils::getInstance()->getSuitableFOpen(zip).c_str());
     if (! zipfile)
@@ -344,7 +360,7 @@ bool AssetsManagerEx::decompress(const std::string &zip)
         CCLOG("AssetsManagerEx : can not open downloaded zip file %s\n", zip.c_str());
         return false;
     }
-    
+
     // Get info about the zip file
     unz_global_info global_info;
     if (unzGetGlobalInfo(zipfile, &global_info) != UNZ_OK)
@@ -353,7 +369,7 @@ bool AssetsManagerEx::decompress(const std::string &zip)
         unzClose(zipfile);
         return false;
     }
-    
+
     // Buffer to hold data read from the zip file
     char readBuffer[BUFFER_SIZE];
     // Loop to extract all files.
@@ -377,7 +393,7 @@ bool AssetsManagerEx::decompress(const std::string &zip)
             return false;
         }
         const std::string fullPath = rootPath + fileName;
-        
+
         // Check if this entry is a directory or a file.
         const size_t filenameLength = strlen(fileName);
         if (fileName[filenameLength-1] == '/')
@@ -412,7 +428,7 @@ bool AssetsManagerEx::decompress(const std::string &zip)
                 unzClose(zipfile);
                 return false;
             }
-            
+
             // Create a file to store current file.
             FILE *out = fopen(FileUtils::getInstance()->getSuitableFOpen(fullPath).c_str(), "wb");
             if (!out)
@@ -422,7 +438,7 @@ bool AssetsManagerEx::decompress(const std::string &zip)
                 unzClose(zipfile);
                 return false;
             }
-            
+
             // Write current file content to destinate file.
             int error = UNZ_OK;
             do
@@ -436,18 +452,18 @@ bool AssetsManagerEx::decompress(const std::string &zip)
                     unzClose(zipfile);
                     return false;
                 }
-                
+
                 if (error > 0)
                 {
                     fwrite(readBuffer, error, 1, out);
                 }
             } while(error > 0);
-            
+
             fclose(out);
         }
-        
+
         unzCloseCurrentFile(zipfile);
-        
+
         // Goto next entry listed in the zip file.
         if ((i+1) < global_info.number_entry)
         {
@@ -459,7 +475,7 @@ bool AssetsManagerEx::decompress(const std::string &zip)
             }
         }
     }
-    
+
     unzClose(zipfile);
     return true;
 }
@@ -472,12 +488,12 @@ void AssetsManagerEx::decompressDownloadedZip(const std::string &customId, const
         std::string zipFile;
         bool succeed;
     };
-    
+
     AsyncData* asyncData = new AsyncData;
     asyncData->customId = customId;
     asyncData->zipFile = storagePath;
     asyncData->succeed = false;
-    
+
     std::function<void(void*)> decompressFinished = [this](void* param) {
         auto dataInner = reinterpret_cast<AsyncData*>(param);
         if (dataInner->succeed)
@@ -679,7 +695,7 @@ void AssetsManagerEx::startUpdate()
     _percent = _percentByFile = _sizeCollected = _totalSize = 0;
     _downloadedSize.clear();
     _totalEnabled = false;
-    
+
     // Temporary manifest exists, resuming previous download
     if (_tempManifest && _tempManifest->isLoaded() && _tempManifest->versionEquals(_remoteManifest))
     {
@@ -687,7 +703,7 @@ void AssetsManagerEx::startUpdate()
         _tempManifest->genResumeAssetsList(&_downloadUnits);
         _totalWaitToDownload = _totalToDownload = (int)_downloadUnits.size();
         this->batchDownload();
-        
+
         std::string msg = StringUtils::format("Resuming from previous unfinished update, %d files remains to be finished.", _totalToDownload);
         dispatchUpdateEvent(EventAssetsManagerEx::EventCode::UPDATE_PROGRESSION, "", msg);
     }
@@ -703,11 +719,11 @@ void AssetsManagerEx::startUpdate()
             _fileUtils->createDirectory(_tempStoragePath);
             _remoteManifest->saveToFile(_tempManifestPath);
         }
-        
+
         // Temporary manifest will be used to register the download states of each asset,
         // in this case, it equals remote manifest.
         _tempManifest = _remoteManifest;
-        
+
         // Check difference between local manifest and remote manifest
         std::unordered_map<std::string, Manifest::AssetDiff> diff_map = _localManifest->genDiff(_remoteManifest);
         if (diff_map.size() == 0)
@@ -738,7 +754,7 @@ void AssetsManagerEx::startUpdate()
             }
             _totalWaitToDownload = _totalToDownload = (int)_downloadUnits.size();
             this->batchDownload();
-            
+
             std::string msg = StringUtils::format("Start to update %d files from remote package.", _totalToDownload);
             dispatchUpdateEvent(EventAssetsManagerEx::EventCode::UPDATE_PROGRESSION, "", msg);
         }
@@ -797,6 +813,7 @@ void AssetsManagerEx::updateSucceed()
 
 void AssetsManagerEx::checkUpdate()
 {
+    CCLOG("AssetsManagerEx : checkUpdate.\n");
     if (_updateEntry != UpdateEntry::NONE)
     {
         CCLOGERROR("AssetsManagerEx::checkUpdate, updateEntry isn't NONE");
@@ -842,6 +859,7 @@ void AssetsManagerEx::checkUpdate()
 
 void AssetsManagerEx::update()
 {
+    CCLOG("AssetsManagerEx : update.\n");
     if (_updateEntry != UpdateEntry::NONE)
     {
         CCLOGERROR("AssetsManagerEx::update, updateEntry isn't NONE");
@@ -919,7 +937,7 @@ void AssetsManagerEx::updateAssets(const DownloadUnits& assets)
         dispatchUpdateEvent(EventAssetsManagerEx::EventCode::ERROR_NO_LOCAL_MANIFEST);
         return;
     }
-    
+
     if (_updateState != State::UPDATING && _localManifest->isLoaded() && _remoteManifest->isLoaded())
     {
         _updateState = State::UPDATING;
@@ -959,13 +977,13 @@ void AssetsManagerEx::fileError(const std::string& identifier, const std::string
     if (unitIt != _downloadUnits.end())
     {
         _totalWaitToDownload--;
-        
+
         DownloadUnit unit = unitIt->second;
         _failedUnits.emplace(unit.customId, unit);
     }
     dispatchUpdateEvent(EventAssetsManagerEx::EventCode::ERROR_UPDATING, identifier, errorStr, errorCode, errorCodeInternal);
     _tempManifest->setAssetDownloadState(identifier, Manifest::DownloadState::UNSTARTED);
-    
+
     _currConcurrentTask = MAX(0, _currConcurrentTask-1);
     queueDowload();
 }
@@ -974,7 +992,7 @@ void AssetsManagerEx::fileSuccess(const std::string &customId, const std::string
 {
     // Set download state to SUCCESSED
     _tempManifest->setAssetDownloadState(customId, Manifest::DownloadState::SUCCESSED);
-    
+
     auto unitIt = _failedUnits.find(customId);
     // Found unit and delete it
     if (unitIt != _failedUnits.end())
@@ -982,20 +1000,20 @@ void AssetsManagerEx::fileSuccess(const std::string &customId, const std::string
         // Remove from failed units list
         _failedUnits.erase(unitIt);
     }
-    
+
     unitIt = _downloadUnits.find(customId);
     if (unitIt != _downloadUnits.end())
     {
         // Reduce count only when unit found in _downloadUnits
         _totalWaitToDownload--;
-        
+
         _percentByFile = 100 * (float)(_totalToDownload - _totalWaitToDownload) / _totalToDownload;
         // Notify progression event
         dispatchUpdateEvent(EventAssetsManagerEx::EventCode::UPDATE_PROGRESSION, "");
     }
     // Notify asset updated event
     dispatchUpdateEvent(EventAssetsManagerEx::EventCode::ASSET_UPDATED, customId);
-    
+
     _currConcurrentTask = MAX(0, _currConcurrentTask-1);
     queueDowload();
 }
@@ -1065,7 +1083,7 @@ void AssetsManagerEx::onProgress(double total, double downloaded, const std::str
                 }
             }
         }
-        
+
         if (_totalEnabled && _updateState == State::UPDATING)
         {
             float currentPercent = 100 * totalDownloaded / _totalSize;
@@ -1104,7 +1122,7 @@ void AssetsManagerEx::onSuccess(const std::string &/*srcUrl*/, const std::string
                 ok = _verifyCallback(storagePath, asset);
             }
         }
-        
+
         if (ok)
         {
             bool compressed = assetIt != assets.end() ? assetIt->second.compressed : false;
@@ -1141,7 +1159,7 @@ void AssetsManagerEx::batchDownload()
             _totalSize += unit.size;
             _sizeCollected++;
         }
-        
+
         _queue.push_back(iter.first);
     }
     // All collected, enable total size
@@ -1149,7 +1167,7 @@ void AssetsManagerEx::batchDownload()
     {
         _totalEnabled = true;
     }
-    
+
     queueDowload();
 }
 
@@ -1160,17 +1178,17 @@ void AssetsManagerEx::queueDowload()
         this->onDownloadUnitsFinished();
         return;
     }
-    
+
     while (_currConcurrentTask < _maxConcurrentTask && _queue.size() > 0)
     {
         std::string key = _queue.back();
         _queue.pop_back();
-        
+
         _currConcurrentTask++;
         DownloadUnit& unit = _downloadUnits[key];
         _fileUtils->createDirectory(basename(unit.storagePath));
         _downloader->createDownloadFileTask(unit.srcUrl, unit.storagePath, unit.customId);
-        
+
         _tempManifest->setAssetDownloadState(key, Manifest::DownloadState::DOWNLOADING);
     }
     if (_percentByFile / 100 > _nextSavePoint)
@@ -1188,7 +1206,7 @@ void AssetsManagerEx::onDownloadUnitsFinished()
     {
         // Save current download manifest information for resuming
         _tempManifest->saveToFile(_tempManifestPath);
-    
+
         _updateState = State::FAIL_TO_UPDATE;
         dispatchUpdateEvent(EventAssetsManagerEx::EventCode::UPDATE_FAILED);
     }
diff --git a/frameworks/cocos2d-x/extensions/assets-manager/AssetsManagerEx.h b/frameworks/cocos2d-x/extensions/assets-manager/AssetsManagerEx.h
index f9d2fb8..97c5d22 100644
--- a/frameworks/cocos2d-x/extensions/assets-manager/AssetsManagerEx.h
+++ b/frameworks/cocos2d-x/extensions/assets-manager/AssetsManagerEx.h
@@ -70,7 +70,14 @@ public:
     
     const static std::string VERSION_ID;
     const static std::string MANIFEST_ID;
-    
+
+    //idk
+    static AssetsManagerEx* getInstance();
+    /** idk
+     *  The singleton pointer of AssetsManagerEx.
+     */
+    static AssetsManagerEx* s_sharedAssetsManagerEx;
+
     /** @brief Create function for creating a new AssetsManagerEx
      @param manifestUrl   The url for the local manifest file
      @param storagePath   The storage path for downloaded assets
diff --git a/frameworks/cocos2d-x/extensions/assets-manager/Manifest.cpp b/frameworks/cocos2d-x/extensions/assets-manager/Manifest.cpp
index b91779d..5a6ec18 100644
--- a/frameworks/cocos2d-x/extensions/assets-manager/Manifest.cpp
+++ b/frameworks/cocos2d-x/extensions/assets-manager/Manifest.cpp
@@ -90,6 +90,7 @@ void Manifest::loadJson(const std::string& url)
 {
     clear();
     std::string content;
+    CCLOG("idk loadJson with %s\n", url.c_str());
     if (_fileUtils->isFileExist(url))
     {
         // Load file content
