import 'dart:convert';

class HomeModel {
  double? maxIncentive;
  double? incentive;
  double? balance;
  String? user;
  String? walletAddress;

  HomeModel({
    this.maxIncentive,
    this.incentive,
    this.balance,
    this.user,
    this.walletAddress
  });

  HomeModel copyWith({
    double? maxIncentive,
    double? incentive,
    double? balance,
    String? user,
    String? walletAddress
  }) {
    return HomeModel(
      maxIncentive: maxIncentive ?? this.maxIncentive,
      incentive: incentive ?? this.incentive,
      balance: balance ?? this.balance,
      user: user ?? this.user,
      walletAddress: walletAddress ?? this.walletAddress
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'maxIncentive': maxIncentive,
      'incentive': incentive,
      'balance': balance,
      'user': user,
      'walletAddress': walletAddress
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      maxIncentive: map['maxIncentive']?.toDouble(),
      incentive: map['incentive']?.toDouble(),
      balance: map['balance']?.toDouble(),
      user: map['user'],
      walletAddress: map['walletAddress']
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) => HomeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HomeModel(maxIncentive: $maxIncentive, incentive: $incentive, balance: $balance, user: $user, walletAddress: $walletAddress)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeModel &&
        other.maxIncentive == maxIncentive &&
        other.incentive == incentive &&
        other.balance == balance &&
        other.user == user &&
        other.walletAddress == walletAddress;
  }

  @override
  int get hashCode {
    return maxIncentive.hashCode ^ incentive.hashCode ^ balance.hashCode ^ user.hashCode ^ walletAddress.hashCode;
  }
}