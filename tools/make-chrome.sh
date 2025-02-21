#!/bin/bash

if [ -n "$1" ]; then
  cd $1
fi

# manifest.json
# Replace SVG icons with PNG icons.
sed -i 's/"16": "img\/rotate\.svg"/"16": "img\/rotate-16.png"/g' manifest.json
sed -i 's/"48": "img\/rotate\.svg"/"48": "img\/rotate-48.png"/g' manifest.json
sed -i 's/"128": "img\/rotate\.svg"/"128": "img\/rotate-128.png"/g' manifest.json
# Replace permissions.menus with permissions.contextMenus in manifest.json.
sed -i 's/"menus"/"contextMenus"/g' manifest.json
# Replace background.scripts with background.service_worker in manifest.json.
sed -i 's/"scripts": \["background\.js"\]/"service_worker": "background.js"/g' manifest.json
sed -i -rz 's/"  browser_specific_settings": \{\n    "gecko": \{\n      "id": "image-transform-context-menu@RedAndBlueEraser"\n    \}\n  \},\n//g' manifest.json

# background.js, content.js
# Replace browser.* with chrome.* in *.js.
find *.js -type f -exec sed -i 's/\<browser\>/chrome/g' {} +
# Replace browser.menus with browser.contextMenus in *.js.
find *.js -type f -exec sed -i 's/\.menus\b/.contextMenus/g' {} +
# Delete menusCreateProperties[].icons in *.js.
find *.js -type f -exec sed -i -rz 's/,(\s|\n)*icons:(\s|\n)*\{[^\{]*\}/,contexts:contexts}/g' {} +
