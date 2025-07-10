const fs = require('fs')
const path = require('path')


function reindex(filename) {
    const filePath = path.resolve(__dirname, filename)
    // 读取 JSON 文件
    const raw = fs.readFileSync(filePath, 'utf-8')
    let data = JSON.parse(raw)

    // 遍历并修改 id
    data = data.map((item, index) => ({
        ...item,
        id: index + 1
    }))

    // 写回 JSON 文件（可选：格式化为 2 空格缩进）
    fs.writeFileSync(filePath, JSON.stringify(data, null, 2), 'utf-8')
}

reindex("beverages.json")
reindex("brands.json")
reindex("condiments.json")