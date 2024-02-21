class TransactionData{
  final String type;
  final String category;
  final String date;
  final String amount;
  final String description;

  TransactionData({required this.type,required this.category,required this.date,required this.amount,required this.description});

  Map<String,dynamic> toJson(){
    return {
      'type':type,
      'category':category,
      'date':date,
      'amount':amount,
      'description':description
    };
  }

  factory TransactionData.fromJson(Map<String,dynamic>json){
    return TransactionData(
      type:json ['type'],
       category:json['category'],
        date:json['date'],
         amount:json['amount'],
          description:json['description']);
  }
}