# 添加预设数据

> ets/database/constants/presets

按照已有格式来添加即可。其中，需要注意的是，beverage的添加需要确保brandId的正确性。
同一品牌的饮品可以放在一起，添加的时候可以不用关注id是多少，最后执行一下**node reindex.js**即可自动更新id。

添加了新数据，需要将应用卸载重装才能生效。

# 使用DbHandler

本模块只对外导出了DbHandler，只能通过DbHandler访问数据库。

## 初始化数据

```typescript
DbHandler.initDbData()
```

## 访问其他接口

```typescript
DbHandler.brandApi.getAllBrands()
```

其他几个表的api以此类推。