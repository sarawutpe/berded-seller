class Constants {
  // Images
  static const String IMAGE_DIR = 'assets/images';
  static const String IC_TEXT_SIZE = '$IMAGE_DIR/ic_text_size.png';
  static const String IC_SCAN = '$IMAGE_DIR/ic_scan.png';
  static const String LOGO_APP = '$IMAGE_DIR/logo_footer.png';
  static const String LOGO_APP_SVG = '$IMAGE_DIR/logo_footer.svg';
  static const String LOGO_LOGIN = '$IMAGE_DIR/logo_login.png';
  static const String LOGO_EXTRA = '$IMAGE_DIR/logo_pospos_extra.png';
  static const String LOGO_PROMT_PAY = '$IMAGE_DIR/logo_promt_pay.jpg';
  static const String IMAGE_PATH = 'https://www.berded.in.th';


  // network constants
  static const String OK = 'ok';
  static const String NOK = 'nok';

  // Auth
  static const String USERNAME = 'USERNAME';
  static const String ACCESS_TOKEN = 'ACCESS_TOKEN';
  static const String CURRENT_STORE = 'CURRENT_STORE';
  static const String AUTHORIZED_STORES = 'AUTHORIZED_STORES';
  static const String AUTHORIZED_META = 'AUTHORIZED_META';

  // Platform
  static const String ANDROID = 'android';
  static const String IOS = 'ios';
  static const String WEB = 'web';

  // Studio
  static const String DEFAULT_STUDIO_IMAGE = 'DEFAULT_STUDIO_IMAGE';
  static const String DEFAULT_STUDIO_NUMBER_COLOR = 'DEFAULT_STUDIO_NUMBER_COLOR';
  static const String DEFAULT_STUDIO_FONT_STYLE = 'DEFAULT_FONT_STYLE';
  static const String DEFAULT_STUDIO_FONT_SIZE = 'DEFAULT_FONT_SIZE';

  // Bookmark numbers
  static const String BOOKMARK_NUMBERS = 'BOOKMARK_NUMBERS';

  // Manage page Menu URL
  static const String MANAGE_PAGE_DASHBOARD_MENU = 'https://www.berded.in.th/portal/dashboard/';
  static const String MANAGE_PAGE_SELLER_PERSONAL_MENU = 'https://www.berded.in.th/portal/dashboard';
  static const String MANAGE_PAGE_SELLER_PROFILE_MENU = 'https://www.berded.in.th/portal/profile/';
  static const String MANAGE_PAGE_SELLER_STATS_MENU = 'https://www.berded.in.th/portal/stat/?action=7';
  static const String MANAGE_PAGE_SELLER_EMAIL_MENU = 'https://www.berded.in.th/portal/email/';
  static const String MANAGE_PAGE_SELLER_ARTICLE_MENU = 'https://www.berded.in.th/portal/articles/';
  static const String MANAGE_PAGE_SELLER_EMS_MENU = 'https://www.berded.in.th/portal/ems/';
  static const String MANAGE_PAGE_SELLER_HELP_MENU = 'https://www.berded.in.th/portal/help/';
  static const String MANAGE_PAGE_FILTER_BERDED_MENU = 'https://www.berded.in.th/portal/dashboard/?action=search&search_phone=&search_pre=all&search_sum=all&search_price_gap=all&price_custom=&search_operator=all&search_type=1&search_kind=all';
  static const String MANAGE_PAGE_FILTER_BADGE_MENU = 'https://www.berded.in.th/portal/dashboard/?action=search&search_phone=&search_pre=all&search_sum=all&search_price_gap=all&price_custom=&search_operator=all&search_type=2&search_kind=all';

  static const String MANAGE_PAGE_DESKTOP_MODE = 'https://www.berded.in.th/portal/dashboard/display_mode?mode=desktop&device=native';
  static const String MANAGE_PAGE_MOBILE_MODE = 'https://www.berded.in.th/portal/dashboard/display_mode?mode=phone&device=native';

  // Manage Menu
  static const searchPreList = [
    'ขึ้นต้นด้วย',
    'ขึ้นต้นด้วย 06 : 06',
    'ขึ้นต้นด้วย 08 : 08',
    'ขึ้นต้นด้วย 09 : 09',
  ];

  static const searchSumList = [
    'ผลรวม',
    '14 ผู้ยิ่งใหญ่ : 14',
    '15 ความสุนทรี : 15',
    '19 ผู้เสวยสุข : 19',
    '23 ยอดเสน่ห์ : 23',
    '24 สมบูรณ์สุข : 24',
    '32 เสน่ห์แรง : 32',
    '36 สื่อแห่งความรัก : 36',
    '40 ชอบเดินทาง : 40',
    '41 ความผูกพันกับต่างประเทศ : 41',
    '42 ดวงอุปถัมภ์ : 42',
    '44 ฝีปากดี : 44',
    '45 เทพีแห่งโชค : 45',
    '46 การแสวงหา : 46',
    '50 ความกระตือรือร้น : 50',
    '51 ความสุขที่ได้มา : 51',
    '54 ดวงดาวแห่งโชค : 54',
    '55 เจริญก้าวหน้าและสุขสบาย : 55',
    '56 มีโชคเรื่องความรัก : 56',
    '59 ยอดแห่งรหัสชีวิต : 59',
    '60 มีโชคเรื่องการเงิน : 60',
    '63 ความรักและความสดชื่น : 63',
    '64 ชีวิตพบกับความสำเร็จ : 64',
    '65 คู่ทรัพย์คู่โชค : 65',
  ];

  static const searchPriceGapList = [
    'ช่วงราคา',
    'ไม่เกิน 1,000 : 1000',
    '1,001 - 3,000 : 1001-3000',
    '3,001 - 5,000 : 3001-5000',
    '5,001 - 10,000 : 5001-10000',
    '10,001 - 20,000 : 10001-20000',
    '20,001 - 40,000 : 20001-40000',
    '40,001 - 100,000 : 40001-100000',
    'มากกว่า 100,000 : 100000',
    'ระบุเอง',
  ];

  static const searchOperatorList = [
    'เครือข่าย',
    'AIS : AIS',
    'DTAC : DTAC',
    'TRUE : TRUE',
    'i-Mobile : IMOBILE',
    'My by CAT : MYCAT',
    'TOT 3G : TOT',
    'PENGUIN : PG',
    'Myworld : MW',
    'อื่นๆ : OTHER',
  ];

  static const searchTypeList = [
    'ชนิด',
    'เบอร์เด็ด : 1',
    'เบอร์แนะนำ : 2',
    'เบอร์เด็ด & เบอร์แนะนำ : 12',
    'เบอร์ที่จอง : 9',
  ];

  static const searchKindList = [
    'ประเภท',
    'ทั่วไป : nil',
    'เลขมังกร : 017',
    'เลขหงส์ : 018',
    'เบอร์คู่ เบอร์หาบ : 000',
    'เบอร์ตอง : 002',
    'เบอร์เรียง : 003',
    'เบอร์โฟร์ : 004',
    'เบอร์เซเว่น : 005',
    'เบอร์ซิกซ์ : 006',
    'เบอร์ไฟว์ : 007',
    'เบอร์พัน ร้อย สิบ : 008',
    'เบอร์สองตัว : 012',
    'เบอร์สลับ : 013',
    'เบอร์สูตรคูณ : 014',
    'เบอร์ชุด เบอร์กลุ่ม : 015',
    'เบอร์กระจก : 016',
    'เบอร์มงคล : 001',
  ];
}
