
class TokenCreditService {
  int _userTokenBalance = 5000; // الرصيد المبدئي لكل مستخدم (حسب الباقة)

  int get currentBalance => _userTokenBalance;

  /// هل المستخدم يقدر يولّد؟
  bool canGenerate(int requiredTokens) {
    return _userTokenBalance >= requiredTokens;
  }

  /// خصم التوكنات بعد كل استدعاء ناجح
  void deductTokens(int usedTokens) {
    _userTokenBalance -= usedTokens;
    if (_userTokenBalance < 0) _userTokenBalance = 0;
  }

  /// إعادة تعبئة الرصيد (مثلاً بعد اشتراك)
  void recharge(int amount) {
    _userTokenBalance += amount;
  }
}
