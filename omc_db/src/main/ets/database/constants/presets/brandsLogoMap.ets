const logoMap: Map<number, Resource> =
  new Map([
    [0, $r('app.media.009_coffeecup')],
    [1, $r('app.media.Chagee')], [2, $r('app.media.Naixue')],
    [3, $r('app.media.HeyTea')], [4, $r('app.media.GoodMe')],
    [5, $r('app.media.Luckin')], [6, $r('app.media.Xingyunka')],
    [7, $r('app.media.Cotti')], [8, $r('app.media.Starbucks')],
    [9, $r('app.media.MStand')], [10, $r('app.media.Mixue')],
    [11, $r('app.media.Yidiandian')], [12, $r('app.media.Chayanyuese')],
    [13, $r('app.media.Chaliyishi')], [14, $r('app.media.ChaPanda')],
    [15, $r('app.media.CoCo')], [16, $r('app.media.MollyTea')],
    [17, $r('app.media.Ningji')], [18, $r('app.media.Chahuanong')],
    [19, $r('app.media.MoreYogurt')], [20, $r('app.media.Chajiuxingqiu')],
    [21, $r('app.media.Yihetang')], [22, $r('app.media.Hushangayi')],
    [23, $r('app.media.Manner')], [24, $r('app.media.Lelecha')],
    [25, $r('app.media.Yinggehun')], [26, $r('app.media.Linlee')],
    [27, $r('app.media.Shuyishaoxiancao')], [28, $r('app.media.Wuyinliangpin')],
    [29, $r('app.media.Yeyebupaocha')]])

export function getLogoByBrandId(id: number) {
  return logoMap.get(id) ?? $r("app.media.009_coffeecup")
}