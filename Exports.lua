 --[[  <!-- sourceC.lua -->
    
    <export function="getGuiHoverElement" type="client" />
    <export function="setLineWidth" type="client" />
    <export function="drawGuiElementWithChildren" type="client" />
    <export function="moveInputCursorBack" type="client" />
    <export function="showTooltip" type="client" />
    <export function="getClickArgument" type="client" />
    <export function="setInventoryPosition" type="client" />
    <export function="getTitleBarHeight" type="client" />
    <export function="getDDSPreview" type="client" />
    <export function="convertSizeToP2" type="client" />
    <export function="playUISound" type="client" />
    <export function="setGuiFontScheme" type="client" />
    <export function="setGuiColorScheme" type="client" />
    <export function="getColorHex" type="client" />
    <export function="getColorCode" type="client" />
    <export function="setElementColorTableToData" type="client" />
    <export function="getColorSetCodeToColor" type="client" />
    <export function="getColorCodeToColor" type="client" />
    <export function="setElementColorToData" type="client" />
    <export function="getColorCodeHex" type="client" />
    <export function="getGradientTick" type="client" />
    <export function="getGradientFilename" type="client" />
    <export function="getGradient2Filename" type="client" />
    <export function="getGradient3Filename" type="client" />
    <export function="getGradient4Filename" type="client" />
    <export function="cacheGradient" type="client" />
    <export function="setCursorType" type="client" />
    <export function="setGuiParent" type="client" />
    <export function="getGuiParent" type="client" />
    <export function="getGuiPosition" type="client" />
    <export function="isGuiRenderDisabled" type="client" />
    <export function="setGuiRenderDisabled" type="client" />
    <export function="getGuiRealPosition" type="client" />
    <export function="setGuiPosition" type="client" />
    <export function="setGuiPositionAnimated" type="client" />
    <export function="getGuiSize" type="client" />
    <export function="setGuiSize" type="client" />
    <export function="setGuiSizeAnimated" type="client" />
    <export function="createGuiElement" type="client" />
    <export function="deleteAllChildren" type="client" />
    <export function="setDeleteEvent" type="client" />
    <export function="deleteGuiElement" type="client" />
    <export function="setElementGradientToData" type="client" />
    <export function="setGuiBackground" type="client" />
    <export function="setGuiHover" type="client" />
    <export function="setImageCrop" type="client" />
    <export function="setImageUV" type="client" />
    <export function="setImageDDS" type="client" />
    <export function="resetImageDDS" type="client" />
    <export function="setImageShadow" type="client" />
    <export function="setImageFile" type="client" />
    <export function="setImageRotation" type="client" />
    <export function="setImageSpinner" type="client" />
    <export function="setImageFadeHover" type="client" />
    <export function="setImageColor" type="client" />
    <export function="setImageFadeHoverBase" type="client" />
    <export function="setGuiHoverable" type="client" />
    <export function="getGuiHoverable" type="client" />
    <export function="setGuiBoundingBox" type="client" />
    <export function="setImageRightCornerHover" type="client" />
    <export function="setGuiHrColor" type="client" />
    <export function="fadeIn" type="client" />
    <export function="fadeOut" type="client" />
    <export function="showInfobox" type="client" />
    <export function="showInfobox" type="server" />
    <export function="showLoadingScreen" type="client" />
    <export function="setDDSPreview" type="client" />
    <export function="thousandsStepper" type="client" />
    <export function="thousandsStepper" type="server" />
    <export function="guiToBack" type="client" />
    <export function="guiToFront" type="client" />
    <export function="isGuiElementValid" type="client" />
    <export function="guiSetTooltip" type="client" />
    <export function="setTexturePreview" type="client" />
    <export function="guiSetTooltipImage" type="client" />
    <export function="guiSetTooltipImageDDS" type="client" />
    <export function="guiSetPositionAbsolute" type="client" />
    <export function="setElementDisabled" type="client" />
    <export function="setHoverEvent" type="client" />
    <export function="setClickSound" type="client" />
    <export function="setDisableClickSound" type="client" />
    <export function="setClickArgument" type="client" />
    <export function="setClickEvent" type="client" />
    <export function="disableClickTrough" type="client" />
    <export function="formatDate" type="client" />
    <export function="updateScreenSourceBefore" type="client" />
    <export function="lockHover" type="client" />
    <export function="disableLinkCursor" type="client" />
    <export function="setColorSet" type="client" />
    <export function="getColorSet" type="client" />
    <export function="getColorsForPreview" type="client" />
    <export function="getColorsForPreviewEx" type="client" />
    <export function="getColorSetName" type="client" />
    <export function="getColorSetsCount" type="client" />
    <export function="getInfoboxChatbox" type="client" />
    <export function="setInfoboxChatbox" type="client" />
    <export function="getInfoboxSound" type="client" />
    <export function="setInfoboxSound" type="client" />
    <export function="getLoadingScreen" type="client" />
    <export function="setRefreshColors" type="client" />
    <export function="getTogCursorKey" type="client" />
    <export function="setTogCursorKey" type="client" />
    <export function="setRadarCoords" type="client" />
    <export function="getColorCodeToColor" type="client" /> --]]

function getGuiHoverElement()
  return hoverElement
end

function setLineWidth(el, width)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "line" then
      guiElements[el].lineWidth = width
    else
      throwGuiError("setLineWidth: guiElement is not line")
    end
  else
    throwGuiError("setLineWidth: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function drawGuiElementWithChildren(el, x, y, secondLevel)
  if tonumber(el) and guiElements[el] then
    for k = 1, #guiElements[el].children do
      if guiElements[el].children[k] and guiElements[guiElements[el].children[k]] then
        drawGuiElementWithChildren(guiElements[el].children[k], x, y, true)
      end
    end
    toDraw[el] = true
    if not secondLevel then
      for k = 1, #renderList do
        if renderList[k] then
          local el = renderList[k]
          if not guiElements[el].disableRender and toDraw[el] then
            local xWas = guiElements[el].x
            local yWas = guiElements[el].y
            if x or y then
              guiElements[el].x = xWas + (x or 0)
              guiElements[el].y = yWas + (y or 0)
            end
            if guiElements[el].updateScreenSource then
              dxUpdateScreenSource(guiElements[el].updateScreenSource, guiElements[el].updateScreenSourceResample)
            end
            if renderFunctions[guiElements[el].type] then
              renderFunctions[guiElements[el].type](el)
            else
              renderBackground(el)
            end
            if x or y then
              guiElements[el].x = xWas
              guiElements[el].y = yWas
            end
          end
        end
      end
      toDraw = {}
    end
  else
    throwGuiError("drawGuiElementWithChildren: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function moveInputCursorBack(el)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      if guiElements[el].value then
        guiElements[activeInput].cursorPosition = utf8.len(guiElements[activeInput].value)
      end
    else
      throwGuiError("moveInputCursorBack: guiElement is not input")
    end
  else
    throwGuiError("moveInputCursorBack: invalid guiElement")
  end
end

function showTooltip(text, x, y)
  tooltipText = text
  tooltipImage = false
  tooltipPosX = x or "right"
  tooltipPosY = y or "down"
end

function getClickArgument(el)
  if tonumber(el) and guiElements[el] then
    return guiElements[el].clickArg
  else
    throwGuiError("setClickEvent: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setInventoryPosition(x, y, sizeX, sizeY)
  inventoryX = x
  inventoryY = y
  inventorySizeX = sizeX
  inventorySizeY = sizeY
end

function getTitleBarHeight()
  return titleBarHeight
end

function getDDSPreview()
  if ddsPreviewTexture then
    return ddsPreviewTexture
  else
    return ddsPreviewFile, ddsPreviewFormat, ddsPreviewMip, ddsPreviewLatent
  end
end

function convertSizeToP2(size)
  if not size then
  end
  if 256 <= size then
    return math.ceil(size)
  else
    for i = 0, 8 do
      local p2 = math.pow(2, i)
      if size <= p2 then
        return p2
      end
    end
  end
end

function playUISound(f)
  if f == "click" then
    f = "click" .. math.random(1, 3)
  end
  local s = playSound("sounds/" .. f .. ".wav")
  setSoundVolume(s, 1)
end

function setGuiFontScheme(el, scheme)
  if tonumber(el) and guiElements[el] then
    if fontSchemes[guiElements[el].type] then
      scheme = scheme or "normal"
      if fontSchemes[guiElements[el].type][scheme] then
        if guiElements[el].type == "input" then
          setInputFont(el, fontSchemes[guiElements[el].type][scheme])
        elseif guiElements[el].type == "button" then
          setButtonFont(el, fontSchemes[guiElements[el].type][scheme])
        elseif guiElements[el].type == "label" then
          setLabelFont(el, fontSchemes[guiElements[el].type][scheme])
        elseif guiElements[el].type == "checkbox" then
          setCheckboxFont(el, fontSchemes[guiElements[el].type][scheme])
        end
      else
        throwGuiError("setGuiFontScheme: invalid fontscheme (" .. tostring(scheme) .. ")")
      end
    end
  else
    throwGuiError("setGuiFontScheme: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setGuiColorScheme(el, scheme)
  if tonumber(el) and guiElements[el] then
    if colorSchemes[guiElements[el].type] then
      if not scheme then
        if colorSchemes[guiElements[el].type].default then
          scheme = "default"
        else
          for k in pairs(colorSchemes[guiElements[el].type]) do
            scheme = k
            break
          end
        end
      end
      if colorSchemes[guiElements[el].type][scheme] then
        if guiElements[el].type == "checkbox" then
          setCheckboxColor(el, colorSchemes[guiElements[el].type][scheme][1], colorSchemes[guiElements[el].type][scheme][2], colorSchemes[guiElements[el].type][scheme][3], colorSchemes[guiElements[el].type][scheme][4])
        elseif guiElements[el].type == "slider" then
          setSliderColor(el, colorSchemes[guiElements[el].type][scheme][1], colorSchemes[guiElements[el].type][scheme][2])
        elseif guiElements[el].type == "toggle" then
          setToggleColor(el, colorSchemes[guiElements[el].type][scheme][1], colorSchemes[guiElements[el].type][scheme][2], colorSchemes[guiElements[el].type][scheme][3])
        elseif guiElements[el].type == "input" then
          setInputColor(el, colorSchemes[guiElements[el].type][scheme][1], colorSchemes[guiElements[el].type][scheme][2], colorSchemes[guiElements[el].type][scheme][3], colorSchemes[guiElements[el].type][scheme][4], colorSchemes[guiElements[el].type][scheme][5])
        elseif guiElements[el].type == "button" then
          setGuiBackground(el, colorSchemes[guiElements[el].type][scheme][1][1], colorSchemes[guiElements[el].type][scheme][1][2])
          setGuiHover(el, colorSchemes[guiElements[el].type][scheme][2][1], colorSchemes[guiElements[el].type][scheme][2][2])
          setButtonTextColor(el, colorSchemes[guiElements[el].type][scheme][3])
        else
          setGuiBackground(el, colorSchemes[guiElements[el].type][scheme][1][1], colorSchemes[guiElements[el].type][scheme][1][2])
          if colorSchemes[guiElements[el].type][scheme][2] then
            setGuiHover(el, colorSchemes[guiElements[el].type][scheme][2][1], colorSchemes[guiElements[el].type][scheme][2][2])
          end
        end
      else
        throwGuiError("setGuiColorScheme: invalid colorscheme (" .. tostring(scheme) .. ")")
      end
    end
  else
    throwGuiError("setGuiColorScheme: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function getColorHex(color)
  if colorHexCache[color] then
    return colorHexCache[color]
  end
  local r, g, b, a = getColorFromString(color)
  colorHexCache[color] = {
    r,
    g,
    b,
    a
  }
  return colorHexCache[color]
end

function getColorCode(color)
  if type(color) == "string" then
    if color:sub(1, 1) == "#" then
      return getColorHex(color)
    else
      return colors[color]
    end
  else
    return color
  end
end

function setElementColorTableToData(el, data, color)
  guiElements[el].toColorTableCache[data] = nil
  if type(color) == "string" then
    if color:sub(1, 1) == "#" then
      guiElements[el][data] = getColorHex(color)
    else
      guiElements[el].toColorTableCache[data] = color
      guiElements[el][data] = colors[color]
    end
  elseif type(color) == "table" then
    guiElements[el][data] = color
  end
end

function getColorSetCodeToColor(color, set)
  if type(color) == "string" then
    if color:sub(1, 1) == "#" then
      return getColorHex(color)
    else
      return tocolor(colorSets[set][color][1], colorSets[set][color][2], colorSets[set][color][3], colorSets[set][color][4])
    end
  elseif type(color) == "table" then
    return tocolor(color[1], color[2], color[3], color[4])
  else
    return color
  end
end

function getColorCodeToColor(color)
  if type(color) == "string" then
    if color:sub(1, 1) == "#" then
      local color = getColorHex(color)
      return tocolor(color[1], color[2], color[3], color[4])
    else
      return colorsToColor[color]
    end
  elseif type(color) == "table" then
    return tocolor(color[1], color[2], color[3], color[4])
  else
    return color
  end
end

function setElementColorToData(el, data, color)
  guiElements[el].toColorCache[data] = nil
  if type(color) == "string" then
    if color:sub(1, 1) == "#" then
      local color = getColorHex(color)
      guiElements[el][data] = tocolor(color[1], color[2], color[3], color[4])
    else
      guiElements[el].toColorCache[data] = color
      guiElements[el][data] = colorsToColor[color]
    end
  elseif type(color) == "table" then
    guiElements[el][data] = tocolor(color[1], color[2], color[3], color[4])
  end
end

function getColorCodeHex(color)
  local rgb = getColorCode(color)
  if rgb then
    rgb = rgb[1] * 65536 + rgb[2] * 256 + rgb[3]
    local hex = string.format("%x", rgb)
    for i = utf8.len(hex) + 1, 6 do
      hex = "0" .. hex
    end
    return "#" .. hex
  end
end

function getGradientTick()
  return gradientTick
end

local gTick = 0
function getGradientFilename(sizeX, sizeY, fromColor, toColor, force)
  sizeX = convertSizeToP2(sizeX)
  sizeY = convertSizeToP2(sizeY)
  local fileName = "gradients/" .. sizeX .. "-" .. sizeY .. "-" .. table.concat(fromColor, "-") .. "-" .. table.concat(toColor, "-") .. ".png"
  if force and gradientTick[fileName] and fileExists(fileName .. "." .. gradientTick[fileName]) then
    fileDelete(fileName .. "." .. gradientTick[fileName])
  end
  if not (not force and gradientTick[fileName]) or not fileExists(fileName .. "." .. gradientTick[fileName]) then
    gTick = gTick + 1
    gradientTick[fileName] = gTick
    doRefreshGradTicks = true
    if fileExists(fileName .. "." .. gradientTick[fileName]) then
      fileDelete(fileName .. "." .. gradientTick[fileName])
    end
    local rt = dxCreateRenderTarget(sizeX, sizeY)
    if not isElement(rt) then
      table.insert(gradientToRestore, {
        sizeX,
        sizeY,
        fromColor,
        toColor
      })
      throwGuiError("getGradientFilename: failed grad! (no rt)")
      return fileName
    end
    dxSetRenderTarget(rt, true)
    dxSetBlendMode("modulate_add")
    for x = 0, sizeX do
      for y = 0, sizeY do
        local r, g, b = interpolateBetween(fromColor[1], fromColor[2], fromColor[3], toColor[1], toColor[2], toColor[3], (x / sizeX + y / sizeY) / 2, "Linear")
        dxDrawRectangle(x, y, 1, 1, tocolor(r, g, b))
      end
    end
    dxSetBlendMode("blend")
    dxSetRenderTarget()
    local pixels = dxGetTexturePixels(rt)
    destroyElement(rt)
    if not pixels then
      table.insert(gradientToRestore, {
        sizeX,
        sizeY,
        fromColor,
        toColor
      })
      throwGuiError("getGradientFilename: failed grad! (1)")
    else
      local r, g, b = dxGetPixelColor(pixels, 0, 0)
      local r2, g2, b2 = dxGetPixelColor(pixels, math.floor(sizeX / 2), math.floor(sizeY / 2))
      local r3, g3, b3 = dxGetPixelColor(pixels, sizeX - 1, sizeY - 1)
      if tonumber(r + g + b + r2 + g2 + b2 + r3 + b3 + g3) == 0 then
        table.insert(gradientToRestore, {
          sizeX,
          sizeY,
          fromColor,
          toColor
        })
        throwGuiError("getGradientFilename: failed grad! (2)")
      end
      pixels = dxConvertPixels(pixels, "png")
      local fh = fileCreate(fileName .. "." .. gradientTick[fileName])
      writeFileList(fileName .. "." .. gradientTick[fileName])
      fileWrite(fh, pixels)
      fileClose(fh)
      pixels = nil
      collectgarbage("collect")
    end
  end
  if not gradientList[fileName] then
    gradientList[fileName] = true
  end
  return fileName
end

function getGradient2Filename(sizeX, sizeY, fromColor, toColor, force)
  sizeX = convertSizeToP2(sizeX)
  sizeY = convertSizeToP2(sizeY)
  local sizeX = math.ceil(sizeX)
  local sizeY = math.ceil(sizeY)
  local fileName = "gradients2/" .. sizeX .. "-" .. sizeY .. "-" .. table.concat(fromColor, "-") .. "-" .. table.concat(toColor, "-") .. ".png"
  if force and gradientTick[fileName] and fileExists(fileName .. "." .. gradientTick[fileName]) then
    fileDelete(fileName .. "." .. gradientTick[fileName])
  end
  if not (not force and gradientTick[fileName]) or not fileExists(fileName .. "." .. gradientTick[fileName]) then
    gTick = gTick + 1
    gradientTick[fileName] = gTick
    doRefreshGradTicks = true
    if fileExists(fileName .. "." .. gradientTick[fileName]) then
      fileDelete(fileName .. "." .. gradientTick[fileName])
    end
    local rt = dxCreateRenderTarget(sizeX, sizeY)
    if not isElement(rt) then
      table.insert(gradient2ToRestore, {
        sizeX,
        sizeY,
        fromColor,
        toColor
      })
      throwGuiError("getGradient2Filename: failed grad! (no rt)")
      return fileName
    end
    dxSetRenderTarget(rt, true)
    dxSetBlendMode("modulate_add")
    for x = 0, sizeX do
      local progress = x / sizeX
      local r, g, b = fromColor[1], fromColor[2], fromColor[3]
      if 0.5 < progress then
        r, g, b = interpolateBetween(fromColor[1], fromColor[2], fromColor[3], toColor[1], toColor[2], toColor[3], (progress - 0.5) * 2, "Linear")
      else
        r, g, b = interpolateBetween(toColor[1], toColor[2], toColor[3], fromColor[1], fromColor[2], fromColor[3], progress * 2, "Linear")
      end
      dxDrawRectangle(x, 0, 1, sizeY, tocolor(r, g, b))
    end
    dxSetBlendMode("blend")
    dxSetRenderTarget()
    local pixels = dxGetTexturePixels(rt)
    destroyElement(rt)
    if not pixels then
      table.insert(gradient2ToRestore, {
        sizeX,
        sizeY,
        fromColor,
        toColor
      })
      throwGuiError("getGradient2Filename: failed grad! (1)")
    else
      local r, g, b = dxGetPixelColor(pixels, 0, 0)
      local r2, g2, b2 = dxGetPixelColor(pixels, math.floor(sizeX / 2), math.floor(sizeY / 2))
      local r3, g3, b3 = dxGetPixelColor(pixels, sizeX - 1, sizeY - 1)
      if tonumber(r + g + b + r2 + g2 + b2 + r3 + b3 + g3) == 0 then
        table.insert(gradient2ToRestore, {
          sizeX,
          sizeY,
          fromColor,
          toColor
        })
        throwGuiError("getGradient2Filename: failed grad! (2)")
      end
      pixels = dxConvertPixels(pixels, "png")
      local fh = fileCreate(fileName .. "." .. gradientTick[fileName])
      writeFileList(fileName .. "." .. gradientTick[fileName])
      fileWrite(fh, pixels)
      fileClose(fh)
      pixels = nil
      collectgarbage("collect")
    end
  end
  if not gradientList[fileName] then
    gradientList[fileName] = true
  end
  return fileName
end

function getGradient3Filename(sizeX, sizeY, fromColor, toColor, force)
  sizeX = convertSizeToP2(sizeX)
  sizeY = convertSizeToP2(sizeY)
  local fileName = "gradients3/" .. sizeX .. "-" .. sizeY .. "-" .. table.concat(fromColor, "-") .. "-" .. table.concat(toColor, "-") .. ".png"
  if force and gradientTick[fileName] and fileExists(fileName .. "." .. gradientTick[fileName]) then
    fileDelete(fileName .. "." .. gradientTick[fileName])
  end
  if not (not force and gradientTick[fileName]) or not fileExists(fileName .. "." .. gradientTick[fileName]) then
    gTick = gTick + 1
    gradientTick[fileName] = gTick
    doRefreshGradTicks = true
    if fileExists(fileName .. "." .. gradientTick[fileName]) then
      fileDelete(fileName .. "." .. gradientTick[fileName])
    end
    local rt = dxCreateRenderTarget(sizeX, sizeY)
    if not isElement(rt) then
      table.insert(gradient3ToRestore, {
        sizeX,
        sizeY,
        fromColor,
        toColor
      })
      throwGuiError("getGradient3Filename: failed grad! (no rt)")
      return fileName
    end
    dxSetRenderTarget(rt, true)
    dxSetBlendMode("modulate_add")
    for x = 1, sizeX do
      local progress = x / sizeX
      local r, g, b = fromColor[1], fromColor[2], fromColor[3]
      r, g, b = interpolateBetween(fromColor[1], fromColor[2], fromColor[3], toColor[1], toColor[2], toColor[3], progress, "Linear")
      dxDrawRectangle(x - 1, 0, 1, sizeY, tocolor(r, g, b))
    end
    dxSetBlendMode("blend")
    dxSetRenderTarget()
    local pixels = dxGetTexturePixels(rt)
    destroyElement(rt)
    if not pixels then
      table.insert(gradient3ToRestore, {
        sizeX,
        sizeY,
        fromColor,
        toColor
      })
      throwGuiError("getGradient3Filename: failed grad! (1)")
    else
      local r, g, b = dxGetPixelColor(pixels, 0, 0)
      local r2, g2, b2 = dxGetPixelColor(pixels, math.floor(sizeX / 2), math.floor(sizeY / 2))
      local r3, g3, b3 = dxGetPixelColor(pixels, sizeX - 1, sizeY - 1)
      if tonumber(r + g + b + r2 + g2 + b2 + r3 + b3 + g3) == 0 then
        table.insert(gradient3ToRestore, {
          sizeX,
          sizeY,
          fromColor,
          toColor
        })
        throwGuiError("getGradient3Filename: failed grad! (2)")
      end
      pixels = dxConvertPixels(pixels, "png")
      local fh = fileCreate(fileName .. "." .. gradientTick[fileName])
      writeFileList(fileName .. "." .. gradientTick[fileName])
      fileWrite(fh, pixels)
      fileClose(fh)
      pixels = nil
      collectgarbage("collect")
    end
  end
  if not gradientList[fileName] then
    gradientList[fileName] = true
  end
  return fileName
end

function getGradient4Filename(sizeX, sizeY, fromColor, force)
  sizeX = convertSizeToP2(sizeX)
  sizeY = convertSizeToP2(sizeY)
  local fileName = "gradients4/" .. sizeX .. "-" .. sizeY .. "-" .. table.concat(fromColor, "-") .. ".png"
  if force and gradientTick[fileName] and fileExists(fileName .. "." .. gradientTick[fileName]) then
    fileDelete(fileName .. "." .. gradientTick[fileName])
  end
  if not (not force and gradientTick[fileName]) or not fileExists(fileName .. "." .. gradientTick[fileName]) then
    gTick = gTick + 1
    gradientTick[fileName] = gTick
    doRefreshGradTicks = true
    if fileExists(fileName .. "." .. gradientTick[fileName]) then
      fileDelete(fileName .. "." .. gradientTick[fileName])
    end
    local rt = dxCreateRenderTarget(sizeX, sizeY, true)
    if not isElement(rt) then
      table.insert(gradient4ToRestore, {
        sizeX,
        sizeY,
        fromColor
      })
      throwGuiError("getGradient4Filename: failed grad! (no rt)")
      return fileName
    end
    dxSetRenderTarget(rt, true)
    dxSetBlendMode("modulate_add")
    for y = 1, sizeY do
      local progress = y / sizeY
      dxDrawRectangle(0, y - 1, sizeX, 1, tocolor(fromColor[1], fromColor[2], fromColor[3], progress * 255))
    end
    dxSetBlendMode("blend")
    dxSetRenderTarget()
    local pixels = dxGetTexturePixels(rt)
    destroyElement(rt)
    if not pixels then
      table.insert(gradient4ToRestore, {
        sizeX,
        sizeY,
        fromColor
      })
      throwGuiError("getGradient4Filename: failed grad 1!")
    else
      local r, g, b = dxGetPixelColor(pixels, 0, 0)
      local r2, g2, b2 = dxGetPixelColor(pixels, math.floor(sizeX / 2), math.floor(sizeY / 2))
      local r3, g3, b3 = dxGetPixelColor(pixels, sizeX - 1, sizeY - 1)
      if tonumber(r + g + b + r2 + g2 + b2 + r3 + b3 + g3) == 0 then
        table.insert(gradient4ToRestore, {
          sizeX,
          sizeY,
          fromColor
        })
        throwGuiError("getGradient4Filename: failed grad 2!")
      end
      pixels = dxConvertPixels(pixels, "png")
      local fh = fileCreate(fileName .. "." .. gradientTick[fileName])
      writeFileList(fileName .. "." .. gradientTick[fileName])
      fileWrite(fh, pixels)
      fileClose(fh)
      pixels = nil
      collectgarbage("collect")
    end
  end
  if not gradientList[fileName] then
    gradientList[fileName] = true
  end
  return fileName
end

function cacheGradient(sx, sy, color)
  for k = 1, #colorSets do
    local color1 = false
    if colorSets[k][color[1]] then
      color1 = colorSets[k][color[1]]
    else
      color1 = getColorCode(color[1])
    end
    local color2 = false
    if colorSets[k][color[2]] then
      color2 = colorSets[k][color[2]]
    else
      color2 = getColorCode(color[2])
    end
    if color[3] == "3rd" then
      getGradient3Filename(sx, sy, color1, color2)
    elseif color[3] then
      getGradient2Filename(sx, sy, color1, color2)
    else
      getGradientFilename(sx, sy, color1, color2)
    end
  end
end

function setCursorType(theType)
  cursorTexturesDelete[cursorType] = now + 3000
  cursorType = theType
  cursorTexturesDelete[cursorType] = nil
  if not isElement(cursorTextures[cursorType]) and cursorType ~= "none" then
    cursorTextures[cursorType] = dxCreateTexture("cursor/" .. cursorType .. ".dds")
  end
end

function setGuiParent(el, parent)
  if el == "last" then
    el = lastGuiElement
  end
  if tonumber(el) and guiElements[el] then
    if el == parent then
      throwGuiError("setGuiParent: parent same as element")
    else
      local parentEl = guiElements[el].parent
      if parentEl then
        if tonumber(parentEl) and guiElements[parentEl] then
          for k = 1, #guiElements[parentEl].children do
            if guiElements[parentEl].children[k] == el then
              table.remove(guiElements[parentEl].children, k)
              break
            end
          end
        end
        guiElements[el].parent = false
      end
      if tonumber(parent) and guiElements[parent] then
        guiElements[el].parent = parent
        table.insert(guiElements[parent].children, el)
      end
    end
  else
    throwGuiError("setGuiParent: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function getGuiParent(el)
  if el == "last" then
    el = lastGuiElement
  end
  if tonumber(el) and guiElements[el] then
    return guiElements[el].parent
  else
    throwGuiError("getGuiParent: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function getGuiPosition(el, dimension)
  if el == "last" then
    el = lastGuiElement
  end
  if tonumber(el) and guiElements[el] then
    local x, y = guiElements[el].x, guiElements[el].y
    local parentEl = guiElements[el].parent
    if parentEl then
      x = x - guiElements[parentEl].x
      y = y - guiElements[parentEl].y
    end
    if dimension == "x" then
      return x
    elseif dimension == "y" then
      return y
    else
      return x, y
    end
  else
    throwGuiError("getGuiPosition: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function isGuiRenderDisabled(el, state)
  if el == "last" then
    el = lastGuiElement
  end
  if tonumber(el) and guiElements[el] then
    return guiElements[el].disableRender
  else
    throwGuiError("isGuiRenderDisabled: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setGuiRenderDisabled(el, state, childrenToo)
  if el == "last" then
    el = lastGuiElement
  end
  if tonumber(el) and guiElements[el] then
    guiElements[el].disableRender = state
    if childrenToo then
      for k = 1, #guiElements[el].children do
        local child = guiElements[el].children[k]
        setGuiRenderDisabled(child, state, true)
      end
    end
  else
    throwGuiError("setGuiRenderDisabled: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function getGuiRealPosition(el, dimension)
  if el == "last" then
    el = lastGuiElement
  end
  if tonumber(el) and guiElements[el] then
    if dimension == "x" then
      return guiElements[el].x
    elseif dimension == "y" then
      return guiElements[el].y
    else
      return guiElements[el].x, guiElements[el].y
    end
  else
    throwGuiError("getGuiRealPosition: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setGuiPosition(el, x, y, absolute, excludeChildren)
  if el == "last" then
    el = lastGuiElement
  end
  if tonumber(el) and guiElements[el] then
    local parentEl = guiElements[el].parent
    local lastX = guiElements[el].x
    local lastY = guiElements[el].y
    if not tonumber(x) then
      x = guiElements[el].x
    elseif parentEl and not absolute then
      guiElements[el].x = guiElements[parentEl].x + x
    else
      guiElements[el].x = x
    end
    if not tonumber(y) then
      y = guiElements[el].y
    elseif parentEl and not absolute then
      guiElements[el].y = guiElements[parentEl].y + y
    else
      guiElements[el].y = y
    end
    if not excludeChildren then
      for k = 1, #guiElements[el].children do
        local child = guiElements[el].children[k]
        local px = guiElements[child].x - lastX
        local py = guiElements[child].y - lastY
        setGuiPosition(child, guiElements[el].x + px, guiElements[el].y + py, true)
      end
    end
  else
    throwGuiError("setGuiPosition: invalid guiElement (" .. tostring(el) .. ")")
  end
end

local guiAnimations = {}
function setGuiPositionAnimated(el, x, y, time, event, interpolationType, absolute, excludeChildren)
  if el == "last" then
    el = lastGuiElement
  end
  if tonumber(el) and guiElements[el] then
    local parentEl = guiElements[el].parent
    local lastX = guiElements[el].x
    local lastY = guiElements[el].y
    if not tonumber(x) then
      x = guiElements[el].x
    end
    if not tonumber(y) then
      y = guiElements[el].y
    end
    local toX = 0
    local toY = 0
    if parentEl and not absolute then
      toX = guiElements[parentEl].x + x
      toY = guiElements[parentEl].y + y
    else
      toX = x
      toY = y
    end
    table.insert(guiAnimations, {
      now,
      tonumber(time) or 1000,
      event,
      el,
      {
        x = {lastX, toX},
        y = {lastY, toY}
      },
      interpolationType
    })
    if not excludeChildren then
      for k = 1, #guiElements[el].children do
        local child = guiElements[el].children[k]
        local px = guiElements[child].x - lastX
        local py = guiElements[child].y - lastY
        toX = x + px
        toY = y + py
        setGuiPositionAnimated(child, toX, toY, time, false, interpolationType, true, excludeChildren)
      end
    end
  else
    throwGuiError("setGuiPositionAnimated: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function getGuiSize(el, dimension)
  if el == "last" then
    el = lastGuiElement
  end
  if tonumber(el) and guiElements[el] then
    if dimension == "x" then
      return guiElements[el].sx
    elseif dimension == "y" then
      return guiElements[el].sy
    else
      return guiElements[el].sx, guiElements[el].sy
    end
  else
    throwGuiError("setGuiSize: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setGuiSize(el, sx, sy)
  if el == "last" then
    el = lastGuiElement
  end
  if tonumber(el) and guiElements[el] then
    if not tonumber(sx) and sizeSchemes[guiElements[el].type] and sizeSchemes[guiElements[el].type][sx] then
      sx = sizeSchemes[guiElements[el].type][sx][1]
    end
    if not tonumber(sy) and sizeSchemes[guiElements[el].type] and sizeSchemes[guiElements[el].type][sy] then
      sy = sizeSchemes[guiElements[el].type][sy][2]
    end
    if not tonumber(sx) then
      sx = guiElements[el].sx
    end
    if not tonumber(sy) then
      sy = guiElements[el].sy
    end
    guiElements[el].sx = sx
    guiElements[el].sy = sy
    if guiElements[el].type == "input" then
      refreshInputSize(el)
    elseif guiElements[el].type == "checkbox" then
      guiElements[el].fontPadding = (guiElements[el].sy - dxGetFontHeight(fontScales[guiElements[el].font], guiElements[el].font)) / 2
      guiElements[el].checkIcon = getFaIconFilename("check", guiElements[el].sy)
    end
  else
    throwGuiError("setGuiSize: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setGuiSizeAnimated(el, sx, sy, time, event, interpolationType)
  if el == "last" then
    el = lastGuiElement
  end
  if tonumber(el) and guiElements[el] then
    if not tonumber(sx) and sizeSchemes[guiElements[el].type] and sizeSchemes[guiElements[el].type][sx] then
      sx = sizeSchemes[guiElements[el].type][sx][1]
    end
    if not tonumber(sy) and sizeSchemes[guiElements[el].type] and sizeSchemes[guiElements[el].type][sy] then
      sy = sizeSchemes[guiElements[el].type][sy][2]
    end
    if not tonumber(sx) then
      sx = guiElements[el].sx
    end
    if not tonumber(sy) then
      sy = guiElements[el].sy
    end
    local anim = {
      sx = {
        guiElements[el].sx,
        sx
      },
      sy = {
        guiElements[el].sy,
        sy
      }
    }
    if guiElements[el].type == "input" then
      if guiElements[el].multiline then
        refreshInputSize(el)
      else
        anim.fontPadding = {
          guiElements[el].fontPadding,
          (guiElements[el].sy - dxGetFontHeight(fontScales[guiElements[el].font], guiElements[el].font)) / 2
        }
        if guiElements[el].icon then
          guiElements[el].icon = getFaIconFilename(guiElements[el].iconRaw, math.ceil(sy) - 2)
        end
      end
    elseif guiElements[el].type == "checkbox" then
      anim.fontPadding = {
        guiElements[el].fontPadding,
        (guiElements[el].sy - dxGetFontHeight(fontScales[guiElements[el].font], guiElements[el].font)) / 2
      }
      guiElements[el].checkIcon = getFaIconFilename(guiElements[el].checkIconRaw, guiElements[el].sy)
    end
    table.insert(guiAnimations, {
      now,
      tonumber(time) or 1000,
      event,
      el,
      anim,
      interpolationType
    })
  else
    throwGuiError("setGuiSizeAnimated: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function createGuiElement(guiType, x, y, sx, sy, parent, skipInit)
  local el = (lastGuiElement or 0) + 1
  lastGuiElement = el
  if not sx and sizeSchemes[guiType] and sizeSchemes[guiType].normal then
    sx = sizeSchemes[guiType].normal[1]
  end
  if not sy and sizeSchemes[guiType] and sizeSchemes[guiType].normal then
    sy = sizeSchemes[guiType].normal[2]
  end
  if not tonumber(sx) and sizeSchemes[guiType] and sizeSchemes[guiType][sx] then
    sx = sizeSchemes[guiType][sx][1]
  end
  if not tonumber(sy) and sizeSchemes[guiType] and sizeSchemes[guiType][sy] then
    sy = sizeSchemes[guiType][sy][2]
  end
  guiElements[el] = {
    type = guiType,
    x = x,
    y = y,
    sx = sx,
    sy = sy,
    parent = false,
    children = {},
    textures = {},
    sourceResource = sourceResource,
    sourceResourceRoot = sourceResourceRoot,
    toColorCache = {},
    toColorTableCache = {},
    gradientCache = {},
    clickSound = "click"
  }
  if tonumber(parent) then
    setGuiParent(el, parent)
    if tonumber(parent) and guiElements[parent] then
      guiElements[el].x = guiElements[parent].x + x
      guiElements[el].y = guiElements[parent].y + y
      if guiElements[parent].disableChildClickSound then
        guiElements[el].disableChildClickSound = true
        guiElements[el].clickSound = nil
      end
    end
  end
  if guiType ~= "null" then
    table.insert(renderList, el)
  end
  if hoverables[guiType] then
    guiElements[el].activateEffect = 0
    guiElements[el].disableClickTrough = true
    guiElements[el].hoverAlpha = 0
    guiElements[el].hoverTime = defaultHoverTime
    hoverList[el] = true
  end
  if not skipInit then
    if guiType == "slider" then
      setSliderColor(el, "sightgrey1", "sightgreen")
    elseif guiType == "hr" then
      setGuiHrColor(el, "sightgrey3", "sightgrey1")
    elseif guiType == "window" then
      setWindowColors(el, "sightgrey2", "sightgrey1", "sightgrey3", "#ffffff")
    end
  end
  setGuiColorScheme(el)
  setGuiFontScheme(el)
  return el
end

function deleteAllChildren(el)
  if tonumber(el) and guiElements[el] then
    for k = 1, #guiElements[el].children do
      local el = guiElements[el].children[k]
      if el and guiElements[el] then
        guiElements[el].parent = nil
        deleteGuiElement(el)
      end
    end
    guiElements[el].children = {}
  else
    throwGuiError("deleteAllChildren: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setDeleteEvent(el, event)
  if tonumber(el) and guiElements[el] then
    guiElements[el].deleteEvent = event
  else
    throwGuiError("setDeleteEvent: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function deleteGuiElement(el, excludeChildren)
  if tonumber(el) and guiElements[el] then
    if enterTrigger == el then
      enterTrigger = false
      sightlangCondHandl0(enterTrigger)
    end
    if guiElements[el].deleteEvent then
      triggerEvent(guiElements[el].deleteEvent, localPlayer, el)
    end
    for k = 1, #guiElements[el].children do
      if guiElements[el].children[k] and guiElements[guiElements[el].children[k]] then
        guiElements[guiElements[el].children[k]].parent = nil
        if not excludeChildren then
          deleteGuiElement(guiElements[el].children[k])
        end
      end
    end
    local parentEl = guiElements[el].parent
    if tonumber(parentEl) and guiElements[parentEl] then
      for k = 1, #guiElements[parentEl].children do
        if guiElements[parentEl].children[k] == el then
          table.remove(guiElements[parentEl].children, k)
          break
        end
      end
    end
    for k = #renderList, 1, -1 do
      if renderList[k] == el then
        table.remove(renderList, k)
        break
      end
    end
    hoverList[el] = nil
    guiElements[el] = nil
    if activeInput == el then
      activeInput = false
    end
  else
    throwGuiError("deleteGuiElement: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setElementGradientToData(el, data, color)
  local color1 = getColorCode(color[1])
  local color2 = getColorCode(color[2])
  local sx, sy = false, false
  if not guiElements[el].hoverSy then
    sx, sy = guiElements[el].hoverSx or guiElements[el].sx, guiElements[el].sy
  end
  if not (sx or sy) then
    sx, sy = guiElements[el].sx, guiElements[el].sy
  end
  if color[3] == "4rd" then
    guiElements[el][data] = getGradient4Filename(sx, sy, color1)
  elseif color[3] == "3rd" then
    guiElements[el][data] = getGradient3Filename(sx, sy, color1, color2)
  elseif color[3] then
    guiElements[el][data] = getGradient2Filename(sx, sy, color1, color2)
  else
    guiElements[el][data] = getGradientFilename(sx, sy, color1, color2)
  end
  guiElements[el].gradientCache[data] = nil
  if colors[color[1]] or colors[color[2]] then
    guiElements[el].gradientCache[data] = color
  end
end

function setGuiBackground(el, backgroundType, color)
  if tonumber(el) and guiElements[el] then
    guiElements[el].backgroundType = backgroundType
    if backgroundType == "solid" then
      setElementColorToData(el, "background", color)
    elseif backgroundType == "gradient" then
      guiElements[el].hoverSx = guiElements[el].sx
      guiElements[el].hoverSy = guiElements[el].sy
      setElementGradientToData(el, "background", color)
    end
  else
    throwGuiError("setGuiBackground: invalid guiElement (" .. inspect(el) .. ")")
  end
end

function setGuiHover(el, hoverType, color, toFront, disableSize)
  if tonumber(el) and guiElements[el] then
    guiElements[el].hoverType = hoverType
    guiElements[el].hoverFront = toFront
    guiElements[el].hoverDisableSize = disableSize
    if hoverType == "none" then
    elseif hoverType == "solid" then
      setElementColorToData(el, "hover", color)
    elseif hoverType == "gradient" then
      guiElements[el].hoverSx = guiElements[el].sx
      guiElements[el].hoverSy = guiElements[el].sy
      setElementGradientToData(el, "hover", color)
    else
      throwGuiWarning("setGuiHover: invalid hover color type")
    end
  else
    throwGuiError("setGuiHover: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setImageCrop(el, x, y)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "image" then
      guiElements[el].cropX = x
      guiElements[el].cropY = y
    else
      throwGuiError("setImageCrop: guiElement is not image")
    end
  else
    throwGuiError("setImageCrop: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setImageUV(el, u, v, usize, vsize)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "image" then
      guiElements[el].u = u
      guiElements[el].v = v
      guiElements[el].usize = usize
      guiElements[el].vsize = vsize
    else
      throwGuiError("setImageCrop: guiElement is not image")
    end
  else
    throwGuiError("setImageCrop: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setImageDDS(el, file, format, mipMap, latent)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "image" then
      guiElements[el].file = false
      guiElements[el].dds = file
      guiElements[el].ddsFormat = format
      guiElements[el].ddsMipMap = mipMap
      guiElements[el].ddsLatent = latent
    else
      throwGuiError("setImageDDS: guiElement is not image")
    end
  else
    throwGuiError("setImageDDS: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function resetImageDDS(file)
  resetDynamicImage(file)
end

function setImageShadow(el, i, x, y, col)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "image" then
      if i then
        guiElements[el].shadowI = i
        guiElements[el].shadowX = x
        guiElements[el].shadowY = y
        setElementColorToData(el, "shadowColor", col)
      else
        guiElements[el].shadowI = nil
        guiElements[el].shadowX = nil
        guiElements[el].shadowY = nil
        setElementColorToData(el, "shadowColor", false)
      end
    else
      throwGuiError("setImageShadow: guiElement is not image")
    end
  else
    throwGuiError("setImageShadow: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setImageFile(el, file)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "image" then
      guiElements[el].file = file
      guiElements[el].dds = nil
      guiElements[el].ddsFormat = nil
      guiElements[el].ddsMipMap = nil
      guiElements[el].ddsLatent = nil
    else
      throwGuiError("setImageFile: guiElement is not image")
    end
  else
    throwGuiError("setImageFile: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setImageRotation(el, rotation)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "image" then
      guiElements[el].rotation = rotation
    else
      throwGuiError("setImageRotation: guiElement is not image")
    end
  else
    throwGuiError("setImageRotation: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setImageSpinner(el, spinner)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "image" then
      guiElements[el].spinner = spinner
    else
      throwGuiError("setImageSpinner: guiElement is not image")
    end
  else
    throwGuiError("setImageSpinner: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setImageFadeHover(el, state)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "image" then
      guiElements[el].fadeHover = state
    else
      throwGuiError("setImageFadeHover: guiElement is not image")
    end
  else
    throwGuiError("setImageFadeHover: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setImageColor(el, color)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "image" then
      setElementColorToData(el, "color", color)
    else
      throwGuiError("setImageColor: guiElement is not image")
    end
  else
    throwGuiError("setImageColor: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setImageFadeHoverBase(el, state)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "image" then
      guiElements[el].fadeHoverBase = state
    else
      throwGuiError("setImageFadeHoverBase: guiElement is not image")
    end
  else
    throwGuiError("setImageFadeHoverBase: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setGuiHoverable(el, state, hoverTime)
  if tonumber(el) and guiElements[el] then
    hoverList[el] = state
    if hoverList[el] then
      guiElements[el].activateEffect = 0
      guiElements[el].hoverAlpha = 0
      guiElements[el].hoverTime = hoverTime or defaultHoverTime
    else
      guiElements[el].activateEffect = false
      guiElements[el].hoverAlpha = false
      guiElements[el].hoverTime = false
      hoverList[el] = nil
    end
  else
    throwGuiError("setGuiHoverable: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function getGuiHoverable(el)
  if tonumber(el) and guiElements[el] then
    return hoverList[el]
  else
    throwGuiError("getGuiHoverable: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setGuiBoundingBox(el, el2)
  if tonumber(el) and guiElements[el] then
    guiElements[el].boundingBox = el2
  else
    throwGuiError("setGuiBoundingBox: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setImageRightCornerHover(el, x, y)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "image" then
      guiElements[el].rightCornerX = x
      guiElements[el].rightCornerY = x
    else
      throwGuiError("setImageRightCornerHover: guiElement is not image")
    end
  else
    throwGuiError("setImageRightCornerHover: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setGuiHrColor(el, c1, c2)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "hr" then
      setElementColorToData(el, "color1", c1)
      setElementColorToData(el, "color2", c2)
    else
      throwGuiError("setGuiHrColor: guiElement is not hr")
    end
  else
    throwGuiError("setGuiHrColor: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function fadeIn(el, time, inclChildren)
  if tonumber(el) and guiElements[el] then
    guiElements[el].fadeIn = now
    guiElements[el].fadeInTime = time
    if inclChildren then
      for k = 1, #guiElements[el].children do
        fadeIn(guiElements[el].children[k], time, inclChildren)
      end
    end
  else
    throwGuiError("fadeIn: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function fadeOut(el, time, inclChildren)
  if tonumber(el) and guiElements[el] then
    guiElements[el].fadeOut = now
    guiElements[el].fadeOutTime = time
    if inclChildren then
      for k = 1, #guiElements[el].children do
        fadeOut(guiElements[el].children[k], time, inclChildren)
      end
    end
  else
    throwGuiError("fadeOut: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function showInfobox(info, text, time, grouping)
  if type(info) == "string" then
    info = infoboxTypes[utf8.sub(info, 1, 1)]
  end
  if type(info) == "table" then
    local icon = info[1]
    local color = getColorCodeToColor(info[2])
    local color2 = getColorCodeToColor(info[3])
    if infoboxSound or info[6] then
      local s = playSound("sounds/" .. info[5])
      if info[6] then
        setSoundVolume(s, 2.5)
      end
    end
    local font = getFont("11/Ubuntu-L.ttf")
    local textWidth = getTextWidthFont(text, font)
    local fontPadding = math.floor((infoboxHeight - getFontHeight(font)) / 2)
    if not tonumber(time) then
      time = math.max(4000, utf8.len(text) * 120)
    end
    local y = 0
    local ty = 0
    if 0 < #infoboxes then
      y = infoboxes[#infoboxes][12] + (infoboxHeight + 8)
      ty = infoboxes[#infoboxes][13] + (infoboxHeight + 8)
      for k = 1, #infoboxes do
        if (infoboxes[k][2] == text or grouping and infoboxes[k][15] == grouping) and infoboxes[k][4] == icon and not infoboxes[k][14] then
          infoboxes[k][1] = now - infoboxes[k][11] - 250
          infoboxes[k][14] = true
        end
      end
    else
      y = 16
      ty = 16
    end
    table.insert(infoboxes, {
      now,
      text,
      textWidth,
      icon,
      color,
      color2,
      false,
      false,
      font,
      fontPadding,
      time,
      y,
      ty,
      false,
      grouping
    })
    if not info[6] then
      if infoboxChatbox then
        outputChatBox("[color=" .. info[2] .. "][SkyRPG - " .. info[4] .. "]: #ffffff" .. text, 255, 255, 255, true)
      else
        outputConsole("[SkyRPG - " .. info[4] .. "]: " .. text)
      end
    end
  end
end

function showLoadingScreen(time, text, noUnload)
  loadingScreenData = {
    getColorCodeToColor("sightgrey1"),
    getColorCodeToColor("sightmidgrey"),
    getColorCodeToColor("sightgreen"),
    getFont("11/Ubuntu-L.ttf"),
    now,
    time,
    text or "Betöltés...",
    noUnload
  }
end

function setDDSPreview(file, format, mipMap, latent, u, v, us, vs, black)
  ddsPreviewX = 0
  ddsPreviewY = 0
  ddsPreviewZoom = 1
  ddsPreviewMinZoom = false
  if isElement(ddsScreenShader) then
    destroyElement(ddsScreenShader)
  end
  ddsScreenShader = nil
  if isElement(ddsScreenSrc) then
    destroyElement(ddsScreenSrc)
  end
  ddsScreenSrc = nil
  ddsPreviewMoving = false
  sightlangCondHandl1(false)
  if file then
    if not black then
      ddsScreenSrc = dxCreateScreenSource(screenX, screenY)
      ddsScreenShader = dxCreateShader(ddsShaderSource)
      dxSetShaderValue(ddsScreenShader, "UVSize", screenX, screenY)
      dxSetShaderValue(ddsScreenShader, "factor", 0.0016)
      dxSetShaderValue(ddsScreenShader, "texture0", ddsScreenSrc)
    end
    ddsPreviewFile = file
    ddsPreviewFormat = format
    ddsPreviewMip = mipMap
    ddsPreviewLatent = latent
    ddsPreviewU = u
    ddsPreviewV = v
    ddsPreviewUS = us
    ddsPreviewVS = vs
    ddsPreviewSX = false
    ddsPreviewSY = false
    showCursor(true)
    showChat(false)
    sightlangCondHandl2(true)
    sightlangCondHandl3(true)
    showInfobox("i", "A képnézegetőt a Backspace gombbal zárhatod be.")
  else
    ddsPreviewTexture = false
    ddsPreviewFile = false
    ddsPreviewFormat = false
    ddsPreviewMip = false
    ddsPreviewLatent = false
    ddsPreviewSX = false
    ddsPreviewSY = false
    ddsPreviewU = false
    ddsPreviewV = false
    ddsPreviewUS = false
    ddsPreviewVS = false
    showCursor(togCursorState)
    showChat(true)
    sightlangCondHandl2(false)
    sightlangCondHandl3(false)
  end
end

function thousandsStepper(amount)
  local formatted = amount
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1 %2")
    if k == 0 then
      break
    end
  end
  return formatted
end

function guiToBack(el, excludeChildren)
  if tonumber(el) and guiElements[el] then
    local tmp = {}
    if guiElements[el].type ~= "null" then
      table.insert(tmp, el)
    end
    local childrenTmp = {}
    if not excludeChildren then
      for k = 1, #guiElements[el].children do
        if guiElements[el].children[k] then
          childrenTmp[guiElements[el].children[k]] = true
        end
      end
      for k = 1, #renderList do
        if childrenTmp[renderList[k]] and guiElements[k].type ~= "null" then
          table.insert(tmp, renderList[k])
        end
      end
    end
    for k = 1, #renderList do
      if renderList[k] ~= el and not childrenTmp[renderList[k]] and guiElements[k] and guiElements[k].type ~= "null" then
        table.insert(tmp, renderList[k])
      end
    end
    renderList = tmp
  else
    throwGuiError("guiToBack: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function guiToFront(el, excludeChildren)
  if tonumber(el) and guiElements[el] then
    local childrenTmp = {}
    local childrenTo = {}
    if not excludeChildren then
      for k = 1, #guiElements[el].children do
        if guiElements[el].children[k] then
          childrenTmp[guiElements[el].children[k]] = true
        end
      end
    end
    for k = #renderList, 1, -1 do
      if renderList[k] == el then
        table.remove(renderList, k)
        break
      end
    end
    if not excludeChildren then
      for k = 1, #renderList do
        if childrenTmp[renderList[k]] then
          table.insert(childrenTo, renderList[k])
        end
      end
    end
    if guiElements[el].type ~= "null" then
      table.insert(renderList, el)
    end
    if not excludeChildren then
      for k = 1, #childrenTo do
        guiToFront(childrenTo[k])
      end
    end
  else
    throwGuiError("guiToFront: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function isGuiElementValid(el)
  return tonumber(el) and guiElements[el]
end

function guiSetTooltip(el, text, x, y)
  if tonumber(el) and guiElements[el] then
    if hoverElement == el then
      tooltipText = text
      tooltipImage = false
      tooltipPosX = x or "right"
      tooltipPosY = y or "down"
    end
    guiElements[el].tooltipText = text
    guiElements[el].tooltipImage = nil
    guiElements[el].tooltipImageSX = nil
    guiElements[el].tooltipImageSY = nil
    guiElements[el].tooltipPosX = x
    guiElements[el].tooltipPosY = y
  else
    throwGuiError("guiSetTooltip: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setTexturePreview(texture, u, v, us, vs, black)
  ddsPreviewX = 0
  ddsPreviewY = 0
  ddsPreviewZoom = 1
  ddsPreviewMinZoom = false
  if isElement(ddsScreenShader) then
    destroyElement(ddsScreenShader)
  end
  ddsScreenShader = nil
  if isElement(ddsScreenSrc) then
    destroyElement(ddsScreenSrc)
  end
  ddsScreenSrc = nil
  ddsPreviewMoving = false
  sightlangCondHandl1(false)
  if texture then
    if not black then
      ddsScreenSrc = dxCreateScreenSource(screenX, screenY)
      ddsScreenShader = dxCreateShader(ddsShaderSource)
      dxSetShaderValue(ddsScreenShader, "UVSize", screenX, screenY)
      dxSetShaderValue(ddsScreenShader, "factor", 0.0016)
      dxSetShaderValue(ddsScreenShader, "texture0", ddsScreenSrc)
    end
    ddsPreviewTexture = texture
    ddsPreviewFile = false
    ddsPreviewFormat = false
    ddsPreviewMip = false
    ddsPreviewLatent = false
    ddsPreviewU = u
    ddsPreviewV = v
    ddsPreviewUS = us
    ddsPreviewVS = vs
    ddsPreviewSX = false
    ddsPreviewSY = false
    showCursor(false)
    showChat(false)
    sightlangCondHandl2(true)
    sightlangCondHandl3(true)
    showInfobox("i", "A képnézegetőt a Backspace gombbal zárhatod be.")
  else
    ddsPreviewTexture = false
    ddsPreviewFile = false
    ddsPreviewFormat = false
    ddsPreviewMip = false
    ddsPreviewLatent = false
    ddsPreviewSX = false
    ddsPreviewSY = false
    ddsPreviewU = false
    ddsPreviewV = false
    ddsPreviewUS = false
    ddsPreviewVS = false
    showCursor(togCursorState)
    showChat(true)
    sightlangCondHandl2(false)
    sightlangCondHandl3(false)
  end
end

function guiSetTooltipImage(el, image, sx, sy, x, y)
  if tonumber(el) and guiElements[el] then
    if hoverElement == el then
      tooltipText = false
      tooltipImage = image
      tooltipImageSX = sx
      tooltipImageSY = sy
      tooltipPosX = x or "right"
      tooltipPosY = y or "down"
    end
    guiElements[el].tooltipText = nil
    guiElements[el].tooltipImage = image
    guiElements[el].tooltipImageSX = sx
    guiElements[el].tooltipImageSY = sy
    guiElements[el].tooltipPosX = x
    guiElements[el].tooltipPosY = y
  else
    throwGuiError("guiSetTooltip: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function guiSetTooltipImageDDS(el, image, sx, sy, x, y)
  if tonumber(el) and guiElements[el] then
    if hoverElement == el then
      tooltipText = false
      tooltipImage = image
      tooltipImageSX = sx
      tooltipImageSY = sy
      tooltipPosX = x or "right"
      tooltipPosY = y or "down"
    end
    guiElements[el].tooltipText = nil
    guiElements[el].tooltipImage = image
    guiElements[el].tooltipImageDDS = true
    guiElements[el].tooltipImageSX = sx
    guiElements[el].tooltipImageSY = sy
    guiElements[el].tooltipPosX = x
    guiElements[el].tooltipPosY = y
  else
    throwGuiError("guiSetTooltip: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function guiSetPositionAbsolute(el, x, y, excludeChildren)
  if tonumber(el) and guiElements[el] then
    local lastX = guiElements[el].x
    local lastY = guiElements[el].y
    guiElements[el].x = x
    guiElements[el].y = y
    if not excludeChildren then
      for k = 1, #guiElements[el].children do
        local child = guiElements[guiElements[el].children[k]]
        local px = guiElements[child].x - lastX
        local py = guiElements[child].y - lastY
        guiElements[child].x = guiElements[el].x + px
        guiElements[child].y = guiElements[el].y + py
      end
    end
  else
    throwGuiError("guiSetPositionAbsolute: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setElementDisabled(el, disabled)
  if tonumber(el) and guiElements[el] then
    guiElements[el].disabled = disabled
  else
    throwGuiError("setElementDisabled: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setHoverEvent(el, event)
  if tonumber(el) and guiElements[el] then
    guiElements[el].hoverEvent = event
  else
    throwGuiError("setHoverEvent: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setClickSound(el, sound)
  if tonumber(el) and guiElements[el] then
    guiElements[el].clickSound = sound
  else
    throwGuiError("setClickSound: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setDisableClickSound(el, disable, children)
  if tonumber(el) and guiElements[el] then
    if disable then
      guiElements[el].clickSound = nil
    end
    guiElements[el].disableChildClickSound = children
  else
    throwGuiError("setClickSound: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setClickArgument(el, arg)
  if tonumber(el) and guiElements[el] then
    guiElements[el].clickArg = arg
  else
    throwGuiError("setClickEvent: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setClickEvent(el, event, keyTrigger)
  if tonumber(el) and guiElements[el] then
    if enterTrigger == el then
      enterTrigger = false
    end
    guiElements[el].clickEvent = event
    if event and keyTrigger then
      enterTrigger = el
    end
    sightlangCondHandl0(enterTrigger)
  else
    throwGuiError("setClickEvent: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function disableClickTrough(el, state)
  if tonumber(el) and guiElements[el] then
    guiElements[el].disableClickTrough = state
  else
    throwGuiError("disableClickTrough: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function formatDate(format, escaper, timestamp)
  escaper = (escaper or "'"):sub(1, 1)
  local time = getRealTime(timestamp)
  local formattedDate = ""
  local escaped = false
  time.year = time.year + 1900
  time.month = time.month + 1
  local datetime = {
    d = ("%02d"):format(time.monthday),
    h = ("%02d"):format(time.hour),
    i = ("%02d"):format(time.minute),
    m = ("%02d"):format(time.month),
    s = ("%02d"):format(time.second),
    w = gWeekDays[time.weekday + 1]:sub(1, 2),
    W = gWeekDays[time.weekday + 1],
    y = tostring(time.year):sub(-2),
    Y = time.year
  }
  for char in format:gmatch(".") do
    if char == escaper then
      escaped = not escaped
    else
      formattedDate = formattedDate .. (not escaped and datetime[char] or char)
    end
  end
  return formattedDate
end

function updateScreenSourceBefore(el, screenSource, resample)
  if tonumber(el) and guiElements[el] then
    guiElements[el].updateScreenSource = screenSource
    guiElements[el].updateScreenSourceResample = resample
  else
    throwGuiError("guiToBack: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function lockHover(el, state, excludeChildren)
  if tonumber(el) and guiElements[el] then
    guiElements[el].hoverLock = state
    if not excludeChildren then
      for k = 1, #guiElements[el].children do
        if guiElements[el].children[k] then
          lockHover(guiElements[el].children[k], state)
        end
      end
    end
  else
    throwGuiError("lockHover: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function disableLinkCursor(el, state)
  if tonumber(el) and guiElements[el] then
    guiElements[el].disableLinkCursor = state
  else
    throwGuiError("disableClickTrough: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setColorSet(id)
  if tonumber(id) and id ~= currentColorSet and colorSets[id] then
    currentColorSet = id
    colors = colorSets[currentColorSet]
    for k in pairs(colors) do
      colorsToColor[k] = tocolor(colors[k][1], colors[k][2], colors[k][3])
    end
    for k = 1, #renderList do
      if renderList[k] then
        local el = renderList[k]
        if guiElements[el] then
          for data, color in pairs(guiElements[el].toColorCache) do
            guiElements[el][data] = colorsToColor[color]
          end
          for data, color in pairs(guiElements[el].toColorTableCache) do
            guiElements[el][data] = colors[color]
          end
          for data, color in pairs(guiElements[el].gradientCache) do
            setElementGradientToData(el, data, color)
          end
        end
      end
    end
    for k in pairs(colors) do
      sightexports.sCore:registerChatColor(k, colorsToColor[k])
    end
    setRefreshColors()
    return true
  end
end

function getColorSet()
  return currentColorSet
end

function getColorsForPreview(colorSet)
  if not tonumber(colorSet) or not colorSets[colorSet] then
    colorSet = currentColorSet
  end
  local colors = {}
  for k = 1, #allColorNames do
    colors[k] = colorSets[colorSet][allColorNames[k]]
  end
  return colors
end

function getColorsForPreviewEx(colorSet)
  if not tonumber(colorSet) or not colorSets[colorSet] then
    colorSet = currentColorSet
  end
  local colors = {}
  for k = 1, #allColorNames do
    colors[allColorNames[k]] = colorSets[colorSet][allColorNames[k]]
  end
  return colors
end

function getColorSetName(colorSet)
  return colorSets[colorSet].name
end

function getColorSetsCount()
  return #colorSets
end

function getInfoboxChatbox()
  return infoboxChatbox
end

function setInfoboxChatbox(val)
  infoboxChatbox = val
end

function getInfoboxSound()
  return infoboxSound
end

function setInfoboxSound(val)
  infoboxSound = val
end

function getLoadingScreen()
  return loadingScreenData
end

function setRefreshColors()
  doRefreshColors = true
end

function getTogCursorKey()
  return togCursorKey
end

function setTogCursorKey(val)
  unbindKey(togCursorKey, "down", "mouseon")
  unbindKey(togCursorKey, "up", "mouseoff")
  togCursorKey = val
  bindKey(togCursorKey, "down", "mouseon")
  bindKey(togCursorKey, "up", "mouseoff")
end

function setRadarCoords(el, x, y, zoom)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "radar" then
      guiElements[el].radarX = x
      guiElements[el].radarY = y
      guiElements[el].radarZoom = zoom
    else
      throwGuiError("setRadarCoords: guiElement is not radar")
    end
  else
    throwGuiError("setRadarCoords: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function getColorCodeToColor(color)
  if type(color) == "string" then
    if color:sub(1, 1) == "#" then
      local color = getColorHex(color)
      return tocolor(color[1], color[2], color[3], color[4])
    else
      return colorsToColor[color]
    end
  elseif type(color) == "table" then
    return tocolor(color[1], color[2], color[3], color[4])
  else
    return color
  end
end

--[[    <!-- backgroundC.lua -->
    <export function="setGuiBackgroundAlpha" type="client" />
    <export function="setGuiBackgroundBorder" type="client" />]]

function setGuiBackgroundAlpha(el, alpha)
  if tonumber(el) and guiElements[el] then
    guiElements[el].backgroundAlpha = alpha
  else
    throwGuiError("setGuiBackgroundAlpha: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setGuiBackgroundBorder(el, size, color)
  if tonumber(el) and guiElements[el] then
    if tonumber(size) then
      guiElements[el].borderSize = size
      setElementColorToData(el, "border", color)
    else
      guiElements[el].border = nil
    end
  else
    throwGuiError("setGuiBackgroundBorder: invalid guiElement (" .. tostring(el) .. ")")
  end
end

--[[    <!-- buttonC.lua -->
    <export function="setButtonFont" type="client" />
    <export function="setButtonIcon" type="client" />
    <export function="setButtonIconDDS" type="client" />
    <export function="setButtonTextPadding" type="client" />
    <export function="setButtonTextAlign" type="client" />
    <export function="setButtonTextColor" type="client" />
    <export function="setButtonIconColor" type="client" />
    <export function="setButtonText" type="client" />
    <export function="getButtonText" type="client" />]]

function setButtonFont(el, font)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      guiElements[el].font = getFont(font)
      if guiElements[el].icon then
        if guiElements[el].text then
          guiElements[el].textWidth = getTextWidthFont(guiElements[el].text, guiElements[el].font)
        end
        guiElements[el].textHeight = getFontHeight(guiElements[el].font)
      end
    else
      throwGuiError("setButtonFont: guiElement is not button")
    end
  else
    throwGuiError("setButtonFont: invalid guiElement")
  end
end

function setButtonIcon(el, file)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      guiElements[el].icon = file
      guiElements[el].iconDDS = false
      if guiElements[el].icon and guiElements[el].font then
        if guiElements[el].text then
          guiElements[el].textWidth = getTextWidthFont(guiElements[el].text, guiElements[el].font)
        end
        guiElements[el].textHeight = getFontHeight(guiElements[el].font)
      end
    else
      throwGuiError("setButtonIcon: guiElement is not button")
    end
  else
    throwGuiError("setButtonIcon: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setButtonIconDDS(el, file)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      guiElements[el].icon = file
      guiElements[el].iconDDS = true
      if guiElements[el].icon and guiElements[el].font then
        if guiElements[el].text then
          guiElements[el].textWidth = getTextWidthFont(guiElements[el].text, guiElements[el].font)
        end
        guiElements[el].textHeight = getFontHeight(guiElements[el].font)
      end
    else
      throwGuiError("setButtonIconDDS: guiElement is not button")
    end
  else
    throwGuiError("setButtonIconDDS: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setButtonTextPadding(el, px, py)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      guiElements[el].px = px
      guiElements[el].py = py
    else
      throwGuiError("setButtonTextPadding: guiElement is not button")
    end
  else
    throwGuiError("setButtonTextPadding: invalid guiElement")
  end
end

function setButtonTextAlign(el, al1, al2)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      guiElements[el].al1 = al1
      guiElements[el].al2 = al2
    else
      throwGuiError("setButtonTextAlign: guiElement is not button")
    end
  else
    throwGuiError("setButtonTextAlign: invalid guiElement")
  end
end

function setButtonTextColor(el, color)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      setElementColorToData(el, "fontColor", color)
    else
      throwGuiError("setButtonTextColor: guiElement is not button")
    end
  else
    throwGuiError("setButtonTextColor: invalid guiElement")
  end
end

function setButtonIconColor(el, color)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      setElementColorToData(el, "iconColor", color)
    else
      throwGuiError("setButtonIconColor: guiElement is not button")
    end
  else
    throwGuiError("setButtonIconColor: invalid guiElement")
  end
end

function setButtonText(el, text)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      guiElements[el].text = text
      if guiElements[el].icon and guiElements[el].text then
        guiElements[el].textWidth = getTextWidthFont(guiElements[el].text, guiElements[el].font)
      end
    else
      throwGuiError("setButtonText: guiElement is not button")
    end
  else
    throwGuiError("setButtonText: invalid guiElement")
  end
end

function getButtonText(el)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      return guiElements[el].text
    else
      throwGuiError("getButtonText: guiElement is not button")
    end
  else
    throwGuiError("getButtonText: invalid guiElement")
  end
end

--[[    <!-- checkboxC.lua -->
    <export function="setCheckboxFont" type="client" />
    <export function="setCheckboxIcon" type="client" />
    <export function="getCheckboxWidth" type="client" />
    <export function="setCheckboxColor" type="client" />
    <export function="setCheckboxText" type="client" />
    <export function="isCheckboxChecked" type="client" />
    <export function="setCheckboxChecked" type="client" />
    <export function="setCheckboxHoverable" type="client" />]]

function setCheckboxFont(el, font)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "checkbox" then
      guiElements[el].font = getFont(font)
      local height = math.ceil(dxGetFontHeight(fontScales[guiElements[el].font], guiElements[el].font))
      guiElements[el].fontPadding = math.max(6, math.floor((guiElements[el].sy - height) / 2))
      guiElements[el].checkIcon = getFaIconFilename("check", guiElements[el].sy)
      guiElements[el].checkIconRaw = "check"
      guiElements[el].checkX = -0.075
      guiElements[el].checkY = 0.025
    else
      throwGuiError("setCheckboxFont: guiElement is not checkbox")
    end
  else
    throwGuiError("setCheckboxFont: invalid guiElement")
  end
end

function setCheckboxIcon(el, icon, x, y, iconStyle)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "checkbox" then
      guiElements[el].checkIcon = getFaIconFilename(icon, guiElements[el].sy, iconStyle)
      guiElements[el].checkIconRaw = icon
      guiElements[el].checkX = x
      guiElements[el].checkY = y
    else
      throwGuiError("setCheckboxIcon: guiElement is not checkbox")
    end
  else
    throwGuiError("setCheckboxIcon: invalid guiElement")
  end
end

function getCheckboxWidth(el)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "checkbox" then
      return guiElements[el].sy * 0.6 + guiElements[el].fontPadding + getTextWidthFont(guiElements[el].text, guiElements[el].font)
    else
      throwGuiError("getCheckboxWidth: guiElement is not checkbox")
    end
  else
    throwGuiError("getCheckboxWidth: invalid guiElement")
  end
end

function setCheckboxColor(el, color1, color2, color3, fontColor)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "checkbox" then
      setElementColorToData(el, "color1", color1)
      setElementColorToData(el, "color2", color2)
      setElementColorToData(el, "color3", color3)
      setElementColorToData(el, "fontColor", fontColor)
    else
      throwGuiError("setCheckboxColor: guiElement is not checkbox")
    end
  else
    throwGuiError("setCheckboxColor: invalid guiElement")
  end
end

function setCheckboxText(el, text)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "checkbox" then
      guiElements[el].text = text
    else
      throwGuiError("setCheckboxText: guiElement is not checkbox")
    end
  else
    throwGuiError("setCheckboxText: invalid guiElement")
  end
end

function isCheckboxChecked(el)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "checkbox" then
      return guiElements[el].checked
    else
      throwGuiError("isCheckboxChecked: guiElement is not checkbox")
    end
  else
    throwGuiError("isCheckboxChecked: invalid guiElement")
  end
end

function setCheckboxChecked(el, state)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "checkbox" then
      guiElements[el].checked = state
    else
      throwGuiError("setCheckboxChecked: guiElement is not checkbox")
    end
  else
    throwGuiError("setCheckboxChecked: invalid guiElement")
  end
end

function setCheckboxHoverable(el, state)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "checkbox" then
      hoverList[el] = state
      if hoverList[el] then
        guiElements[el].activateEffect = 0
        guiElements[el].hoverAlpha = 0
        guiElements[el].hoverTime = defaultHoverTime
      else
        guiElements[el].activateEffect = false
        guiElements[el].hoverAlpha = false
        guiElements[el].hoverTime = false
        hoverList[el] = nil
      end
    else
      throwGuiError("setCheckboxHoverable: guiElement is not checkbox")
    end
  else
    throwGuiError("setCheckboxHoverable: invalid guiElement")
  end
end

--[[    <!-- errorG.lua -->
    <export function="throwGuiError" type="shared" />
    <export function="throwGuiWarning" type="shared" />]]

function throwGuiError(string)
  local resname = sourceResource and getResourceName(sourceResource)
  outputDebugString(tostring(resname) .. " : " .. string, 1)
end

function throwGuiWarning(string)
  local resname = sourceResource and getResourceName(sourceResource)
  outputDebugString(tostring(resname) .. " : " .. string, 2)
end

--[[    <!-- fontawesomeC.lua -->
    <export function="getFaIconFilename" type="client" />
    <export function="getFaTicks" type="client" />]]

function getFaIconFilename(name, size, style, force, border, color, border2)
  if border or border2 then
    size = math.ceil(size)
  else
    size = convertSizeToP2(size)
  end
  style = style or "solid"
  if style == "solid" or style == "brands" or style == "regular" or style == "light" then
    if faUnicodes[name] then
      local fileName = "faicons/" .. name .. "-" .. style .. "-" .. size
      if border then
        fileName = fileName .. "-b-" .. border
      end
      if border2 then
        fileName = fileName .. "-b2-" .. border2
      end
      if color then
        fileName = fileName .. "-c-" .. color
      end
      fileName = fileName .. ".png"
      if force and faTicks[fileName] and fileExists(fileName .. faTicks[fileName]) then
        fileDelete(fileName .. faTicks[fileName])
      end
      if not (not force and faTicks[fileName]) or not fileExists(fileName .. faTicks[fileName]) then
        tick = tick + 1
        faTicks[fileName] = tick
        doRefreshFaTicks = true
        if fileExists(fileName .. faTicks[fileName]) then
          fileDelete(fileName .. faTicks[fileName])
        end
        local rt = dxCreateRenderTarget(size, size, true)
        if not isElement(rt) then
          table.insert(faIconsToRestore, {
            name,
            size,
            style,
            border,
            color,
            border2
          })
          throwGuiError("getFaIconFilename: failed icon! (no rt)")
          return fileName
        end
        local fontSize = size
        if border or border2 then
          fontSize = size - 2
        end
        if not isElement(faFonts[style .. fontSize]) then
          faFonts[style .. fontSize] = dxCreateFont("fa/" .. style .. ".otf", 0.4375 * fontSize, false, "antialiased")
        end
        local font = faFonts[style .. fontSize]
        if not isElement(font) then
          table.insert(faIconsToRestore, {
            name,
            size,
            style,
            border,
            color,
            border2
          })
          throwGuiError("getFaIconFilename: failed icon! (no font)")
          destroyElement(rt)
          return fileName
        end
        dxSetRenderTarget(rt, true)
        dxSetBlendMode("modulate_add")
        if border then
          dxDrawText(utf8.char(tonumber("0x" .. faUnicodes[name])), 1, 1, size + 1, size + 1, border, 1, font, "center", "center")
        end
        if border2 then
          for bx = -1, 1, 2 do
            for by = -1, 1, 2 do
              dxDrawText(utf8.char(tonumber("0x" .. faUnicodes[name])), 0 + bx, 0 + by, size + bx, size + by, border2, 1, font, "center", "center")
            end
          end
        end
        dxDrawText(utf8.char(tonumber("0x" .. faUnicodes[name])), 0, 0, size, size, color or tocolor(255, 255, 255), 1, font, "center", "center")
        dxSetBlendMode("blend")
        dxSetRenderTarget()
        local pixels = dxGetTexturePixels(rt)
        destroyElement(rt)
        if not pixels then
          table.insert(faIconsToRestore, {
            name,
            size,
            style,
            border,
            color,
            border2
          })
          throwGuiError("getFaIconFilename: failed icon! (1)")
        else
          local pixelCount = 0
          for x = 0, size - 1, 4 do
            for y = 0, size - 1, 4 do
              local r, g, b, a = dxGetPixelColor(pixels, x, y)
              pixelCount = pixelCount + a
              if 0 < pixelCount then
                break
              end
            end
          end
          if pixelCount == 0 then
            table.insert(faIconsToRestore, {
              name,
              size,
              style,
              border,
              color,
              border2
            })
            throwGuiError("getFaIconFilename: failed icon! (2)")
          end
          pixels = dxConvertPixels(pixels, "png")
          local fh = fileCreate(fileName .. faTicks[fileName])
          writeFileList(fileName .. faTicks[fileName])
          fileWrite(fh, pixels)
          fileClose(fh)
          if 0 < pixelCount then
            dxDrawImage(-10000, -10000, 1000, 100, fileName .. faTicks[fileName])
          end
          pixels = nil
          collectgarbage("collect")
        end
      end
      if not faIconsList[fileName] then
        faIconsList[fileName] = true
      end
      return fileName
    else
      throwGuiError("getFaIconFilename: invalid icon name (" .. name .. ")")
      return getFaIconFilename("times", size)
    end
  else
    throwGuiError("getFaIconFilename: invalid style")
    return getFaIconFilename("times", size)
  end
end

function getFaTicks()
  return faTicks
end

--[[    <!-- fontC.lua -->
    <export function="getTextWidthFont" type="client" />
    <export function="getFontHeight" type="client" />
    <export function="getFontScale" type="client" />
    <export function="getFont" type="client" />]]

function getTextWidthFont(text, font, scale, disableColor)
  if type(font) == "string" then
    font = getFont(font)
  end
  return dxGetTextWidth(text, (tonumber(fontScales[font]) or 1) * (tonumber(scale) or 1), font, not disableColor)
end

local fontHeightCache = {}
function getFontHeight(font, scale)
  if type(font) == "string" then
    font = getFont(font)
  end
  scale = tonumber(scale) or 1
  local name = tostring(font) .. "*" .. scale
  if not fontHeightCache[name] then
    fontHeightCache[name] = dxGetFontHeight((tonumber(fontScales[font]) or 1) * scale, font)
  end
  return fontHeightCache[name]
end

function getFontScale(font)
  if fontCache[font] then
    return fontScales[fontCache[font]]
  end
end

function getFont(font)
  if isElement(fontCache[font]) then
    return fontCache[font]
  end
  if utf8.find(font, ":") then
    local fontData = split(font, ":")
    if fontSchemes[fontData[1]] and fontSchemes[fontData[1]][fontData[2]] then
      return getFont(fontSchemes[fontData[1]][fontData[2]])
    end
  elseif utf8.find(font, "/") then
    local fontData = split(font, "/")
    if tonumber(fontData[1]) and not isElement(fontCache[font]) then
      local scale = (tonumber(fontScaleCorrection[fontData[2]]) or 1) * (tonumber(fontResize[fontData[2]]) or 1)
      fontCache[font] = dxCreateFont("fonts/" .. fontData[2], fontData[1] * scale, false, "antialiased")
      fontScales[fontCache[font]] = 1 / scale
    end
    return fontCache[font]
  end
end

--[[    <!-- inputC.lua -->
    <export function="setInputUppercaseOnly" type="client" />
    <export function="setInputColor" type="client" />
    <export function="setInputNumberOnly" type="client" />
    <export function="setInputNumberNegative" type="client" />
    <export function="setInputFontPaddingHeight" type="client" />
    <export function="setActiveInput" type="client" />
    <export function="setInputDisableBorder" type="client" />
    <export function="setInputLineHeight" type="client" />
    <export function="setInputMultiline" type="client" />
    <export function="setInputFont" type="client" />
    <export function="setInputMaxLength" type="client" />
    <export function="setInputChangeEvent" type="client" />
    <export function="setInputIcon" type="client" />
    <export function="setInputPassword" type="client" />
    <export function="setInputPlaceholder" type="client" />
    <export function="setInputBorderSize" type="client" />
    <export function="setInputValue" type="client" />
    <export function="getInputValue" type="client" />
    <export function="getActiveInput" type="client" />
    <export function="setActiveInput" type="client" />
    <export function="resetInput" type="client" />]]

function setInputUppercaseOnly(el, val)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      guiElements[el].uppercaseOnly = val
    else
      throwGuiError("setInputUppercaseOnly: guiElement is not input")
    end
  else
    throwGuiError("setInputUppercaseOnly: invalid guiElement")
  end
end

function setInputColor(el, color1, color2, color3, color4, fontColor)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      setElementColorToData(el, "color1", color1)
      setElementColorToData(el, "color2", color2)
      setElementColorToData(el, "color3", color3)
      setElementColorToData(el, "color4", color4)
      setElementColorToData(el, "fontColor", fontColor)
    else
      throwGuiError("setInputColor: guiElement is not input")
    end
  else
    throwGuiError("setInputColor: invalid guiElement")
  end
end

function setInputNumberOnly(el, val)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      guiElements[el].numberOnly = val
      guiElements[el].numberNegative = nil
    else
      throwGuiError("setInputNumberOnly: guiElement is not input")
    end
  else
    throwGuiError("setInputNumberOnly: invalid guiElement")
  end
end

function setInputNumberNegative(el, val)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      guiElements[el].numberOnly = nil
      guiElements[el].numberNegative = val
    else
      throwGuiError("setInputNumberNegative: guiElement is not input")
    end
  else
    throwGuiError("setInputNumberNegative: invalid guiElement")
  end
end

function setInputFontPaddingHeight(el, height)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      if guiElements[el].multiline then
        guiElements[el].paddingHeight = height
        guiElements[el].fontPadding = (height - guiElements[el].fontHeight) / 2
      end
    else
      throwGuiError("setInputFontPaddingHeight: guiElement is not input")
    end
  else
    throwGuiError("setInputFontPaddingHeight: invalid guiElement")
  end
end

function setActiveInput(el)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      if activeInput then
        guiElements[activeInput].active = false
      end
      activeInput = el
      focusPasteBrowser()
      guiElements[activeInput].active = true
    else
      throwGuiError("setActiveInput: guiElement is not input")
    end
  else
    if activeInput then
      guiElements[activeInput].active = false
    end
    activeInput = false
  end
end

function setInputDisableBorder(el, state)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      guiElements[el].disableBorder = state
    else
      throwGuiError("setInputDisableBorder: guiElement is not input")
    end
  else
    throwGuiError("setInputDisableBorder: invalid guiElement")
  end
end

function setInputLineHeight(el, height)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      if guiElements[el].multiline then
        guiElements[el].lineHeight = height
        guiElements[el].maxLines = (guiElements[el].sy - guiElements[el].fontPadding * 2) / guiElements[el].lineHeight
      end
    else
      throwGuiError("setInputLineHeight: guiElement is not input")
    end
  else
    throwGuiError("setInputLineHeight: invalid guiElement")
  end
end

function setInputMultiline(el, state, padding)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      guiElements[el].multiline = state
      if guiElements[el].multiline then
        guiElements[el].fontPadding = tonumber(padding) or 8
        guiElements[el].lineHeight = guiElements[el].fontHeight
        guiElements[el].maxLines = (guiElements[el].sy - guiElements[el].fontPadding * 2) / guiElements[el].lineHeight
        refreshMultilineText(el, true)
      else
        refreshInputSize(el)
      end
    else
      throwGuiError("setInputMultiline: guiElement is not input")
    end
  else
    throwGuiError("setInputMultiline: invalid guiElement")
  end
end

function setInputFont(el, font)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      guiElements[el].font = getFont(font)
      if not guiElements[el].multiline then
        guiElements[el].fontHeight = dxGetFontHeight(fontScales[guiElements[el].font], guiElements[el].font)
        local height = math.ceil(guiElements[el].fontHeight)
        guiElements[el].fontPadding = math.floor((guiElements[el].sy - height) / 2)
        if guiElements[el].password then
          guiElements[el].shownIcon = getFaIconFilename("eye", height)
          guiElements[el].hiddenIcon = getFaIconFilename("eye-slash", height)
        end
      end
    else
      throwGuiError("setInputFont: guiElement is not input")
    end
  else
    throwGuiError("setInputFont: invalid guiElement")
  end
end

function setInputMaxLength(el, maxLength)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      guiElements[el].maxLength = maxLength
    else
      throwGuiError("setInputMaxLength: guiElement is not input")
    end
  else
    throwGuiError("setInputMaxLength: invalid guiElement")
  end
end

function setInputChangeEvent(el, changeEvent)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      guiElements[el].changeEvent = changeEvent
    else
      throwGuiError("setInputChangeEvent: guiElement is not input")
    end
  else
    throwGuiError("setInputChangeEvent: invalid guiElement")
  end
end

function setInputIcon(el, icon, iType)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      if icon then
        guiElements[el].icon = getFaIconFilename(icon, math.ceil(guiElements[el].sy) - 2, iType)
        guiElements[el].iconRaw = icon
        local height = math.ceil(guiElements[el].fontHeight)
        guiElements[el].shownIcon = getFaIconFilename("eye", height)
        guiElements[el].hiddenIcon = getFaIconFilename("eye-slash", height)
      else
        guiElements[el].icon = nil
        guiElements[el].iconRaw = nil
      end
    else
      throwGuiError("setInputIcon: guiElement is not input")
    end
  else
    throwGuiError("setInputIcon: invalid guiElement")
  end
end

function setInputPassword(el, password)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      guiElements[el].password = password
      if guiElements[el].password then
        guiElements[el].mask = ""
        for k = 1, utf8.len(guiElements[el].value or "") do
          guiElements[el].mask = guiElements[el].mask .. "\226\128\162"
        end
      end
    else
      throwGuiError("setInputPassword: guiElement is not input")
    end
  else
    throwGuiError("setInputPassword: invalid guiElement")
  end
end

function setInputPlaceholder(el, text)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      guiElements[el].placeholder = text
    else
      throwGuiError("setInputPlaceholder: guiElement is not input")
    end
  else
    throwGuiError("setInputPlaceholder: invalid guiElement")
  end
end

function setInputBorderSize(el, size)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      guiElements[el].inputBorderSize = size
    else
      throwGuiError("setInputBorderSize: guiElement is not input")
    end
  else
    throwGuiError("setInputBorderSize: invalid guiElement")
  end
end

function setInputValue(el, value)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      guiElements[el].value = value
      guiElements[el].len = utf8.len(guiElements[el].value)
      if guiElements[el].multiline then
        refreshMultilineText(el)
      elseif guiElements[el].password then
        guiElements[el].mask = ""
        for k = 1, utf8.len(guiElements[el].value or "") do
          guiElements[el].mask = guiElements[el].mask .. "\226\128\162"
        end
      end
      if not guiElements[el].cursorPosition or guiElements[el].cursorPosition > utf8.len(guiElements[el].value) then
        guiElements[el].cursorPosition = utf8.len(guiElements[el].value)
      end
    else
      throwGuiError("setInputValue: guiElement is not input")
    end
  else
    throwGuiError("setInputValue: invalid guiElement")
  end
end

function getInputValue(el)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      if guiElements[el].multiline and guiElements[el].value then
        local tmp = split(guiElements[el].value, " ")
        guiElements[el].value = table.concat(tmp, " ")
      end
      return guiElements[el].value
    else
      throwGuiError("getInputValue: guiElement is not input")
    end
  else
    throwGuiError("getInputValue: invalid guiElement")
  end
  return ""
end

function getActiveInput()
  return activeInput
end

function setActiveInput(el)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      if activeInput then
        guiElements[activeInput].active = false
      end
      activeInput = el
      focusPasteBrowser()
      guiElements[activeInput].active = true
    else
      throwGuiError("setActiveInput: guiElement is not input")
    end
  else
    if activeInput then
      guiElements[activeInput].active = false
    end
    activeInput = false
  end
end

function resetInput(el)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "input" then
      guiElements[el].value = ""
      guiElements[el].len = 0
      guiElements[el].mask = ""
      guiElements[el].cursorPosition = 0
      refreshMultilineText(el)
    else
      throwGuiError("resetInput: guiElement is not input")
    end
  else
    throwGuiError("resetInput: invalid guiElement")
  end
end

--[[    <!-- labelC.lua -->
    <export function="setLabelRotation" type="client" />
    <export function="setLabelClip" type="client" />
    <export function="setLabelWordBreak" type="client" />
    <export function="setLabelAlignment" type="client" />
    <export function="setLabelShadow" type="client" />
    <export function="setLabelFont" type="client" />
    <export function="setLabelColor" type="client" />
    <export function="setLabelText" type="client" />
    <export function="getLabelFontHeight" type="client" />
    <export function="getLabelTextWidth" type="client" />
    <export function="fadeInLabel" type="client" />
    <export function="fadeOutLabel" type="client" />]]

function setLabelRotation(el, rotation)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "label" then
      guiElements[el].rotation = rotation
    else
      throwGuiError("setLabelRotation: guiElement is not label")
    end
  else
    throwGuiError("setLabelRotation: invalid guiElement (" .. tostring(el) .. ")")
  end
end

function setLabelClip(el, state)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "label" then
      guiElements[el].clip = state
    else
      throwGuiError("setLabelClip: guiElement is not label")
    end
  else
    throwGuiError("setLabelClip: invalid guiElement")
  end
end

function setLabelWordBreak(el, state)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "label" then
      guiElements[el].wordBreak = state
    else
      throwGuiError("setLabelWordBreak: guiElement is not label")
    end
  else
    throwGuiError("setLabelWordBreak: invalid guiElement")
  end
end

function setLabelAlignment(el, al1, al2)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "label" then
      if al1 then
        guiElements[el].al1 = al1
      end
      if al2 then
        guiElements[el].al2 = al2
      end
    else
      throwGuiError("setLabelAlignment: guiElement is not label")
    end
  else
    throwGuiError("setLabelAlignment: invalid guiElement")
  end
end

function setLabelShadow(el, color, x, y)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "label" then
      if color then
        setElementColorToData(el, "shadow", color)
        guiElements[el].shadowX = x
        guiElements[el].shadowY = y
      else
        setElementColorToData(el, "shadow", false)
        guiElements[el].shadow = false
      end
    else
      throwGuiError("setLabelShadow: guiElement is not label")
    end
  else
    throwGuiError("setLabelShadow: invalid guiElement")
  end
end

function setLabelFont(el, font)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "label" then
      guiElements[el].font = isElement(font) and font or getFont(font)
      if guiElements[el].text then
        guiElements[el].textWidth = getTextWidthFont(guiElements[el].text, guiElements[el].font)
      end
      guiElements[el].fontHeight = getFontHeight(guiElements[el].font)
    else
      throwGuiError("setLabelFont: guiElement is not label")
    end
  else
    throwGuiError("setLabelFont: invalid guiElement")
  end
end

function setLabelColor(el, color)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "label" then
      setElementColorToData(el, "fontColor", color)
    else
      throwGuiError("setLabelColor: guiElement is not label")
    end
  else
    throwGuiError("setLabelColor: invalid guiElement")
  end
end

function setLabelText(el, text)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "label" then
      guiElements[el].ot = text
      guiElements[el].text = utf8.gsub(guiElements[el].ot, "%[color%=([a-zA-Z1-9]*)%]", function(color)
        return getColorCodeHex(color)
      end)
      guiElements[el].textWidth = getTextWidthFont(guiElements[el].text, guiElements[el].font)
    else
      throwGuiError("setLabelText: guiElement is not label")
    end
  else
    throwGuiError("setLabelText: invalid guiElement")
  end
end

function getLabelFontHeight(el)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "label" then
      guiElements[el].fontHeight = getFontHeight(guiElements[el].font)
      return guiElements[el].fontHeight
    else
      throwGuiError("getLabelFontHeight: guiElement is not label")
    end
  else
    throwGuiError("getLabelFontHeight: invalid guiElement")
  end
end

function getLabelTextWidth(el)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "label" then
      if guiElements[el].text then
        guiElements[el].textWidth = getTextWidthFont(guiElements[el].text, guiElements[el].font)
        return guiElements[el].textWidth
      else
        return 0
      end
    else
      throwGuiError("getLabelTextWidht: guiElement is not label")
    end
  else
    throwGuiError("getLabelTextWidht: invalid guiElement")
  end
end

function fadeInLabel(el, time)
  fadeIn(el, time)
end

function fadeOutLabel(el, time)
  fadeOut(el, time)
end

--[[    <!-- sliderC.lua -->
    <export function="setSliderChangeEvent" type="client" />
    <export function="setSliderBorder" type="client" />
    <export function="setSliderSize" type="client" />
    <export function="setSliderColor" type="client" />
    <export function="setSliderValue" type="client" />
    <export function="getSliderValue" type="client" />]]

function setSliderChangeEvent(el, event)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "slider" then
      guiElements[el].changeEvent = event
    else
      throwGuiError("setSliderChangeEvent: guiElement is not slider")
    end
  else
    throwGuiError("setSliderChangeEvent: invalid guiElement")
  end
end

function setSliderBorder(el, col, size, ex)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "slider" then
      if col then
        setElementColorToData(el, "sliderBorderColor", col)
        guiElements[el].sliderBorderSize = size or 1
        guiElements[el].sliderBorderEx = ex
      else
        guiElements[el].sliderBorderColor = nil
        guiElements[el].sliderBorderEx = nil
        setElementColorToData(el, "sliderBorderColor", false)
        guiElements[el].sliderBorderSize = nil
      end
    else
      throwGuiError("setSliderSize: guiElement is not slider")
    end
  else
    throwGuiError("setSliderSize: invalid guiElement")
  end
end

function setSliderSize(el, size)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "slider" then
      guiElements[el].sliderSize = size
    else
      throwGuiError("setSliderSize: guiElement is not slider")
    end
  else
    throwGuiError("setSliderSize: invalid guiElement")
  end
end

function setSliderColor(el, color1, color2)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "slider" then
      setElementColorToData(el, "color1", color1)
      setElementColorToData(el, "color2", color2)
    else
      throwGuiError("setSliderColor: guiElement is not slider")
    end
  else
    throwGuiError("setSliderColor: invalid guiElement")
  end
end

function setSliderValue(el, value)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "slider" then
      guiElements[el].sliderValue = math.min(1, math.max(value, 0))
    else
      throwGuiError("setSliderValue: guiElement is not slider")
    end
  else
    throwGuiError("setSliderValue: invalid guiElement")
  end
end

function getSliderValue(el, value)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "slider" then
      return guiElements[el].sliderValue
    else
      throwGuiError("getSliderValue: guiElement is not slider")
    end
  else
    throwGuiError("getSliderValue: invalid guiElement")
  end
end

--[[    <!-- toggleC.lua -->
    <export function="setToggleColor" type="client" />
    <export function="setToggleState" type="client" />
    <export function="getToggleState" type="client" />]]

function setToggleColor(el, color1, color2, color3)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "toggle" then
      setElementColorToData(el, "color1", color1)
      setElementColorTableToData(el, "color2", color2)
      setElementColorTableToData(el, "color3", color3)
    else
      throwGuiError("setToggleColor: guiElement is not toggle")
    end
  else
    throwGuiError("setToggleColor: invalid guiElement")
  end
end

function setToggleState(el, state, skipAnimation)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "toggle" then
      guiElements[el].toggleState = state
      if skipAnimation then
        guiElements[el].toggleStateVal = state and 1 or 0
      end
    else
      throwGuiError("setToggleState: guiElement is not toggle")
    end
  else
    throwGuiError("setToggleState: invalid guiElement")
  end
end

function getToggleState(el)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "toggle" then
      return guiElements[el].toggleState
    else
      throwGuiError("getToggleState: guiElement is not toggle")
    end
  else
    throwGuiError("getToggleState: invalid guiElement")
  end
end

--[[    <!-- windowC.lua -->
    <export function="setWindowMoveEvent" type="client" />
    <export function="setWindowCloseButton" type="client" />
    <export function="setWindowColors" type="client" />
    <export function="setWindowTitle" type="client" />
    <export function="setWindowElementMaxDistance" type="client" />]]

function setWindowMoveEvent(el, ev)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "window" then
      guiElements[el].moveEvent = ev
    else
      throwGuiError("setWindowMoveEvent: guiElement is not window")
    end
  else
    throwGuiError("setWindowMoveEvent: invalid guiElement")
  end
end

function setWindowCloseButton(el, event, icon, color)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "window" then
      if event then
        color = color or "sightred"
        icon = icon or "times"
        guiElements[el].closeIcon = getFaIconFilename(icon, titleBarHeight)
        guiElements[el].closeIconEvent = event
        setElementColorToData(el, "closeButtonColor", color)
      else
        guiElements[el].closeIcon = nil
        guiElements[el].closeIconEvent = nil
        setElementColorToData(el, "closeButtonColor", false)
      end
    else
      throwGuiError("setWindowCloseButton: guiElement is not window")
    end
  else
    throwGuiError("setWindowCloseButton: invalid guiElement")
  end
end

function setWindowColors(el, bcg, titleColor, light, text)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "window" then
      setElementColorToData(el, "bcg", bcg)
      setElementColorToData(el, "titleColor", titleColor)
      setElementColorToData(el, "light", light)
      setElementColorToData(el, "textColor", textColor)
    else
      throwGuiError("setWindowColors: guiElement is not window")
    end
  else
    throwGuiError("setWindowColors: invalid guiElement")
  end
end

function setWindowTitle(el, font, title)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "window" then
      guiElements[el].font = getFont(font)
      local height = math.ceil(dxGetFontHeight(fontScales[guiElements[el].font], guiElements[el].font))
      guiElements[el].fontPadding = math.floor((titleBarHeight - height) / 2)
      guiElements[el].title = title
    else
      throwGuiError("setWindowTitle: guiElement is not window")
    end
  else
    throwGuiError("setWindowTitle: invalid guiElement")
  end
end

function setWindowElementMaxDistance(el, element, distance, closeEvent)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "window" then
      guiElements[el].element = element
      guiElements[el].maxDistance = distance
      guiElements[el].elementEvent = closeEvent
    else
      throwGuiError("setWindowElementMaxDistance: guiElement is not window")
    end
  else
    throwGuiError("setWindowElementMaxDistance: invalid guiElement")
  end
end

--[[    <!-- logoC.lua -->
    <export function="setLogoAnimated" type="client" />
    <export function="playLogoAnimation" type="client" />]]

function setLogoAnimated(el, animated)
    if tonumber(el) and guiElements[el] then
        if guiElements[el].type == "logo" then
            shader = dxCreateShader(shaderCode)
            guiElements[el].animatedLogo = animated
        else
            outputDebugString("setLogoAnimated: guiElement is not a logo", 1)
        end
    else
        outputDebugString("setLogoAnimated: invalid guiElement", 1)
    end
end

function playLogoAnimation(el, animType, animationTime)
    if not (tonumber(el) and guiElements[el]) then
        outputDebugString("playLogoAnimation: invalid guiElement", 1)
        return
    end
    if guiElements[el].type ~= "logo" then
        outputDebugString("playLogoAnimation: guiElement is not a logo", 1)
        return
    end

    local now = getTickCount()
    local animTime = animationTime or 1000

    if animType == "in" or animType == "out" then
        guiElements[el].logoAnimationType = animType
        guiElements[el].logoAnimations = { startTick = now, duration = animTime }
        if animType == "in" then
            guiElements[el].faded = false
        end
    else
        outputDebugString("playLogoAnimation: animType must be 'in' or 'out'", 1)
    end
end

--[[    <!-- sourceS.lua -->
    <export function="thousandsStepper" type="server" />]]

function thousandsStepper(amount)
    local formatted = amount
    while true do
      formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1 %2")
      if k == 0 then
        break
      end
    end
    return formatted
  end

  function showInfobox(player, type, msg)
    triggerClientEvent(player, "showInfobox", resourceRoot, type, msg)
end

--[[sItems Exports]]

--[[    <export function="toggleInventory" type="client" />
    <export function="processTooltip" type="client" />
    <export function="drawShowItem" type="client" />
    <export function="playerHasItemWithData" type="client" />
    <export function="takeBullet" type="client" />
    <export function="playerHasItem" type="client" />
    <export function="getLocalPlayerItems" type="client" />
    <export function="getLocalPlayerItemsEx" type="client" />
    <export function="playerHasItemWithAmount" type="client" />
    <export function="getAirsoftItems" type="shared" />
    
    <export function="findPrimaryItem" type="server" />
    <export function="unuseItem" type="server" />
    <export function="removeRadio" type="server" />
    <export function="createSafe" type="server" />
    <export function="validRadio" type="server" />
    <export function="getItemSlotID" type="server" />
    <export function="getRadioDatas" type="server" />
    <export function="giveItem" type="server" />
    <export function="takeDutyItems" type="server" />
    <export function="usingMegaphone" type="server" />
    <export function="checkPawnItems" type="server" />
    <export function="playerHasItemWithData" type="server" />
    <export function="hasItemWithData" type="server" />
    <export function="takeItem" type="server" />
    <export function="enableWeaponFire" type="server" />
    <export function="getElementItems" type="server" />
    <export function="hasItem" type="server" />
    <export function="hasItemEx" type="server" />
    <export function="addItemDose" type="server" />
    <export function="getCurrentWeight" type="server" />
    <export function="getCurrentWeight" type="client" />
    <export function="getWeightLimit" type="client" />
    <export function="getItemWeight" type="server" />
    <export function="getWeightLimit" type="server" />
    <export function="formatSerial" type="server" />
    <export function="getLastWeaponSerial" type="server" />
    <export function="hasSpaceForItem" type="server" />
    <export function="setItemData2" type="server" />
    <export function="updateItemData3" type="server" />
    <export function="updateItemData2" type="server" />
    <export function="updateItemData1" type="server" />
    <export function="getItemData1" type="server" />
    <export function="getItemData" type="server" />
    <export function="createInteriorSafe" type="server" />
    <export function="getItemCount" type="server" />
    <export function="getItemCountEx" type="server" />
    
    <export function="getItemSpecialTooltip" type="shared" />
    <export function="getItemPic" type="shared" />
    <export function="getItemInfoForShop" type="shared" />
    <export function="isKeyItem" type="shared" />
    <export function="getHifiItem" type="shared" />
    <export function="isPaperItem" type="shared" />
    <export function="getItemNameList" type="shared" />
    <export function="getItemDescriptionList" type="shared" />
    <export function="getItemName" type="shared" />
    <export function="getItemWeight" type="shared" />
    <export function="getItemType" type="shared" />
    <export function="getWeaponID" type="shared" />
    <export function="isItemDroppable" type="shared" />
    <export function="isItemStackable" type="shared" />
    <export function="getItemAmmoID" type="shared" />
    <export function="getItemModel" type="shared" />
    <export function="getLastItemId" type="shared" />]]

function drawShowItem(itemData, sx, plusY)
	local itemX = math.floor(sx / 2 - defaultSettings.slotBoxWidth * 1.1 / 2)
	local itemY = plusY
	local perishable = false
	local alpha = 255
	if perishableItems[itemData.itemId] then
		alpha = 255 * (1 - itemData.data3 / perishableItems[itemData.itemId])
		perishable = grayItemPictures[itemData.itemId]
	end
	if copyableItems[itemData.itemId] and isTheItemCopy(itemData) then
		alpha = 0
		perishable = grayItemPictures[itemData.itemId]
	end
	local picPath = getItemPic(itemData)
	if perishable then
		dxDrawImage(itemX, itemY, defaultSettings.slotBoxWidth * 1.1, defaultSettings.slotBoxHeight * 1.1, perishable, 0, 0, 0, tocolor(255, 255, 255, 255))
	end
	dxDrawImage(itemX, itemY, defaultSettings.slotBoxWidth * 1.1, defaultSettings.slotBoxHeight * 1.1, picPath, 0, 0, 0, tocolor(255, 255, 255, alpha))
	local dose = 1
	if doseItems[itemData.itemId] then
		dose = tonumber(itemData.data1)
		if dose then
			dose = 1 - dose / doseItems[itemData.itemId]
		else
			dose = 1
		end
	end
	if dose < 1 then
		dxDrawRectangle(itemX + 3, itemY + defaultSettings.slotBoxHeight * 1.1 - 8 - 1, defaultSettings.slotBoxWidth * 1.1 - 6, 6, titlebar)
		dxDrawRectangle(itemX + 4, itemY + defaultSettings.slotBoxHeight * 1.1 - 8, (defaultSettings.slotBoxWidth * 1.1 - 8) * dose, 4, useColor)
	elseif currentAmount < itemData.amount then
		if 0 < currentAmount then
			dxDrawText(currentAmount, itemX + defaultSettings.slotBoxWidth * 1.1 - 6, itemY + defaultSettings.slotBoxHeight * 1.1 - 15, itemX + defaultSettings.slotBoxWidth * 1.1, itemY + defaultSettings.slotBoxHeight * 1.1 - 15 + 5, tocolor(255, 255, 255, 255), craftFontScale * 0.75, craftFont, "right", "top")
		else
			dxDrawText(itemData.amount, itemX + defaultSettings.slotBoxWidth * 1.1 - 6, itemY + defaultSettings.slotBoxHeight * 1.1 - 15, itemX + defaultSettings.slotBoxWidth * 1.1, itemY + defaultSettings.slotBoxHeight * 1.1 - 15 + 5, tocolor(255, 255, 255, 255), craftFontScale * 0.75, craftFont, "right", "top")
		end
	else
		dxDrawText(itemData.amount, itemX + defaultSettings.slotBoxWidth * 1.1 - 6, itemY + defaultSettings.slotBoxHeight * 1.1 - 15, itemX + defaultSettings.slotBoxWidth * 1.1, itemY + defaultSettings.slotBoxHeight * 1.1 - 15 + 5, tocolor(255, 255, 255, 255), craftFontScale * 0.75, craftFont, "right", "top")
	end
	local itemId = itemData.itemId
	if itemList[itemId] then
		local theItemName = itemList[itemId][1]
		local absX = sx / 2
		local absY = defaultSettings.slotBoxHeight + 16 + plusY
		return processTooltip(absX, absY, theItemName, itemId, itemData, true, false)
	end
end

function playerHasItemWithData(id, data1)
	data1 = tonumber(data1) or data1
	for k, v in pairs(itemsTable.player) do
		if v.itemId == id then
			local vdata1 = tonumber(v.data1) or v.data1
			if vdata1 == data1 then
				return true
			end
		end
	end
	return false
end

function getLocalPlayerItems()
	return itemsTable.player
end

function getLocalPlayerItemsEx()
	local dat = sightexports.sItems:getLocalPlayerItems()
	local list = {}
	for k, v in pairs(dat) do
		table.insert(list, {
			v,
			itemList[v.itemId] and itemList[v.itemId][1] or "n/a",
			itemList[v.itemId] and itemList[v.itemId][2] or "n/a"
		})
	end
	return list
end

function playerHasItemWithAmount(id, amount)
	amount = tonumber(data1) or amount
	local allAmount = 0
	for k, v in pairs(itemsTable.player) do
		if v.itemId == id then
			allAmount = allAmount + v.amount
		end
	end
	return allAmount >= amount
end

function getItemSlotID(element, itemDBID)
    if itemsTable[element] then
        for k, v in pairs(itemsTable[element]) do
            if v.dbID == itemDBID then
                return v.slot
            end
        end
    end
    
    return false
end

function giveItem(element, itemId, amount, slotId, data1, data2, data3)
    if isElement(element) then
        local ownerType = getElementType(element)
        local ownerId = false
        
        if ownerType == "player" then
            ownerId = getElementData(element, defaultSettings.characterId)
        elseif ownerType == "vehicle" then
            ownerId = getElementData(element, defaultSettings.vehicleId)
        elseif ownerType == "object" then
            ownerId = getElementData(element, defaultSettings.objectId)
        end
        
        if ownerId then
            if not itemsTable[element] then
                itemsTable[element] = {}
            end
            
            if not slotId then
                slotId = findEmptySlot(element, ownerType, itemId)
            elseif tonumber(slotId) then
                if itemsTable[element][slotId] then
                    slotId = findEmptySlot(element, ownerType, itemId)
                end
            end
            
            if tonumber(slotId) then
                if perishableItems[itemId] then
                    data3 = 0
                end
                
                --[[if itemId == 9 then -- phone
                    queuedPhoneItems[ownerId] = {element, ownerType, ownerId, itemId, amount, slotId, data1, data2, data3}
                    safeCall("sMobile", "generateNewPhone", ownerId)
                    return true
                end]]
                
                if itemId == 9 then
                    lastPhoneNumber = lastPhoneNumber + 1
                    data1 = lastPhoneNumber
                    data2 = toJSON({
                        noti = 1,
                        ringtone = 1,
                        sound = true,
                        vibration = false,
                        location = true,
                        voice = true
                    }, true)
                end
                
                giveItemImpl(element, ownerType, ownerId, itemId, amount, slotId, data1, data2, data3)
                
                return true
            end
        end
    end
    
    return false
end

function playerHasItemWithData(thePlayer, id, data1)
    if itemsTable[thePlayer] then
        data1 = tonumber(data1) or data1
        for k, v in pairs(itemsTable[thePlayer]) do
            if v.itemId == id then
                local vdata1 = tonumber(v.data1) or v.data1
                if vdata1 == data1 then
                    return v
                end
            end
        end
    end
    
    return false
end

function hasItemWithData(thePlayer, id, dataType, data)
    if itemsTable[thePlayer] then
        data = tonumber(data) or data
        for k, v in pairs(itemsTable[thePlayer]) do
            if not id or v.itemId == id then
                local vdata = tonumber(v["dataType"]) or v["dataType"]
                if vdata == data then
                    return v
                end
            end
        end
    end
    
    return false
end

function hasItem(element, itemId, amount)
    if itemsTable[element] then
        for k, v in pairs(itemsTable[element]) do
            if v.itemId == itemId and (not amount or v.amount == amount) then
                return v
            end
        end
    end
    
    return false
end

function hasItemEx(element, dataName, dataValue, amount, data1)
    if itemsTable[element] then
        for k, v in pairs(itemsTable[element]) do
            if v[dataName] == dataValue and (not amount or v.amount >= amount) and (not data1 or (v.data1 == data1 or tonumber(v.data1) == data1)) then
                return v
            end
        end
    end
    
    return false
end

function getItemCount(element, itemId)
    local foundAmount = 0
    
    if itemsTable[element] then
        for k, v in pairs(itemsTable[element]) do
            if v.itemId == itemId then
                foundAmount = foundAmount + v.amount
            end
        end
    end
    
    return foundAmount
end

function getItemCountEx(element, dbID)
    local foundAmount = 0
    
    if itemsTable[element] then
        for k, v in pairs(itemsTable[element]) do
            if v.dbID == dbID then
                foundAmount = v.amount
            end
        end
    end
    
    return foundAmount
end

function getItemData1(thePlayer, itemDBID)
    if itemsTable[thePlayer] then
        for k, v in pairs(itemsTable[thePlayer]) do
            if v.dbID == itemDBID then
                return v.data1 or 0
            end
        end
    end
end

function getItemData(thePlayer, itemDatabaseIdentity, dataType)
    if itemsTable[thePlayer] then
        for k, v in pairs(itemsTable[thePlayer]) do
            if v.dbID == itemDatabaseIdentity then
                if dataType == 1 then
                    return v.data1 or 0
                elseif dataType == 2 then
                    return v.data2 or 0
                elseif dataType == 3 then
                    return v.data3 or 0
                end
            end
        end
    end
end

function getItemSpecialTooltip(itemId)
  if newItemList[itemId] then
    return newItemList[itemId].tooltip
  end
  return false
end

function getItemPic(itemData)
  if tonumber(itemData) then
    local id = itemData - 1
    if differentPics[id] then
      return "files/items/" .. id .. ".png"
    elseif hasPic[id] then
      return "files/items/" .. id .. ".png"
    end
    return "files/items/nopic.png"
  else
    local picPath = "files/items/nopic.png"
    if lotteryTickets[itemData.itemId] then
      if itemData.data3 == "empty" then
        picPath = "files/items/" .. itemData.itemId - 1 .. "_monochrome.png"
      else
        picPath = "files/items/" .. itemData.itemId - 1 .. ".png"
      end
    else
      local id = itemData.itemId - 1
      if differentPics[id] then
        picPath = "files/items/sight/" .. id .. ".png"
      elseif hasPic[id] then
        picPath = "files/items/" .. id .. ".png"
      end
    end
    return picPath
  end
end

function getItemName(id)
  if not itemList[id] then
    return ""
  else
    return itemList[id][1]
  end
end

function getItemWeight(id)
  if not itemList[id] then
    return 0
  else
    return itemList[id][10] or 0
  end
end

function getItemType(id)
  if not itemList[id] then
    return 0
  else
    return itemList[id][3]
  end
end

function isItemStackable(id)
  if not itemList[id] then
    return false
  else
    return itemList[id][14]
  end
end

function getLastItemId()
  return #itemList
end