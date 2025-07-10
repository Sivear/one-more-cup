const iconMap: Map<string, Resource> = new Map([
  ["001_beercan", $r("app.media.001_beercan")],
  ["002_milkshake", $r("app.media.002_milkshake")],
  ["003_cappuccino", $r("app.media.003_cappuccino")],
  ["004_milkbox", $r("app.media.004_milkbox")],
  ["005_orangejuice", $r("app.media.005_orangejuice")],
  ["006_champagne", $r("app.media.006_champagne")],
  ["007_cocktail", $r("app.media.007_cocktail")],
  ["008_coconutdrink", $r("app.media.008_coconutdrink")],
  ["009_coffeecup", $r("app.media.009_coffeecup")],
  ["010_cosmopolitan", $r("app.media.010_cosmopolitan")],
  ["011_frappe", $r("app.media.011_frappe")],
  ["012_chocolatemilk", $r("app.media.012_chocolatemilk")],
  ["013_milkbottle", $r("app.media.013_milkbottle")],
  ["014_pintofbeer", $r("app.media.014_pintofbeer")],
  ["015_coffee", $r("app.media.015_coffee")],
  ["016_latte", $r("app.media.016_latte")],
  ["017_icedcoffee", $r("app.media.017_icedcoffee")],
  ["018_icedcoffee", $r("app.media.018_icedcoffee")],
  ["019_margarita", $r("app.media.019_margarita")],
  ["020_martini", $r("app.media.020_martini")],
  ["021_milkshake", $r("app.media.021_milkshake")],
  ["022_mojito", $r("app.media.022_mojito")],
  ["023_orangejuice", $r("app.media.023_orangejuice")],
  ["024_wineglass", $r("app.media.024_wineglass")],
  ["025_milkshake", $r("app.media.025_milkshake")],
  ["026_cocktails_14", $r("app.media.026_cocktails_14")],
  ["026_smoothie", $r("app.media.026_smoothie")],
  ["027_Softdrink", $r("app.media.027_Softdrink")],
  ["028_Softdrink", $r("app.media.028_Softdrink")],
  ["029_tea", $r("app.media.029_tea")],
  ["030_cocktails_10", $r("app.media.030_cocktails_10")],
  ["030_whiskeyontherocks", $r("app.media.030_whiskeyontherocks")]
])

export class IconManager {
  static getRandomIcon() {
    const index = Math.floor(Math.random() * iconMap.size)
    return Array.from(iconMap.keys())[index]
  }

  static getIconById(id: string) {
    return iconMap.get(id) ?? $r("app.media.002_milkshake")
  }
}































