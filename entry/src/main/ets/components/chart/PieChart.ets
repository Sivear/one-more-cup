// PieChart.ets
interface ILabelPosition {
  x: number
  y: number
  align: string
}

// 饼图数据类型
export interface IPieData {
  name: string
  value: number
}


@ComponentV2
export struct PieChart {
  // 图表数据
  @Param data: Array<IPieData> = []
  @Param canvasWidth: number = 320
  @Param canvasHeight: number = 250
  // 内半径(用于环形图)
  @Param innerRadius: number = 0
  // 颜色集合
  @Param colors: Array<number> = [
    0X8979ff,
    0Xff928a,
    0X3cc3df,
    0Xffae4c,
    0X537ff1,
    0X6fd195,
    0X2bb7dc,
    0X1f94ff,
    0Xf4cf3b,
    0X55c4ae,
    0X6186cc,
  ]
  @Param showLabel: boolean = true
  @Param showData: boolean = true
  @Param showPercent: boolean = true
  @BuilderParam centerComp: () => void = this.defaultComp
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  // 标签字体大小
  private labelFontSize: number = this.getUIContext().vp2px(8)
  // 第一段引线长度(径向)
  private radialLineLength: number = 10

  @Builder
  defaultComp() {
    Row()
      .width(0)
      .height(0)
  }

  /**
   * 数据变化时重新绘制
   */
  @Monitor("data")
  draw() {
    this.drawEnhancedPie(this.context)
  }


  build() {
    Stack({ alignContent: Alignment.Center }) {
      // 饼图主体
      Canvas(this.context)
        .width(this.canvasWidth)
        .height(this.canvasHeight)
        .onReady(() => {
          this.draw()
        })

      // 中心文本(环形图时显示)
      if (this.innerRadius > 0) {
        Column() {
          this.centerComp()
        }
        .width(this.innerRadius * 2)
        .height(this.innerRadius * 2)
        .borderRadius(this.innerRadius)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width(this.canvasWidth)
    .height(this.canvasHeight)
  }

  // 绘制增强版饼图
  private drawEnhancedPie(ctx: CanvasRenderingContext2D) {
    // 清除画布
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight)

    const centerX = this.canvasWidth / 2
    const centerY = this.canvasHeight / 2
    const radius = Math.min(centerX, centerY) - 20// 留出更多标签空间
    let startAngle = 0

    // 计算总值
    const total = this.getTotalValue()
    if (total <= 0) {
      return
    } // 无数据时不绘制

    // 预计算所有标签位置
    const labelPositions: Array<ILabelPosition> = []

    // 第一遍：计算理想位置
    this.data.forEach((item, index) => {
      const angle = (item.value / total) * Math.PI * 2
      const midAngle = startAngle + angle / 2

      // 计算标签位置
      const radialX = centerX + Math.cos(midAngle) * (radius + this.radialLineLength)
      const radialY = centerY + Math.sin(midAngle) * (radius + this.radialLineLength)

      // 确定水平方向
      const isRightSide = Math.cos(midAngle) > 0
      const horizontalX = isRightSide
        ? this.canvasWidth
        : 0

      labelPositions.push({
        x: horizontalX,
        y: radialY,
        align: isRightSide ? 'left' : 'right'
      })

      startAngle += angle
    })

    // 调整重叠的标签
    this.adjustLabelPositions(labelPositions)

    // 第二遍：实际绘制
    startAngle = 0
    this.data.forEach((item, index) => {
      const angle = (item.value / total) * Math.PI * 2
      const midAngle = startAngle + angle / 2
      const endAngle = startAngle + angle

      // 绘制扇形
      ctx.beginPath()
      ctx.moveTo(centerX, centerY)
      ctx.arc(centerX, centerY, radius, startAngle, endAngle)
      ctx.closePath()

      // 设置填充颜色
      ctx.fillStyle = this.getColor(index).toString()
      ctx.fill()


      if (this.showLabel) {
        // 计算径向引线终点
        const radialX = centerX + Math.cos(midAngle) * (radius + this.radialLineLength)
        const radialY = centerY + Math.sin(midAngle) * (radius + this.radialLineLength)

        // 绘制引线
        ctx.beginPath()
        // 第一段：径向线
        ctx.moveTo(
          centerX + Math.cos(midAngle) * radius,
          centerY + Math.sin(midAngle) * radius
        )
        ctx.lineTo(radialX, radialY)
        // 第二段：水平线
        const lineEndX = labelPositions[index].x
        ctx.lineTo(lineEndX, radialY)

        ctx.strokeStyle = this.getColor(index)
        ctx.lineWidth = 1
        ctx.stroke()

        // 绘制标签
        ctx.font = `${this.labelFontSize}px sans-serif`
        ctx.fillStyle = '#b3000000'

        const labelX = labelPositions[index].x
        const labelY = labelPositions[index].y - 8
        const textAlign = labelPositions[index].align

        ctx.textAlign = textAlign === "right" ? "left" : "right"
        ctx.textBaseline = 'middle'

        ctx.fillStyle = '#b3000000'
        ctx.fillText(item.name, labelX, labelY)
      }

      // 绘制数据(可选)
      if (this.showData) {
        ctx.font = `bold ${this.labelFontSize - 1}px sans-serif`;
        ctx.fillStyle = this.getColor(index)
        ctx.textAlign = labelPositions[index].align === "right" ? "left" : "right"
        ctx.fillText(item.value.toFixed(2), labelPositions[index].x, labelPositions[index].y + 8)
      }

      // 可选：显示百分比
      if (this.showPercent) {
        const percent = ((item.value / total) * 100).toFixed(1) + '%'
        if (angle > Math.PI / 8) { // 只在足够大的扇形上显示百分比
          const percentX = centerX + Math.cos(midAngle) * (radius * 0.7)
          const percentY = centerY + Math.sin(midAngle) * (radius * 0.7)
          ctx.textAlign = 'center'
          ctx.fillStyle = '#ffffff'
          ctx.fillText(percent, percentX, percentY)
        }
      }

      startAngle = endAngle
    })

    // 如果是环形图，绘制内圆
    if (this.innerRadius > 0) {
      ctx.beginPath()
      ctx.arc(centerX, centerY, this.innerRadius, 0, Math.PI * 2)
      ctx.fillStyle = '#ffffff'
      ctx.fill()
    }
  }

  // 调整标签位置防止重叠
  private adjustLabelPositions(positions: Array<ILabelPosition>): void {
    // 按y坐标排序
    const sortedIndices = Array.from(positions.keys())
      .sort((a, b) => positions[a].y - positions[b].y)

    // 检查并调整重叠
    for (let i = 1; i < sortedIndices.length; i++) {
      const prevIdx = sortedIndices[i - 1]
      const currIdx = sortedIndices[i]
      const prev = positions[prevIdx]
      const curr = positions[currIdx]

      const minVerticalGap = this.labelFontSize * 1.5

      if (Math.abs(curr.y - prev.y) < minVerticalGap && curr.align === prev.align) {
        // 调整当前标签位置
        const direction = curr.y > prev.y ? 1 : -1
        positions[currIdx].y = prev.y + direction * minVerticalGap

        // 确保不超出画布边界
        const minY = this.labelFontSize + 5
        const maxY = this.canvasHeight - this.labelFontSize - 5
        positions[currIdx].y = Math.max(minY, Math.min(maxY, positions[currIdx].y))
      }
    }
  }

  // 获取总值
  private getTotalValue(): number {
    return this.data.reduce((sum, item) => sum + item.value, 0)
  }

  // 获取颜色
  private getColor(index: number): string {
    return `#${this.colors[index % this.colors.length].toString(16).padStart(6, '0')}`
  }
}

@Preview
@Component
struct PieChartExample {
  private data: Array<IPieData> = [
    { name: '电子产品', value: 35 },
    { name: '服装', value: 25 },
    { name: '食品', value: 20 },
    { name: '家居用品', value: 15 },
    { name: '其他', value: 5 }
  ]

  build() {
    Column({ space: 20 }) {
      // 基本饼图
      PieChart({
        data: this.data,
      })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#f5f5f5')
  }
}