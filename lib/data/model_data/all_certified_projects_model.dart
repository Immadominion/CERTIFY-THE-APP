// ignore_for_file: constant_identifier_names

import 'dart:convert';

class AllCertifiedProjectsModel {
    List<Result>? results;
    int? page;
    int? limit;
    int? totalPages;
    int? totalResults;

    AllCertifiedProjectsModel({
        this.results,
        this.page,
        this.limit,
        this.totalPages,
        this.totalResults,
    });

    AllCertifiedProjectsModel copyWith({
        List<Result>? results,
        int? page,
        int? limit,
        int? totalPages,
        int? totalResults,
    }) => 
        AllCertifiedProjectsModel(
            results: results ?? this.results,
            page: page ?? this.page,
            limit: limit ?? this.limit,
            totalPages: totalPages ?? this.totalPages,
            totalResults: totalResults ?? this.totalResults,
        );

    factory AllCertifiedProjectsModel.fromJson(String str) => AllCertifiedProjectsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllCertifiedProjectsModel.fromMap(Map<String, dynamic> json) => AllCertifiedProjectsModel(
        results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromMap(x))),
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        totalResults: json["totalResults"],
    );

    Map<String, dynamic> toMap() => {
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toMap())),
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
        "totalResults": totalResults,
    };
}

class Result {
    int? id;
    bool? semifungible;
    String? mintAddress;
    Status? status;
    bool? transferable;
    bool? compressed;
    int? sellerFeeBasisPoints;
    Name? name;
    Symbol? symbol;
    String? description;
    String? image;

    Result({
        this.id,
        this.semifungible,
        this.mintAddress,
        this.status,
        this.transferable,
        this.compressed,
        this.sellerFeeBasisPoints,
        this.name,
        this.symbol,
        this.description,
        this.image,
    });

    Result copyWith({
        int? id,
        bool? semifungible,
        String? mintAddress,
        Status? status,
        bool? transferable,
        bool? compressed,
        int? sellerFeeBasisPoints,
        Name? name,
        Symbol? symbol,
        String? description,
        String? image,
    }) => 
        Result(
            id: id ?? this.id,
            semifungible: semifungible ?? this.semifungible,
            mintAddress: mintAddress ?? this.mintAddress,
            status: status ?? this.status,
            transferable: transferable ?? this.transferable,
            compressed: compressed ?? this.compressed,
            sellerFeeBasisPoints: sellerFeeBasisPoints ?? this.sellerFeeBasisPoints,
            name: name ?? this.name,
            symbol: symbol ?? this.symbol,
            description: description ?? this.description,
            image: image ?? this.image,
        );

    factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"],
        semifungible: json["semifungible"],
        mintAddress: json["mintAddress"],
        status: statusValues.map[json["status"]]!,
        transferable: json["transferable"],
        compressed: json["compressed"],
        sellerFeeBasisPoints: json["sellerFeeBasisPoints"],
        name: nameValues.map[json["name"]]!,
        symbol: symbolValues.map[json["symbol"]]!,
        description: json["description"],
        image: json["image"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "semifungible": semifungible,
        "mintAddress": mintAddress,
        "status": statusValues.reverse[status],
        "transferable": transferable,
        "compressed": compressed,
        "sellerFeeBasisPoints": sellerFeeBasisPoints,
        "name": nameValues.reverse[name],
        "symbol": symbolValues.reverse[symbol],
        "description": description,
        "image": image,
    };
}

enum Name {
    MY_PROJECT,
    REQ_BODY_NAME,
    U_CHIKA_PROJECT
}

final nameValues = EnumValues({
    "MY PROJECT": Name.MY_PROJECT,
    "req.body.name": Name.REQ_BODY_NAME,
    "UChika Project": Name.U_CHIKA_PROJECT
});

enum Status {
    CONFIRMED
}

final statusValues = EnumValues({
    "confirmed": Status.CONFIRMED
});

enum Symbol {
    DFA,
    MPJ,
    UP
}

final symbolValues = EnumValues({
    "dfa": Symbol.DFA,
    "MPJ": Symbol.MPJ,
    "UP": Symbol.UP
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
