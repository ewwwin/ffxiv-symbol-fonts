# ffxiv-symbol-fonts

Font files for displaying FFXIV's special characters, pulled from the Lodestone.

Assets in this repository are owned by Square Enix and reproduced in accordance with the [Materials Usage License](https://support.na.square-enix.com/rule.php?id=5382&tag=authc). © SQUARE ENIX. FINAL FANTASY is a registered trademark of Square Enix Holdings Co., Ltd.

## Basic Usage

In addition to the raw font files, this repo provides a CSS stylesheet which defines a `FFXIV_Lodestone_SSF` font family that you can use in your own styles. Assets are hosted via Github Pages and are available at https://ewwwin.github.io/ffxiv-symbol-fonts/.

```css
/* CSS */
@import "https://ewwwin.github.io/ffxiv-symbol-fonts/FFXIV_Lodestone_SSF.css";
/* Use whatever CSS class you want here */
.ffxiv-chat-icon { font-family: "FFXIV_Lodestone_SSF" }
```
```html
<!-- HTML -->
Maple Lumber <span class="ffxiv-chat-icon">&#xE03C;</span>
```

## Supported characters

A preview of all characters supported by the font can be found [here](https://ewwwin.github.io/ffxiv-symbol-fonts/characters.html).

## Font updates

The assets in this repository are automatically updated from any changes to the font that get pushed to the Lodestone. Font files are scraped and processed by `make.sh`, and the Github action at `.github/workflows/check.yml` runs this script once per day and creates a pull request with any changes, which I then manually review. By linking to the assets in this repository, new icons will become available without any action on your part.
