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
    // ── MODULE 1: WAREHOUSE OPERATIONS & GATE PASS (Q1–Q20) ──
    // Q1
    QaItem(
      keywords: ['how to deposit grain in warehouse', 'how to deposit grain', 'deposit grain', 'mal jama', 'माल जमा कैसे करें', 'inward', 'इनवर्ड', 'જમા'],
      en: 'Tap "Inwards" in the app, select warehouse, commodity & stack, enter weight and vehicle number to submit.',
      hi: 'ऐप में "माल जमा" पर क्लिक करें, अपना गोदाम, अनाज और स्टैक नंबर चुनें, वजन और वाहन विवरण भरें।',
      mwr: 'गोदाम मांय माल जमा (Inward) करावण वास्ते ऐप में माल जमा पर क्लिक करो सा, स्टैक चुणो अर सबमिट करो सा।',
      bho: 'गोदाम में माल जमा (Inward) करे खातिर ऐप में माल जमा पर क्लिक करीं, अपना गोदाम, अनाज अउर स्टैक नंबर चुनीं।',
      guj: 'ગોડાઉનમાં માલ જમા (Inward) કરવા માટે એપ્લિકેશનમાં "માલ જમા" પર ક્લિક કરો, અનાજ અને સ્ટેક પસંદ કરો.',
    ),
    // Q2
    QaItem(
      keywords: ['how to withdraw grain from warehouse', 'how to withdraw grain', 'withdraw grain', 'mal nikasi', 'माल निकासी कैसे करें', 'outward', 'आउटवर्ड', 'નિકાસી'],
      en: 'Tap "Outward" in the warehouse section, select your commodity stack, enter weight & vehicle details.',
      hi: 'ऐप के "माल निकासी" सेक्शन में जाएं, अपना स्टैक चुनें, निकासी वजन और वाहन विवरण भरकर सबमिट करें।',
      mwr: 'गोदाम सूं माल काढण वास्ते ऐप में माल निकासी पर जावो सा, आपरो स्टैक चुणो अर सबमिट करो सा।',
      bho: 'गोदाम से माल निकाले (Outward) खातिर ऐप में माल निकासी पर क्लिक करीं, अपना गोदाम अउर स्टैक चुन के सबमिट करीं।',
      guj: 'ગોડાઉનમાંથી માલ કાઢવા (Outward) માટે "માલ નિકાસી" પર ક્લિક કરો અને વજન ભરી સબમિટ કરો.',
    ),
    // Q3
    QaItem(
      keywords: ['what is digital gatepass', 'digital gatepass', 'digital gate pass', 'डिजिटल गेटपास क्या है', 'डिजिटल गेटपास', 'ગેટ પાસ'],
      en: 'A digital pass generated after Inward/Outward approval featuring a QR code for warehouse entry/exit.',
      hi: 'इनवर्ड/आउटवर्ड अप्रूव होने पर जारी QR कोड पास जिससे गोदाम में प्रवेश और निकासी मिलती है।',
      mwr: 'इनवर्ड या आउटवर्ड अप्रूवल मिलता ही जारी QR कोड पास जका सूं गोदाम में एंट्री अर निकासी मिलै छै सा।',
      bho: 'इनवर्ड/आउटवर्ड अप्रूव भइला पर जारी QR कोड पास जवना से प्रवेश अउर निकासी मिलेला।',
      guj: 'ઈનવર્ડ કે આઉટવર્ડ મંજૂર થતાં જ મળતો QR કોડ ડિજિટલ ગેટ પાસ.',
    ),
    // Q4
    QaItem(
      keywords: ['how to create gatepass', 'how to create gate pass', 'create gatepass', 'create gate pass', 'गेट पास कैसे बनाएं'],
      en: 'Submit an Inward or Outward request; once approved, your QR gate pass automatically generates in app.',
      hi: 'इनवर्ड या आउटवर्ड रिक्वेस्ट सबमिट करें, अप्रूवल मिलते ही ऐप में QR कोड गेट पास जारी हो जाएगा।',
      mwr: 'डिजिटल गेट पास बणावण वास्ते इनवर्ड या आउटवर्ड रिक्वेस्ट सबमिट करो सा, QR गेट पास बण ज्यासी सा।',
      bho: 'इनवर्ड भा आउटवर्ड रिक्वेस्ट सबमिट करीं, अप्रूवल मिलत ही ऐप में QR कोड गेट पास जारी हो जाई।',
      guj: 'ઈનવર્ડ કે આઉટવર્ડ વિનંતી સબમિટ કરો, મંજૂરી મળતાં જ ગેટ પાસ બની જશે.',
    ),
    // Q5
    QaItem(
      keywords: ['what is kata parchi', 'kata parchi', 'kanta parchi', 'कांटा पर्ची क्या है', 'कांटा पर्ची', 'weigh slip'],
      en: 'Official weighbridge slip recording gross weight, tare weight, net weight, vehicle no & date.',
      hi: 'धर्म कांटा की रसीद जिसमें गाड़ी का सकल वजन, खाली वजन, शुद्ध वजन, वाहन नंबर दर्ज होता है।',
      mwr: 'कांटा पर्ची में धर्म कांटा रो पूरो वजन, गाड़ी नंबर, तारीख, सकल अर शुद्ध वजन दर्ज होवै छै सा।',
      bho: 'कांटा पर्ची धर्म कांटा के रसीद बा जवना में कुल, खाली अउर शुद्ध तोल दर्ज होला।',
      guj: 'કાંટા પર્ચીમાં ગ્રોસ વજન, ટેર વજન, નેટ વજન અને વાહન નંબર નોંધાય છે.',
    ),
    // Q6
    QaItem(
      keywords: ['who issues kata parchi', 'who issues kanta parchi', 'कांटा पर्ची कौन देता है', 'kanta man', 'कांटा मैन'],
      en: 'The Weighbridge Operator (Kanta Man) at the warehouse weighbridge.',
      hi: 'धर्म कांटा पर मौजूद कांटा मैन (Weighbridge Operator) तोल के बाद कांटा पर्ची जारी करता है।',
      mwr: 'धर्म कांटा पर तैनात कांटा मैन गाड़ियां रो वजन कर कांटा पर्ची देवै छै सा।',
      bho: 'धर्म कांटा पर मौजूद कांटा मैन (Weighbridge Operator) कांटा पर्ची देवेला।',
      guj: 'ધર્મ કાંટા પર તૈનાત કાંટા મેન (Weighbridge Operator) કાંટા પર્ચી આપે છે.',
    ),
    // Q7
    QaItem(
      keywords: ['what is stack number', 'stack number', 'stack no', 'स्टैक नंबर क्या है', 'स्टैक नंबर'],
      en: 'Unique identification code assigned to a specific pile/lot of commodity bags in a warehouse.',
      hi: 'गोदाम में बोरियों की निश्चित ढेरी (ढेर) को दिया गया विशिष्ट नंबर।',
      mwr: 'गोदाम मांय बोरियां री ठोर (ढेरी) ने दियो गयो खास नंबर स्टैक नंबर होवै छै सा।',
      bho: 'गोदाम में बोरियन के ढेरी के दिहल गइल खास नंबर।',
      guj: 'ગોડાઉનમાં બોરીઓની ઢગલીને આપવામાં આવેલો ખાસ સ્ટેક નંબર.',
    ),
    // Q8
    QaItem(
      keywords: ['jute bag capacity', 'what is jute bag capacity', 'जूट बोरी में कितना अनाज आता है', 'जूट बोरी'],
      en: 'Standard jute bag capacity is typically 50 kg or 100 kg per bag depending on crop type.',
      hi: 'मानक जूट बोरी में फसल के अनुसार सामान्यतः 50 किग्रा या 100 किग्रा अनाज भरा जाता है।',
      mwr: 'मानक जूट बोरी में फसल री किस्म अनुसार 50 किग्रा या 100 किग्रा माल आवै छै सा।',
      bho: 'मानक जूट बोरी में फसल के अनुसार 50 किग्रा चाहे 100 किग्रा अनाज भरल जाला।',
      guj: 'જૂટ બોરીમાં પાક મુજબ 50 કિગ્રા અથવા 100 કિગ્રા અનાજ ભરાય છે.',
    ),
    // Q9
    QaItem(
      keywords: ['stitching thread', 'sutli', 'सिलाई सुतली का क्या काम है', 'सुतली', 'धागा'],
      en: 'Thread used for machine or manual stitching of filled commodity bags to prevent spillage.',
      hi: 'अनाज की बोरियों को बंद करने और सिलाई के लिए इस्तेमाल किया जाने वाला मजबूत धागा/सुतली।',
      mwr: 'बोरियां रो मुंह बंद कर सिलाई करण वास्ते काम आवण वाली सुतली अर धागो सा।',
      bho: 'अनाज के बोरियन के मुंह बंद कर के सिलाई करे खातिर इस्तेमाल होवे वाला मजबूत सुतली।',
      guj: 'બોરીઓનું મોં બંધ કરીને સિલાઇ કરવા માટે વપરાતી સૂતળી.',
    ),
    // Q10
    QaItem(
      keywords: ['plastic bag usage', 'plastic bag', 'प्लास्टिक बोरी का प्रयोग कब होता है', 'प्लास्टिक बोरी'],
      en: 'Used for moisture-sensitive crops or chemical fertilizers to protect against moisture absorption.',
      hi: 'नमी से सुरक्षा और रासायनिक उर्वरकों के भंडारण के लिए एचडीपीई/प्लास्टिक बोरियों का उपयोग होता है।',
      mwr: 'नमी सूं बचावण वास्ते प्लास्टिक/एचडीपीई बोरी रो प्रयोग कर्यो जावै छै सा।',
      bho: 'नमी से सुरक्षा अउर खाद खातिर प्लास्टिक बोरी के इस्तेमाल होला।',
      guj: 'ભેજથી બચાવવા માટે પ્લાસ્ટિક અને એચડીપીઈ બોરીનો ઉપયોગ થાય છે.',
    ),
    // Q11
    QaItem(
      keywords: ['tarpaulin', 'tripal', 'तिरपाल का उपयोग क्या है', 'तिरपाल', 'त्रिपाल'],
      en: 'Heavy waterproof sheet used to cover grain bags and protect them from rain and sunlight.',
      hi: 'बारिश, नमी और तेज धूप से बोरियों की सुरक्षा के लिए इस्तेमाल की जाने वाली वाटरप्रूफ चादर।',
      mwr: 'बरसात अर धूप सूं बोरियां ने बचावण वास्ते ढकी जावण वाली तिरपाल चादर सा।',
      bho: 'बरसात अउर धूप से बोरियन के बचावे खातिर ढकल जाए वाला वाटरप्रूफ तिरपाल।',
      guj: 'વરસાદ અને તડકાથી બોરીઓને બચાવવા માટે ઢાંકવામાં આવતી ત્રિપાલ.',
    ),
    // Q12
    QaItem(
      keywords: ['why sandbags are used', 'sandbags', 'sand bags', 'मिट्टी की बोरियां क्यों रखी जाती हैं', 'मिट्टी की बोरियां', 'रेत के कट्टे'],
      en: 'Placed over tarpaulins on outdoor stacks to hold sheets securely against high wind speeds.',
      hi: 'खुले मैदान में तिरपाल को तेज हवा में उड़ने से रोकने और दबाकर रखने के लिए।',
      mwr: 'हवा सूं तिरपाल ने उडण सूं रोकण वास्ते तिरपाल पर राख्यो जावण वाला रेत रा कट्टा सा।',
      bho: 'हवा से तिरपाल के उड़े से रोके खातिर ऊपर रखल जाए वाला बालू/माटी के कट्टा।',
      guj: 'પવનથી ત્રિપાલને ઊડતી અટકાવવા માટે ઉપર મૂકવામાં આવતી રેતીની બોરીઓ.',
    ),
    // Q13
    QaItem(
      keywords: ['cctv monitoring', 'cctv', 'सीसीटीवी कैमरे का क्या काम है', 'सीसीटीवी'],
      en: '24/7 video surveillance of warehouse premises to ensure stock safety and prevent theft.',
      hi: 'गोदाम परिसर और स्टैक की 24 घंटे सुरक्षा निगरानी और चोरी रोकने के लिए।',
      mwr: 'गोदाम मांय माल अर स्टैक री 24 घंटा निगरानी वास्ते सीसीटीवी कैमरा लाग्या होवै छै सा।',
      bho: 'गोदाम में 24 घंटा सुरक्षा निगरानी अउर चोरी रोके खातिर।',
      guj: 'ગોડાઉનમાં 24 કલાક સુરક્ષા અને ચોરી અટકાવવા માટે સીસીટીવી કેમેરા.',
    ),
    // Q14
    QaItem(
      keywords: ['warehouse supervisor role', 'supervisor role', 'सुपरवाइजर का काम क्या है', 'सुपरवाइजर'],
      en: 'Oversees daily warehouse operations, supervises labor, checks stock entry & approves gate passes.',
      hi: 'कर्मचारियों की देखरेख, माल आवक-जावक प्रबंधन, लेबर संचालन और गेट पास सत्यापन करना।',
      mwr: 'गोदाम री पूरी व्यवस्था, लेबर रो काम अर इनवर्ड-आउटवर्ड देखरेख सुपरवाइजर करे छै सा।',
      bho: 'गोदाम के सब संचालन अउर लेबर के देखरेख करे के काम।',
      guj: 'ગોડાઉન સુપરવાઇઝર સમગ્ર વ્યવસ્થા, લેબર કામ અને ગેટ પાસ ચકાસણી કરે છે.',
    ),
    // Q15
    QaItem(
      keywords: ['labor role', 'labour role', 'लेबर मजदूर का क्या काम है', 'लेबर', 'मजदूर'],
      en: 'Handles physical loading, unloading, bag stitching, winnowing, cleaning and stacking.',
      hi: 'बोरियों की लोडिंग, अनलोडिंग, सिलाई, थप्पाई (स्टैकिंग), पाखी चलाना और गोदाम सफाई।',
      mwr: 'बोरियां री लोडिंग, अनलोडिंग, सिलाई, चकट्टा बणावण अर सफाई रो काम लेबर करे छै सा।',
      bho: 'बोरियन के लोडिंग, अनलोडिंग, सिलाई अउर सफाई के काम।',
      guj: 'મજૂર (Labour) લોડિંગ, અનલોડિંગ, બોરી સિલાઇ અને સફાઇ કરે છે.',
    ),
    // Q16
    QaItem(
      keywords: ['what is fumigation', 'fumigation', 'फ्यूमिगेशन क्या है', 'फ्यूमिगेशन'],
      en: 'Chemical pest control treatment applied to stored grain stacks to eliminate insects and weevils.',
      hi: 'अनाज के स्टैक में कीड़े-मकौड़ों और सूंडी को नष्ट करने के लिए गैस/रसायन उपचार (फ्यूमिगेशन)।',
      mwr: 'बोरियां मांय सुंडी अर कीड़ा ने मारण वास्ते कर्यो जावण वालो रासायनिक उपचार (फ्यूमिगेशन) सा।',
      bho: 'अनाज में कीड़ा मारे खातिर कइल जाए वाला रासायनिक उपचार (फ्यूमिगेशन)।',
      guj: 'અનાજમાં જીવાત અટકાવવા માટે કરવામાં આવતી દવાની પ્રક્રિયા (Fumigation).',
    ),
    // Q17
    QaItem(
      keywords: ['who performs fumigation', 'फ्यूमिगेशन कौन करता है'],
      en: 'Certified Fumigation Agency and trained sprayers using approved safety protocols.',
      hi: 'प्रमाणित फ्यूमिगेशन एजेंसी और प्रशिक्षित स्प्रेयर सुरक्षा नियमों के साथ करते हैं।',
      mwr: 'अधिकृत फ्यूमिगेशन एजेंसी अर स्प्रेयर टीम दवा रो छिड़काव करे छै सा।',
      bho: 'प्रमाणित फ्यूमिगेशन एजेंसी अउर स्प्रेयर टीम दवा के छिड़काव करेला।',
      guj: 'પ્રમાણિત એજન્સી અને સ્પ્રેયર ટીમ દવાનો છંટકાવ કરે છે.',
    ),
    // Q18
    QaItem(
      keywords: ['warehouse receipt', 'what is warehouse receipt', 'godam rasid', 'गोदाम रसीद क्या है', 'गोदाम रसीद', 'wr'],
      en: 'Official legal document certifying ownership and exact weight/quality of grain stored in warehouse.',
      hi: 'गोदाम में जमा फसल के स्वामित्व, वजन और गुणवत्ता को दर्शाने वाला आधिकारिक कानूनी दस्तावेज।',
      mwr: 'गोदाम में जमा माल रो पक्को सबूत अर मालियत बतावण वाली रसीद डब्ल्यूआर (WR) होवै छै सा।',
      bho: 'गोदाम में जमा माल के रसीद जवना में स्वामित्व अउर वजन दर्ज होला।',
      guj: 'ગોડાઉનમાં રાખેલા માલની માલિકી અને વજન દર્શાવતી રસીદ.',
    ),
    // Q19
    QaItem(
      keywords: ['can i get loan on wr', 'loan on wr', 'क्या गोदाम रसीद पर लोन मिलता है', 'रसीद पर लोन'],
      en: 'Yes, Apna Godam provides instant collateral bank loans against electronic warehouse receipts (WBR/WR).',
      hi: 'हां, अपना गोदाम इलेक्ट्रॉनिक गोदाम रसीद पर तुरंत गिरवी ऋण (Collateral Loan) प्रदान करता है।',
      mwr: 'हां सा, गोदाम रसीद पर आप तुरंत बैंक लोन अर गिरवी एडवांस ले सको छौ सा।',
      bho: 'हां, गोदाम रसीद पर तुरंत बैंक गिरवी लोन मिलेला।',
      guj: 'હા, ગોડાઉન રસીદ પર તુરંત બેંક લોન મળે છે.',
    ),
    // Q20
    QaItem(
      keywords: ['battery/inverter used for', 'inverter used for', 'बैट्री इनवर्टर क्यों होता है', 'इनवर्टर', 'बैट्री'],
      en: 'Provides continuous power backup for weighbridge, computer systems, CCTV & testing meters during outages.',
      hi: 'बिजली जाने पर कांटा, कंप्यूटर, नमी मापक और सीसीटीवी कैमरों को निर्बाध बिजली देने के लिए।',
      mwr: 'लाइट जाबा पर कांटा अर कंप्यूटर चालू राखण वास्ते पावर बैकअप बणाए राखे छै सा।',
      bho: 'बिजली गइला पर धर्म कांटा अउर कंप्यूटर चालू रखे खातिर।',
      guj: 'લાઇટ બંધ થતાં કાંટા અને કમ્પ્યુટર ચાલુ રાખવા માટે ઇન્વર્ટર પાવર બેકઅપ આપે છે.',
    ),

    // ── MODULE 2: QUALITY ASSAYING & MOISTURE METER (Q21–Q40) ──
    // Q21
    QaItem(
      keywords: ['what is quality assayer', 'quality assayer', 'क्वालिटी अस्सेयर क्या है', 'क्वालिटी अस्सेयर'],
      en: 'Certified quality inspector who samples grain and measures moisture, foreign matter, damaged kernels & oil content.',
      hi: 'अनाज का सैंपल लेकर नमी %, कचरा (FM), दाना और तेल गुणवत्ता जांचने वाला विशेषज्ञ।',
      mwr: 'अनाज रो सैंपल लेइने नमी %, कचरा अर दाना री जांच करण वालो क्वालिटी अस्सेयर होवै छै सा।',
      bho: 'अनाज के सैंपल लेके नमी, कचरा अउर गुणवत्ता जांचे वाला विशेषज्ञ।',
      guj: 'અનાજનો સેમ્પલ લઈને ભેજ %, કચરો અને ગુણવત્તા ચકાસનાર નિષ્ણાત.',
    ),
    // Q22
    QaItem(
      keywords: ['what is moisture meter', 'moisture meter', 'नमी मापक क्या है', 'नमी मापक'],
      en: 'Electronic device used to accurately measure percentage of moisture in grain before warehouse inward.',
      hi: 'अनाज की बोरियों में नमी का प्रतिशत (% Moisture) मापने वाला डिजिटल यंत्र।',
      mwr: 'अनाज मांय नमी री मात्रा जाचण वालो डिजिटल नमी मापक यंत्र (Moisture Meter) सा।',
      bho: 'अनाज में नमी के प्रतिशत मापे वाला डिजिटल यंत्र।',
      guj: 'અનાજમાં ભેજનું પ્રમાણ માપવા માટેનું ડિજિટલ સાધન.',
    ),
    // Q23
    QaItem(
      keywords: ['ideal crop moisture', 'what is ideal crop moisture', 'अनाज में सही नमी कितनी होनी चाहिए', 'सही नमी कितनी'],
      en: 'Ideally 10% to 12% max moisture content for long-term safe warehouse storage.',
      hi: 'सुरक्षित लंबे भंडारण के लिए अनाज में नमी 10% से 12% तक होनी चाहिए।',
      mwr: 'लमबा समय तक माल सुरक्षित राखण वास्ते नमी 10% सूं 12% तक होनी चाहीजै सा।',
      bho: 'सुरक्षित रखे खातिर अनाज में 10 से 12% नमी होखे के चाही।',
      guj: 'અનાજ સુરક્ષિત રાખવા માટે 10% થી 12% ભેજ યોગ્ય છે.',
    ),
    // Q24
    QaItem(
      keywords: ['what happens if moisture is high', 'moisture is high', 'moisture high', 'नमी ज्यादा होने पर क्या होगा', 'नमी ज्यादा'],
      en: 'High moisture causes fungal growth, grain discoloration, heating, and quality deterioration.',
      hi: 'अत्यधिक नमी से अनाज में फंगस (फफूंद), गर्माहट, कालापन और दाना खराब हो जाता है।',
      mwr: 'नमी बत्ती होबा सूं अनाज में फफूंद लाग ज्यासी, गर्माहट सूं दाना कालो पड़ ज्यासी सा।',
      bho: 'जादा नमी से अनाज में फंगस, गर्माहट अउर कालापन आ जाला।',
      guj: 'વધારે ભેજથી અનાજમાં ફૂગ અને કાળાશ આવી જાય છે.',
    ),
    // Q25
    QaItem(
      keywords: ['foreign matter', 'what is foreign matter', 'fm', 'फॉरेन मैटर क्या है', 'फॉरेन मैटर'],
      en: 'Chaff, dust, stones, weed seeds and non-grain particles mixed inside crop lot.',
      hi: 'अनाज में मिला कचरा, धूल, कंकड़, तिनके और भूसा जिसे फॉरेन मैटर (FM) कहते हैं।',
      mwr: 'फसल में मिल्योड़ो कचरो, कंकड़, धूड़ अर भूसा ने फॉरेन मैटर (FM) कहे छै सा।',
      bho: 'अनाज में मिलल कचरा, धूल अउर कंकड़ के फॉरेन मैटर (FM) कहल जाला।',
      guj: 'અનાજમાં ભળેલ કચરો, ધૂળ અને કાંકરાને ફોરેન મેટર (FM) કહે છે.',
    ),
    // Q26
    QaItem(
      keywords: ['pakhki', 'winnowing fan', 'पाखी क्या है', 'पाखी', 'पंखा'],
      en: 'Winnowing fan/blower machine used to remove light dust, chaff and foreign matter from grain.',
      hi: 'अनाज से हल्का भूसा और धूल उड़ाकर साफ करने वाली पाखी (पंखा/क्लिनर) मशीन।',
      mwr: 'अनाज सूं उडण वाला कचरा अर भूसा ने साफ करण वाली पंखा पाखी मशीन सा।',
      bho: 'अनाज से भूसा अउर धूल उड़ा के साफ करे वाला पाखी पंखा मशीन।',
      guj: 'અનાજમાંથી કચરો અને ભૂસું ઉડાડીને સાફ કરતી પાખી (પંખો) મશીન.',
    ),
    // Q27
    QaItem(
      keywords: ['pocket scale', 'pocket scale & tray', 'pocket scale and tray', 'पॉकेट स्केल और ट्रे का काम क्या है', 'पॉकेट स्केल', 'ट्रे', 'scale'],
      en: 'Precision scale & sampling tray used by assayer to weigh exact 100g sample for FM & damage analysis.',
      hi: 'क्वालिटी अस्सेयर द्वारा 100 ग्राम सैंपल तोलकर कचरा और दाना प्रतिशत जांचने की ट्रे।',
      mwr: '100 ग्राम सैंपल तोलने कचरा अर दाना रो प्रतिशत काढण वाली छोटी कांटा ट्रे सा।',
      bho: 'पॉकेट स्केल अउर ट्रे से 100 ग्राम सैंपल तोल के कचरा अउर दाना के जांच कइल जाला।',
      guj: 'પોકેટ સ્કેલ અને ટ્રેનો ઉપયોગ ક્વોલિટી અસેયર દ્વારા 100 ગ્રામ સેમ્પલ જોખીને ચકાસણી કરવા માટે થાય છે.',
    ),
    // Q28
    QaItem(
      keywords: ['sikai groundnut', 'sikai quality groundnut', 'सिकाई मूंगफली क्या है', 'सिकाई मूंगफली', 'सिकाई'],
      en: 'Whole roasted groundnut with golden shell grown in Western Rajasthan (Jaisalmer, Bikaner, Phalodi).',
      hi: 'पश्चिमी राजस्थान (जैसलमेर, बीकानेर) की सुनहरे छिलके वाली समूची सिकाई मूंगफली।',
      mwr: 'पश्चिमी राजस्थान री सुनहरे छिलके वाली समूची सिकाई मूंगफली छै सा।',
      bho: 'पच्छिमी राजस्थान के सुनहला छिलका वाली समूचा सिकाई मूंगफली।',
      guj: 'પશ્ચિમ રાજસ્થાનની સોનેરી ફોતરાંવાળી આખી શેકેલી સિકાઈ મગફળી.',
    ),
    // Q29
    QaItem(
      keywords: ['harvesting type sikai groundnut', 'सिकाई मूंगफली का प्रकार'],
      en: 'Exclusively "Khala" harvesting type (pulled with root from soil).',
      hi: 'केवल "खला" प्रकार की मूंगफली ही सिकाई में उपयुक्त होती है।',
      mwr: 'सिकाई में केवल "खला" मूंगफली ही काम आवै छै सा।',
      bho: 'सिकाई में सिर्फ "खला" मूंगफली इस्तेमाल होला।',
      guj: 'સિકાઈમાં માત્ર "ખલા" પ્રકારની મગફળી વપરાય છે.',
    ),
    // Q30
    QaItem(
      keywords: ['khala groundnut', 'what is khala groundnut', 'खला मूंगफली क्या है', 'खला मूंगफली', 'खला'],
      en: 'Pods harvested directly along with plant roots during primary digging.',
      hi: 'पौधे के साथ जड़ से एक साथ उखाड़ी जाने वाली समूची मूंगफली को खला कहते हैं।',
      mwr: 'पौधे सागे जड़ सूं निकलण वाली मूंगफली ने "खला" कहे छै सा।',
      bho: 'पौधा के साथ जड़ से निकले वाला मूंगफली के "खला" कहल जाला।',
      guj: 'છોડ સાથે મૂળમાંથી નીકળતી મગફળીને "ખલા" કહે છે.',
    ),
    // Q31
    QaItem(
      keywords: ['chugga groundnut', 'what is chugga groundnut', 'चुग्गा मूंगफली क्या है', 'चुग्गा मूंगफली', 'चुग्गा'],
      en: 'Pods left behind in soil after root pulling, sifted out later; used for Oil Quality.',
      hi: 'जड़ खींचने के बाद जमीन में छूटी मूंगफली जिसे बाद में छाना जाता है; यह तेल गुणवत्ता में आती है।',
      mwr: 'जमीन मांय रह जाण वाली मूंगफली ने "चुग्गा" कहे छै सा, आ तेल गुणवत्ता में आवै छै।',
      bho: 'जमीन में छूट गईल मूंगफली के "चुग्गा" कहल जाला जवन तेल गुणवत्ता में आवेला।',
      guj: 'જમીનમાં રહી જતી મગફળીને "ચુગ્ગા" કહે છે જે તેલ ક્વોલિટીમાં ગણાય છે.',
    ),
    // Q32
    QaItem(
      keywords: ['singdana quality', 'dana quality', 'दाना / सिंगदाना गुणवत्ता क्या है', 'सिंगदाना', 'दाना गुणवत्ता'],
      en: 'Shelled kernels with thin shell, high seed yield, harvested via Khala method.',
      hi: 'छिलका उतारकर निकाले गए मोटे दाने (सिंगदाना) जो खाने और प्रोसेसिंग में काम आते हैं।',
      mwr: 'मूंगफली रो छिलको हटाण सूं मिलण वाला दाना (सिंगदाना) सा।',
      bho: 'छिलका निकाल के मिलल मोटा दाना (सिंगदाना)।',
      guj: 'ફોતરાં કાઢીને મળતા મોટા દાણા (સિંગદાણા).',
    ),
    // Q33
    QaItem(
      keywords: ['oil quality groundnut', 'तेल गुणवत्ता मूंगफली क्या है', 'तेल गुणवत्ता'],
      en: 'Thin kernels used for oil extraction, comprising both Khala and Chugga types.',
      hi: 'तेल पेराई (Oil Extraction) के लिए पतले दानों वाली मूंगफली (खला व चुग्गा दोनों)।',
      mwr: 'तेल पेराई वास्ते काम आवण वाली पतली मूंगफली तेल गुणवत्ता होवै छै सा।',
      bho: 'तेल पेराई खातिर पतली दानों वाली मूंगफली।',
      guj: 'તેલ કાઢવા માટે વપરાતી પાતળી મગફળી.',
    ),
    // Q34
    QaItem(
      keywords: ['2-dana & 3-dana pods', '2-dana', '3-dana', '2-दाना और 3-दाना फलियां क्या हैं', '2 दाना', '3 दाना'],
      en: 'Pods containing 2 or 3 solid kernels inside shell, commanding premium market price.',
      hi: '2 दाने या 3 दाने वाली मजबूत मूंगफली फलियां जिन पर मंडी में प्रीमियम भाव मिलता है।',
      mwr: '2 या 3 दाना वाली मूंगफली फली पर बत्ती भाव मिलै छै सा।',
      bho: '2 चाहे 3 दाना वाली फली जवना पर बढ़िया भाव मिलेला।',
      guj: '2 કે 3 દાણાવાળી ફળી જેના પર ઊંચો ભાવ મળે છે.',
    ),
    // Q35
    QaItem(
      keywords: ['1-dana pods', '1-dana', '1-दाना फली का क्या होता है', '1 दाना'],
      en: 'Single-kernel pods that attract price deduction due to higher shell-to-kernel peeling labor.',
      hi: '1 दाने वाली फली जिसमें छिलका ज्यादा और दाना कम होने से भाव में कटौती होती है।',
      mwr: '1 दाना वाली फली में छिलाई ज्यादा होबा सूं भाव कम मिलै छै सा।',
      bho: '1 दाना फली में छिलाई जादा भइला से भाव कटेला।',
      guj: '1 દાણાવાળી ફળી જેમાં ફોતરાં વધારે હોવાથી ભાવ કપાય છે.',
    ),
    // Q36
    QaItem(
      keywords: ['sample divider', 'सैंपल डिवाइडर का क्या उपयोग है', 'सैंपल डिवाइडर'],
      en: 'Device used to homogeneously divide bulk grain sample into unbiased testing portions.',
      hi: 'बड़े अनाज सैंपल को निष्पक्ष रूप से छोटे जांच नमूनों में विभाजित करने वाला उपकरण।',
      mwr: 'ढेर सूं लिया गया सैंपल ने बराबर भागों में बांटण वालो उपकरण सा।',
      bho: 'अनाज के बड़े सैंपल के बराबर भाग में बांटे वाला यंत्र।',
      guj: 'અનાજના મોટા સેમ્પલને સરખા ભાગે વહેંચતું સાધન.',
    ),
    // Q37
    QaItem(
      keywords: ['grading process', 'grading', 'ग्रेडिंग क्या है', 'ग्रेडिंग'],
      en: 'Sorting grain by size, weight, color & purity to classify into A-Grade, B-Grade or Commercial.',
      hi: 'दाने के आकार, रंग, चमक और शुद्धता के आधार पर ए-ग्रेड, बी-ग्रेड में वर्गीकरण करना।',
      mwr: 'दाना रो आकार अर चमक देख ग्रेड ए या बी में बांटण रो काम सा।',
      bho: 'दाना के आकार अउर चमक देख के ए-ग्रेड भा बी-ग्रेड तय कइल।',
      guj: 'દાણાના કદ અને રંગના આધારે એ-ગ્રેડ કે બી-ગ્રેડ નક્કી કરવું.',
    ),
    // Q38
    QaItem(
      keywords: ['damaged kernel', 'damaged kernel %', 'डैमेज दाना प्रतिशत क्या है', 'डैमेज दाना'],
      en: 'Percentage of discolored, broken, insect-bitten or sprouted grains in a lot.',
      hi: 'कीड़े लगे, टूटे, बदरंग या अंकुरित दानों का कुल प्रतिशत।',
      mwr: 'सुंडी खाधोड़ा, टूट्योड़ा या कालो पड़्योड़ा दाना रो प्रतिशत सा।',
      bho: 'कीड़ा लागल, टूटल अउर कालो दाना के प्रतिशत।',
      guj: 'જીવાતવાળા, તૂટેલા કે કાળા દાણાની ટકાવારી.',
    ),
    // Q39
    QaItem(
      keywords: ['oil content test', 'तेल प्रतिशत जांच क्या है', 'तेल जांच'],
      en: 'Chemical/NMR laboratory test measuring exact oil percentage in oilseed crops (Mustard, Groundnut).',
      hi: 'तिलहन फसलों (सरसों, मूंगफली) में तेल का कुल प्रतिशत मापने वाली लैब जांच।',
      mwr: 'सरसों अर मूंगफली में तेल री मात्रा % जांचण री प्रक्रिया सा।',
      bho: 'सरसों अउर मूंगफली में तेल के प्रतिशत मापे वाला लैब जांच।',
      guj: 'રાયડો અને મગફળીમાં તેલની ટકાવારી માપતી લેબ ચકાસણી.',
    ),
    // Q40
    QaItem(
      keywords: ['cleaning member', 'क्लीनिंग मेंबर कौन होता है', 'क्लीनिंग मेंबर'],
      en: 'Authorized contractor responsible for operating winnowing machines & cleaning dirty grain lots.',
      hi: 'गोदाम परिसर में गंदे अनाज की छनाई और सफाई सेवा प्रदान करने वाला सदस्य।',
      mwr: 'गोदाम में अनाज री सफाई अर छनाई करण वालो ठेकेदार मेंबर सा।',
      bho: 'गोदाम में अनाज के सफाई करे वाला ठेकेदार मेंबर।',
      guj: 'ગોડાઉનમાં અનાજની સફાઈ કરનાર કોન્ટ્રાક્ટર.',
    ),

    // ── MODULE 3: STOCK-BASED (SBT) & WAREHOUSE-BASED (WBT) TRADING (Q41–Q60) ──
    // Q41
    QaItem(
      keywords: ['wbt trading', 'wbt', 'WBT व्यापार क्या है', 'WBT व्यापार', 'warehouse based trading'],
      en: 'Warehouse Based Trading: Selling/buying commodities stored physically inside Apna Godam warehouses.',
      hi: 'गोदाम आधारित व्यापार: अपना गोदाम में रखे भौतिक स्टॉक की ऑनलाइन खरीद-बिक्री।',
      mwr: 'गोदाम मांय जमा माल रो ऐप सूं सीधा खरीद-बेचाण (WBT) सा।',
      bho: 'गोदाम में रखल माल के ऑनलाइन खरीद-बिक्री (WBT)।',
      guj: 'ગોડાઉનમાં રાખેલા માલનું ઓનલાઇન વેચાણ (WBT).',
    ),
    // Q42
    QaItem(
      keywords: ['sbt trading', 'sbt', 'SBT व्यापार क्या है', 'SBT व्यापार', 'stock based trading'],
      en: 'Stock Based Trading: Direct trading of verified crop stocks anywhere using live bids.',
      hi: 'स्टॉक आधारित व्यापार: सत्यापित कृषि स्टॉक की लाइव बोलियों (Bids) द्वारा सीधी ट्रेडिंग।',
      mwr: 'सत्यापित कृषि माल री लाइव बोली लगाइने व्यापार करणो (SBT) सा।',
      bho: 'सत्यापित कृषि माल के लाइव बोली से व्यापार (SBT)।',
      guj: 'લાઈવ બોલી દ્વારા કૃષિ માલનું વેચાણ (SBT).',
    ),
    // Q43
    QaItem(
      keywords: ['create live bid', 'how to create live bid', 'बोली कैसे लगाएं', 'बोली लगाएं'],
      en: 'Select crop, enter quantity (tons/quintals), enter your buying/selling rate & submit bid in app.',
      hi: 'फसल चुनें, मात्रा (क्विंटल) और अपना खरीद/बिक्री भाव दर्ज करके ऐप में बोली लगाएं।',
      mwr: 'फसल चुणो, मात्रा अर आपरो भाव भर ऐप में बोली (Bid) लगाओ सा।',
      bho: 'फसल चुनीं, मात्रा अउर भाव भर के बोली लगाईं।',
      guj: 'પાક પસંદ કરો, જથ્થો અને ભાવ ભરીને બોલી લગાવો.',
    ),
    // Q44
    QaItem(
      keywords: ['buy bid', 'बाय बिड क्या है', 'बाय बिड'],
      en: 'Purchase offer submitted by a buyer specifying crop, location & max purchase price.',
      hi: 'खरीदार द्वारा दी गई बोली जिसमें फसल, मात्रा और खरीद का उच्चतम भाव दर्ज होता है।',
      mwr: 'माल खरेीदण वाला व्यापारी री तरफ सूं लगायी गई बोली सा।',
      bho: 'खरीददार द्वारा दिहल गइल ખરીદ બોલી।',
      guj: 'ખરીદદાર દ્વારા મુકવામાં આવેલો ખરીદીનો ભાવ.',
    ),
    // Q45
    QaItem(
      keywords: ['sell bid', 'सेल बिड क्या है', 'सेल बिड'],
      en: 'Sale offer submitted by a seller/farmer specifying crop quantity & min selling price.',
      hi: 'बिकवाले (किसान/विक्रेता) द्वारा दर्ज बोली जिसमें बिक्री की न्यूनतम कीमत दर्ज होती है।',
      mwr: 'माल बेचण वाला किसान री तरफ सूं लगायी गई बिक्री बोली सा।',
      bho: 'बिक्रेता चाहे किसान द्वारा दिहल गइल बिक्री बोली।',
      guj: 'વેચનાર ખેડૂત દ્વારા મુકવામાં આવેલો વેચાણનો ભાવ.',
    ),
    // Q46
    QaItem(
      keywords: ['bid matching', 'how bid matching works', 'बोली का मिलान कैसे होता है', 'बोली का मिलान'],
      en: 'System automatically matches compatible buyer rate & seller rate, creating trade settlement.',
      hi: 'खरीदार के भाव और विक्रेता के भाव का मिलान होने पर सिस्टम स्वतः सौदा बुक कर देता है।',
      mwr: 'खरीददार अर बेचवाल रो भाव मिलता ही सिस्टम तुरंत सौदा बुक कर दे छै सा।',
      bho: 'खरीददार अउर बिक्रेता के भाव मिलत ही सौदा बुक हो जाला।',
      guj: 'ખરીદદાર અને વેચનારનો ભાવ મળતા જ સોદો બુક થઈ જાય છે.',
    ),
    // Q47
    QaItem(
      keywords: ['trading member', 'who is trading member', 'ट्रेडिंग मेंबर कौन है', 'ट्रेडिंग मेंबर'],
      en: 'Verified trader/broker authorized to execute crop buy and sell trades on Apna Godam platform.',
      hi: 'अपना गोदाम प्लेटफॉर्म पर फसल खरीद-बिक्री के लिए अधिकृत सत्यापित व्यापारी/दलाल।',
      mwr: 'अपना गोदाम पर खरीद-बेचाण करण वालो रजिस्टर्ड व्यापारी मेंबर सा।',
      bho: 'अपना गोदाम पर फसल खरीद-बिक्री खातिर अधिकृत व्यापारी।',
      guj: 'અપના ગોડાઉન પર વેપાર કરવા માટે રજિસ્ટર્ડ વેપારી.',
    ),
    // Q48
    QaItem(
      keywords: ['trading member fee', 'ट्रेडिंग मेंबर फीस कितनी है', 'ट्रेडिंग फीस'],
      en: 'Standard transparent commission charged per trade execution as per platform terms.',
      hi: 'प्रत्येक व्यापार निष्पादन पर नियमानुसार लागू पारदर्शी ट्रेडिंग कमीशन।',
      mwr: 'सौदा पक्को होबा पर लागू होवण वालो नियमानुसार ट्रेडिंग चार्ज सा।',
      bho: 'प्रत्येक सौदा पर लागू होवे वाला पारदर्शी कमीशन।',
      guj: 'દરેક વેપાર પર લાગુ પડતું પારદર્શક કમિશન.',
    ),
    // Q49
    QaItem(
      keywords: ['trade settlement', 'what is trade settlement', 'ट्रेड सेटलमेंट क्या है', 'ट्रेड सेटलमेंट'],
      en: 'Finalization of transaction where payment is transferred to seller and WR ownership to buyer.',
      hi: 'व्यापार पूरा होने पर खरीदार से भुगतान लेकर विक्रेता के खाते में जमा करना और स्वामित्व हस्तांतरण।',
      mwr: 'सौदा पूरो होबा पर पेमेंट जमा कर माल रो मालिकाना हक ट्रांसफर करणो सा।',
      bho: 'सौदा पूरा भइला पर बिक्रेता के भुगतान अउर माल के मालिकाना हक ट्रांसफर।',
      guj: 'વેપાર પૂરો થતાં નાણાંની ચૂકવણી અને માલિકીની ફેરબદલી.',
    ),
    // Q50
    QaItem(
      keywords: ['instant payment policy', 'instant payment', 'तुरंत भुगतान नियम क्या है', 'तुरंत भुगतान'],
      en: 'Payment is credited to seller\'s bank account within 24 hours of successful trade settlement.',
      hi: 'सौदा पूरा होते ही विक्रेता के बैंक खाते में 24 घंटे के भीतर सीधे राशि ट्रांसफर की जाती है।',
      mwr: 'माल बिकता ही 24 घंटा मांय किसान रा बैंक खाता मांय रपिया जमा हो ज्यासी सा।',
      bho: 'माल बिकत ही 24 घंटा में किसान के बैंक खाता में पइसा ट्रांसफर हो जाला।',
      guj: 'સોદો પૂરો થતાં જ 24 કલાકમાં ખેડૂતના બેંક ખાતામાં નાણાં જમા થાય છે.',
    ),
    // Q51
    QaItem(
      keywords: ['trade without moving grain', 'can i trade without moving grain', 'क्या बिना माल हिलाए व्यापार हो सकता है'],
      en: 'Yes! WBT allows trading stored warehouse stock by digital receipt transfer without moving bags.',
      hi: 'हां! गोदाम में रखे माल को बिना हिलाए केवल डिजिटल रसीद ट्रांसफर करके बेचा जा सकता है।',
      mwr: 'हां सा! गोदाम सूं माल बाहर काढ्या बिना ही ऐप सूं रसीद ट्रांसफर कर बेच सको छौ सा।',
      bho: 'हां! गोदाम में रखल माल के बिना हिलवले सिर्फ रसीद ट्रांसफर कर के बेच सकिला।',
      guj: 'હા! ગોડાઉનનો માલ ખસેડ્યા વગર ડિજિટલ રસીદથી વેચી શકાય છે.',
    ),
    // Q52
    QaItem(
      keywords: ['tlw product type', 'tlw', 'TLW प्रोडक्ट टाइप क्या है', 'TLW'],
      en: 'Truckload Weighment (TLW): Commodity trade based on full truckload weight.',
      hi: 'ट्रक लोड तोल आधारित सौदा (Truckload Weighment Trade)।',
      mwr: 'पूरे ट्रक रा तोल पर आधारित कृषि सौदा (TLW) सा।',
      bho: 'पूरा ट्रक के वजन पर आधारित कृषि सौदा (TLW)।',
      guj: 'આખા ટ્રકના વજન પર આધારિત વેપાર (TLW).',
    ),
    // Q53
    QaItem(
      keywords: ['spot price', 'स्पॉट प्राइस क्या है', 'हाजिर भाव क्या है', 'हाजिर भाव'],
      en: 'Immediate cash settlement market price for crop delivery today.',
      hi: 'आज की तारीख में नकद भुगतान और तुरंत डिलीवरी का हाजिर मंडी भाव।',
      mwr: 'आज री तारीख में नकद सौदा रो हाजिर मंडी भाव सा।',
      bho: 'आज के तारीख में नकद सौदा अउर तुरंत डिलीवरी के हाजिर भाव।',
      guj: 'આજની તારીખમાં રોકડ ચૂકવણી અને ડિલિવરીનો હાજર ભાવ.',
    ),
    // Q54
    QaItem(
      keywords: ['price discovery', 'भाव खोज क्या है', 'भाव खोज'],
      en: 'Mechanism where competitive open bidding determines fair market price of a crop.',
      hi: 'खुली बोली प्रक्रिया द्वारा बाजार में फसल का पारदर्शी और सर्वोत्तम मूल्य तय होना।',
      mwr: 'खुली बोली सूं फसल रो सही अर चौखो भाव तय होवण री प्रक्रिया सा।',
      bho: 'खुला बोली से फसल के सही अउर बढ़िया भाव तय होइ।',
      guj: 'ઓપન બોલી દ્વારા પાકનો સાચો અને ઉત્તમ ભાવ નક્કી થવો.',
    ),
    // Q55
    QaItem(
      keywords: ['delivery order', 'do', 'डिलीवरी ऑर्डर क्या है', 'डिलीवरी ऑर्डर'],
      en: 'Authorization slip issued to buyer to collect purchased commodity from warehouse.',
      hi: 'खरीदार को गोदाम से खरीदा गया माल उठाने के लिए जारी किया गया अधिकृत पत्र।',
      mwr: 'खरीदार ने गोदाम सूं माल उठावण वास्ते दियो गयो डिलीवरी परवानो सा।',
      bho: 'खरीददार के गोदाम से माल उठावे खातिर दिहल गइल पत्र।',
      guj: 'ખરીદદારને ગોડાઉનમાંથી માલ ઉપાડવા માટે અપાતો પત્ર (DO).',
    ),
    // Q56
    QaItem(
      keywords: ['trade terms agreement', 'trade terms', 'ट्रेड शर्तें क्या हैं', 'ट्रेड शर्तें'],
      en: 'Binding legal rules governing quality tolerance, payment timelines & delivery schedules.',
      hi: 'गुणवत्ता छूट, भुगतान सीमा और माल उठाने की समय सीमा के कानूनी नियम।',
      mwr: 'सौदा रा नियम, भुगतान तारीख अर माल उठावण री कानूनी शर्तें सा।',
      bho: 'गुणवत्ता छूट अउर भुगतान के समय सीमा के कानूनी नियम।',
      guj: 'ગુણવત્તા, ચૂકવણી અને ડિલિવરીના કાયદાકીય નિયમો.',
    ),
    // Q57
    QaItem(
      keywords: ['how to view live market bids', 'view live market bids', 'लाइव बोलियां कहां देखें', 'लाइव बोलियां'],
      en: 'Open the "Trade" / "Market" section in Apna Godam app to view live buy & sell bids.',
      hi: 'ऐप में "व्यापार" / "मार्केट" सेक्शन खोलें जहाँ सभी लाइव खरीद-बिक्री बोलियां दिखती हैं।',
      mwr: 'ऐप मांय व्यापार/मार्केट बटन दबाओ सा, उड़े सब लाइव बोलियां दिख ज्यासी सा।',
      bho: 'ऐप में "व्यापार" चाहे "मार्केट" सेक्शन खोलीं जहां सब लाइव बोली दिखेला।',
      guj: 'એપ્લિકેશનમાં "માર્કેટ" વિભાગ ખોલીને લાઈવ બોલીઓ જુઓ.',
    ),
    // Q58
    QaItem(
      keywords: ['mandi license', 'mandi license role', 'मंडी लाइसेंस का क्या काम है', 'मंडी लाइसेंस'],
      en: 'Mandatory trade authorization issued by Krishi Upaj Mandi Samiti for agricultural trading.',
      hi: 'कृषि उपज मंडी समिति द्वारा जारी अधिकृत कृषि व्यापार लाइसेंस।',
      mwr: 'कृषि मंडी समिति सूं मान्यता प्राप्त व्यापार लाइसेंस सा।',
      bho: 'कृषि उपज मंडी समिति द्वारा जारी लाइसेंस।',
      guj: 'કૃષિ મંડી સમિતિ દ્વારા અપાતું વેપાર લાયસન્સ.',
    ),
    // Q59
    QaItem(
      keywords: ['seller verification', 'विक्रेता सत्यापन क्यों होता है', 'विक्रेता सत्यापन'],
      en: 'Verifies farmer identity & land ownership to prevent fraudulent crop listings.',
      hi: 'फर्जी सौदों को रोकने के लिए किसान पहचान और माल स्वामित्व का सत्यापन।',
      mwr: 'धोखाधड़ी रोकण वास्ते किसान री पहचान अर माल रो सत्यापन कर्यो जावै छै सा।',
      bho: 'धोखाधड़ी रोके खातिर किसान के पहचान अउर माल के सत्यापन।',
      guj: 'ધાસાબાજી અટકાવવા ખેડૂતની ઓળખ અને માલિકીની ચકાસણી.',
    ),
    // Q60
    QaItem(
      keywords: ['buyer fee', 'बायर फीस कितनी है', 'बायर फीस'],
      en: 'Platform service fee applicable to buyers per transaction as per agreed trade terms.',
      hi: 'खरीदार पर लागू नियमानुसार पारदर्शी प्लेटफॉर्म सेवा शुल्क।',
      mwr: 'माल खरेीदण वाला व्यापारी परे क्नयमानुसारे लागू प्लेटफॉमडसेवा शुल्क सा।',
      bho: 'खरीददार पर लागू होवे वाला प्लेटफ़ॉर्म सेवा शुल्क।',
      guj: 'ખરીદદાર પર લાગુ પડતી પ્લેટફોર્મ સેવા ફી.',
    ),
  ];
}
