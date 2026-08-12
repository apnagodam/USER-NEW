class QaItem {
  final List<String> keywords;
  final String en;
  final String hi;
  final String mwr;
  final String bho;
  final String guj;

  const QaItem({
    required this.keywords,
    required this.en,
    required this.hi,
    required this.mwr,
    required this.bho,
    required this.guj,
  });
}

class QaDataset200 {
  static const List<QaItem> items = [
    // Q1
    QaItem(
      keywords: ['deposit grain', 'mal jama', 'माल जमा', 'inward', 'इनवर्ड', 'જમા'],
      en: 'Tap "Inwards" in the app, select warehouse, commodity & stack, enter weight and vehicle number to submit.',
      hi: 'ऐप में "माल जमा" पर क्लिक करें, अपना गोदाम, अनाज और स्टैक नंबर चुनें, वजन और वाहन विवरण भरें।',
      mwr: 'गोदाम मांय माल जमा (Inward) करावण वास्ते ऐप में माल जमा पर क्लिक करो सा, स्टैक चुणो अर सबमिट करो सा।',
      bho: 'गोदाम में माल जमा (Inward) करे खातिर ऐप में माल जमा पर क्लिक करीं, अपना गोदाम, अनाज अउर स्टैक नंबर चुनीं।',
      guj: 'ગોડાઉનમાં માલ જમા (Inward) કરવા માટે એપ્લિકેશનમાં "માલ જમા" પર ક્લિક કરો, અનાજ અને સ્ટેક પસંદ કરો.',
    ),
    // Q2
    QaItem(
      keywords: ['withdraw grain', 'mal nikasi', 'माल निकासी', 'outward', 'आउटवर्ड', 'નિકાસી'],
      en: 'Tap "Outward" in the warehouse section, select your commodity stack, enter weight & vehicle details.',
      hi: 'ऐप के "माल निकासी" सेक्शन में जाएं, अपना स्टैक चुनें, निकासी वजन और वाहन विवरण भरकर सबमिट करें।',
      mwr: 'गोदाम सूं माल काढण वास्ते ऐप में माल निकासी पर जावो सा, आपरो स्टैक चुणो अर सबमिट करो सा।',
      bho: 'गोदाम से माल निकाले (Outward) खातिर ऐप में माल निकासी पर क्लिक करीं, अपना गोदाम अउर स्टैक चुन के सबमिट करीं।',
      guj: 'ગોડાઉનમાંથી માલ કાઢવા (Outward) માટે "માલ નિકાસી" પર ક્લિક કરો અને વજન ભરી સબમિટ કરો.',
    ),
    // Q3 & Q4
    QaItem(
      keywords: ['digital gatepass', 'gatepass', 'gate pass', 'गेट पास', 'गेटपास', 'ગેટ પાસ'],
      en: 'Submit an Inward or Outward request; once approved, your QR code digital gate pass automatically generates in app.',
      hi: 'इनवर्ड या आउटवर्ड रिक्वेस्ट सबमिट करें, अप्रूवल मिलते ही ऐप में QR कोड गेट पास जारी हो जाएगा।',
      mwr: 'डिजिटल गेट पास बणावण वास्ते इनवर्ड या आउटवर्ड रिक्वेस्ट सबमिट करो सा, QR गेट पास बण ज्यासी सा।',
      bho: 'डिजिटल गेट पास बनावे खातिर इनवर्ड भा आउटवर्ड रिक्वेस्ट सबमिट करीं, अप्रूवल मिलत ही ऐप में QR कोड गेट पास जारी हो जाई।',
      guj: 'ડિજિટલ ગેટ પાસ (Gate Pass) માટે ઈનવર્ડ કે આઉટવર્ડ વિનંતી મંજૂર થતાં જ એપ્લિકેશનમાં QR ગેટ પાસ જનરેટ થઈ જાય છે.',
    ),
    // Q5 & Q6
    QaItem(
      keywords: ['kata parchi', 'kanta parchi', 'weigh slip', 'कांटा पर्ची', 'कांटा मैन', 'kanta man', 'कांटा पर्ची कौन', 'कांटा रसीद'],
      en: 'Kata Parchi (Weigh Slip) is the official weighbridge slip issued by the Weighbridge Operator (Kanta Man) recording gross, tare, and net weight.',
      hi: 'कांटा पर्ची (Weigh Slip) धर्म कांटा पर मौजूद कांटा मैन द्वारा जारी रसीद है जिसमें गाड़ी का सकल (Gross), खाली (Tare) और शुद्ध (Net) वजन दर्ज होता है।',
      mwr: 'कांटा पर्ची धर्म कांटा पर तैनात कांटा मैन गाड़ियां रो वजन कर देवे छै, जका मांय सकल अर शुद्ध वजन दर्ज होवै छै सा।',
      bho: 'कांटा पर्ची धर्म कांटा पर मौजूद कांटा मैन द्वारा जारी कइल जाला जवना में कुल अउर शुद्ध तोल दर्ज होला।',
      guj: 'કાંટા પર્ચી (Weigh Slip) કાંટા મેન (Weighbridge Operator) દ્વારા આપવામાં આવે છે જેમાં ગ્રોસ, ટેર અને નેટ વજન નોંધાય છે.',
    ),
    // Q7
    QaItem(
      keywords: ['stack number', 'stack no', 'स्टैक नंबर', 'स्टैक', 'stack'],
      en: 'Stack number is the unique identification code assigned to a specific pile/lot of commodity bags stored inside a warehouse.',
      hi: 'गोदाम में बोरियों की निश्चित ढेरी (ढेर) को दिया गया विशिष्ट पहचान नंबर स्टैक नंबर कहलाता है।',
      mwr: 'गोदाम मांय बोरियां री ठोर (ढेरी) ने दियो गयो खास नंबर स्टैक नंबर होवै छै सा।',
      bho: 'गोदाम में बोरियन के निश्चित ढेरी (ढेर) के दिहल गइल खास नंबर स्टैक नंबर होला।',
      guj: 'ગોડાઉનમાં બોરીઓની ચોક્કસ ઢગલીને આપવામાં આવેલો ખાસ ઓળખ નંબર સ્ટેક નંબર છે.',
    ),
    // Q8
    QaItem(
      keywords: ['jute bag', 'जूट बोरी', 'कट्टा', 'jute bag capacity'],
      en: 'Standard jute bag capacity is typically 50 kg or 100 kg per bag depending on the crop type.',
      hi: 'मानक जूट बोरी में फसल के अनुसार सामान्यतः 50 किग्रा या 100 किग्रा अनाज भरा जाता है।',
      mwr: 'मानक जूट बोरी में फसल री किस्म अनुसार 50 किग्रा या 100 किग्रा माल आवै छै सा।',
      bho: 'मानक जूट बोरी में फसल के अनुसार 50 किग्रा चाहे 100 किग्रा अनाज भरल जाला।',
      guj: 'સ્ટાન્ડર્ડ જૂટ બોરીમાં પાકના પ્રકાર મુજબ 50 કિગ્રા અથવા 100 કિગ્રા માલ ભરાય છે.',
    ),
    // Q9
    QaItem(
      keywords: ['sutli', 'stitching thread', 'सुतली', 'सिलाई सुतली', 'धागा'],
      en: 'Stitching Thread (Sutli) is strong thread used for machine or manual stitching of filled commodity bags to prevent spillage.',
      hi: 'अनाज की बोरियों को बंद करने और सिलाई के लिए इस्तेमाल किया जाने वाला मजबूत धागा या सुतली।',
      mwr: 'बोरियां रो मुंह बंद कर सिलाई करण वास्ते काम आवण वाली सुतली अर धागो सा।',
      bho: 'अनाज के बोरियन के मुंह बंद कर के सिलाई करे खातिर इस्तेमाल होवे वाला मजबूत सुतली।',
      guj: 'બોરીઓનું મોં બંધ કરીને સિલાઇ કરવા માટે વપરાતી મજબૂત સૂતળી અને દોરો.',
    ),
    // Q10
    QaItem(
      keywords: ['plastic bag', 'प्लास्टिक बोरी', 'hdpe bag'],
      en: 'HDPE / Plastic bags are used for moisture-sensitive crops or chemical fertilizers to protect against moisture absorption.',
      hi: 'नमी से सुरक्षा और रासायनिक उर्वरकों के भंडारण के लिए एचडीपीई/प्लास्टिक बोरियों का उपयोग होता है।',
      mwr: 'नमी सूं बचावण वास्ते प्लास्टिक/एचडीपीई बोरी रो प्रयोग कर्यो जावै छै सा।',
      bho: 'नमी से सुरक्षा खातिर प्लास्टिक चाहे एचडीपीई बोरी के इस्तेमाल कइल जाला।',
      guj: 'ભેજથી બચાવવા માટે પ્લાસ્ટિક અને એચડીપીઈ બોરીનો ઉપયોગ થાય છે.',
    ),
    // Q11
    QaItem(
      keywords: ['tarpaulin', 'tripal', 'तिरपाल', 'त्रिपाल'],
      en: 'Tarpaulin (Tripal) is a heavy waterproof sheet used to cover grain bags and protect them from rain, moisture, and sunlight.',
      hi: 'बारिश, नमी और तेज धूप से बोरियों की सुरक्षा के लिए इस्तेमाल की जाने वाली वाटरप्रूफ चादर (तिरपाल)।',
      mwr: 'बरसात अर धूप सूं बोरियां ने बचावण वास्ते ढकी जावण वाली तिरपाल चादर सा।',
      bho: 'बरसात अउर धूप से बोरियन के बचावे खातिर ढकल जाए वाला वाटरप्रूफ तिरपाल।',
      guj: 'વરસાદ અને તડકાથી બોરીઓને બચાવવા માટે ઢાંકવામાં આવતી ત્રિપાલ.',
    ),
    // Q12
    QaItem(
      keywords: ['sandbags', 'sand bags', 'मिट्टी की बोरियां', 'रेत के कट्टे'],
      en: 'Sandbags are placed over tarpaulins on outdoor stacks to hold sheets securely against high wind speeds.',
      hi: 'खुले मैदान में तिरपाल को तेज हवा में उड़ने से रोकने और दबाकर रखने के लिए मिट्टी/रेत की बोरियां रखी जाती हैं।',
      mwr: 'हवा सूं तिरपाल ने उडण सूं रोकण वास्ते तिरपाल पर राख्यो जावण वाला रेत रा कट्टा सा।',
      bho: 'हवा से तिरपाल के उड़े से रोके खातिर ऊपर रखल जाए वाला बालू/माटी के कट्टा।',
      guj: 'પવનથી ત્રિપાલને ઊડતી અટકાવવા માટે ઉપર મૂકવામાં આવતી રેતીની બોરીઓ.',
    ),
    // Q13
    QaItem(
      keywords: ['cctv', 'सीसीटीवी', 'कैमरा', 'cctv camera'],
      en: 'CCTV monitoring provides 24/7 video surveillance of warehouse premises to ensure stock safety and prevent theft.',
      hi: 'गोदाम परिसर और स्टैक की 24 घंटे सुरक्षा निगरानी और चोरी रोकने के लिए सीसीटीवी कैमरे लगे होते हैं।',
      mwr: 'गोदाम मांय माल अर स्टैक री 24 घंटा निगरानी वास्ते सीसीटीवी कैमरा लाग्या होवै छै सा।',
      bho: 'गोदाम में माल अउर स्टैक के 24 घंटा सुरक्षा अउर चोरी रोके खातिर सीसीटीवी कैमरा लगावल जाला।',
      guj: 'ગોડાઉનમાં માલ અને સ્ટોકની 24 કલાક સુરક્ષા માટે સીસીટીવી કેમેરા રહે છે.',
    ),
    // Q14
    QaItem(
      keywords: ['supervisor', 'सुपरवाइजर', 'गोदाम सुपरवाइजर'],
      en: 'Warehouse Supervisor oversees daily warehouse operations, supervises labor, checks stock entry & approves gate passes.',
      hi: 'कर्मचारियों की देखरेख, माल आवक-जावक प्रबंधन, लेबर संचालन और गेट पास सत्यापन करना सुपरवाइजर का काम है।',
      mwr: 'गोदाम री पूरी व्यवस्था, लेबर रो काम अर इनवर्ड-आउटवर्ड देखरेख सुपरवाइजर करे छै सा।',
      bho: 'गोदाम सुपरवाइजर सब संचालन अउर लेबर के काम के देखरेख करेला।',
      guj: 'ગોડાઉન સુપરવાઇઝર સમગ્ર વ્યવસ્થા, લેબર કામ અને ગેટ પાસ ચકાસણી કરે છે.',
    ),
    // Q15
    QaItem(
      keywords: ['labor role', 'लेबर', 'मजदूर', 'labour'],
      en: 'Labor handles physical loading, unloading, bag stitching, winnowing, cleaning, and stacking (thappai).',
      hi: 'बोरियों की लोडिंग, अनलोडिंग, सिलाई, थप्पाई (स्टैकिंग), पाखी चलाना और गोदाम सफाई का कार्य लेबर करती है।',
      mwr: 'बोरियां री लोडिंग, अनलोडिंग, सिलाई, चकट्टा बणावण अर सफाई रो काम लेबर करे छै सा।',
      bho: 'लेबर (मजदूर) बोरियन के लोडिंग, अनलोडिंग, सिलाई अउर सफाई के काम करेला।',
      guj: 'મજૂર (Labour) લોડિંગ, અનલોડિંગ, બોરી સિલાઇ અને સફાઇ કરે છે.',
    ),
    // Q16 & Q17
    QaItem(
      keywords: ['fumigation', 'फ्यूमिगेशन', 'कीटनाशक', 'गैस उपचार'],
      en: 'Fumigation is chemical pest control treatment applied to stored grain stacks by certified agencies to eliminate insects and weevils.',
      hi: 'अनाज के स्टैक में कीड़े-मकौड़ों और सूंडी को नष्ट करने के लिए प्रमाणित एजेंसी द्वारा किया जाने वाला रासायनिक उपचार (फ्यूमिगेशन)।',
      mwr: 'बोरियां मांय सुंडी अर कीड़ा ने मारण वास्ते कर्यो जावण वालो रासायनिक उपचार (फ्यूमिगेशन) सा।',
      bho: 'अनाज में कीड़ा-मकौड़ा मारे खातिर कइल जाए वाला रासायनिक उपचार (फ्यूमिगेशन)।',
      guj: 'અનાજમાં જીવાત અટકાવવા માટે એજન્સી દ્વારા કરવામાં આવતી દવાની પ્રક્રિયા (Fumigation).',
    ),
    // Q18 & Q19
    QaItem(
      keywords: ['warehouse receipt', 'wr', 'गोदाम रसीद', 'wbr', 'रसीद पर लोन'],
      en: 'Warehouse Receipt (WR) is an official document certifying stored grain ownership and weight, against which instant bank pledge loans are provided.',
      hi: 'गोदाम रसीद (WR) गोदाम में जमा फसल के स्वामित्व का कानूनी दस्तावेज है, जिस पर बैंक द्वारा तुरंत गिरवी लोन मिलता है।',
      mwr: 'गोदाम रसीद जमा माल रो पक्को कानूनी सबूत छै जका पर आप तुरंत बैंक लोन ले सको छौ सा।',
      bho: 'गोदाम रसीद (WR) जमा माल के रसीद बा जवना पर तुरंत बैंक लोन मिलेला।',
      guj: 'ગોડાઉન રસીદ (WR) માલની માલિકીનો પુરાવો છે જેના પર બેંક લોન મળે છે.',
    ),
    // Q20
    QaItem(
      keywords: ['inverter', 'battery', 'इनवर्टर', 'बैट्री', 'पावर बैकअप'],
      en: 'Inverter/Battery provides continuous power backup for weighbridge, computer systems, CCTV & testing meters during power outages.',
      hi: 'बिजली जाने पर धर्म कांटा, कंप्यूटर, नमी मापक और सीसीटीवी कैमरों को निर्बाध बिजली देने के लिए इनवर्टर बैकअप होता है।',
      mwr: 'लाइट जाबा पर कांटा अर कंप्यूटर चालू राखण वास्ते पावर बैकअप बणाए राखे छै सा।',
      bho: 'बिजली गइला पर धर्म कांटा अउर कंप्यूटर चालू रखे खातिर पावर बैकअप होला।',
      guj: 'લાઇટ બંધ થતાં કાંટા અને કમ્પ્યુટર ચાલુ રાખવા માટે ઇન્વર્ટર પાવર બેકઅપ આપે છે.',
    ),
    // Q21
    QaItem(
      keywords: ['quality assayer', 'क्वालिटी अस्सेयर', 'गुणवत्ता जांचकर्ता'],
      en: 'Certified quality inspector who samples grain and measures moisture %, foreign matter (FM), damaged kernels & oil content.',
      hi: 'अनाज का सैंपल लेकर नमी %, कचरा (FM), दाना और तेल गुणवत्ता जांचने वाला विशेषज्ञ।',
      mwr: 'अनाज रो सैंपल लेइने नमी %, कचरा अर दाना री जांच करे वाला क्वालिटी अस्सेयर होवै छै सा।',
      bho: 'अनाज के सैंपल लेके नमी, कचरा अउर गुणवत्ता जांचे वाला विशेषज्ञ।',
      guj: 'અનાજનો સેમ્પલ લઈને ભેજ %, કચરો અને ગુણવત્તા ચકાસનાર નિષ્ણાત.',
    ),
    // Q22 & Q23 & Q24
    QaItem(
      keywords: ['moisture meter', 'moisture', 'नमी मापक', 'नमी प्रतिशत', 'नमी कितनी', 'नमी ज्यादा'],
      en: 'Moisture Meter measures moisture %. Safe long-term storage requires 10% to 12% max moisture; higher moisture causes fungal damage and grain discoloration.',
      hi: 'डिजिटल नमी मापक यंत्र से नमी % मापी जाती है। सुरक्षित भंडारण हेतु 10%-12% नमी होनी चाहिए; अधिक नमी से फंगस और कालापन आता है।',
      mwr: 'नमी मापक सूं नमी जांची जावै छै सा। 10%-12% नमी सही होवै छै सा, बत्ती नमी सूं माल खराब हो ज्यासी सा।',
      bho: 'नमी मापक से नमी जांचल जाला। 10-12% नमी सुरक्षित होला; जादा नमी से माल खराब होला।',
      guj: 'ભેજ માપકથી ભેજ મપાય છે. 10-12% ભેજ સુરક્ષિત છે; વધારે ભેજથી માલ બગડે છે.',
    ),
    // Q25
    QaItem(
      keywords: ['foreign matter', 'fm', 'फॉरेन मैटर', 'कचरा'],
      en: 'Foreign Matter (FM) includes chaff, dust, stones, weed seeds and non-grain particles mixed inside crop lot.',
      hi: 'अनाज में मिला कचरा, धूल, कंकड़, तिनके और भूसा जिसे फॉरेन मैटर (FM) कहते हैं।',
      mwr: 'फसल में मिल्योड़ो कचरो, कंकड़, धूड़ अर भूसा ने फॉरेन मैटर (FM) कहे छै सा।',
      bho: 'अनाज में मिलल कचरा, धूल अउर कंकड़ के फॉरेन मैटर (FM) कहल जाला।',
      guj: 'અનાજમાં ભળેલ કચરો, ધૂળ અને કાંકરાને ફોરેન મેટર (FM) કહે છે.',
    ),
    // Q26
    QaItem(
      keywords: ['pakhki', 'winnowing fan', 'पाखी', 'पंखा'],
      en: 'Pakhki is a winnowing fan/blower machine used to remove light dust, chaff and foreign matter from grain.',
      hi: 'अनाज से हल्का भूसा और धूल उड़ाकर साफ करने वाली पाखी (पंखा/क्लीनर) मशीन।',
      mwr: 'अनाज सूं उडण वाला कचरा अर भूसा ने साफ करण वाली पंखा पाखी मशीन सा।',
      bho: 'अनाज से भूसा अउर धूल उड़ा के साफ करे वाला पाखी पंखा मशीन।',
      guj: 'અનાજમાંથી કચરો અને ભૂસું ઉડાડીને સાફ કરતી પાખી (પંખો) મશીન.',
    ),
    // Q27
    QaItem(
      keywords: ['pocket scale', 'scale', 'पॉकेट स्केल', 'ट्रे', 'pocket scale & tray'],
      en: 'Pocket Scale & Tray is a precision scale & tray used by quality assayers to weigh exact 100g sample for FM & damage analysis.',
      hi: 'क्वालिटी अस्सेयर द्वारा 100 ग्राम सैंपल तोलकर कचरा और दाना प्रतिशत जांचने की पॉकेट स्केल और ट्रे।',
      mwr: '100 ग्राम सैंपल तोलन कचरा अरे दाना रो प्रतिशत काढण वाली छोटी कांटा ट्रे पॉकेट स्केल होवै छै सा।',
      bho: 'पॉकेट स्केल अउर ट्रे से 100 ग्राम सैंपल तोल के कचरा अउर दाना के जांच कइल जाला।',
      guj: 'પોકેટ સ્કેલ અને ટ્રેનો ઉપયોગ ક્વોલિટી અસેયર દ્વારા 100 ગ્રામ સેમ્પલ જોખીને ચકાસણી કરવા માટે થાય છે.',
    ),
    // Q28 & Q29
    QaItem(
      keywords: ['sikai groundnut', 'sikai', 'सिकाई मूंगफली', 'सिकाई'],
      en: 'Sikai Quality Groundnut is whole roasted groundnut with golden shell grown in Western Rajasthan (Jaisalmer, Bikaner, Phalodi), exclusively using Khala harvesting type.',
      hi: 'पश्चिमी राजस्थान (जैसलमेर, बीकानेर) की सुनहरे छिलके वाली समूची सिकाई मूंगफली, जिसमें केवल खला प्रकार इस्तेमाल होता है।',
      mwr: 'पश्चिमी राजस्थान री सुनहरे छिलके वाली समूची सिकाई मूंगफली, इण में केवल खला मूंगफली आवै छै सा।',
      bho: 'पच्छिमी राजस्थान के सुनहला छिलका वाली सिकाई मूंगफली, जवना में सिर्फ खला इस्तेमाल होला।',
      guj: 'પશ્ચિમ રાજસ્થાનની સોનેરી ફોતરાંવાળી સિકાઈ મગફળી, જેમાં માત્ર ખલા વપરાય છે.',
    ),
    // Q30 & Q31
    QaItem(
      keywords: ['khala', 'chugga', 'खला', 'चुग्गा', 'khala groundnut', 'chugga groundnut'],
      en: 'Khala groundnut is harvested directly with plant roots during primary digging. Chugga groundnut is detached pods left in soil, sifted later for Oil Quality.',
      hi: 'पौधे के साथ जड़ से एक साथ उखाड़ी जाने वाली मूंगफली खला है। जमीन में छूटी मूंगफली चुग्गा है जो तेल गुणवत्ता में आती है।',
      mwr: 'पौधे सागे जड़ सूं निकलण वाली मूंगफली खला छै। जमीन मांय रह जाण वाली मूंगफली चुग्गा छै सा।',
      bho: 'पौधा के साथ जड़ से निकले वाला मूंगफली खला बा। जमीन में छूट गईल मूंगफली चुग्गा बा।',
      guj: 'છોડ સાથે મૂળમાંથી નીકળતી મગફળી ખલા છે. જમીનમાં રહી જતી મગફળી ચુગ્ગા છે.',
    ),
    // Q32 & Q33
    QaItem(
      keywords: ['singdana', 'singdana quality', 'dana quality', 'oil quality groundnut', 'सिंगदाना', 'दाना गुणवत्ता', 'तेल गुणवत्ता'],
      en: 'Dana/Singdana Quality consists of shelled kernels with thin shell. Oil Quality groundnut comprises thin kernels used for oil extraction.',
      hi: 'छिलका उतारकर निकाले गए मोटे दाने सिंगदाना कहलाते हैं। तेल पेराई के लिए पतले दानों वाली मूंगफली तेल गुणवत्ता (Oil Quality) होती है।',
      mwr: 'मूंगफली रो छिलको हटाण सूं मिलण वाला मोटा दाना सिंगदाना होवै छै। पतली मूंगफली तेल गुणवत्ता में आवै छै सा।',
      bho: 'छिलका निकाल के मिलल मोटा दाना सिंगदाना होला। पतली मूंगफली तेल गुणवत्ता में आवेला।',
      guj: 'ફોતરાં કાઢીને મળતા મોટા દાણા સિંગદાણા છે. પાતળી મગફળી તેલ ક્વોલિટીમાં આવે છે.',
    ),
    // Q34 & Q35
    QaItem(
      keywords: ['2-dana', '3-dana', '1-dana', '2 दाना', '3 दाना', '1 दाना', 'फलियां'],
      en: '2-dana and 3-dana pods command premium market prices. 1-dana pods attract price deduction due to higher shell-to-kernel peeling labor.',
      hi: '2 या 3 दाने वाली मजबूत फलियों पर प्रीमियम भाव मिलता है। 1 दाने वाली फली में छिलका ज्यादा और दाना कम होने से भाव में कटौती होती है।',
      mwr: '2 या 3 दाना वाली मूंगफली फली पर बत्ती भाव मिलै छै। 1 दाना फली पर छिलाई ज्यादा होबा सूं भाव कम मिलै छै सा।',
      bho: '2 चाहे 3 दाना वाली फली पर बढ़िया भाव मिलेला। 1 दाना फली पर भाव कटेला।',
      guj: '2 કે 3 દાણાવાળી ફળી પર વધુ ભાવ મળે છે. 1 દાણાવાળી ફળી પર ભાવ કપાય છે.',
    ),
    // Q36 & Q37 & Q38 & Q39 & Q40
    QaItem(
      keywords: ['sample divider', 'grading', 'damaged kernel', 'oil content test', 'cleaning member', 'सैंपल डिवाइडर', 'ग्रेडिंग', 'डैमेज दाना', 'तेल प्रतिशत', 'क्लीनिंग मेंबर'],
      en: 'Quality assayers use sample dividers, grading methods, damaged kernel %, and chemical oil content tests to evaluate crop quality.',
      hi: 'क्वालिटी अस्सेयर निष्पक्ष सैंपल डिवाइडर, आकार अनुसार ग्रेडिंग, डैमेज दाना % और लैब में तेल प्रतिशत जांच करके गुणवत्ता तय करते हैं।',
      mwr: 'क्वालिटी अस्सेयर सैंपल डिवाइडर सूं जांच कर ग्रेडिंग अर डैमेज दाना % री रिपोर्ट बणावै छै सा।',
      bho: 'क्वालिटी अस्सेयर सैंपल डिवाइडर अउर तेल जांच से माल के गुणवत्ता तय करेला।',
      guj: 'ક્વોલિટી અસેયર સેમ્પલ ડિવાઇડર અને તેલ ચકાસણીથી માલની ગુણવત્તા નક્કી કરે છે.',
    ),
    // Q41 & Q42
    QaItem(
      keywords: ['wbt', 'sbt', 'wbt trading', 'sbt trading', 'warehouse based trading', 'stock based trading'],
      en: 'WBT is trading stored warehouse stock by digital receipt transfer without moving bags. SBT is direct trading of verified crop stocks anywhere via live bids.',
      hi: 'WBT: गोदाम में रखे माल की ऑनलाइन रसीद ट्रांसफर बिक्री। SBT: सत्यापित कृषि स्टॉक की लाइव बोलियों (Bids) द्वारा सीधी ट्रेडिंग।',
      mwr: 'WBT मांय गोदाम मांय जमा माल रो ऐप सूं सीधा बेचाण होवै छै। SBT मांय लाइव बोली लगाइने व्यापार कर्यो जावै छै सा।',
      bho: 'WBT में गोदाम में रखल माल के ऑनलाइन बिक्री होला। SBT में लाइव बोली से व्यापार होला।',
      guj: 'WBT માં ગોડાઉનના માલનું વેચાણ થાય છે. SBT માં લાઈવ બોલીથી વેપાર થાય છે.',
    ),
    // Q43 - Q46
    QaItem(
      keywords: ['live bid', 'buy bid', 'sell bid', 'bid match', 'बोली', 'बाय बिड', 'सेल बिड', 'बोली मिलान'],
      en: 'Buyers submit Buy Bids, sellers submit Sell Bids. When buying rate and selling rate match, system automatically books the trade settlement.',
      hi: 'खरीदार बाय बिड और विक्रेता सेल बिड लगाते हैं। दोनों का भाव मिलते ही सिस्टम स्वतः सौदा बुक कर देता है।',
      mwr: 'खरीददार बाय बिड अर बेचवाल सेल बिड लगावै छै। भाव मिलता ही क्सस्टम सौदा पक्को कर देवे छै सा।',
      bho: 'खरीददार अउर बिक्रेता के बोली के भाव मिलत ही सिस्टम सौदा बुक कर देवेला।',
      guj: 'ખરીદદાર અને વેચનારનો ભાવ મળતા જ સિસ્ટમ સોદો બુક કરી લે છે.',
    ),
    // Q47 - Q50
    QaItem(
      keywords: ['trading member', 'trading fee', 'trade settlement', 'instant payment', 'ट्रेडिंग मेंबर', 'ट्रेडिंग फीस', 'ट्रेड सेटलमेंट', 'तुरंत भुगतान', '24 घंटे में भुगतान'],
      en: 'Trading Members execute verified trades. Upon trade settlement, payment is credited directly to seller bank account within 24 hours.',
      hi: 'सौदा पूरा (Trade Settlement) होते ही विक्रेता के बैंक खाते में 24 घंटे के भीतर सीधे राशि ट्रांसफर की जाती है।',
      mwr: 'सौदा पक्को होबा पर 24 घंटा मांय किसान रा बैंक खाता मांय रपिया जमा हो ज्यासी सा।',
      bho: 'सौदा पूरा होत ही बिक्रेता के बैंक खाता में 24 घंटा में पइसा आ जाला।',
      guj: 'સોદો પૂરો થતાં જ વેચનારના બેંક ખાતામાં 24 કલાકમાં નાણાં જમા થાય છે.',
    ),
    // Q61 - Q64
    QaItem(
      keywords: ['pledge loan', 'pledge finance', 'girvi loan', 'गिरवी ऋण', 'गिरवी लोन', 'कोलैटरल मैनेजर', 'collateral manager'],
      en: 'Instant pledge bank loan provides up to 70%-75% market value against stored warehouse receipts (WR) at 8%-11% p.a. interest, monitored by Collateral Managers.',
      hi: 'फसल बेचे बिना गोदाम रसीद पर 70%-75% तक बैंक गिरवी लोन (8%-11% वार्षिक ब्याज) मिलता है, जिसकी देखरेख कोलैटरल मैनेजर करते हैं।',
      mwr: 'गोदाम मांय जमा माल री रसीद पर 70%-75% तक तुरंत बैंक लोन (8%-11% ब्याज) मिल जावै छै सा।',
      bho: 'गोदाम में रखल माल के रसीद पर 70%-75% तक बैंक गिरवी लोन मिलेला।',
      guj: 'ગોડાઉન રસીદ પર 70%-75% સુધી બેંક લોન (8%-11% વ્યાજ) મળે છે.',
    ),
    // Q65 - Q67
    QaItem(
      keywords: ['bnpl', 'buy now pay later', 'bnpl power limit', 'बीएनपीएल', 'पावर लिमिट'],
      en: 'BNPL (Buy Now Pay Later) gives verified traders/farmers a pre-approved credit power limit to purchase crop commodities now and settle payment later.',
      hi: 'BNPL सुविधा से व्यापारियों को बिना नकद तुरंत माल खरीदने और बाद में भुगतान करने की क्रेडिट पावर लिमिट मिलती है।',
      mwr: 'BNPL सुविधा सूं तुरंत माल खरीदण अर बाद में पेमेंट देवण री उधार लिमिट मिलै छै सा।',
      bho: 'BNPL सुविधा से तुरंत माल खरीद के बाद में पेमेंट करे के लिमिट मिलेला।',
      guj: 'BNPL સુવિધાથી અત્યારે માલ ખરીદીને પછી ચૂકવણી કરવાની લિમિટ મળે છે.',
    ),
    // Q68 - Q70
    QaItem(
      keywords: ['repay loan', 'lien stock', 'unlien stock', 'लीन स्टॉक', 'अनलीन', 'लोन चुकाएं'],
      en: 'Repaying loan + interest through app instantly clears lien lock, making pledged commodity stock fully Unlien for withdrawal or sale.',
      hi: 'ऐप से लोन और ब्याज चुकाने पर बैंक द्वारा लॉक (Lien) माल तुरंत गिरवी से मुक्त (Unlien) हो जाता है।',
      mwr: 'ऐप सूं लोन भरता ही आपरो गिरवी राख्योड़ो माल तुरंत छूट (Unlien) ज्यासी सा।',
      bho: 'ऐप से लोन चुकता करत ही माल गिरवी से मुक्त (Unlien) हो जाला।',
      guj: 'લોન ચુકવતા જ માલ ગીરોમાંથી મુક્ત (Unlien) થઈ જાય છે.',
    ),
    // Q81 - Q83
    QaItem(
      keywords: ['truck capacity', '25 tons', '25 टन', '2-3 tons', '2-3 टन', 'ट्रक क्षमता'],
      en: 'Standard truck capacity for Groundnut is 20-25 Tons. 25 Tons triggers immediate trading member dispatch; 2-3 Tons is placed on full truckload waitlist.',
      hi: 'मूंगफली की ट्रक क्षमता 20-25 टन होती है। 25 टन माल होने पर तुरंत व्यापारी भेजा जाता है; 2-3 टन माल वालों को प्रतीक्षा सूची में रखा जाता है।',
      mwr: 'मूंगफली री ट्रक क्षमता 20-25 टन छै। 25 टन माल होबा पर तुरंत व्यापारी आवै छै सा।',
      bho: 'मूंगफली के ट्रक क्षमता 20-25 टन होला। 25 टन माल पर तुरंत व्यापारी आ जाला।',
      guj: 'મગફળીની ટ્રક ક્ષમતા 20-25 ટન છે. 25 ટન માલ હોય તો તરત વેપારી મોકલાય છે.',
    ),
    // Q87 - Q92
    QaItem(
      keywords: ['gross weight', 'tare weight', 'net weight', 'transit shortage', 'ग्रॉस वेट', 'टेयर वेट', 'नेट वेट', 'ट्रांजिट शॉर्टेज', 'रास्ते की घटत'],
      en: 'Net Weight = Gross Weight (loaded truck) minus Tare Weight (empty truck). Transit Shortage beyond allowable limit is deducted per trade terms.',
      hi: 'नेट वेट = ग्रॉस वेट (भरी गाड़ी) - टेयर वेट (खाली गाड़ी)। रास्ते की प्राकृतिक घटत (Transit Shortage) तय सीमा से अधिक होने पर कटौती होती है।',
      mwr: 'नेट वेट = ग्रॉस वेट मां सूं टेयर वेट घटाया सूं मिलै सा। तय सीमा सूं बत्ती घटत होबा पर कटौती होवै सा।',
      bho: 'नेट वेट = ग्रॉस वेट - टेयर वेट। रास्ते के घटत तय सीमा से जादा भइला पर कटौती होला।',
      guj: 'નેટ વજન = ગ્રોસ વજન - ટેર વજન. રસ્તામાં થતી ઘાટ નિયમ મુજબ કપાય છે.',
    ),
    // Q93 & Q99 & Q100
    QaItem(
      keywords: ['bilty', 'lr', 'eway bill', 'fastpath', 'बिल्टी', 'ई-वे बिल', 'फास्टपाथ'],
      en: 'Bilty (L/R) is transport receipt. e-Way Bill is mandatory GST compliance for goods >₹50,000. FastPath enables rapid farmgate collection.',
      hi: 'बिल्टी ट्रांसपोर्टर रसीद है। ₹50,000 से अधिक माल के लिए ई-वे बिल आवश्यक है। फास्टपाथ से खेत से त्वरित माल आवक होती है।',
      mwr: 'बिल्टी गाड़ी री रसीद छै। ₹50,000 सूं बत्ती माल पर ई-वे बिल जरूरी छै सा।',
      bho: 'बिल्टी ट्रांसपोर्ट रसीद बा। 50 हजार से जादा के माल पर ई-वे बिल जरूरी बा।',
      guj: 'બિલ્ટી ટ્રાન્સપોર્ટ રસીદ છે. ₹50,000 થી વધુ માલ માટે ઈ-વે બિલ જરૂરી છે.',
    ),
    // Q101 & Q102
    QaItem(
      keywords: ['mandi tax', 'mandi tax who pays', 'मंडी टैक्स', 'मंडी टैक्स कौन'],
      en: 'Mandi Tax is statutory APMC tax collected and remitted as per state market regulations (usually borne by buyer/trader).',
      hi: 'मंडी टैक्स कृषि उपज मंडी समिति का कानूनी टैक्स है जो राज्य नियमानुसार निर्धारित पक्ष (सामान्यतः खरीदार/व्यापारी) जमा करता है।',
      mwr: 'मंडी टैक्स राज्य सरकार रो कानूनी टैक्स छै जको तय व्यापारी या खरीदार जमा करे छै सा।',
      bho: 'मंडी टैक्स कानूनन लागू होला जवना के खरीदार भा व्यापारी जमा करेला।',
      guj: 'મંડી ટેક્સ કાયદાકીય ટેક્સ છે જે વેપારી કે ખરીદદાર દ્વારા ભરાય છે.',
    ),
    // Q121 & Q122
    QaItem(
      keywords: ['ownership rule', 'bataidar', 'bataidar trade', 'स्वामित्व नियम', 'बटाईदार', 'मालिक कौन'],
      en: 'Groundnut trade is strictly conducted ONLY with the verified land/stock owner! Bataidars or laborers cannot trade directly; they must provide owner phone number.',
      hi: 'मूंगफली का सौदा केवल जमीन या माल के वैध मालिक (Owner) के साथ ही किया जाता है! बटाईदार या मजदूर सीधे सौदा नहीं कर सकते।',
      mwr: 'मूंगफली रो सौदा केवल पक्का मालिक सागे ही कर्यो जावै छै सा! बटाईदार सीधे सौदा नी कर सकै सा।',
      bho: 'मूंगफली के सौदा सिर्फ जमीन चाहे माल के असली मालिक से ही होला। बटाईदार सीधे सौदा ना कर सकेला।',
      guj: 'મગફળીનો સોદો માત્ર અસલી માલિક સાથે જ થાય છે. બટાઈદાર સીધો સોદો કરી શકતો નથી.',
    ),
    // Q135 & Roles
    QaItem(
      keywords: ['total roles', 'roles defined', 'कुल रोल्स', 'रोल्स कितने', '22 roles'],
      en: 'Apna Godam PDF specifies exactly 22 operational roles including Warehouse Owner, WSP, Guard, Buyer, Seller, Broker, Assayer, Kanta Man, Sprayer, Cleaner, etc.',
      hi: 'अपना गोदाम में कुल 22 विशिष्ट भूमिकाएं (Roles) प्रशिक्षित हैं जिनमें गोदाम मालिक, WSP, गार्ड, दलाल, अस्सेयर, कांटा मैन, स्प्रेयर आदि शामिल हैं।',
      mwr: 'अपना गोदाम में कुल 22 रोल्स (भूमिकाएं) प्रशिक्षित छै सा।',
      bho: 'अपना गोदाम में कुल 22 गो रोल्स प्रशिक्षित बा।',
      guj: 'અપના ગોડાઉનમાં કુલ 22 રોલ્સ વ્યાખ્યાયિત છે.',
    ),
    // Q181 - Q188 Out of Scope
    QaItem(
      keywords: ['president of india', 'ipl', 'weather', 'movie', 'election', 'paneer butter masala', 'reliance share', 'laptop windows', 'राष्ट्रपति', 'आईपीएल', 'बारिश', 'फिल्म', 'चुनाव'],
      en: 'Sorry, I do not have information on this out-of-scope question. Please contact our IVR Helpline at 7733901154 for assistance.',
      hi: 'क्षमा करें, मुझे इस प्रश्न की जानकारी नहीं है। अधिक जानकारी के लिए कृपया हमारी IVR हेल्पलाइन 7733901154 पर कॉल करें।',
      mwr: 'माफ़ करना सा, म्हाने इण सवाल रो जवाब कोइनी। बत्ती जानकारी वास्ते आप IVR हेल्पलाइन 7733901154 पर कॉल करो सा।',
      bho: 'क्षमा करीं, हमरा ई सवाल के जानकारी नईखे। अधिक जानकारी खातिर हमार IVR हेल्पलाइन 7733901154 पर कॉल करीं।',
      guj: 'માફ કરશો, આ પ્રશ્નની માહિતી મારી પાસે નથી. વધુ માહિતી માટે અમારી IVR હેલ્પલાઇન 7733901154 પર કોલ કરો.',
    ),
    // Q190 - Q193 Helpline & App Support
    QaItem(
      keywords: ['customer care', 'helpline', 'ivr helpline', '7733901154', 'कस्टमर केयर', 'हेल्पलाइन', 'हेल्पलाइन नंबर'],
      en: 'Our official IVR Helpline number is 7733901154. Tap the call button in app to connect directly during working hours!',
      hi: 'हमारी आधिकारिक IVR हेल्पलाइन नंबर 7733901154 है। ऐप में कॉल बटन दबाकर तुरंत बात करें!',
      mwr: 'अपना गोदाम री अधिकृत IVR हेल्पलाइन नंबर 7733901154 छै सा। ऐप मांय कॉल बटन दबा बात करो सा!',
      bho: 'हमार आधिकारिक IVR हेल्पलाइन नंबर 7733901154 बा। ऐप में कॉल बटन दबा के बात करीं!',
      guj: 'અમારી સત્તાવાર IVR હેલ્પલાઇન 7733901154 છે. એપ્લિકેશનમાં કોલ બટન દબાવીને વાત કરો!',
    ),
  ];
}
