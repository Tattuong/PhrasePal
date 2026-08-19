import 'phrases_more.dart';

class TravelLanguage {
  final String id;
  final String name;
  final String ttsCode;
  final String flag;

  const TravelLanguage({
    required this.id,
    required this.name,
    required this.ttsCode,
    required this.flag,
  });
}

class PhraseCategory {
  final String id;
  final String nameKey;
  final bool extra;

  const PhraseCategory({
    required this.id,
    required this.nameKey,
    this.extra = false,
  });
}

class Phrase {
  final String id;
  final String categoryId;
  final String native;
  final String romanization;
  final String english;

  const Phrase({
    required this.id,
    required this.categoryId,
    required this.native,
    required this.romanization,
    required this.english,
  });
}

class PhraseCatalog {
  PhraseCatalog._();

  static const languages = [
    TravelLanguage(id: 'ja', name: 'Japanese', ttsCode: 'ja-JP', flag: 'JP'),
    TravelLanguage(id: 'vi', name: 'Vietnamese', ttsCode: 'vi-VN', flag: 'VN'),
    TravelLanguage(id: 'es', name: 'Spanish', ttsCode: 'es-ES', flag: 'ES'),
    TravelLanguage(id: 'fr', name: 'French', ttsCode: 'fr-FR', flag: 'FR'),
    TravelLanguage(id: 'ko', name: 'Korean', ttsCode: 'ko-KR', flag: 'KR'),
    TravelLanguage(id: 'th', name: 'Thai', ttsCode: 'th-TH', flag: 'TH'),
    TravelLanguage(id: 'it', name: 'Italian', ttsCode: 'it-IT', flag: 'IT'),
    TravelLanguage(id: 'de', name: 'German', ttsCode: 'de-DE', flag: 'DE'),
    TravelLanguage(id: 'zh', name: 'Chinese', ttsCode: 'zh-CN', flag: 'CN'),
  ];

  static TravelLanguage languageById(String id) =>
      languages.firstWhere((l) => l.id == id, orElse: () => languages.first);

  static const categories = [
    PhraseCategory(id: 'airport', nameKey: 'catAirport'),
    PhraseCategory(id: 'hotel', nameKey: 'catHotel'),
    PhraseCategory(id: 'food', nameKey: 'catFood'),
    PhraseCategory(id: 'shopping', nameKey: 'catShopping'),
    PhraseCategory(id: 'emergency', nameKey: 'catEmergency'),
    PhraseCategory(id: 'transport', nameKey: 'catTransport'),
    PhraseCategory(id: 'health', nameKey: 'catHealth'),
    PhraseCategory(id: 'numbers', nameKey: 'catNumbers'),
  ];

  static List<Phrase> forLanguage(String langId, {required bool extra}) {
    final all = _byLang[langId] ?? _byLang['ja']!;
    if (extra) return all;
    const extras = {'transport', 'health', 'numbers'};
    return all.where((p) => !extras.contains(p.categoryId)).toList();
  }
}

const _ja = <Phrase>[
  Phrase(id: 'ja_air_1', categoryId: 'airport', native: '搭乗券はどこでもらえますか？', romanization: 'Tōjōken wa doko de moraemasu ka?', english: 'Where can I get my boarding pass?'),
  Phrase(id: 'ja_air_2', categoryId: 'airport', native: '荷物を預けたいです。', romanization: 'Nimotsu o azuketai desu.', english: 'I would like to check in my luggage.'),
  Phrase(id: 'ja_air_3', categoryId: 'airport', native: 'ゲートはどこですか？', romanization: 'Gēto wa doko desu ka?', english: 'Where is the gate?'),
  Phrase(id: 'ja_air_4', categoryId: 'airport', native: 'この便は遅れていますか？', romanization: 'Kono bin wa okurete imasu ka?', english: 'Is this flight delayed?'),
  Phrase(id: 'ja_air_5', categoryId: 'airport', native: '入国審査はどこですか？', romanization: 'Nyūkoku shinsa wa doko desu ka?', english: 'Where is immigration?'),
  Phrase(id: 'ja_air_6', categoryId: 'airport', native: '荷物をなくしました。', romanization: 'Nimotsu o nakushimashita.', english: 'I lost my luggage.'),
  Phrase(id: 'ja_htl_1', categoryId: 'hotel', native: '予約しています。', romanization: 'Yoyaku shite imasu.', english: 'I have a reservation.'),
  Phrase(id: 'ja_htl_2', categoryId: 'hotel', native: 'チェックインをお願いします。', romanization: 'Chekkuin o onegai shimasu.', english: 'I would like to check in.'),
  Phrase(id: 'ja_htl_3', categoryId: 'hotel', native: 'Wi-Fiのパスワードは何ですか？', romanization: 'Wi-Fi no pasuwādo wa nan desu ka?', english: 'What is the Wi-Fi password?'),
  Phrase(id: 'ja_htl_4', categoryId: 'hotel', native: '荷物を預かってもらえますか？', romanization: 'Nimotsu o azukatte moraemasu ka?', english: 'Can you hold my bags?'),
  Phrase(id: 'ja_htl_5', categoryId: 'hotel', native: 'チェックアウトは何時ですか？', romanization: 'Chekkuauto wa nanji desu ka?', english: 'What time is checkout?'),
  Phrase(id: 'ja_htl_6', categoryId: 'hotel', native: 'もう一枚タオルをください。', romanization: 'Mō ichimai taoru o kudasai.', english: 'Could I have another towel?'),
  Phrase(id: 'ja_fd_1', categoryId: 'food', native: 'メニューをください。', romanization: 'Menyū o kudasai.', english: 'Please bring the menu.'),
  Phrase(id: 'ja_fd_2', categoryId: 'food', native: 'おすすめは何ですか？', romanization: 'Osusume wa nan desu ka?', english: 'What do you recommend?'),
  Phrase(id: 'ja_fd_3', categoryId: 'food', native: 'アレルギーがあります。', romanization: 'Arerugī ga arimasu.', english: 'I have an allergy.'),
  Phrase(id: 'ja_fd_4', categoryId: 'food', native: 'お会計をお願いします。', romanization: 'Okaikei o onegai shimasu.', english: 'The bill, please.'),
  Phrase(id: 'ja_fd_5', categoryId: 'food', native: '水をください。', romanization: 'Mizu o kudasai.', english: 'Water, please.'),
  Phrase(id: 'ja_fd_6', categoryId: 'food', native: 'これは辛いですか？', romanization: 'Kore wa karai desu ka?', english: 'Is this spicy?'),
  Phrase(id: 'ja_sh_1', categoryId: 'shopping', native: 'これはいくらですか？', romanization: 'Kore wa ikura desu ka?', english: 'How much is this?'),
  Phrase(id: 'ja_sh_2', categoryId: 'shopping', native: '試着できますか？', romanization: 'Shichaku dekimasu ka?', english: 'Can I try this on?'),
  Phrase(id: 'ja_sh_3', categoryId: 'shopping', native: 'もっと小さいサイズはありますか？', romanization: 'Motto chiisai saizu wa arimasu ka?', english: 'Do you have a smaller size?'),
  Phrase(id: 'ja_sh_4', categoryId: 'shopping', native: 'カードで払えますか？', romanization: 'Kādo de haraemasu ka?', english: 'Can I pay by card?'),
  Phrase(id: 'ja_sh_5', categoryId: 'shopping', native: '袋をください。', romanization: 'Fukuro o kudasai.', english: 'A bag, please.'),
  Phrase(id: 'ja_sh_6', categoryId: 'shopping', native: '免税できますか？', romanization: 'Menzei dekimasu ka?', english: 'Can I get tax-free?'),
  Phrase(id: 'ja_em_1', categoryId: 'emergency', native: '助けてください。', romanization: 'Tasukete kudasai.', english: 'Please help me.'),
  Phrase(id: 'ja_em_2', categoryId: 'emergency', native: '警察を呼んでください。', romanization: 'Keisatsu o yonde kudasai.', english: 'Please call the police.'),
  Phrase(id: 'ja_em_3', categoryId: 'emergency', native: '病院はどこですか？', romanization: 'Byōin wa doko desu ka?', english: 'Where is the hospital?'),
  Phrase(id: 'ja_em_4', categoryId: 'emergency', native: '気分が悪いです。', romanization: 'Kibun ga warui desu.', english: 'I feel unwell.'),
  Phrase(id: 'ja_em_5', categoryId: 'emergency', native: 'パスポートをなくしました。', romanization: 'Pasupōto o nakushimashita.', english: 'I lost my passport.'),
  Phrase(id: 'ja_em_6', categoryId: 'emergency', native: '英語を話せますか？', romanization: 'Eigo o hanasemasu ka?', english: 'Do you speak English?'),
  Phrase(id: 'ja_tr_1', categoryId: 'transport', native: '駅はどこですか？', romanization: 'Eki wa doko desu ka?', english: 'Where is the station?'),
  Phrase(id: 'ja_tr_2', categoryId: 'transport', native: 'この電車は新宿に行きますか？', romanization: 'Kono densha wa Shinjuku ni ikimasu ka?', english: 'Does this train go to Shinjuku?'),
  Phrase(id: 'ja_tr_3', categoryId: 'transport', native: 'タクシーを呼んでください。', romanization: 'Takushī o yonde kudasai.', english: 'Please call a taxi.'),
  Phrase(id: 'ja_tr_4', categoryId: 'transport', native: '切符を一枚ください。', romanization: 'Kippu o ichimai kudasai.', english: 'One ticket, please.'),
  Phrase(id: 'ja_hl_1', categoryId: 'health', native: '薬局はどこですか？', romanization: 'Yakkyoku wa doko desu ka?', english: 'Where is the pharmacy?'),
  Phrase(id: 'ja_hl_2', categoryId: 'health', native: '頭痛がします。', romanization: 'Zutsū ga shimasu.', english: 'I have a headache.'),
  Phrase(id: 'ja_hl_3', categoryId: 'health', native: '薬をください。', romanization: 'Kusuri o kudasai.', english: 'Medicine, please.'),
  Phrase(id: 'ja_nm_1', categoryId: 'numbers', native: '一つ', romanization: 'Hitotsu', english: 'One (item)'),
  Phrase(id: 'ja_nm_2', categoryId: 'numbers', native: 'いくらですか？', romanization: 'Ikura desu ka?', english: 'How much?'),
  Phrase(id: 'ja_nm_3', categoryId: 'numbers', native: '右に曲がってください。', romanization: 'Migi ni magatte kudasai.', english: 'Please turn right.'),
];

const _ko = <Phrase>[
  Phrase(id: 'ko_air_1', categoryId: 'airport', native: '탑승권은 어디서 받나요?', romanization: 'Tapseungkwoneun eodiseo bannayo?', english: 'Where can I get my boarding pass?'),
  Phrase(id: 'ko_air_2', categoryId: 'airport', native: '짐을 맡기고 싶어요.', romanization: 'Jimeul matgigo sipeoyo.', english: 'I would like to check in my luggage.'),
  Phrase(id: 'ko_air_3', categoryId: 'airport', native: '게이트가 어디예요?', romanization: 'Gateuga eodiyeyo?', english: 'Where is the gate?'),
  Phrase(id: 'ko_air_4', categoryId: 'airport', native: '이 비행기는 지연되나요?', romanization: 'I bihaenggineun jiyeondoenayo?', english: 'Is this flight delayed?'),
  Phrase(id: 'ko_air_5', categoryId: 'airport', native: '입국 심사는 어디예요?', romanization: 'Ipuk simsaneun eodiyeyo?', english: 'Where is immigration?'),
  Phrase(id: 'ko_air_6', categoryId: 'airport', native: '짐을 잃어버렸어요.', romanization: 'Jimeul ileobeoryeosseoyo.', english: 'I lost my luggage.'),
  Phrase(id: 'ko_htl_1', categoryId: 'hotel', native: '예약했어요.', romanization: 'Yeyakhaesseoyo.', english: 'I have a reservation.'),
  Phrase(id: 'ko_htl_2', categoryId: 'hotel', native: '체크인 해주세요.', romanization: 'Chekeuin haejuseyo.', english: 'I would like to check in.'),
  Phrase(id: 'ko_htl_3', categoryId: 'hotel', native: '와이파이 비밀번호가 뭐예요?', romanization: 'Waipai bimilbeonhoga mwoyeyo?', english: 'What is the Wi-Fi password?'),
  Phrase(id: 'ko_htl_4', categoryId: 'hotel', native: '짐을 보관해 주시겠어요?', romanization: 'Jimeul bogwanhae jusigesseoyo?', english: 'Can you hold my bags?'),
  Phrase(id: 'ko_htl_5', categoryId: 'hotel', native: '체크아웃은 몇 시예요?', romanization: 'Chekeuauseun myeot siyeyo?', english: 'What time is checkout?'),
  Phrase(id: 'ko_htl_6', categoryId: 'hotel', native: '수건 하나 더 주세요.', romanization: 'Sugeon hana deo juseyo.', english: 'Could I have another towel?'),
  Phrase(id: 'ko_fd_1', categoryId: 'food', native: '메뉴 주세요.', romanization: 'Menyu juseyo.', english: 'Please bring the menu.'),
  Phrase(id: 'ko_fd_2', categoryId: 'food', native: '추천 메뉴가 뭐예요?', romanization: 'Chucheon menyuga mwoyeyo?', english: 'What do you recommend?'),
  Phrase(id: 'ko_fd_3', categoryId: 'food', native: '알레르기가 있어요.', romanization: 'Allereugiga isseoyo.', english: 'I have an allergy.'),
  Phrase(id: 'ko_fd_4', categoryId: 'food', native: '계산해 주세요.', romanization: 'Gyesanhae juseyo.', english: 'The bill, please.'),
  Phrase(id: 'ko_fd_5', categoryId: 'food', native: '물 주세요.', romanization: 'Mul juseyo.', english: 'Water, please.'),
  Phrase(id: 'ko_fd_6', categoryId: 'food', native: '이거 매워요?', romanization: 'Igeo maewoyo?', english: 'Is this spicy?'),
  Phrase(id: 'ko_sh_1', categoryId: 'shopping', native: '이거 얼마예요?', romanization: 'Igeo eolmayeyo?', english: 'How much is this?'),
  Phrase(id: 'ko_sh_2', categoryId: 'shopping', native: '입어봐도 돼요?', romanization: 'Ibeobwado dwaeyo?', english: 'Can I try this on?'),
  Phrase(id: 'ko_sh_3', categoryId: 'shopping', native: '더 작은 사이즈 있어요?', romanization: 'Deo jageun saijeu isseoyo?', english: 'Do you have a smaller size?'),
  Phrase(id: 'ko_sh_4', categoryId: 'shopping', native: '카드로 결제되나요?', romanization: 'Kadeuro gyeoljedoenayo?', english: 'Can I pay by card?'),
  Phrase(id: 'ko_sh_5', categoryId: 'shopping', native: '봉투 주세요.', romanization: 'Bongtu juseyo.', english: 'A bag, please.'),
  Phrase(id: 'ko_sh_6', categoryId: 'shopping', native: '면세 되나요?', romanization: 'Myeonse doenayo?', english: 'Can I get tax-free?'),
  Phrase(id: 'ko_em_1', categoryId: 'emergency', native: '도와주세요.', romanization: 'Dowajuseyo.', english: 'Please help me.'),
  Phrase(id: 'ko_em_2', categoryId: 'emergency', native: '경찰을 불러 주세요.', romanization: 'Gyeongchareul bulleo juseyo.', english: 'Please call the police.'),
  Phrase(id: 'ko_em_3', categoryId: 'emergency', native: '병원이 어디예요?', romanization: 'Byeongwoni eodiyeyo?', english: 'Where is the hospital?'),
  Phrase(id: 'ko_em_4', categoryId: 'emergency', native: '몸이 안 좋아요.', romanization: 'Momi an joayo.', english: 'I feel unwell.'),
  Phrase(id: 'ko_em_5', categoryId: 'emergency', native: '여권을 잃어버렸어요.', romanization: 'Yeogwoneul ileobeoryeosseoyo.', english: 'I lost my passport.'),
  Phrase(id: 'ko_em_6', categoryId: 'emergency', native: '영어 하세요?', romanization: 'Yeongeo haseyo?', english: 'Do you speak English?'),
  Phrase(id: 'ko_tr_1', categoryId: 'transport', native: '역이 어디예요?', romanization: 'Yeogi eodiyeyo?', english: 'Where is the station?'),
  Phrase(id: 'ko_tr_2', categoryId: 'transport', native: '이 기차는 서울로 가나요?', romanization: 'I gichaneun seoullo ganayo?', english: 'Does this train go to Seoul?'),
  Phrase(id: 'ko_tr_3', categoryId: 'transport', native: '택시 불러 주세요.', romanization: 'Taeksi bulleo juseyo.', english: 'Please call a taxi.'),
  Phrase(id: 'ko_tr_4', categoryId: 'transport', native: '표 한 장 주세요.', romanization: 'Pyo han jang juseyo.', english: 'One ticket, please.'),
  Phrase(id: 'ko_hl_1', categoryId: 'health', native: '약국이 어디예요?', romanization: 'Yakgugi eodiyeyo?', english: 'Where is the pharmacy?'),
  Phrase(id: 'ko_hl_2', categoryId: 'health', native: '머리가 아파요.', romanization: 'Meoriga apayo.', english: 'I have a headache.'),
  Phrase(id: 'ko_hl_3', categoryId: 'health', native: '약 주세요.', romanization: 'Yak juseyo.', english: 'Medicine, please.'),
  Phrase(id: 'ko_nm_1', categoryId: 'numbers', native: '하나', romanization: 'Hana', english: 'One (item)'),
  Phrase(id: 'ko_nm_2', categoryId: 'numbers', native: '얼마예요?', romanization: 'Eolmayeyo?', english: 'How much?'),
  Phrase(id: 'ko_nm_3', categoryId: 'numbers', native: '오른쪽으로 가 주세요.', romanization: 'Oreunjjogeuro ga juseyo.', english: 'Please turn right.'),
];

const _th = <Phrase>[
  Phrase(id: 'th_air_1', categoryId: 'airport', native: 'รับบัตรขึ้นเครื่องที่ไหนครับ?', romanization: 'Rap bat kheun khrueang thi nai khrap?', english: 'Where can I get my boarding pass?'),
  Phrase(id: 'th_air_2', categoryId: 'airport', native: 'อยากฝากกระเป๋าครับ', romanization: 'Yak fak krapao khrap', english: 'I would like to check in my luggage.'),
  Phrase(id: 'th_air_3', categoryId: 'airport', native: 'เกตอยู่ที่ไหนครับ?', romanization: 'Get yu thi nai khrap?', english: 'Where is the gate?'),
  Phrase(id: 'th_air_4', categoryId: 'airport', native: 'เที่ยวบินนี้ดีเลย์ไหมครับ?', romanization: 'Thiao bin ni delay mai khrap?', english: 'Is this flight delayed?'),
  Phrase(id: 'th_air_5', categoryId: 'airport', native: 'ตรวจคนเข้าเมืองอยู่ที่ไหนครับ?', romanization: 'Truat khon khao mueang yu thi nai khrap?', english: 'Where is immigration?'),
  Phrase(id: 'th_air_6', categoryId: 'airport', native: 'กระเป๋าหายครับ', romanization: 'Krapao hai khrap', english: 'I lost my luggage.'),
  Phrase(id: 'th_htl_1', categoryId: 'hotel', native: 'จองห้องไว้แล้วครับ', romanization: 'Chong hong wai laeo khrap', english: 'I have a reservation.'),
  Phrase(id: 'th_htl_2', categoryId: 'hotel', native: 'ขอเช็คอินครับ', romanization: 'Kho check-in khrap', english: 'I would like to check in.'),
  Phrase(id: 'th_htl_3', categoryId: 'hotel', native: 'รหัสไวไฟคืออะไรครับ?', romanization: 'Hats wi-fai khue arai khrap?', english: 'What is the Wi-Fi password?'),
  Phrase(id: 'th_htl_4', categoryId: 'hotel', native: 'ฝากกระเป๋าได้ไหมครับ?', romanization: 'Fak krapao dai mai khrap?', english: 'Can you hold my bags?'),
  Phrase(id: 'th_htl_5', categoryId: 'hotel', native: 'เช็คเอาต์กี่โมงครับ?', romanization: 'Check-out ki mong khrap?', english: 'What time is checkout?'),
  Phrase(id: 'th_htl_6', categoryId: 'hotel', native: 'ขอผ้าเช็ดตัวอีกผืนครับ', romanization: 'Kho pha chet tua ik phuen khrap', english: 'Could I have another towel?'),
  Phrase(id: 'th_fd_1', categoryId: 'food', native: 'ขอเมนูครับ', romanization: 'Kho menu khrap', english: 'Please bring the menu.'),
  Phrase(id: 'th_fd_2', categoryId: 'food', native: 'แนะนำอะไรดีครับ?', romanization: 'Naenam arai di khrap?', english: 'What do you recommend?'),
  Phrase(id: 'th_fd_3', categoryId: 'food', native: 'แพ้อาหารครับ', romanization: 'Phae ahan khrap', english: 'I have an allergy.'),
  Phrase(id: 'th_fd_4', categoryId: 'food', native: 'คิดเงินครับ', romanization: 'Khit ngen khrap', english: 'The bill, please.'),
  Phrase(id: 'th_fd_5', categoryId: 'food', native: 'ขอน้ำครับ', romanization: 'Kho nam khrap', english: 'Water, please.'),
  Phrase(id: 'th_fd_6', categoryId: 'food', native: 'เผ็ดไหมครับ?', romanization: 'Phet mai khrap?', english: 'Is this spicy?'),
  Phrase(id: 'th_sh_1', categoryId: 'shopping', native: 'อันนี้เท่าไหร่ครับ?', romanization: 'An ni thao rai khrap?', english: 'How much is this?'),
  Phrase(id: 'th_sh_2', categoryId: 'shopping', native: 'ลองใส่ได้ไหมครับ?', romanization: 'Long sai dai mai khrap?', english: 'Can I try this on?'),
  Phrase(id: 'th_sh_3', categoryId: 'shopping', native: 'มีไซส์เล็กกว่านี้ไหมครับ?', romanization: 'Mi sai lek kwa ni mai khrap?', english: 'Do you have a smaller size?'),
  Phrase(id: 'th_sh_4', categoryId: 'shopping', native: 'จ่ายบัตรได้ไหมครับ?', romanization: 'Chai bat dai mai khrap?', english: 'Can I pay by card?'),
  Phrase(id: 'th_sh_5', categoryId: 'shopping', native: 'ขอถุงครับ', romanization: 'Kho thung khrap', english: 'A bag, please.'),
  Phrase(id: 'th_sh_6', categoryId: 'shopping', native: 'คืนภาษีได้ไหมครับ?', romanization: 'Khuen phasi dai mai khrap?', english: 'Can I get tax-free?'),
  Phrase(id: 'th_em_1', categoryId: 'emergency', native: 'ช่วยด้วยครับ', romanization: 'Chuai duai khrap', english: 'Please help me.'),
  Phrase(id: 'th_em_2', categoryId: 'emergency', native: 'เรียกตำรวจให้หน่อยครับ', romanization: 'Riak tamruat hai noi khrap', english: 'Please call the police.'),
  Phrase(id: 'th_em_3', categoryId: 'emergency', native: 'โรงพยาบาลอยู่ที่ไหนครับ?', romanization: 'Rong phayaban yu thi nai khrap?', english: 'Where is the hospital?'),
  Phrase(id: 'th_em_4', categoryId: 'emergency', native: 'รู้สึกไม่สบายครับ', romanization: 'Rusuek mai sabai khrap', english: 'I feel unwell.'),
  Phrase(id: 'th_em_5', categoryId: 'emergency', native: 'พาสปอร์ตหายครับ', romanization: 'Passport hai khrap', english: 'I lost my passport.'),
  Phrase(id: 'th_em_6', categoryId: 'emergency', native: 'พูดอังกฤษได้ไหมครับ?', romanization: 'Phut angkrit dai mai khrap?', english: 'Do you speak English?'),
  Phrase(id: 'th_tr_1', categoryId: 'transport', native: 'สถานีอยู่ที่ไหนครับ?', romanization: 'Sathani yu thi nai khrap?', english: 'Where is the station?'),
  Phrase(id: 'th_tr_2', categoryId: 'transport', native: 'รถไฟขบวนนี้ไปกรุงเทพไหมครับ?', romanization: 'Rotfai khabuan ni pai Krung Thep mai khrap?', english: 'Does this train go to Bangkok?'),
  Phrase(id: 'th_tr_3', categoryId: 'transport', native: 'เรียกแท็กซี่ให้หน่อยครับ', romanization: 'Riak taxi hai noi khrap', english: 'Please call a taxi.'),
  Phrase(id: 'th_tr_4', categoryId: 'transport', native: 'ขอตั๋วหนึ่งใบครับ', romanization: 'Kho tua nueng bai khrap', english: 'One ticket, please.'),
  Phrase(id: 'th_hl_1', categoryId: 'health', native: 'ร้านขายยาอยู่ที่ไหนครับ?', romanization: 'Ran khai ya yu thi nai khrap?', english: 'Where is the pharmacy?'),
  Phrase(id: 'th_hl_2', categoryId: 'health', native: 'ปวดหัวครับ', romanization: 'Puat hua khrap', english: 'I have a headache.'),
  Phrase(id: 'th_hl_3', categoryId: 'health', native: 'ขอยาครับ', romanization: 'Kho ya khrap', english: 'Medicine, please.'),
  Phrase(id: 'th_nm_1', categoryId: 'numbers', native: 'หนึ่ง', romanization: 'Nueng', english: 'One (item)'),
  Phrase(id: 'th_nm_2', categoryId: 'numbers', native: 'เท่าไหร่ครับ?', romanization: 'Thao rai khrap?', english: 'How much?'),
  Phrase(id: 'th_nm_3', categoryId: 'numbers', native: 'เลี้ยวขวาครับ', romanization: 'Liao khwa khrap', english: 'Please turn right.'),
];

const _es = <Phrase>[
  Phrase(id: 'es_air_1', categoryId: 'airport', native: '¿Dónde puedo recoger mi tarjeta de embarque?', romanization: 'Don-de pwe-do re-co-her mi tar-he-ta de em-bar-ke?', english: 'Where can I get my boarding pass?'),
  Phrase(id: 'es_air_2', categoryId: 'airport', native: 'Quiero facturar el equipaje.', romanization: 'Kye-ro fak-tu-rar el e-ki-pa-he.', english: 'I would like to check in my luggage.'),
  Phrase(id: 'es_air_3', categoryId: 'airport', native: '¿Dónde está la puerta?', romanization: 'Don-de es-ta la pwer-ta?', english: 'Where is the gate?'),
  Phrase(id: 'es_air_4', categoryId: 'airport', native: '¿Este vuelo tiene retraso?', romanization: 'Es-te vwe-lo tye-ne re-tra-so?', english: 'Is this flight delayed?'),
  Phrase(id: 'es_air_5', categoryId: 'airport', native: '¿Dónde está inmigración?', romanization: 'Don-de es-ta in-mi-gra-thyon?', english: 'Where is immigration?'),
  Phrase(id: 'es_air_6', categoryId: 'airport', native: 'He perdido el equipaje.', romanization: 'E per-di-do el e-ki-pa-he.', english: 'I lost my luggage.'),
  Phrase(id: 'es_htl_1', categoryId: 'hotel', native: 'Tengo una reserva.', romanization: 'Ten-go u-na re-ser-ba.', english: 'I have a reservation.'),
  Phrase(id: 'es_htl_2', categoryId: 'hotel', native: 'Quiero hacer el check-in.', romanization: 'Kye-ro a-ther el chek-in.', english: 'I would like to check in.'),
  Phrase(id: 'es_htl_3', categoryId: 'hotel', native: '¿Cuál es la contraseña del Wi-Fi?', romanization: 'Kwal es la con-tra-se-nya del wi-fi?', english: 'What is the Wi-Fi password?'),
  Phrase(id: 'es_htl_4', categoryId: 'hotel', native: '¿Pueden guardar mi maleta?', romanization: 'Pwe-den gwar-dar mi ma-le-ta?', english: 'Can you hold my bags?'),
  Phrase(id: 'es_htl_5', categoryId: 'hotel', native: '¿A qué hora es el check-out?', romanization: 'A ke o-ra es el chek-out?', english: 'What time is checkout?'),
  Phrase(id: 'es_htl_6', categoryId: 'hotel', native: '¿Me da otra toalla?', romanization: 'Me da o-tra to-a-ya?', english: 'Could I have another towel?'),
  Phrase(id: 'es_fd_1', categoryId: 'food', native: 'La carta, por favor.', romanization: 'La car-ta por fa-bor.', english: 'Please bring the menu.'),
  Phrase(id: 'es_fd_2', categoryId: 'food', native: '¿Qué recomienda?', romanization: 'Ke re-ko-myen-da?', english: 'What do you recommend?'),
  Phrase(id: 'es_fd_3', categoryId: 'food', native: 'Tengo alergia.', romanization: 'Ten-go a-ler-hya.', english: 'I have an allergy.'),
  Phrase(id: 'es_fd_4', categoryId: 'food', native: 'La cuenta, por favor.', romanization: 'La kwen-ta por fa-bor.', english: 'The bill, please.'),
  Phrase(id: 'es_fd_5', categoryId: 'food', native: 'Agua, por favor.', romanization: 'A-gwa por fa-bor.', english: 'Water, please.'),
  Phrase(id: 'es_fd_6', categoryId: 'food', native: '¿Esto es picante?', romanization: 'Es-to es pi-kan-te?', english: 'Is this spicy?'),
  Phrase(id: 'es_sh_1', categoryId: 'shopping', native: '¿Cuánto cuesta esto?', romanization: 'Kwan-to kwes-ta es-to?', english: 'How much is this?'),
  Phrase(id: 'es_sh_2', categoryId: 'shopping', native: '¿Puedo probármelo?', romanization: 'Pwe-do pro-bar-me-lo?', english: 'Can I try this on?'),
  Phrase(id: 'es_sh_3', categoryId: 'shopping', native: '¿Tienen una talla más pequeña?', romanization: 'Tye-nen u-na ta-ya mas pe-ke-nya?', english: 'Do you have a smaller size?'),
  Phrase(id: 'es_sh_4', categoryId: 'shopping', native: '¿Puedo pagar con tarjeta?', romanization: 'Pwe-do pa-gar con tar-he-ta?', english: 'Can I pay by card?'),
  Phrase(id: 'es_sh_5', categoryId: 'shopping', native: 'Una bolsa, por favor.', romanization: 'U-na bol-sa por fa-bor.', english: 'A bag, please.'),
  Phrase(id: 'es_sh_6', categoryId: 'shopping', native: '¿Hay tax free?', romanization: 'Ay tax free?', english: 'Can I get tax-free?'),
  Phrase(id: 'es_em_1', categoryId: 'emergency', native: 'Ayuda, por favor.', romanization: 'A-yu-da por fa-bor.', english: 'Please help me.'),
  Phrase(id: 'es_em_2', categoryId: 'emergency', native: 'Llame a la policía.', romanization: 'Ya-me a la po-li-thi-a.', english: 'Please call the police.'),
  Phrase(id: 'es_em_3', categoryId: 'emergency', native: '¿Dónde está el hospital?', romanization: 'Don-de es-ta el os-pi-tal?', english: 'Where is the hospital?'),
  Phrase(id: 'es_em_4', categoryId: 'emergency', native: 'Me siento mal.', romanization: 'Me syen-to mal.', english: 'I feel unwell.'),
  Phrase(id: 'es_em_5', categoryId: 'emergency', native: 'He perdido el pasaporte.', romanization: 'E per-di-do el pa-sa-por-te.', english: 'I lost my passport.'),
  Phrase(id: 'es_em_6', categoryId: 'emergency', native: '¿Habla inglés?', romanization: 'A-bla in-gles?', english: 'Do you speak English?'),
  Phrase(id: 'es_tr_1', categoryId: 'transport', native: '¿Dónde está la estación?', romanization: 'Don-de es-ta la es-ta-thyon?', english: 'Where is the station?'),
  Phrase(id: 'es_tr_2', categoryId: 'transport', native: '¿Este tren va al centro?', romanization: 'Es-te tren ba al then-tro?', english: 'Does this train go downtown?'),
  Phrase(id: 'es_tr_3', categoryId: 'transport', native: 'Un taxi, por favor.', romanization: 'Un tak-si por fa-bor.', english: 'Please call a taxi.'),
  Phrase(id: 'es_tr_4', categoryId: 'transport', native: 'Un billete, por favor.', romanization: 'Un bi-ye-te por fa-bor.', english: 'One ticket, please.'),
  Phrase(id: 'es_hl_1', categoryId: 'health', native: '¿Dónde está la farmacia?', romanization: 'Don-de es-ta la far-ma-thya?', english: 'Where is the pharmacy?'),
  Phrase(id: 'es_hl_2', categoryId: 'health', native: 'Me duele la cabeza.', romanization: 'Me dwe-le la ka-be-tha.', english: 'I have a headache.'),
  Phrase(id: 'es_hl_3', categoryId: 'health', native: 'Medicina, por favor.', romanization: 'Me-di-thi-na por fa-bor.', english: 'Medicine, please.'),
  Phrase(id: 'es_nm_1', categoryId: 'numbers', native: 'Uno', romanization: 'U-no', english: 'One (item)'),
  Phrase(id: 'es_nm_2', categoryId: 'numbers', native: '¿Cuánto es?', romanization: 'Kwan-to es?', english: 'How much?'),
  Phrase(id: 'es_nm_3', categoryId: 'numbers', native: 'Gire a la derecha.', romanization: 'Hi-re a la de-re-cha.', english: 'Please turn right.'),
];

const _fr = <Phrase>[
  Phrase(id: 'fr_air_1', categoryId: 'airport', native: 'Où puis-je récupérer ma carte d’embarquement ?', romanization: 'Ou pwee-je re-ku-pe-re ma kart dahn-bar-ke-mahn?', english: 'Where can I get my boarding pass?'),
  Phrase(id: 'fr_air_2', categoryId: 'airport', native: 'Je voudrais enregistrer mes bagages.', romanization: 'Je voo-dre ahn-re-jee-stre me ba-gazh.', english: 'I would like to check in my luggage.'),
  Phrase(id: 'fr_air_3', categoryId: 'airport', native: 'Où est la porte d’embarquement ?', romanization: 'Ou eh la port dahn-bar-ke-mahn?', english: 'Where is the gate?'),
  Phrase(id: 'fr_air_4', categoryId: 'airport', native: 'Ce vol est-il en retard ?', romanization: 'Se vol eh-teel ahn re-tar?', english: 'Is this flight delayed?'),
  Phrase(id: 'fr_air_5', categoryId: 'airport', native: 'Où est le contrôle des passeports ?', romanization: 'Ou eh le kon-trol de pas-por?', english: 'Where is immigration?'),
  Phrase(id: 'fr_air_6', categoryId: 'airport', native: 'J’ai perdu mes bagages.', romanization: 'Zhay per-du me ba-gazh.', english: 'I lost my luggage.'),
  Phrase(id: 'fr_htl_1', categoryId: 'hotel', native: 'J’ai une réservation.', romanization: 'Zhay uen re-zer-va-syon.', english: 'I have a reservation.'),
  Phrase(id: 'fr_htl_2', categoryId: 'hotel', native: 'Je voudrais m’enregistrer.', romanization: 'Je voo-dre mahn-re-jee-stre.', english: 'I would like to check in.'),
  Phrase(id: 'fr_htl_3', categoryId: 'hotel', native: 'Quel est le mot de passe du Wi-Fi ?', romanization: 'Kel eh le mo de pas du wi-fi?', english: 'What is the Wi-Fi password?'),
  Phrase(id: 'fr_htl_4', categoryId: 'hotel', native: 'Pouvez-vous garder mes bagages ?', romanization: 'Poo-ve voo gar-de me ba-gazh?', english: 'Can you hold my bags?'),
  Phrase(id: 'fr_htl_5', categoryId: 'hotel', native: 'À quelle heure est le départ ?', romanization: 'A kel er eh le de-par?', english: 'What time is checkout?'),
  Phrase(id: 'fr_htl_6', categoryId: 'hotel', native: 'Puis-je avoir une autre serviette ?', romanization: 'Pwee-je a-vwar uen o-tre ser-vyet?', english: 'Could I have another towel?'),
  Phrase(id: 'fr_fd_1', categoryId: 'food', native: 'La carte, s’il vous plaît.', romanization: 'La kart seel voo pleh.', english: 'Please bring the menu.'),
  Phrase(id: 'fr_fd_2', categoryId: 'food', native: 'Que recommandez-vous ?', romanization: 'Ke re-ko-mahn-de voo?', english: 'What do you recommend?'),
  Phrase(id: 'fr_fd_3', categoryId: 'food', native: 'J’ai une allergie.', romanization: 'Zhay uen a-ler-zhee.', english: 'I have an allergy.'),
  Phrase(id: 'fr_fd_4', categoryId: 'food', native: 'L’addition, s’il vous plaît.', romanization: 'La-dee-syon seel voo pleh.', english: 'The bill, please.'),
  Phrase(id: 'fr_fd_5', categoryId: 'food', native: 'De l’eau, s’il vous plaît.', romanization: 'De lo seel voo pleh.', english: 'Water, please.'),
  Phrase(id: 'fr_fd_6', categoryId: 'food', native: 'Est-ce épicé ?', romanization: 'Ess e-pee-se?', english: 'Is this spicy?'),
  Phrase(id: 'fr_sh_1', categoryId: 'shopping', native: 'Combien ça coûte ?', romanization: 'Kom-byen sa koot?', english: 'How much is this?'),
  Phrase(id: 'fr_sh_2', categoryId: 'shopping', native: 'Puis-je l’essayer ?', romanization: 'Pwee-je less-ay-e?', english: 'Can I try this on?'),
  Phrase(id: 'fr_sh_3', categoryId: 'shopping', native: 'Avez-vous une taille plus petite ?', romanization: 'A-ve voo uen tai plu pe-teet?', english: 'Do you have a smaller size?'),
  Phrase(id: 'fr_sh_4', categoryId: 'shopping', native: 'Puis-je payer par carte ?', romanization: 'Pwee-je pe-ye par kart?', english: 'Can I pay by card?'),
  Phrase(id: 'fr_sh_5', categoryId: 'shopping', native: 'Un sac, s’il vous plaît.', romanization: 'Un sak seel voo pleh.', english: 'A bag, please.'),
  Phrase(id: 'fr_sh_6', categoryId: 'shopping', native: 'Y a-t-il le détaxe ?', romanization: 'Ya-teel le de-taks?', english: 'Can I get tax-free?'),
  Phrase(id: 'fr_em_1', categoryId: 'emergency', native: 'Aidez-moi, s’il vous plaît.', romanization: 'Eh-de mwa seel voo pleh.', english: 'Please help me.'),
  Phrase(id: 'fr_em_2', categoryId: 'emergency', native: 'Appelez la police.', romanization: 'A-ple la po-lees.', english: 'Please call the police.'),
  Phrase(id: 'fr_em_3', categoryId: 'emergency', native: 'Où est l’hôpital ?', romanization: 'Ou eh lo-pee-tal?', english: 'Where is the hospital?'),
  Phrase(id: 'fr_em_4', categoryId: 'emergency', native: 'Je ne me sens pas bien.', romanization: 'Je ne me sahn pa byen.', english: 'I feel unwell.'),
  Phrase(id: 'fr_em_5', categoryId: 'emergency', native: 'J’ai perdu mon passeport.', romanization: 'Zhay per-du mon pas-por.', english: 'I lost my passport.'),
  Phrase(id: 'fr_em_6', categoryId: 'emergency', native: 'Parlez-vous anglais ?', romanization: 'Par-le voo ahn-gleh?', english: 'Do you speak English?'),
  Phrase(id: 'fr_tr_1', categoryId: 'transport', native: 'Où est la gare ?', romanization: 'Ou eh la gar?', english: 'Where is the station?'),
  Phrase(id: 'fr_tr_2', categoryId: 'transport', native: 'Ce train va-t-il au centre ?', romanization: 'Se trehn va-teel o sahn-tr?', english: 'Does this train go downtown?'),
  Phrase(id: 'fr_tr_3', categoryId: 'transport', native: 'Un taxi, s’il vous plaît.', romanization: 'Un tak-si seel voo pleh.', english: 'Please call a taxi.'),
  Phrase(id: 'fr_tr_4', categoryId: 'transport', native: 'Un billet, s’il vous plaît.', romanization: 'Un bee-ye seel voo pleh.', english: 'One ticket, please.'),
  Phrase(id: 'fr_hl_1', categoryId: 'health', native: 'Où est la pharmacie ?', romanization: 'Ou eh la far-ma-see?', english: 'Where is the pharmacy?'),
  Phrase(id: 'fr_hl_2', categoryId: 'health', native: 'J’ai mal à la tête.', romanization: 'Zhay mal a la tet.', english: 'I have a headache.'),
  Phrase(id: 'fr_hl_3', categoryId: 'health', native: 'Un médicament, s’il vous plaît.', romanization: 'Un me-dee-ka-mahn seel voo pleh.', english: 'Medicine, please.'),
  Phrase(id: 'fr_nm_1', categoryId: 'numbers', native: 'Un', romanization: 'Un', english: 'One (item)'),
  Phrase(id: 'fr_nm_2', categoryId: 'numbers', native: 'Ça fait combien ?', romanization: 'Sa feh kom-byen?', english: 'How much?'),
  Phrase(id: 'fr_nm_3', categoryId: 'numbers', native: 'Tournez à droite.', romanization: 'Toor-ne a drwat.', english: 'Please turn right.'),
];

const _byLang = <String, List<Phrase>>{
  'ja': _ja,
  'ko': _ko,
  'th': _th,
  'es': _es,
  'fr': _fr,
  'vi': viPhrases,
  'it': itPhrases,
  'de': dePhrases,
  'zh': zhPhrases,
};
