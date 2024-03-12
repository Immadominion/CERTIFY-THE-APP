import 'dart:convert';

class AllCertifiedProjectsModel {
    int? id;
    String? status;
    String? mintAddress;
    bool? semifungible;
    int? sellerFeeBasisPoints;
    String? name;
    String? symbol;
    String? description;
    String? image;
    Nfts? nfts;

    AllCertifiedProjectsModel({
        this.id,
        this.status,
        this.mintAddress,
        this.semifungible,
        this.sellerFeeBasisPoints,
        this.name,
        this.symbol,
        this.description,
        this.image,
        this.nfts,
    });

    AllCertifiedProjectsModel copyWith({
        int? id,
        String? status,
        String? mintAddress,
        bool? semifungible,
        int? sellerFeeBasisPoints,
        String? name,
        String? symbol,
        String? description,
        String? image,
        Nfts? nfts,
    }) => 
        AllCertifiedProjectsModel(
            id: id ?? this.id,
            status: status ?? this.status,
            mintAddress: mintAddress ?? this.mintAddress,
            semifungible: semifungible ?? this.semifungible,
            sellerFeeBasisPoints: sellerFeeBasisPoints ?? this.sellerFeeBasisPoints,
            name: name ?? this.name,
            symbol: symbol ?? this.symbol,
            description: description ?? this.description,
            image: image ?? this.image,
            nfts: nfts ?? this.nfts,
        );

    factory AllCertifiedProjectsModel.fromJson(String str) => AllCertifiedProjectsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllCertifiedProjectsModel.fromMap(Map<String, dynamic> json) => AllCertifiedProjectsModel(
        id: json["id"],
        status: json["status"],
        mintAddress: json["mintAddress"],
        semifungible: json["semifungible"],
        sellerFeeBasisPoints: json["sellerFeeBasisPoints"],
        name: json["name"],
        symbol: json["symbol"],
        description: json["description"],
        image: json["image"],
        nfts: json["nfts"] == null ? null : Nfts.fromMap(json["nfts"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
        "mintAddress": mintAddress,
        "semifungible": semifungible,
        "sellerFeeBasisPoints": sellerFeeBasisPoints,
        "name": name,
        "symbol": symbol,
        "description": description,
        "image": image,
        "nfts": nfts?.toMap(),
    };
}

class Nfts {
    List<dynamic>? results;
    int? page;
    int? limit;
    int? totalPages;
    int? totalResults;

    Nfts({
        this.results,
        this.page,
        this.limit,
        this.totalPages,
        this.totalResults,
    });

    Nfts copyWith({
        List<dynamic>? results,
        int? page,
        int? limit,
        int? totalPages,
        int? totalResults,
    }) => 
        Nfts(
            results: results ?? this.results,
            page: page ?? this.page,
            limit: limit ?? this.limit,
            totalPages: totalPages ?? this.totalPages,
            totalResults: totalResults ?? this.totalResults,
        );

    factory Nfts.fromJson(String str) => Nfts.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Nfts.fromMap(Map<String, dynamic> json) => Nfts(
        results: json["results"] == null ? [] : List<dynamic>.from(json["results"]!.map((x) => x)),
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        totalResults: json["totalResults"],
    );

    Map<String, dynamic> toMap() => {
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x)),
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
        "totalResults": totalResults,
    };
}
