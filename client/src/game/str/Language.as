package game.str
{
	public class Language
	{
		public static const WANG:String = "萬";
		public static const YI:String = "億";
		public static const MIAO:String = "秒";
		public static const FEN_ZHONG:String = "分鐘";
		public static const XIAO_SHI:String = "小時";
		public static const NIAN:String = "年";
		public static const YUE:String = "月";
		public static const RI:String = "日";
		public static const FEN:String = "分";
		public static const SHI:String = "時";
		public static const TIAN:String = "天";
		public static const USER_NO_EXIST:String = "用户不存在";
		public static const BUILD_NOTEXIST:String = "该建筑点不对";
		public static const BUILD_ALREADY_CREATED:String = "该建筑点已激活";
		public static const DIAMOND_NOT_ENOUGH:String = "老板，咱们的钻石不够！";
		public static const CONFIG_ERROR:String = "取配置出错";
		public static const CREATE_BUILD_TIP:String = "是否激活该建筑?";
		public static const MONEY_NOT_ENOUGH:String = "老板，钱不够了，啊啊啊！";
		public static const POWER_NET_ENOUGH:String = "体力值不够";
		public static const PERMISSIONS_LIMIT:String = "没有设置权限";
		public static const BUILD_NO_CREATEED:String = "该建筑点末激活";
		public static const REQUEST_ERROR:String = "请求出错";
		public static const MODIFY_USER_INFO_FAILD:String = "修改用户信息失败";
		public static const ERRCODE_5020:Object = {
			1: MONEY_NOT_ENOUGH,
			2: "一周只能修改一次",
			3: "上传数据不对",
			4: "入驻只能是住宅楼",
			5: "操作类型不对",
			6: "价格有变化！",
			7: "已被人入住",
			8: "出售价格不对",
			9: "不是房东或者租房",
			10: "不能购买自已的房产",
			11: "已经被人抢先租用了！",
			12: "没有人租住",
			13: "用户等级开店数量限制",
			14: "开店铺类型未解锁",
			15: "已开店",
			16: "不是房东",
			17: "收获时间末到",
			18: "该房产不能开店",
			19: "违约金不够",
			20: "不能购买房东自住住房",
			21: "入住的房子才能点赞",
			22: "点赞超过次数",
			23: "每天只能点赞一次",
			24: "增加楼层上限"
		};

		public static const ERRCODE_5022:Object = {
			1: "无后续事件选择", 2: "上传数据有误"
		};
		public static const HOUSE_NAME:String = "Lv{@}  {@}";
		public static const TIP_25:String = "老板，要经营{店铺类型名称}吗？"
		public static const RENT_HOUSE_TIP:String = "要租用，并入住吗？";
		public static const BUY_ESTATE_TIP:String = "要购买吗？买卖双方收取0.5%交易税。";
		public static const BUY_SSTATE_SUCCESS:String = "买下啦！";
		public static const GROWUP_SUCCESS:String="恭喜老板，升级成功！";
		public static const MOVE_HOUSE_TIP:String = "从 A房产x楼 搬迁到 B房产x楼 吗？需要补偿旧房东昵称 1天租金，钞票n。";
		public static const ZM_SUCCESS:String = "招募成功！";
		public static const RENT_SHOP_TIP:String = "要租用店铺吗";
		public static const ADD_BEST_FAIL:String = "增加满意度失败";
		public static const OPER_ERROR:String = "操作失败";
		public static const UNOPENED:String = "未开店";
		public static const NAME_ERROR_TIP:String = "输入的名字不符合规范，请重新输入";

	}
}