import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
import { BeverageSweetness, BeverageTemperature } from 'omc_db';
import { OpenBeverageDetailSheet } from '../components/beverage_detail/OpenBeverageDetailSheet';
import { BeverageSweetnessUtil } from '../components/beverage_detail/utils/BeverageSweetnessUtil';
import { BeverageTemperatureUtil } from '../components/beverage_detail/utils/BeverageTemperatureUtil';
import { DrinkRecord } from '../model/Record';
import { NavParams } from '../router/NavParams';
import { HomePageViewModel } from '../viewmodel/HomePageViewModel';

interface IRecordDetailParamType {
  record: DrinkRecord,
  homeViewModel?: HomePageViewModel
}

@HMRouter({
  pageUrl: NavParams.RECORD_DETAIL_PAGE_URL,
  singleton: true,
  dialog: true
})
@ComponentV2
export struct RecordDetailPage {
  record?: DrinkRecord
  homeViewModel?: HomePageViewModel
  deleteDialogController: CustomDialogController = new CustomDialogController({
    builder: DeleteConfirmDialog({
      onConfirm: () => {
        this?.record?.id !== undefined && this.homeViewModel?.deleteRecord(this.record.id)
        this.deleteDialogController.close()
        HMRouterMgr.pop()
      }
    })
  })

  aboutToAppear(): void {
    let param = HMRouterMgr.getCurrentParam() as IRecordDetailParamType;
    this.record = param.record
    this.homeViewModel = param.homeViewModel
  }

  @Builder
  header() {
    // header
    Row() {
      Row({ space: 12 }) {
        Stack() {
          Column()
            .height(64)
            .width(64)
            .borderRadius(6)
            .backgroundColor($r("app.color.primary"))
          // todo: 添加品牌logo
        }

        Column() {
          Text(this?.record?.beverageName ?? "")
            .fontSize(16)
          Text(this?.record?.brandName ?? "")
            .fontSize(12)
            .fontColor($r("app.color.text_01"))
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(HorizontalAlign.Start)
        .height("100%")
        .padding({ top: 2, bottom: 2 })
      }
      .height("100%")

      Row({ space: 2 }) {
        ForEach([1, 2, 3, 4, 5], (num: number) => {
          Image(num <= (this?.record?.degree ?? 0) ? $r("app.media.star_gold") : $r("app.media.star_gray"))
            .width(20)
            .height(20)
        })
      }
    }
    .height(64)
    .width("100%")
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Bottom)
  }

  @Builder
  details() {
    Column({ space: 20 }) {
      Row() {
        Text($r("app.string.price"))
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
        Text((this.record?.price ?? 0).toString())
          .fontSize(18)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)
      .width("100%")

      Row() {
        Text($r("app.string.time"))
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
        Text($r("app.string.date", new Date(this.record?.time ?? 0).getFullYear(),
          new Date(this.record?.time ?? 0).getMonth() + 1))
          .fontSize(18)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)
      .width("100%")

      Row() {
        Text($r("app.string.sweetness"))
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
        Text(BeverageSweetnessUtil.transferSweetnessToString(this.record?.sweetness as BeverageSweetness))
          .fontSize(18)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)
      .width("100%")

      Row() {
        Text($r("app.string.temperature"))
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
        Text(BeverageTemperatureUtil.transferTemperatureToString(this.record?.temperature as BeverageTemperature))
          .fontSize(18)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)
      .width("100%")

      Row() {
        Text($r("app.string.condiments"))
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
        Text((this.record?.condiments && this.record?.condiments.length > 0) ?
        (this.homeViewModel ? this.homeViewModel.condimentIdToName(this.record?.condiments) :
          this.record?.condiments).join(",") : $r("app.string.none"))
          .fontSize(18)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)
      .width("100%")

      Row() {
        Text($r("app.string.remark"))
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
        Row() {
          Text(this.record?.remark ?? "")
            .fontSize(14)
            .maxLines(6)
            .textOverflow({
              overflow: TextOverflow.Ellipsis
            })
        }
        .width("60%")
        .justifyContent(FlexAlign.End)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)
      .width("100%")
    }
    .width("100%")
    .layoutWeight(1)
  }

  build() {
    Column() {
      Column({ space: 36 }) {
        Column({ space: 50 }) {
          this.header()
          this.details()
        }
        .width("100%")
        .layoutWeight(1)

        Row() {
          Button($r("app.string.delete"))
            .width("41%")
            .height("100%")
            .backgroundColor($r("app.color.bg_03"))
            .borderRadius(12)
            .fontColor(Color.Black)
            .onClick(() => {
              this.deleteDialogController.open()
            })
          Button($r("app.string.edit"))
            .width("41%")
            .height("100%")
            .backgroundColor($r("app.color.primary"))
            .borderRadius(12)
            .onClick(() => {
              this.record && OpenBeverageDetailSheet(this.getUIContext(), this.getUniqueId())({ record: this.record })
            })
        }
        .width("100%")
        .height(54)
        .justifyContent(FlexAlign.SpaceBetween)

      }
      .width('100%')
      .height("80%")
      .backgroundColor(Color.White)
      .padding(36)
      .justifyContent(FlexAlign.SpaceBetween)
      .border({
        radius: {
          topLeft: 20,
          topRight: 20
        }
      })
      .onClick(() => {
      })
    }
    .height("100%")
    .width("100%")
    .backgroundColor(Color.Transparent)
    .justifyContent(FlexAlign.End)
    .onClick(() => {
      HMRouterMgr.pop()
    })
  }
}

@CustomDialog
struct DeleteConfirmDialog {
  controller: CustomDialogController
  onCancel: () => void = () => {
    this.controller.close()
  }
  onConfirm: () => void = () => {}

  build() {
    Column({ space: 60 }) {
      Text($r("app.string.delete_confirm_text"))
        .fontSize(20)


      Row() {
        Button($r("app.string.cancel"))
          .width("36%")
          .height(54)
          .borderRadius(12)
          .backgroundColor($r("app.color.bg_03"))
          .fontColor(Color.Black)
          .onClick(() => {
            this.onCancel()
          })
        Button($r("app.string.delete"))
          .width("36%")
          .height(54)
          .borderRadius(12)
          .backgroundColor($r("app.color.primary"))
          .onClick(() => {
            this.onConfirm()
          })
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width("100%")
    .alignItems(HorizontalAlign.Center)
    .padding(24)
  }
}