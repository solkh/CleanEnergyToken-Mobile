import 'dart:convert';

class HomeModel {
  double? maxIncentive;
  double? incentive;
  double? balance;
  bool? isPowerStationWorker;
  String? walletAddress;

  HomeModel({
    this.maxIncentive,
    this.incentive,
    this.balance,
    this.isPowerStationWorker,
    this.walletAddress
  });

  HomeModel copyWith({
    double? maxIncentive,
    double? incentive,
    double? balance,
    bool? user,
    String? walletAddress
  }) {
    return HomeModel(
      maxIncentive: maxIncentive ?? this.maxIncentive,
      incentive: incentive ?? this.incentive,
      balance: balance ?? this.balance,
      isPowerStationWorker: user ?? this.isPowerStationWorker,
      walletAddress: walletAddress ?? this.walletAddress
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'maxIncentive': maxIncentive,
      'incentive': incentive,
      'balance': balance,
      'isPowerStationWorker': isPowerStationWorker,
      'walletAddress': walletAddress
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      maxIncentive: map['maxIncentive']?.toDouble(),
      incentive: map['incentive']?.toDouble(),
      balance: map['balance']?.toDouble(),
      isPowerStationWorker: map['isPowerStationWorker'],
      walletAddress: map['walletAddress']
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) => HomeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HomeModel(maxIncentive: $maxIncentive, incentive: $incentive, balance: $balance, isPowerStationWorker: $isPowerStationWorker, walletAddress: $walletAddress)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeModel &&
        other.maxIncentive == maxIncentive &&
        other.incentive == incentive &&
        other.balance == balance &&
        other.isPowerStationWorker == isPowerStationWorker &&
        other.walletAddress == walletAddress;
  }

  @override
  int get hashCode {
    return maxIncentive.hashCode ^ incentive.hashCode ^ balance.hashCode ^ isPowerStationWorker.hashCode ^ walletAddress.hashCode;
  }
}