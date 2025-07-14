import { HMRouterMgr } from '@hadss/hmrouter'
import { NavParams } from '../../router/NavParams'
import { AddBeverageButtonController } from './AddBeverageButtonController'

/**
 * @description 新建按钮
 */
@Builder
export function AddBeverageButton() {
  Image($r('app.media.omc_new_beverage_icon'))
    .width(62)
    .height(62 + 20)
    .margin({
      bottom: 20
    })
    .position(AddBeverageButtonController.position)
    .translate(AddBeverageButtonController.translate)
    .onClick(() => {
      HMRouterMgr.push({
        pageUrl: NavParams.NEW_BEVERAGE_PAGE_URL
      })
    })
}