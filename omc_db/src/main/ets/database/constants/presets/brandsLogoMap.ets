const logoMap: Map<number, Resource> =
  new Map([
    [0, $r('app.media.beverage_009_coffeecup')],
    [1, $r("app.media.brand_Chagee")], [2, $r("app.media.brand_Naixue")],
    [3, $r("app.media.brand_HeyTea")], [4, $r("app.media.brand_GoodMe")],
    [5, $r("app.media.brand_Luckin")], [6, $r("app.media.brand_Xingyunka")],
    [7, $r("app.media.brand_Cotti")], [8, $r("app.media.brand_Starbucks")],
    [9, $r("app.media.brand_MStand")], [10, $r("app.media.brand_Mixue")],
    [11, $r("app.media.brand_Yidiandian")], [12, $r("app.media.brand_Chayanyuese")],
    [13, $r("app.media.brand_Chaliyishi")], [14, $r("app.media.brand_ChaPanda")],
    [15, $r("app.media.brand_CoCo")], [16, $r("app.media.brand_MollyTea")],
    [17, $r("app.media.brand_Ningji")], [18, $r("app.media.brand_Chahuanong")],
    [19, $r("app.media.brand_MoreYogurt")], [20, $r("app.media.brand_Chajiuxingqiu")],
    [21, $r("app.media.brand_Yihetang")], [22, $r("app.media.brand_Hushangayi")],
    [23, $r("app.media.brand_Manner")], [24, $r("app.media.brand_Lelecha")],
    [25, $r("app.media.brand_Yinggehun")], [26, $r("app.media.brand_Linlee")],
    [27, $r("app.media.brand_Shuyishaoxiancao")], [28, $r("app.media.brand_Wuyinliangpin")],
    [29, $r("app.media.brand_Yeyebupaocha")]])

export function getLogoByBrandId(id: number) {
  return logoMap.get(id) ?? $r("app.media.beverage_009_coffeecup")
}