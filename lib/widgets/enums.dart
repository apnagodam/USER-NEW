enum LicenseType {
  single('Single (license for single area) ', 1),
  unified('Unified (license for whole state)', 2),
  // online('online (states which relieves license)', 3);

  excempt('Excempt (states which relieves license)', 4);
  // partnership('Partnership ', 3),
  // company('Company ', 4);

  const LicenseType(this.label, this.type);

  final String label;
  final int type;
}

enum YesNO {
  yes('Yes I have a license', 1),
  no('No I don\'t have a license', 2),
  not('Not required', 3);

  const YesNO(this.label, this.type);

  final String label;
  final int type;
}

enum FinanceTypeChild {
  wallet('Wallet', 0),
  marginFunding('Margin Funding', 2);

  const FinanceTypeChild(this.label, this.type);

  final String label;
  final int type;
}

enum FinanceTypeParent {
  wallet('Wallet', 0),
  marginFunding('Margin Funding', 2),
  purchaseFinance('Purchase Finance', 3);

  const FinanceTypeParent(this.label, this.type);

  final String label;
  final int type;
}

enum FinanceType {
  wallet('Wallet', 1),
  purchaseFinance('Purchase Finance', 2),
  marginFunding('Margin Funding', 3);

  const FinanceType(this.label, this.type);

  final String label;
  final int type;
}

enum GstYesNO {
  yes('Yes ', 1),
  no('No ', 0);

  const GstYesNO(this.label, this.type);

  final String label;
  final int type;
}

enum BusinessProfileType {
  farmer('Farmer ', 1),
  trader('Trader', 2),
  processor('Processor ', 3),
  investor('Investor ', 4);

  // partnership('Partnership ', 3),
  // company('Company ', 4);

  const BusinessProfileType(this.label, this.type);

  final String label;
  final int type;
}

enum InvestorAmount {
  planOne('0 Lakhs - 10 Lakhs ', 1),
  planTwo('10 Lakhs - 50 Lakhs', 2),
  planThree('50 Lakhs- 1 Crore ', 3),
  planFour('Above 1 Crore', 4);

  // partnership('Partnership ', 3),
  // company('Company ', 4);

  const InvestorAmount(this.label, this.type);

  final String label;
  final int type;
}

enum MillTypes {
  riceMills('Rice Mills', 1),
  flourMills('Flour Mills', 2),
  dalMills('Dal Mills', 3),
  oilseedMills('Oilseed Mills', 4);

  // partnership('Partnership ', 3),
  // company('Company ', 4);

  const MillTypes(this.label, this.type);

  final String label;
  final int type;
}

enum RegistrationType {
  defaultType('Select Product Type', 0),
  commodityFinance('Commodity Finance', 1),
  bnpl('BNPL', 2);

  const RegistrationType(this.label, this.type);

  final String label;
  final int type;
}

enum UserType {
  oldUserType(0),
  newUserType(1);

  const UserType(this.type);
  final int type;
}

enum ConstitutionType {
  individual('Individual', 1),
  proprietorship('Proprietorship ', 2),
  partnership('Partnership ', 3),
  company('Company ', 4);

  const ConstitutionType(this.label, this.type);

  final String label;
  final int type;
}

enum TraderTurnover {
  planOne('upto 50 Lakhs', 1),
  planTwo('50 Lacs-  5 Crores', 2),
  planThree('5 Cores - 10 Crores ', 3),
  planFour('Above 10 Crores', 4);

  // partnership('Partnership ', 3),
  // company('Company ', 4);

  const TraderTurnover(this.label, this.type);

  final String label;
  final int type;
}

enum MillCapacity {
  planOne('upto 500 Tons', 1),
  planTwo('500 - 1000 Tons', 2),
  planThree('1000 - 10000 Tons ', 3),
  planFour('Above 10000 Tons', 4);

  // partnership('Partnership ', 3),
  // company('Company ', 4);

  const MillCapacity(this.label, this.type);

  final String label;
  final int type;
}
