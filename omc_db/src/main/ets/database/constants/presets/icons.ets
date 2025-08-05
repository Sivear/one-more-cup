const iconMap: Map<string, Resource> = new Map([
  ["beverage_001_beercan", $r("app.media.beverage_001_beercan")],
  ["beverage_002_milkshake", $r("app.media.beverage_002_milkshake")],
  ["beverage_003_cappuccino", $r("app.media.beverage_003_cappuccino")],
  ["beverage_004_milkbox", $r("app.media.beverage_004_milkbox")],
  ["beverage_005_orangejuice", $r("app.media.beverage_005_orangejuice")],
  ["beverage_006_champagne", $r("app.media.beverage_006_champagne")],
  ["beverage_007_cocktail", $r("app.media.beverage_007_cocktail")],
  ["beverage_008_coconutdrink", $r("app.media.beverage_008_coconutdrink")],
  ["beverage_009_coffeecup", $r("app.media.beverage_009_coffeecup")],
  ["beverage_010_cosmopolitan", $r("app.media.beverage_010_cosmopolitan")],
  ["beverage_011_frappe", $r("app.media.beverage_011_frappe")],
  ["beverage_012_chocolatemilk", $r("app.media.beverage_012_chocolatemilk")],
  ["beverage_013_milkbottle", $r("app.media.beverage_013_milkbottle")],
  ["beverage_014_pintofbeer", $r("app.media.beverage_014_pintofbeer")],
  ["beverage_015_coffee", $r("app.media.beverage_015_coffee")],
  ["beverage_016_latte", $r("app.media.beverage_016_latte")],
  ["beverage_017_icedcoffee", $r("app.media.beverage_017_icedcoffee")],
  ["beverage_018_icedcoffee", $r("app.media.beverage_018_icedcoffee")],
  ["beverage_019_margarita", $r("app.media.beverage_019_margarita")],
  ["beverage_020_martini", $r("app.media.beverage_020_martini")],
  ["beverage_021_milkshake", $r("app.media.beverage_021_milkshake")],
  ["beverage_022_mojito", $r("app.media.beverage_022_mojito")],
  ["beverage_023_orangejuice", $r("app.media.beverage_023_orangejuice")],
  ["beverage_024_wineglass", $r("app.media.beverage_024_wineglass")],
  ["beverage_025_milkshake", $r("app.media.beverage_025_milkshake")],
  ["beverage_026_cocktails_14", $r("app.media.beverage_026_cocktails_14")],
  ["beverage_026_smoothie", $r("app.media.beverage_026_smoothie")],
  ["beverage_027_Softdrink", $r("app.media.beverage_027_softdrink")],
  ["beverage_028_Softdrink", $r("app.media.beverage_028_softdrink")],
  ["beverage_029_tea", $r("app.media.beverage_029_tea")],
  ["beverage_030_cocktails_10", $r("app.media.beverage_030_cocktails_10")],
  ["beverage_030_whiskeyontherocks", $r("app.media.beverage_030_whiskeyontherocks")]
])

export class IconManager {
  static getRandomIcon() {
    const index = Math.floor(Math.random() * iconMap.size)
    return Array.from(iconMap.keys())[index]
  }

  static getIconById(id: string) {
    return iconMap.get(id) ?? $r("app.media.beverage_002_milkshake")
  }
}
