const iconMap: Map<string, Resource> = new Map([
  ["a-001-beercan", $r("app.media.a-001-beercan")],
  ["a-002-milkshake", $r("app.media.a-002-milkshake")],
  ["a-003-cappuccino", $r("app.media.a-003-cappuccino")],
  ["a-004-milkbox", $r("app.media.a-004-milkbox")],
  ["a-005-orangejuice", $r("app.media.a-005-orangejuice")],
  ["a-006-champagne", $r("app.media.a-006-champagne")],
  ["a-007-cocktail", $r("app.media.a-007-cocktail")],
  ["a-008-coconutdrink", $r("app.media.a-008-coconutdrink")],
  ["a-009-coffeecup", $r("app.media.a-009-coffeecup")],
  ["a-010-cosmopolitan", $r("app.media.a-010-cosmopolitan")],
  ["a-011-frappe", $r("app.media.a-011-frappe")],
  ["a-012-chocolatemilk", $r("app.media.a-012-chocolatemilk")],
  ["a-013-milkbottle", $r("app.media.a-013-milkbottle")],
  ["a-014-pintofbeer", $r("app.media.a-014-pintofbeer")],
  ["a-015-coffee", $r("app.media.a-015-coffee")],
  ["a-016-latte", $r("app.media.a-016-latte")],
  ["a-017-icedcoffee", $r("app.media.a-017-icedcoffee")],
  ["a-018-icedcoffee", $r("app.media.a-018-icedcoffee")],
  ["a-019-margarita", $r("app.media.a-019-margarita")],
  ["a-020-martini", $r("app.media.a-020-martini")],
  ["a-021-milkshake", $r("app.media.a-021-milkshake")],
  ["a-022-mojito", $r("app.media.a-022-mojito")],
  ["a-023-orangejuice", $r("app.media.a-023-orangejuice")],
  ["a-024-wineglass", $r("app.media.a-024-wineglass")],
  ["a-025-milkshake", $r("app.media.a-025-milkshake")],
  ["a-026-cocktails-14", $r("app.media.a-026-cocktails-14")],
  ["a-026-smoothie", $r("app.media.a-026-smoothie")],
  ["a-027-Softdrink", $r("app.media.a-027-Softdrink")],
  ["a-028-Softdrink", $r("app.media.a-028-Softdrink")],
  ["a-029-tea", $r("app.media.a-029-tea")],
  ["a-030-cocktails-10", $r("app.media.a-030-cocktails-10")],
  ["a-030-whiskeyontherocks", $r("app.media.a-030-whiskeyontherocks")]
])

export class IconManager {
  static getRandomIcon() {
    const index = Math.floor(Math.random() * iconMap.size)
    return Array.from(iconMap.keys())[index]
  }

  static getIconById(id: string) {
    return iconMap.get(id) ?? $r("app.media.a-002-milkshake")
  }
}































