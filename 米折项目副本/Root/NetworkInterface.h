//
//  NetworkInterface.h
//  米折项目
//
//  Created by sh on 16/7/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#ifndef NetworkInterface_h
#define NetworkInterface_h

/**
 *上新接口
 */

#define PATH_NEW @"http://m.mizhe.com/resource/ads-iPhone-2147483646-App%20Store-0-5.3.0.html"

/**
 *上新 -- 9点上新
 */

#define PATH_NEW_NINE(page) [NSString stringWithFormat:@"http://sapi.beibei.com/item/mz_temai/%d-20-0-0-3-1.html",page]

/**
 * 上新 -- 细节
 */
#define PATH_NEW_DETAIL(_GOODS_ID) [NSString stringWithFormat:@"http://sapi.beibei.com/martshow/item/%@-1-30--0--0-0-.html?package=mizhe",_goods_id]


/**
 *  专场详情
 */
#define PATH_NEW_DETAIL_ASC(_goods_id,_page,_categary) [NSString stringWithFormat:@"http://sapi.beibei.com/martshow/item%@-%d-30-%@-0--0-0-.html?package=mizhe",_goods_id,_page,_categary]
//升序 http://sapi.beibei.com/martshow/item/212762-1-30-price_asc-0--0-0-.html?package=mizhe

//降序 http://sapi.beibei.com/martshow/item/212762-1-30-price_desc-0--0-0-.html?package=mizhe

//销量 http://sapi.beibei.com/martshow/item/212762-1-30-sale_num-0--0-0-.html?package=mizhe


/**
 *女装 母婴 鞋包
 */
#define PATH_NEW_CATEGORY(_page,_category) [NSString stringWithFormat:@"http://sapi.beibei.com/item/mz_temai_cat/%d-20-%@-1.html",_page,_category]
/** 昨日特卖 */
#define PATH_LEAT(_page)  [NSString stringWithFormat:@"http://sapi.beibei.com/item/mz_temai/%d-20-1-0-1-0.html?package=mizhe",_page]

//http://sapi.beibei.com/martshow/item/212762-1-30--0--0-0-.html?package=mizhe

//升序 http://sapi.beibei.com/martshow/item/212762-1-30-price_asc-0--0-0-.html?package=mizhe

//降序 http://sapi.beibei.com/martshow/item/212762-1-30-price_desc-0--0-0-.html?package=mizhe

//销量 http://sapi.beibei.com/martshow/item/212762-1-30-sale_num-0--0-0-.html?package=mizhe
/**
 *  精选 9.9包邮 29.9包邮 最后疯抢
 */
#define PATH_NINE_CATEGORY(_page,_category)[NSString stringWithFormat:@"http://sapi.beibei.com/martgoods/freeship/%d%@.html?package=mizhe",_page,_category]


//精选 http://sapi.beibei.com/martgoods/freeship/1-10-0_3999.html?package=mizhe

//9.9包邮 http://sapi.beibei.com/martgoods/freeship/1-10-0_999.html?package=mizhe

//29.9包邮 http://sapi.beibei.com/martgoods/freeship/1-10-1000_2999.html?package=mizhe

//最后疯抢 http://sapi.beibei.com/martgoods/freeship/1-10-0_3999-last.html?package=mizhe

/**
 *
 */
#define PATH_PINTUAN_CATEGORY(_page,_category) [NSString stringWithFormat:@"http://sapi.beibei.com/item/fightgroup/%d-40-today_group-%@-0.html?package=mizhe",_page,_category]
//拼团上新 http://sapi.beibei.com/item/fightgroup/1-40-today_group--0.html?package=mizhe

//生鲜 http://sapi.beibei.com/item/fightgroup/1-40-today_group-fruit-0.html?package=mizhe

//食品 fooddrink

//居家 house

//美妆 beauty

//母婴  http://sapi.beibei.com/item/fightgroup/1-40-today_group-momthings-0.html?package=mizhe

//服饰 http://sapi.beibei.com/item/fightgroup/1-40-today_group-dress-0.html?package=mizhe

//下期预告 http://sapi.beibei.com/item/fightgroup/1-40-today_group-tomorrow-0.html?package=mizhe

//详情 http://sapi.beibei.com/item/detail/11431242.html?package=mizhe


#define PATH_DETAIL(_goods_iid) [NSString stringWithFormat:@"http://sapi.beibei.com/item/detail/%@.html?package=mizhe",_goods_iid]


/**
 *  购物车
 */
#define PATH_BUYCAR @"http://s.budejie.com/topic/list/jingxuan/1/bs0315-iphone-4.3/0-200.json"

#endif /* NetworkInterface_h */
