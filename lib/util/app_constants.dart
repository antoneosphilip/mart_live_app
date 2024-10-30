import 'package:get/get.dart';
import 'package:live_app/data/model/response/language_model.dart';
import 'package:live_app/util/images.dart';

class AppConstants {
  static const String appName = 'chatApp';
  static const double appVersion = 1.0;
  static const String fontFamily = 'Roboto';
  static const bool payInWevView = false;
  static const int balanceInputLen = 10;
  static const bool isDebug = false;
  static const String scheme = isDebug == true ? 'http://' : 'https://';
  static const String domain =
      isDebug == true ? '192.168.1.10' : 'marioo.online';
  static const String path = isDebug == true ? '/am_mart_chat' : '';
  static const String webHostedUrl = '${scheme}${domain}';
  static const String baseUrl = '${scheme}${domain}${path}';
  static const String webSocketUrl = '/ws:/${domain}:6001/chat_app';
  static const String webSocketAppKey = 'asX6PyVuhiOT6XGH';
  static const String mediaPath = 'storage/app/public';
  static const String mediaUrl = "$baseUrl/$mediaPath";
  //----------------------v2----------------------------------------
  static const String configUri = '/api/v2/config';
  static const String bannerUri = '/api/v2/banners';
  static const String topRoomsUri = '/api/v2/rooms/top';
  static const String homeRoomUri = '/api/v2/rooms/home';
  static const String roomsUri = '/api/v2/rooms/get_rooms';
  static const String joinRoomUri = '/api/v2/rooms/join';
  static const String leaveRoomUri = '/api/v2/rooms/exit';
  static const String roomVisitorsListUri = '/api/v2/rooms/visitors';
  static const String roomOnMicUsersListUri = '/api/v2/rooms/on_mic';
  static const String takeMicUri = '/api/v2/rooms/chair/sit';
  static const String leaveMicUri = '/api/v2/rooms/chair/leave';
  static const String createRoomUri = '/api/v2/rooms/create';
  static const String roomTypesUri = '/api/v2/room-types';
  static const String updateRoomTypesUri = '/api/v2/rooms/update';
  static const String getBlackLists = '/api/v2/rooms/black_list';
  static const String removeUserFromBlackList = '/api/v2/rooms/black_list/remove_user';
  static const String addUserToBlackList = '/api/v2/rooms/black_list/add_user';
  static const String sitChair = '/api/v2/rooms/chair/sit';
  static const String leaveChair = '/api/v2/rooms/chair/leave';

  static const String giftListUri = '/api/v2/gifts';
  static const String sendGiftUri = '/api/v2/gifts/send';
  static const String countryListUri = '/api/v2/countries';
  static const String vipListUri = '/api/v2/vip/list';
  static const String homeDataUri = '/api/v2/home';
  static const String levelListUri = '/api/v2/level/list';
  static const String typesListUri = '/api/v2/store/categories/list';
  static const String itemsListUri = '/api/v2/store/items/list';
  static const String userDataUri = '/api/v2/user/data';
  static const String userDetailsUri = '/api/v2/user/details';
  static const String friendsListUri = '/api/v2/relations/friend-list';
  static const String followersListUri = '/api/v2/relations/followers-list';
  static const String followingsListUri = '/api/v2/relations/followings-list';
  static const String visitorsListUri = '/api/v2/relations/visitors-list';
  static const String followUserUri = '/api/v2/relations/follow';
  static const String unfollowUserUri = '/api/v2/relations/unfollow';
  static const String addFriendUri = '/api/v2/relations/friendship-request';
  static const String removeFriendUri = '/api/v2/relations/remove-friend';
  static const String searchUri = '/api/v2/';
  static const String suggestedItemUri = '/api/v2/search/suggested';
  static const String conversationListUri = '/api/v2/message/list';
  static const String searchConversationListUri = '/api/v2/message/search-list';
  static const String messageListUri = '/api/v2/message/details';
  static const String sendMessageUri = '/api/v2/message/send';
  static const String rechargeListUri = '/api/v2/recharge/list';
  //----------------------v2----------------------------------------

  static const String messageUri = '/api/v1/customer/message/get';
  static const String forgetPasswordUri = '/api/v1/auth/forgot-password';
  static const String verifyTokenUri = '/api/v1/auth/verify-token';
  static const String resetPasswordUri = '/api/v1/auth/reset-password';
  static const String verifyPhoneUri = '/api/v1/auth/verify-phone';
  static const String checkEmailUri = '/api/v1/auth/check-email';
  static const String verifyEmailUri = '/api/v1/auth/verify-email';
  static const String registerUri = '/api/v1/auth/sign-up';
  static const String loginUri = '/api/v1/auth/login';
  static const String tokenUri = '/api/v1/customer/cm-firebase-token';
  static const String customerInfoUri = '/api/v1/customer/info';
  static const String couponUri = '/api/v1/coupon/list';
  static const String couponApplyUri = '/api/v1/coupon/apply?code=';
  static const String aboutUsUri = '/about-us';
  static const String privacyPolicyUri = '/privacy-policy';
  static const String termsAndConditionUri = '/terms-and-conditions';
  static const String notificationUri = '/api/v1/customer/notifications';
  static const String   updateProfileUri = '/api/v2/user/update';

  static const String interestUri = '/api/v1/customer/update-interest';

  static const String wishListGetUri = '/api/v1/customer/wish-list';
  static const String addWishListUri = '/api/v1/customer/wish-list/add?';
  static const String removeWishListUri = '/api/v1/customer/wish-list/remove?';
  static const String socialLoginUri = '/api/v1/auth/social-login';
  static const String socialRegisterUri = '/api/v1/auth/social-register';
  static const String moduleUri = '/api/v1/module';
  static const String subscriptionUri = '/api/v1/newsletter/subscribe';
  static const String customerRemoveUri = '/api/v1/customer/remove-account';
  static const String walletTransactionUri =
      '/api/v1/customer/wallet/transactions';
  static const String loyaltyTransactionUri =
      '/api/v1/customer/loyalty-point/transactions';
  static const String loyaltyPointTransferUri =
      '/api/v1/customer/loyalty-point/point-transfer';
  static const String walletBonusUri = '/api/v1/customer/wallet/bonuses';
  static const String offlineMethodListUri =
      '/api/v1/offline_payment_method_list';
  static const String offlinePaymentSaveInfoUri =
      '/api/v1/customer/order/offline-payment';
  static const String offlinePaymentUpdateInfoUri =
      '/api/v1/customer/order/offline-payment-update';

  // old
  static const String reviewUri = '/api/v1/items/reviews/submit';
  static const String basicCampaignUri = '/api/v1/campaigns/basic';
  static const String itemCampaignUri = '/api/v1/campaigns/item';
  static const String basicCampaignDetailsUri =
      '/api/v1/campaigns/basic-campaign-details?basic_campaign_id=';
  static const String categoryUri = '/api/v1/categories';
  static const String storeItemUri = '/api/v1/items/latest';
  static const String popularItemUri = '/api/v1/items/popular';
  static const String reviewedItemUri = '/api/v1/items/most-reviewed';
  static const String searchItemUri = '/api/v1/items/details/';
  static const String subCategoryUri = '/api/v1/categories/childes/';
  static const String categoryItemUri = '/api/v1/categories/items/';
  static const String categoryStoreUri = '/api/v1/categories/stores/';

  static const String trackUri = '/api/v1/customer/order/track?order_id=';

  static const String placeOrderUri = '/api/v1/customer/order/place';
  static const String placePrescriptionOrderUri =
      '/api/v1/customer/order/prescription/place';
  static const String addressListUri = '/api/v1/customer/address/list';
  static const String zoneUri = '/api/v1/config/get-zone-id';
  static const String removeAddressUri =
      '/api/v1/customer/address/delete?address_id=';
  static const String addAddressUri = '/api/v1/customer/address/add';
  static const String updateAddressUri = '/api/v1/customer/address/update/';
  static const String setMenuUri = '/api/v1/items/set-menu';

  static const String runningOrderListUri =
      '/api/v1/customer/order/running-orders';
  static const String historyOrderListUri = '/api/v1/customer/order/list';
  static const String orderCancelUri = '/api/v1/customer/order/cancel';
  static const String codSwitchUri = '/api/v1/customer/order/payment-method';
  static const String orderDetailsUri =
      '/api/v1/customer/order/details?order_id=';

  static const String itemDetailsUri = '/api/v1/items/details/';
  static const String lastLocationUri =
      '/api/v1/delivery-man/last-location?order_id=';
  static const String deliveryManReviewUri =
      '/api/v1/delivery-man/reviews/submit';
  static const String storeUri = '/api/v1/stores/get-stores';
  static const String popularStoreUri = '/api/v1/stores/popular';
  static const String latestStoreUri = '/api/v1/stores/latest';
  static const String storeDetailsUri = '/api/v1/stores/details/';

  static const String storeReviewUri = '/api/v1/stores/reviews';
  static const String distanceMatrixUri = '/api/v1/config/distance-api';
  static const String searchLocationUri =
      '/api/v1/config/place-api-autocomplete';
  static const String placeDetailsUri = '/api/v1/config/place-api-details';
  static const String geocodeUri = '/api/v1/config/geocode-api';

  static const String updateZoneUri = '/api/v1/customer/update-zone';

  static const String parcelCategoryUri = '/api/v1/parcel-category';

  static const String cancellationUri = '/cancelation';
  static const String refundUri = '/refund';
  static const String shippingPolicyUri = '/shipping-policy';

  static const String zoneListUri = '/api/v1/zone/list';
  static const String storeRegisterUri = '/api/v1/auth/vendor/register';
  static const String dmRegisterUri = '/api/v1/auth/delivery-man/store';
  static const String refundReasonUri = '/api/v1/customer/order/refund-reasons';
  static const String refundRequestUri =
      '/api/v1/customer/order/refund-request';
  static const String directionUri = '/api/v1/config/direction-api';
  static const String vehicleListUri = '/api/v1/vehicles/list';
  static const String taxiCouponUri = '/api/v1/coupon/list/taxi';
  static const String taxiBannerUri = '/api/v1/banners/taxi';

  static const String topRatedVehiclesListUri =
      '/api/v1/vehicles/top-rated/list';
  static const String bandListUri = '/api/v1/vehicles/brand/list';
  static const String taxiCouponApplyUri = '/api/v1/coupon/apply/taxi?code=';
  static const String tripPlaceUri = '/api/v1/trip/place';
  static const String runningTripUri = '/api/v1/trip/list';
  static const String vehicleChargeUri = '/api/v1/vehicle/extra_charge';
  static const String vehiclesUri = '/api/v1/get-vehicles';
  static const String storeRecommendedItemUri = '/api/v1/items/recommended';
  static const String orderCancellationUri =
      '/api/v1/customer/order/cancellation-reasons';
  static const String cartStoreSuggestedItemsUri = '/api/v1/items/suggested';
  static const String landingPageUri = '/api/v1/flutter-landing-page';
  static const String mostTipsUri = '/api/v1/most-tips';
  static const String addFundUri = '/api/v1/customer/wallet/add-fund';

  static const String guestLoginUri = '/api/v1/auth/guest/request';

  static const String storeBannersUri = '/api/v1/banners/';
  static const String recommendedItemsUri = '/api/v1/items/recommended?filter=';
  static const String visitAgainStoreUri = '/api/v1/customer/visit-again';
  static const String discountedItemsUri = '/api/v1/items/discounted';
  static const String parcelOtherBannerUri = '/api/v1/other-banners';
  static const String whyChooseUri = '/api/v1/other-banners/why-choose';
  static const String videoContentUri = '/api/v1/other-banners/video-content';
  static const String promotionalBannerUri = '/api/v1/other-banners';
  static const String basicMedicineUri = '/api/v1/items/basic';
  static const String commonConditionUri = '/api/v1/common-condition';
  static const String conditionWiseItemUri = '/api/v1/common-condition/items/';
  static const String flashSaleUri = '/api/v1/flash-sales';
  static const String flashSaleProductsUri = '/api/v1/flash-sales/items';
  static const String featuredCategoriesItemsUri =
      '/api/v1/categories/featured/items';
  static const String recommendedStoreUri = '/api/v1/stores/recommended';
  static const String parcelInstructionUri =
      '/api/v1/customer/order/parcel-instructions';

  /// Cart
  static const String getCartListUri = '/api/v1/customer/cart/list';
  static const String addCartUri = '/api/v1/customer/cart/add';
  static const String updateCartUri = '/api/v1/customer/cart/update';
  static const String removeAllCartUri = '/api/v1/customer/cart/remove';
  static const String removeItemCartUri = '/api/v1/customer/cart/remove-item';

  /// Shared Key
  static const String theme = '6ammart_theme';
  static const String token = '6ammart_token';
  static const String countryCode = '6ammart_country_code';
  static const String languageCode = '6ammart_language_code';
  static const String cartList = '6ammart_cart_list';
  static const String userPassword = '6ammart_user_password';
  static const String userAddress = '6ammart_user_address';
  static const String userNumber = '6ammart_user_number';
  static const String userCountryCode = '6ammart_user_country_code';
  static const String notification = '6ammart_notification';
  static const String searchHistory = '6ammart_search_history';
  static const String intro = '6ammart_intro';
  static const String notificationCount = '6ammart_notification_count';
  static const String dmTipIndex = '6ammart_dm_tip_index';
  static const String earnPoint = '6ammart_earn_point';
  static const String acceptCookies = '6ammart_accept_cookies';
  static const String suggestedLocation = '6ammart_suggested_location';
  static const String walletAccessToken = '6ammart_wallet_access_token';
  static const String guestId = '6ammart_guest_id';
  static const String guestNumber = '6ammart_guest_number';

////// agora
  static const String appAgoraId = 'b7f620807cab40948f165547fc754260'; // Replace with your Agora App ID
  static const String agoraToken = '007eJxTYFg+o/xMAFdrwZIabfFTmz0mRNSKVPuHJAka7/tjEppTIaLAkGSeZmZkYGFgnpyYZGJgaWKRZmhmampinpZsbmpiZGYwI14pvSGQkYE9bT8zIwMEgvh8DLmJRSXxyRmJJfE5mWWpDAwAp5Uf4A=='; // Replace with token
  static const String channelName = 'mart_chat_live'; // Channel name

  static const String topic = 'all_zone_customer';
  static const String zoneId = 'zoneId';
  static const String operationAreaId = 'operationAreaId';
  static const String moduleId = 'moduleId';
  static const String cacheModuleId = 'cacheModuleId';
  static const String localizationKey = 'X-localization';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String cookiesManagement = 'cookies_management';

  ///Refer & Earn work flow list..
  static final dataList = [
    'invite_your_friends_and_business'.tr,
    '${'they_register'.tr} ${AppConstants.appName} ${'with_special_offer'.tr}',
    'you_made_your_earning'.tr,
  ];

  /// Delivery Tips
  static List<String> tips = ['0', '15', '10', '20', '40', 'custom'];
  static List<String> deliveryInstructionList = [
    'deliver_to_front_door'.tr,
    'deliver_the_reception_desk'.tr,
    'avoid_calling_phone'.tr,
    'come_with_no_sound'.tr,
  ];

  /// order status..
  static const String pending = 'pending';
  static const String accepted = 'accepted';
  static const String processing = 'processing';
  static const String confirmed = 'confirmed';
  static const String handover = 'handover';
  static const String pickedUp = 'picked_up';
  static const String delivered = 'delivered';

  ///user type..
  static const String user = 'user';
  static const String customer = 'customer';
  static const String admin = 'admin';
  static const String deliveryMan = 'delivery_man';
  static const String vendor = 'vendor';

  ///modules..
  static const String pharmacy = 'pharmacy';
  static const String food = 'food';
  static const String ecommerce = 'ecommerce';
  static const String grocery = 'grocery';


  ///family
  static const String family = '/api/v2/my_family';
  static const String createFamily = '/api/v2/create_family';
  static const String allFamily = '/api/v2/all_families';
  static const String getFamily = '/v2/get_family';
  static const String joinFamily = '/api/v2/join_family';
  static const String leaveFamily = '/api/v2/leave_family';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.arabic,
        languageName: 'عربى',
        countryCode: 'SA',
        languageCode: 'ar'),
    // LanguageModel(imageUrl: Images.arabic, languageName: 'Spanish', countryCode: 'ES', languageCode: 'es'),
    // LanguageModel(imageUrl: Images.bengali, languageName: 'Bengali', countryCode: 'BN', languageCode: 'bn'),
  ];

  static List<String> joinDropdown = [
    'join_us',
    'become_a_seller',
    'become_a_delivery_man'
  ];

  static final List<Map<String, String>> walletTransactionSortingList = [
    {'title': 'all_transactions', 'value': 'all'},
    {'title': 'order_transactions', 'value': 'order'},
    {'title': 'converted_from_loyalty_point', 'value': 'loyalty_point'},
    {'title': 'added_via_payment_method', 'value': 'add_fund'},
    {'title': 'earned_by_referral', 'value': 'referrer'},
  ];

  static String getMedia(String directory, String name) {
    return "$mediaUrl/$directory/$name";
  }
}
