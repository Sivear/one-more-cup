import { HMNavigation } from '@hadss/hmrouter';
import { DbHandler } from 'omc_db';
import { NavModifier } from '../router/NavModifier';
import { NavParams } from '../router/NavParams';

@Entry
@ComponentV2
struct Index {
  aboutToAppear(): void {
    DbHandler.initDbData()
  }

  build() {
    Column() {
      HMNavigation({
        navigationId: NavParams.OMC_NAVIGATION_ID,
        homePageUrl: NavParams.HOME_PAGE_URL,
        options: {
          modifier: new NavModifier()
        }
      })
    }
    .width('100%')
    .height('100%')
  }
}