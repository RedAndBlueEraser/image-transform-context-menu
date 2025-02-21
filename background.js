browser.runtime.onInstalled.addListener(() => {
  /* Create menu items for image and video contexts. */
  const contexts = ["image", "video"];
  const menusCreateProperties = [
    {
      id: "transform",
      title: browser.i18n.getMessage("transformMenuItemTitle"),
      contexts: contexts,
      icons: {
        16: "img/rotate.svg"
      }
    },
    {
      id: "rotate-90deg-clockwise",
      title: browser.i18n.getMessage("rotate90degClockwiseMenuItemTitle"),
      parentId: "transform",
      icons: {
        16: "img/rotate-90deg-clockwise.svg"
      }
    },
    {
      id: "rotate-90deg-counterclockwise",
      title: browser.i18n.getMessage("rotate90degCounterclockwiseMenuItemTitle"),
      parentId: "transform",
      icons: {
        16: "img/rotate-90deg-counterclockwise.svg"
      }
    },
    {
      id: "rotate-180deg",
      title: browser.i18n.getMessage("rotate180DegMenuItemTitle"),
      parentId: "transform",
      icons: {
        16: "img/rotate-180deg.svg"
      }
    },
    {
      id: "flip-vertical",
      title: browser.i18n.getMessage("flipVerticalMenuItemTitle"),
      parentId: "transform",
      icons: {
        16: "img/flip-vertical.svg"
      }
    },
    {
      id: "flip-horizontal",
      title: browser.i18n.getMessage("flipHorizontalMenuItemTitle"),
      parentId: "transform",
      icons: {
        16: "img/flip-horizontal.svg"
      }
    }
  ];
  for (const createProperties of menusCreateProperties) {
    browser.menus.create(createProperties);
  }
});

browser.menus.onClicked.addListener((info, tab) => {
  /* Send message to context script to modify the HTML element with the correct transform. */
  browser.tabs.sendMessage(tab.id, info.menuItemId, { frameId: info.frameId });
});
