oint("TOPLEFT",bar,"TOPLEFT", 0,0)
            self.text:SetPoint("BOTTOMRIGHT",bar,"BOTTOMRIGHT", -10,0)
            self.text:SetFont([[Interface\AddOns\NugComboBar\tex\Emblem.ttf]],15)
        end
        self:SetParent(UIParent)
        -- I don't want to rewrite everything
        -- just to make them siblings
        self:SetScale(NugComboBar:GetScale())
        NugComboBar.SetScale = function(self, scale)
            self.bar:SetScale(scale)
            normalSetScale(NugComboBar, scale)
        end
        self:SetAlpha(NugComboBar:GetAlpha())
        NugComboBar.SetAlpha = function(self, alpha)
            self.bar:SetAlpha(alpha)
            normalSetAlpha(NugComboBar, alpha)
        end

        NugComboBar.Hide = function(self)
            self.bar:Hide()
        end
        NugComboBar.Show = function(self)
            self.bar:Show()
        end
        normalHide(NugComboBar)

        self:ClearAllPoints()
        if IsVertical() then
            self:SetPoint("BOTTOMLEFT", NugComboBar, "BOTTOMLEFT", 3, 5)
        else
            self:SetPoint("TOPLEFT", NugComboBar, "TOPLEFT", 5, -3)
        end
        self.text:Show()
    end
    end --endif intiial


    -- local tb = bar:CreateTexture(nil, "BACKGROUND", nil, 1)
    -- tb:SetWidth(ts.width); tb:SetHeight(ts.height)
    -- tb:SetTexture(ts.texture)
    -- tb:SetTexCoord(unpack(ts.coords))
    -- tb:SetPoint("TOPLEFT", bar, "TOPLEFT", -5, 4)

    bar:Small()
    bar:SetColor(0.6,0,0)
    -- bar.t = tb
    self.bar = bar
    bar:Hide()

    
    return self
end



-- NugComboBar.themes = {}
-- NugComboBar.themes["WARLOCK"] = {
--     [1] = {
--         preset = "glowPurple",
--         colors = {
--             ["normal"] = {0.77,0.26,0.29},
--             ["big"] = {0.77,0.26,0.29},
--             ["bar1"] = { 0.9,0.1,0.1 },
--             ["bar2"] = { .9,0.1,0.4 },
--             ["layer2"] = { 0.80, 0.23, 0.79 },
--         },
--     },
-- }                                       A@545  ?>72>;O5B  B515  70:070BL  :>@?CA  < 0 > : < b r > < 1 > < b r > - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - < b r > "K  <>65HL  2K1@0BL  B@8  20@80=B0  @07<5@0  2  7028A8<>AB8  >B  A2>8E  =C64.   !59G0A  <K  <>65<  873>B>28BL  :>@?CA0: < b r > @07<5@><  < 2 >   8  AB>8<>ABLN  < 3 >   c r . < b r > @07<5@><  < 4 >   8  AB>8<>ABLN  < 5 >   c r . < b r > @07<5@><  < 6 >   8  AB>8<>ABLN  < 7 >   c r . < b r > - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - < b r > C  B0:  GB>,   1@0B0=,   :0:>9  2K18@05HL?   2 2    5H5=85  B2>Q,   < P l a y e r F u l l > ! < b r > AQ  C65  3>B>2>  2  ;CGH5<  2845.   "2>9  =>2K9  :>@?CA  C65  ?K;8BAO  =0  A:;045,   B>;L:>  B51O  8  4>68405BAO. < b r > 0409  B0<  60@C  MB8<  <54=K<  ;10<,   1>O:0<.   %5- E5! !   2 9   @8  B5:CI5<  C@>2=5  @0728B8O  B5E=>;>389  2  30;0:B8:5  <K  <>65<  873>B>28BL  4;O  20A  :>@?CA  < 0 > : < b r > < 1 > < b r > - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - < b r > "K  <>65HL  2K1@0BL  B@8  20@80=B0  @07<5@0  2  7028A8<>AB8  >B  A2>8E  =C64.   !59G0A  <K  <>65<  873>B>28BL  :>@?CA0: < b r > @07<5@><  < 2 > ,   AB>8<>ABLN  < 3 >   =>4>2  8  < 4 >   c r . < b r > @07<5@><  < 5 > ,   AB>8<>ABLN  < 6 >   =>4>2  8  < 7 >   c r . < b r > @07<5@><  < 8 > ,   AB>8<>ABLN  < 9 >   =>4>2  8  < 1 0 >   c r . < b r > - - - - - - - - - - - - - - - - - - - - - - - --[[-----------------------------------------------------------------------------
Heading Widget
-------------------------------------------------------------------------------]]
local Type, Version = "Heading", 20
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end

-- Lua APIs
local pairs = pairs

-- WoW APIs
local CreateFrame, UIParent = CreateFrame, UIParent

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local methods = {
	["OnAcquire"] = function(self)
		self:SetText()
		self:SetFullWidth()
		self:SetHeight(18)
	end,

	-- ["OnRelease"] = nil,

	["SetText"] = function(self, text)
		self.label:SetText(text or "")
		if text and text ~= "" then
			self.left:SetPoint("RIGHT", self.label, "LEFT", -5, 0)
			self.right:Show()
		else
			self.left:SetPoint("RIGHT", -3, 0)
			self.right:Hide()
		end
	end
}

--[[-----------------------------------------------------------------------------
Constructor
-------------------------------------------------------------------------------]]
local function Constructor()
	local frame = CreateFrame("Frame", nil, UIParent)
	frame:Hide()

	local label = frame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
	label:SetPoint("TOP")
	label:SetPoint("BOTTOM")
	label:SetJustifyH("CENTER")

	local left = frame:CreateTexture(nil, "BACKGROUND")
	left:SetHeight(8)
	left:SetPoint("LEFT", 3, 0)
	left:SetPoint("RIGHT", label, "LEFT", -5, 0)
	left:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border")
	left:SetTexCoord(0.81, 0.94, 0.5, 1)

	local right = frame:CreateTexture(nil, "BACKGROUND")
	right:SetHeight(8)
	right:SetPoint("RIGHT", -3, 0)
	right:SetPoint("LEFT", label, "RIGHT", 5, 0)
	right:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border")
	right:SetTexCoord(0.81, 0.94, 0.5, 1)

	local widget = {
		label = label,
		left  = left,
		right = right,
		frame = frame,
		type  = Type
	}
	for method, func in pairs(methods) do
		widget[method] = func
	end

	return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)
                                                                                                                                                                                                                                                                          4.   !59G0A  <K  <>65<  873>B>28BL  :>@?CA0:  
 @07<5@><  < s i z e _ v a r i a t i o n [ 0 ] >   8  AB>8<>ABLN  < c o s t _ v a r i a t i o n [ 0 ] >   c r .  
 @07<5@><  < s i z e _ v a r i a t i o n [ 1 ] >   8  AB>8<>ABLN  < c o s t _ v a r i a t i o n [ 1 ] >   c r .  
 @07<5@><  < s i z e _ v a r i a t i o n [ 2 ] >   8  AB>8<>ABLN  < c o s t _ v a r i a t i o n [ 2 ] >   c r .  
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 C  B0:  GB>,   < N a m e ( P l a y e r ( ) ) > ,   :0:>9  2K18@05HL?   T D i a l o g A n s w e r   8  ����r e s t a r t   ����!;C6C  30;0:B8:5!   T i f   b  
     ����S h i p T y p e ( G e t S h i p R u i n s ( P l a y e r ( ) ) ) = = ' W B '    T i f   �  
     ����S h i p R a n k ( P l a y e r ( ) ) > 2    T i f     ����  ����S h i p R a n k ( P l a y e r ( ) ) = = 4    T o p   \  ����  ����c o u n t = 0 ;  
 w h i l e ( c o u n t < 3 ) {  
  
 t e m p _ h u l l = C r e a t e H u l l ( 2 , 1 0 0 + ( 1 0 0 + 2 0 * c o u n t ) * G a l a x y T e c h L e v e l ( ) , G a l a x y T e c h L e v e l ( ) , 2 ) ;  
 b a s i c _ s i z e _ v a r i a t i o n [ c o u n t ] = I t e m S i z e ( t e m p _ h u l l ) ;  
 i f   ( b o n u s _ t y p e > - 1 ) { S p e c i a l T o E q u i p m e n t ( b o n u s _ t y p e , t e m p _ h u l l ) ; }  
 I t e m C o s t ( t e m p _ h u l l , I t e m C o s t ( t e m p _ INDX( 	 �26            (   �  �                             K-    p Z     J-    ��F0�� �=h���a�f~���F0�� `      UZ              D r a w i n g 1 . d w g       L-    p ^     J-    �4F0��HI��a�f~��4F0�� p      id              D r a w i n g 1 5 5 . b a k   M-    p ^     J-    ��F0����(1���a�f~���F0�� p      �g              D r a w i n g 1 5 5 . d w g   N-    p ^     J-    YF0�� -����a�f~�YF0�� p      �n              D r a w i n g . b a k  O-    p ^     J-    YF0�� -����a�f~�YF0�� p      �o              D r a w i n g . d w g   P-    p ^     J-    o�F0�� -����a�f~�o�F0�� �      u              D r a w i n g . b a k   Q-    p ^     J-    o�F0�� -�����S��f~�o�F0�� �      �w              D r a w i n g . d w g   L-    p Z     J-    �4F0��HI��a�f~��4F0�� p      id              D R A W I N ~ 1 . B A K       M-    p Z     J-    ��F0����(1���a�f~���F0�� p     �g              D R A W I N ~ 1 . D W G       N-    p Z     J-    YF0�� -����a�f~�YF0�� p      �n              D R A W I N ~ 2 . B A K       O-    p Z     J-    YF0�� -����a�f~�YF0�� p      �o              D R A W I N ~ 2 . D W G       P-    p Z     J-    o�F0�� -����a�f~�o�F0�� �      u              D R A W I N ~ 3 . B A K       Q-    p Z     J-    o�F0�� -�����S��f~�o�F0�� �      �w              D R A W I N ~ 3 . D W G       R-    p ^    J-    �F0�� ����!��S��f~��F0�� �      �v              j h c j k l h b j b . b a k   S-    p ^     J-    �F0�� ����!��S��f~��F0�� �      Vw              j h c j k l h b j b . d w g   R-    p Z     J-    �F0�� ����!��S��f~��F0�� �      �v              J H C J K L ~ 1 . B A K       S-    p Z     J-    �F0�� ����!��S��f~��F0�� �      Vw              J H C J K L ~ 1 . D W G       T-    h T     J-    /}F0�� ����!��S��f~�/}F0�� �      x             	O P O R A . d w g     U-    h T     J-    ��F0�� �J����S��f~���F0�� �      ��              	P r i s m . b a k     V-    h T     J-    �?F0�� ��G����S��f~��?F0�� �      c�              	P r i s m . d w g     W-    h T     J-    � F0�� ����"���f~�� F0�� �      l�              	R a m k a . d w g     X-    h X     J-    d"F0�� ���"���f~�d"F0�� 0     �)             S B O R K A 1 . b a k Y-    h X     J-    d"F0�� ���"���f~�d"F0�� �      >�             S B O R K A 1 . d w g Z-    h X     J-    q�$F0�� ���"���f~�q�$F0�� �      �              S B O R K A 2 . b a k [-    h X     J-    ��+F0�� ���"���f~���+F0�� �      ��              S B O R K A 2 . d w g \-    h T     J-    �J.F0�� ���"���f~��J.F0�� �      w�              	S X E M A . b a k     ]-    h T     J-    R�0F0�� ����"���f~�R�0F0�� �      �              	S X E M A . d w g                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                --[[-----------------------------------------------------------------------------
Icon Widget
-------------------------------------------------------------------------------]]
local Type, Version = "Icon", 21
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end

-- Lua APIs
local select, pairs, print = select, pairs, print

-- WoW APIs
local CreateFrame, UIParent, GetBuildInfo = CreateFrame, UIParent, GetBuildInfo

--[[-----------------------------------------------------------------------------
Scripts
-------------------------------------------------------------------------------]]
local function Control_OnEnter(frame)
	frame.obj:Fire("OnEnter")
end

local function Control_OnLeave(frame)
	frame.obj:Fire("OnLeave")
end

local function Button_OnClick(frame, button)
	frame.obj:Fire("OnClick", button)
	AceGUI:ClearFocus()
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local methods = {
	["OnAcquire"] = function(self)
		self:SetHeight(110)
		self:SetWidth(110)
		self:SetLabel()
		self:SetImage(nil)
		self:SetImageSize(64, 64)
		self:SetDisabled(false)
	end,

	-- ["OnRelease"] = nil,

	["SetLabel"] = function(self, text)
		if text and text ~= "" then
			self.label:Show()
			self.label:SetText(text)
			self:SetHeight(self.image:GetHeight() + 25)
		else
			self.label:Hide()
			self:SetHeight(self.image:GetHeight() + 10)
		end
	end,

	["SetImage"] = function(self, path, ...)
		local image = self.image
		image:SetTexture(path)
		
		if image:GetTexture() then
			local n = select("#", ...)
			if n == 4 or n == 8 then
				image:SetTexCoord(...)
			else
				image:SetTexCoord(0, 1, 0, 1)
			end
		end
	end,

	["SetImageSize"] = function(self, width, height)
		self.image:SetWidth(width)
		self.image:SetHeight(height)
		--self.frame:SetWidth(width + 30)
		if self.label:IsShown() then
			self:SetHeight(height + 25)
		else
			self:SetHeight(height + 10)
		end
	end,

	["SetDisabled"] = function(self, disabled)
		self.disabled = disabled
		if disabled then
			self.frame:Disable()
			self.label:SetTextColor(0.5, 0.5, 0.5)
			self.image:SetVertexColor(0.5, 0.5, 0.5, 0.5)
		else
			self.frame:Enable()
			self.label:SetTextColor(1, 1, 1)
			self.image:SetVertexColor(1, 1, 1, 1)
		end
	end
}

--[[-----------------------------------------------------------------------------
Constructor
-------------------------------------------------------------------------------]]
local function Constructor()
	local frame = CreateFrame("Button", nil, UIParent)
	frame:Hide()

	frame:EnableMouse(true)
	frame:SetScript("OnEnter", Control_OnEnter)
	frame:SetScript("OnLeave", Control_OnLeave)
	frame:SetScript("OnClick", Button_OnClick)

	local label = frame:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
	label:SetPoint("BOTTOMLEFT")
	label:SetPoint("BOTTOMRIGHT")
	label:SetJustifyH("CENTER")
	label:SetJustifyV("TOP")
	label:SetHeight(18)

	local image = frame:CreateTexture(nil, "BACKGROUND")
	image:SetWidth(64)
	image:SetHeight(64)
	image:SetPoint("TOP", 0, -5)

	local highlight = frame:CreateTexture(nil, "HIGHLIGHT")
	highlight:SetAllPoints(image)
	highlight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
	highlight:SetTexCoord(0, 1, 0.23, 0.77)
	highlight:SetBlendMode("ADD")

	local widget = {
		label = label,
		image = image,
		frame = frame,
		type  = Type
	}
	for method, func in pairs(methods) do
		widget[method] = func
	end
	-- SetText is deprecated, but keep it around for a while. (say, to WoW 4.0)
	if (select(4, GetBuildInfo()) < 40000) then
		widget.SetText = widget.SetLabel
	else
		widget.SetText = function(self, ...) print("AceGUI-3.0-Icon: SetText is deprecated! Use SetLabel instead!"); self:SetLabel(...) end
	end

	return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ( b o n u s _ t y p e , h u l l _ g i f t ) ; }  
 I t e m C o s t ( h u l l _ g i f t , I t e m C o s t ( h u l l _ g i f t ) / 2 ) ;  
 A d d I t e m T o S t o r a g e ( G e t S h i p R u i n s ( P l a y e r ( ) ) , h u l l _ g i f t ) ;  
 S h i p M o n e y ( P l a y e r ( ) , S h i p M o n e y ( P l a y e r ( ) ) - s e l e c t e d _ c o s t ) ;    T D i a l o g A n s w e r   8  �   r e s t a r t   ����!0<>  A>1>9!   T D i a l o g A n s w e r   �  d     ����< s i z e _ v a r i a t i o n [ 0 ] >   70  < c o s t _ v a r i a t i o n [ 0 ] >   c r .   T D i a l o g A n s w e r   �  �     ����< s i z e _ v a r i a t i o n [ 1 ] >   70  < c o s t _ v a r i a t i o n [ 1 ] >   c r .   T D i a l o g A n s w e r   �  �     ����< s i z e _ v a r i a t i o n [ 2 ] >   70  < c o s t _ v a r i a t i o n [ 2 ] >   c r .   T o p   ,  �     ����b a s i c _ s i z e _ v a r i a t i o n = n e w a r r a y ( 3 ) ;  
 s i z e _ v a r i a t i o n = n e w a r r a y ( 3 ) ;  
 c o s t _ v a r i a t i o n = n e w a r r a y ( 3 ) ;  
 n o d _ c o s t _ v a r i a t i o n = n e w a r r a y ( 3 ) ;   T i f          ����S h i p R a n k ( P l a y e r ( ) ) > 6    T i f     �     ����G e t S h i p P i r a t e R a n k ( P l a y e r ( ) ) = = 7    T o p   4  �     ����b o n u s _ t y p e = F i n d B o n u s B y N a m e ( ' #189F0  V ' )    T o p   4       ����b o n u s _ t y p e = F i n d B o n u s B y N a m e ( ' !:0;0  V ' )    T i f   :      ����G e t S h i p R u i n s ( P l a y e r ( ) ) > 0   T i f   X      ����S h i p T y p e ( G e t S h i p R u i n s ( P l a y e r ( ) ) ) = = ' S B '    T i f   v      ����G a l a x y T e c h L e v e l ( ) > 3    T o p   �      ����b o n u s _ n a m e = " >;84" ;  
 A d d D i a l o g I n j e c t ( ' R B K _ D i a l o g _ S B ' , "   5IQ  <K  <>65<  873>B>28BL  4;O  B51O  ?>4  70:07  M:A?5@8<5=B0;L=K9  :>@?CA  < b o n u s _ n a m e > " , " /  E>GC  70:070BL  :>@?CA" , 1 )    T D i a l o g   �    R B K _ D i a l o g _ S B   ����T i f     �     ����G a l a x y T e c h L e v e l ( ) = = 4    T i f         ����G a l a x y T e c h L e v e l ( ) = = 5    T i f         ����G a l a x y T e c h L e v e l ( ) = = 6    T i f     ,    ����G a l a x y T e c h L e v e l ( ) = = 7    T i f     @    ����G a l a x y T e c h L e v e l ( ) = = 8    T o p   4  �     ����b o n u s _ t y p e = F i n d B o n u s B y N a m e ( ' >;84  I ' )    T o p   4      ����b o n u s _ t y p e = F i n d B o n u s B y N a m e ( ' >;84  I I ' )    T o p   4      ����b o n u s _ t y p e = F i n d B o n u s B y N a m e ( ' >;84  I I I ' )    T o p   4  ,    ����b o n u s _ t y p e = F i n d B o n u s B y N a m e ( ' >;84  I V ' )    T o p   4  @    ����b o n u s _ t y p e = F i n d B o n u s B y N a m e ( ' >;84  V ' )    T o p   R      ����c o u n t = 0 ;  
 w h i l e ( c o u n t < 3 ) {  
  
 t e m p _ h u l l = C r e a t e H u l l ( 2 , 1 0 0 + ( 1 0 0 + 2 0 * c o u n t ) * G a l a x y T e c h L e v e l ( ) , G a l a x y T e c h L e v e l ( ) , 2 ) ;  
 b a s i c _ s i z e _ v a r i a t i o n [ c o u n t ] = I t e m S i z e ( t e m p _ h u l l ) ;  
 i f   ( b o n u s _ t y p e > - 1 ) { S p e c i a l T o E q u i p m e n t ( b o n u s _ t y p e , t e m p _ h u l l ) ; }  
 I t e m C o s t ( t e m p _ h u l l , I t e m C o s t ( t e m p _ h u l l ) / 2 ) ;  
 c o s t _ v a r i a t i o n [ c o u n t ] = I t e m C o s t ( t e m p _ h u l l--[[-----------------------------------------------------------------------------
InteractiveLabel Widget
-------------------------------------------------------------------------------]]
local Type, Version = "InteractiveLabel", 20
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end

-- Lua APIs
local select, pairs = select, pairs

-- WoW APIs
local CreateFrame, UIParent = CreateFrame, UIParent

-- Global vars/functions that we don't upvalue since they might get hooked, or upgraded
-- List them here for Mikk's FindGlobals script
-- GLOBALS: GameFontHighlightSmall

--[[-----------------------------------------------------------------------------
Scripts
-------------------------------------------------------------------------------]]
local function Control_OnEnter(frame)
	frame.obj:Fire("OnEnter")
end

local function Control_OnLeave(frame)
	frame.obj:Fire("OnLeave")
end

local function Label_OnClick(frame, button)
	frame.obj:Fire("OnClick", button)
	AceGUI:ClearFocus()
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local methods = {
	["OnAcquire"] = function(self)
		self:LabelOnAcquire()
		self:SetHighlight()
		self:SetHighlightTexCoord()
		self:SetDisabled(false)
	end,

	-- ["OnRelease"] = nil,

	["SetHighlight"] = function(self, ...)
		self.highlight:SetTexture(...)
	end,

	["SetHighlightTexCoord"] = function(self, ...)
		local c = select("#", ...)
		if c == 4 or c == 8 then
			self.highlight:SetTexCoord(...)
		else
			self.highlight:SetTexCoord(0, 1, 0, 1)
		end
	end,

	["SetDisabled"] = function(self,disabled)
		self.disabled = disabled
		if disabled then
			self.frame:EnableMouse(false)
			self.label:SetTextColor(0.5, 0.5, 0.5)
		else
			self.frame:EnableMouse(true)
			self.label:SetTextColor(1, 1, 1)
		end
	end
}

--[[-----------------------------------------------------------------------------
Constructor
-------------------------------------------------------------------------------]]
local function Constructor()
	-- create a Label type that we will hijack
	local label = AceGUI:Create("Label")

	local frame = label.frame
	frame:EnableMouse(true)
	frame:SetScript("OnEnter", Control_OnEnter)
	frame:SetScript("OnLeave", Control_OnLeave)
	frame:SetScript("OnMouseDown", Label_OnClick)

	local highlight = frame:CreateTexture(nil, "HIGHLIGHT")
	highlight:SetTexture(nil)
	highlight:SetAllPoints()
	highlight:SetBlendMode("ADD")

	label.highlight = highlight
	label.type = Type
	label.LabelOnAcquire = label.OnAcquire
	for method, func in pairs(methods) do
		label[method] = func
	end

	return label
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)

                                                                                                                                                             s t _ v a r i a t i o n [ 1 ] ;    T o p   �  6    ����s e l e c t e d _ s i z e = b a s i c _ s i z e _ v a r i a t i o n [ 2 ] ;  
 s e l e c t e d _ c o s t = c o s t _ v a r i a t i o n [ 2 ] ;  
 s e l e c t e d _ n o d _ c o s t = n o d _ c o s t _ v a r i a t i o n [ 2 ] ;    T D i a l o g M s g   �      ����5AL<0  @07C<=K9  2K1>@,   < N a m e ( P l a y e r ( ) ) > .   >A;54=OO  D>@<0;L=>ABL,   A=OBL  =>4K  A  =>4- AGQB0  8;8  C  20A  A  A>1>9  =C6=>5  :>;8G5AB2>?   T o p   �      ����S o u n d ( ' S o u n d . B u y ' ) ;  
 h u l l _ g i f t = C r e a t e H u l l ( 2 , s e l e c t e d _ s i z e , G a l a x y T e c h L e v e l ( ) , 2 ) ;  
 i f   ( b o n u s _ t y p e > - 1 ) { S p e c i a l T o E q u i p m e n t ( b o n u s _ t y p e , h u l l _ g i f t ) ; }  
 I t e m C o s t ( h u l l _ g i f t , I t e m C o s t ( h u l l _ g i f t ) / 2 ) ;  
 A d d I t e m T o S t o r a g e ( G e t S h i p R u --[[-----------------------------------------------------------------------------
Keybinding Widget
Set Keybindings in the Config UI.
-------------------------------------------------------------------------------]]
local Type, Version = "Keybinding", 24
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end

-- Lua APIs
local pairs = pairs

-- WoW APIs
local IsShiftKeyDown, IsControlKeyDown, IsAltKeyDown = IsShiftKeyDown, IsControlKeyDown, IsAltKeyDown
local CreateFrame, UIParent = CreateFrame, UIParent

-- Global vars/functions that we don't upvalue since they might get hooked, or upgraded
-- List them here for Mikk's FindGlobals script
-- GLOBALS: NOT_BOUND

local wowMoP
do
	local _, _, _, interface = GetBuildInfo()
	wowMoP = (interface >= 50000)
end

--[[-----------------------------------------------------------------------------
Scripts
-------------------------------------------------------------------------------]]

local function Control_OnEnter(frame)
	frame.obj:Fire("OnEnter")
end

local function Control_OnLeave(frame)
	frame.obj:Fire("OnLeave")
end

local function Keybinding_OnClick(frame, button)
	if button == "LeftButton" or button == "RightButton" then
		local self = frame.obj
		if self.waitingForKey then
			frame:EnableKeyboard(false)
			self.msgframe:Hide()
			frame:UnlockHighlight()
			self.waitingForKey = nil
		else
			frame:EnableKeyboard(true)
			self.msgframe:Show()
			frame:LockHighlight()
			self.waitingForKey = true
		end
	end
	AceGUI:ClearFocus()
end

local ignoreKeys = {
	["BUTTON1"] = true, ["BUTTON2"] = true,
	["UNKNOWN"] = true,
	["LSHIFT"] = true, ["LCTRL"] = true, ["LALT"] = true,
	["RSHIFT"] = true, ["RCTRL"] = true, ["RALT"] = true,
}
local function Keybinding_OnKeyDown(frame, key)
	local self = frame.obj
	if self.waitingForKey then
		local keyPressed = key
		if keyPressed == "ESCAPE" then
			keyPressed = ""
		else
			if ignoreKeys[keyPressed] then return end
			if IsShiftKeyDown() then
				keyPressed = "SHIFT-"..keyPressed
			end
			if IsControlKeyDown() then
				keyPressed = "CTRL-"..keyPressed
			end
			if IsAltKeyDown() then
				keyPressed = "ALT-"..keyPressed
			end
		end

		frame:EnableKeyboard(false)
		self.msgframe:Hide()
		frame:UnlockHighlight()
		self.waitingForKey = nil

		if not self.disabled then
			self:SetKey(keyPressed)
			self:Fire("OnKeyChanged", keyPressed)
		end
	end
end

local function Keybinding_OnMouseDown(frame, button)
	if button == "LeftButton" or button == "RightButton" then
		return
	elseif button == "MiddleButton" then
		button = "BUTTON3"
	elseif button == "Button4" then
		button = "BUTTON4"
	elseif button == "Button5" then
		button = "BUTTON5"
	end
	Keybinding_OnKeyDown(frame, button)
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local methods = {
	["OnAcquire"] = function(self)
		self:SetWidth(200)
		self:SetLabel("")
		self:SetKey("")
		self.waitingForKey = nil
		self.msgframe:Hide()
		self:SetDisabled(false)
		self.button:EnableKeyboard(false)
	end,

	-- ["OnRelease"] = nil,

	["SetDisabled"] = function(self, disabled)
		self.disabled = disabled
		if disabled then
			self.button:Disable()
			self.label:SetTextColor(0.5,0.5,0.5)
		else
			self.button:Enable()
			self.label:SetTextColor(1,1,1)
		end
	end,

	["SetKey"] = function(self, key)
		if (key or "") == "" then
			self.button:SetText(NOT_BOUND)
			self.button:SetNormalFontObject("GameFontNormal")
		else
			self.button:SetText(key)
			self.button:SetNormalFontObject("GameFontHighlight")
		end
	end,

	["GetKey"] = function(self)
		local key = self.button:GetText()
		if key == NOT_BOUND then
			key = nil
		end
		return key
	end,

	["SetLabel"] = function(self, label)
		self.label:SetText(label or "")
		if (label or "") == "" then
			self.alignoffset = nil
			self:SetHeight(24)
		else
			self.alignoffset = 30
			self:SetHeight(44)
		end
	end,
}

--[[-----------------------------------------------------------------------------
Constructor
-------------------------------------------------------------------------------]]

local ControlBackdrop  = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
}

local function keybindingMsgFixWidth(frame)
	frame:SetWidth(frame.msg:GetWidth() + 10)
	frame:SetScript("OnUpdate", nil)
end

local function Constructor()
	local name = "AceGUI30KeybindingButton" .. AceGUI:GetNextWidgetNum(Type)

	local frame = CreateFrame("Frame", nil, UIParent)
	local button = CreateFrame("Button", name, frame, wowMoP and "UIPanelButtonTemplate" or "UIPanelButtonTemplate2")

	button:EnableMouse(true)
	button:RegisterForClicks("AnyDown")
	button:SetScript("OnEnter", Control_OnEnter)
	button:SetScript("OnLeave", Control_OnLeave)
	button:SetScript("OnClick", Keybinding_OnClick)
	button:SetScript("OnKeyDown", Keybinding_OnKeyDown)
	button:SetScript("OnMouseDown", Keybinding_OnMouseDown)
	button:SetPoint("BOTTOMLEFT")
	button:SetPoint("BOTTOMRIGHT")
	button:SetHeight(24)
	button:EnableKeyboard(false)

	local text = button:GetFontString()
	text:SetPoint("LEFT", 7, 0)
	text:SetPoint("RIGHT", -7, 0)

	local label = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	label:SetPoint("TOPLEFT")
	label:SetPoint("TOPRIGHT")
	label:SetJustifyH("CENTER")
	label:SetHeight(18)

	local msgframe = CreateFrame("Frame", nil, UIParent)
	msgframe:SetHeight(30)
	msgframe:SetBackdrop(ControlBackdrop)
	msgframe:SetBackdropColor(0,0,0)
	msgframe:SetFrameStrata("FULLSCREEN_DIALOG")
	msgframe:SetFrameLevel(1000)
	msgframe:SetToplevel(true)

	local msg = msgframe:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	msg:SetText("Press a key to bind, ESC to clear the binding or click the button again to cancel.")
	msgframe.msg = msg
	msg:SetPoint("TOPLEFT", 5, -5)
	msgframe:SetScript("OnUpdate", keybindingMsgFixWidth)
	msgframe:SetPoint("BOTTOM", button, "TOP")
	msgframe:Hide()

	local widget = {
		button      = button,
		label       = label,
		msgframe    = msgframe,
		frame       = frame,
		alignoffset = 30,
		type        = Type
	}
	for method, func in pairs(methods) do
		widget[method] = func
	end
	button.obj = widget

	return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)
                                                                                                                                                                                                  