/* Get focused element. */
let targetElement;
document.addEventListener("contextmenu", ({ target }) => {
  targetElement = target;
});

/* Modify focused element. */
browser.runtime.onMessage.addListener((message) => {
  switch (message) {
    /* Transform image or video. */
    case "rotate-90deg-clockwise":
      targetElement.style.transform = "rotate(90deg) " + targetElement.style.transform;
      break;
    case "rotate-90deg-counterclockwise":
      targetElement.style.transform = "rotate(-90deg) " + targetElement.style.transform;
      break;
    case "rotate-180deg":
      targetElement.style.transform = "rotate(180deg) " + targetElement.style.transform;
      break;
    case "flip-vertical":
      targetElement.style.transform = "scaleY(-1) " + targetElement.style.transform;
      break;
    case "flip-horizontal":
      targetElement.style.transform = "scaleX(-1) " + targetElement.style.transform;
      break;
  }
});
