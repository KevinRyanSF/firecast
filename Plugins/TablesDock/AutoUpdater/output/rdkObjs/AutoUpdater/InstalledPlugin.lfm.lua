require("firecast.lua");
local __o_rrpgObjs = require("rrpgObjs.lua");
require("rrpgGUI.lua");
require("rrpgDialogs.lua");
require("rrpgLFM.lua");
require("ndb.lua");
require("locale.lua");
local __o_Utils = require("utils.lua");

local function constructNew_frmInstalledPlugin()
    local obj = GUI.fromHandle(_obj_newObject("form"));
    local self = obj;
    local sheet = nil;

    rawset(obj, "_oldSetNodeObjectFunction", rawget(obj, "setNodeObject"));

    function obj:setNodeObject(nodeObject)
        sheet = nodeObject;
        self.sheet = nodeObject;
        self:_oldSetNodeObjectFunction(nodeObject);
    end;

    function obj:setNodeDatabase(nodeObject)
        self:setNodeObject(nodeObject);
    end;

    _gui_assignInitialParentForForm(obj.handle);
    obj:beginUpdate();
    obj:setName("frmInstalledPlugin");
    obj:setHeight(50);
    obj:setMargins({top=1});

    obj.rectangle1 = GUI.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle1:setParent(obj);
    obj.rectangle1:setAlign("client");
    obj.rectangle1:setColor("#212121");
    obj.rectangle1:setHitTest(false);
    obj.rectangle1:setName("rectangle1");

    obj.pluginName = GUI.fromHandle(_obj_newObject("label"));
    obj.pluginName:setParent(obj.rectangle1);
    obj.pluginName:setAlign("left");
    obj.pluginName:setField("name");
    obj.pluginName:setHorzTextAlign("center");
    obj.pluginName:setTextTrimming("none");
    obj.pluginName:setWordWrap(true);
    obj.pluginName:setName("pluginName");
    obj.pluginName:setHitTest(true);

    obj.moduleId = GUI.fromHandle(_obj_newObject("label"));
    obj.moduleId:setParent(obj.rectangle1);
    obj.moduleId:setAlign("left");
    obj.moduleId:setField("moduleId");
    obj.moduleId:setHorzTextAlign("center");
    obj.moduleId:setTextTrimming("none");
    obj.moduleId:setWordWrap(true);
    obj.moduleId:setName("moduleId");
    obj.moduleId:setHitTest(true);

    obj.author = GUI.fromHandle(_obj_newObject("label"));
    obj.author:setParent(obj.rectangle1);
    obj.author:setAlign("left");
    obj.author:setField("author");
    obj.author:setHorzTextAlign("center");
    obj.author:setTextTrimming("none");
    obj.author:setWordWrap(true);
    obj.author:setName("author");
    obj.author:setHitTest(true);

    obj.label1 = GUI.fromHandle(_obj_newObject("label"));
    obj.label1:setParent(obj.rectangle1);
    obj.label1:setAlign("left");
    obj.label1:setField("version");
    obj.label1:setHorzTextAlign("center");
    obj.label1:setTextTrimming("none");
    obj.label1:setWordWrap(true);
    obj.label1:setName("label1");

    obj.label2 = GUI.fromHandle(_obj_newObject("label"));
    obj.label2:setParent(obj.rectangle1);
    obj.label2:setAlign("left");
    obj.label2:setField("versionAvailable");
    obj.label2:setHorzTextAlign("center");
    obj.label2:setTextTrimming("none");
    obj.label2:setWordWrap(true);
    obj.label2:setName("label2");

    obj.downloadButton = GUI.fromHandle(_obj_newObject("button"));
    obj.downloadButton:setParent(obj.rectangle1);
    obj.downloadButton:setAlign("right");
    obj.downloadButton:setWidth(25);
    obj.downloadButton:setName("downloadButton");
    obj.downloadButton:setVisible(false);
    obj.downloadButton:setMargins({top = 12.5, bottom = 12.5, right = 5});

    obj.image1 = GUI.fromHandle(_obj_newObject("image"));
    obj.image1:setParent(obj.downloadButton);
    obj.image1:setAlign("client");
    obj.image1:setShowStyle("proportional");
    obj.image1:setSRC("/AutoUpdater/images/download.png");
    obj.image1:setName("image1");

    obj.openButton = GUI.fromHandle(_obj_newObject("button"));
    obj.openButton:setParent(obj.rectangle1);
    obj.openButton:setAlign("right");
    obj.openButton:setWidth(25);
    obj.openButton:setName("openButton");
    obj.openButton:setVisible(false);
    obj.openButton:setMargins({top = 12.5, bottom = 12.5, right = 5});

    obj.image2 = GUI.fromHandle(_obj_newObject("image"));
    obj.image2:setParent(obj.openButton);
    obj.image2:setAlign("client");
    obj.image2:setShowStyle("proportional");
    obj.image2:setSRC("/AutoUpdater/images/www.png");
    obj.image2:setName("image2");

    obj.removeButton = GUI.fromHandle(_obj_newObject("button"));
    obj.removeButton:setParent(obj.rectangle1);
    obj.removeButton:setAlign("right");
    obj.removeButton:setWidth(25);
    obj.removeButton:setName("removeButton");
    obj.removeButton:setMargins({top = 12.5, bottom = 12.5, right = 5});

    obj.image3 = GUI.fromHandle(_obj_newObject("image"));
    obj.image3:setParent(obj.removeButton);
    obj.image3:setAlign("client");
    obj.image3:setShowStyle("proportional");
    obj.image3:setSRC("/AutoUpdater/images/delete.png");
    obj.image3:setName("image3");

    obj.dataLink1 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink1:setParent(obj);
    obj.dataLink1:setFields({'url'});
    obj.dataLink1:setName("dataLink1");

    obj.dataLink2 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink2:setParent(obj);
    obj.dataLink2:setFields({'enabled'});
    obj.dataLink2:setName("dataLink2");

    obj.dataLink3 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink3:setParent(obj);
    obj.dataLink3:setFields({'description'});
    obj.dataLink3:setName("dataLink3");

    obj.dataLink4 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink4:setParent(obj);
    obj.dataLink4:setFields({'contact'});
    obj.dataLink4:setName("dataLink4");

    obj._e_event0 = obj.downloadButton:addEventListener("onClick",
        function (_)
            local install = true;
            				if sheet.stream ~= nil then
            					install = Firecast.Plugins.installPlugin(sheet.stream, true);
            				end;
            				if install == false or sheet.stream == nil then
            					GUI.openInBrowser(sheet.url);
            				end;
        end, obj);

    obj._e_event1 = obj.openButton:addEventListener("onClick",
        function (_)
            local url = sheet.url;
            				local pos = string.find(url, "/output");
            				if pos == nil then return end;
            				url =  string.sub(url, 1, pos);
            				GUI.openInBrowser(url);
        end, obj);

    obj._e_event2 = obj.removeButton:addEventListener("onClick",
        function (_)
            Dialogs.confirmOkCancel("Deseja desinstalar esse plugin?",
            			        function (confirmado)
            			            if confirmado then
            			                Firecast.Plugins.uninstallPlugin(sheet.moduleId);
            			            end;
            			        end);
        end, obj);

    obj._e_event3 = obj.dataLink1:addEventListener("onChange",
        function (_, field, oldValue, newValue)
            if sheet==nil then return end;
            
            			if sheet.url==nil or sheet.url=="" then
            				self.downloadButton.visible = false;
            				self.openButton.visible = false;
            			else
            				self.downloadButton.visible = true;
            				self.openButton.visible = true;
            			end;
        end, obj);

    obj._e_event4 = obj.dataLink2:addEventListener("onChange",
        function (_, field, oldValue, newValue)
            if sheet==nil then return end;
            
            			if sheet.enabled then
            				self.removeButton.visible = true;
            			else
            				self.removeButton.visible = false;
            			end;
        end, obj);

    obj._e_event5 = obj.dataLink3:addEventListener("onChange",
        function (_, field, oldValue, newValue)
            if sheet==nil then return end;
            
            			self.pluginName.hint = sheet.description;
            			self.moduleId.hint = sheet.description;
        end, obj);

    obj._e_event6 = obj.dataLink4:addEventListener("onChange",
        function (_, field, oldValue, newValue)
            if sheet==nil then return end;
            
            			self.author.hint = sheet.contact;
        end, obj);

    function obj:_releaseEvents()
        __o_rrpgObjs.removeEventListenerById(self._e_event6);
        __o_rrpgObjs.removeEventListenerById(self._e_event5);
        __o_rrpgObjs.removeEventListenerById(self._e_event4);
        __o_rrpgObjs.removeEventListenerById(self._e_event3);
        __o_rrpgObjs.removeEventListenerById(self._e_event2);
        __o_rrpgObjs.removeEventListenerById(self._e_event1);
        __o_rrpgObjs.removeEventListenerById(self._e_event0);
    end;

    obj._oldLFMDestroy = obj.destroy;

    function obj:destroy() 
        self:_releaseEvents();

        if (self.handle ~= 0) and (self.setNodeDatabase ~= nil) then
          self:setNodeDatabase(nil);
        end;

        if self.dataLink1 ~= nil then self.dataLink1:destroy(); self.dataLink1 = nil; end;
        if self.dataLink3 ~= nil then self.dataLink3:destroy(); self.dataLink3 = nil; end;
        if self.label1 ~= nil then self.label1:destroy(); self.label1 = nil; end;
        if self.author ~= nil then self.author:destroy(); self.author = nil; end;
        if self.image1 ~= nil then self.image1:destroy(); self.image1 = nil; end;
        if self.image2 ~= nil then self.image2:destroy(); self.image2 = nil; end;
        if self.moduleId ~= nil then self.moduleId:destroy(); self.moduleId = nil; end;
        if self.pluginName ~= nil then self.pluginName:destroy(); self.pluginName = nil; end;
        if self.image3 ~= nil then self.image3:destroy(); self.image3 = nil; end;
        if self.dataLink2 ~= nil then self.dataLink2:destroy(); self.dataLink2 = nil; end;
        if self.dataLink4 ~= nil then self.dataLink4:destroy(); self.dataLink4 = nil; end;
        if self.openButton ~= nil then self.openButton:destroy(); self.openButton = nil; end;
        if self.rectangle1 ~= nil then self.rectangle1:destroy(); self.rectangle1 = nil; end;
        if self.downloadButton ~= nil then self.downloadButton:destroy(); self.downloadButton = nil; end;
        if self.removeButton ~= nil then self.removeButton:destroy(); self.removeButton = nil; end;
        if self.label2 ~= nil then self.label2:destroy(); self.label2 = nil; end;
        self:_oldLFMDestroy();
    end;

    obj:endUpdate();

    return obj;
end;

function newfrmInstalledPlugin()
    local retObj = nil;
    __o_rrpgObjs.beginObjectsLoading();

    __o_Utils.tryFinally(
      function()
        retObj = constructNew_frmInstalledPlugin();
      end,
      function()
        __o_rrpgObjs.endObjectsLoading();
      end);

    assert(retObj ~= nil);
    return retObj;
end;

local _frmInstalledPlugin = {
    newEditor = newfrmInstalledPlugin, 
    new = newfrmInstalledPlugin, 
    name = "frmInstalledPlugin", 
    dataType = "", 
    formType = "undefined", 
    formComponentName = "form", 
    title = "", 
    description=""};

frmInstalledPlugin = _frmInstalledPlugin;
Firecast.registrarForm(_frmInstalledPlugin);

return _frmInstalledPlugin;
