class Pagination {
  final int totalCount;
  final int perPage;
  final int maxPage;
  final int currentPage;

  Pagination({
    required this.totalCount,
    required this.perPage,
    required this.maxPage,
    required this.currentPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalCount: json['totalCount'] as int,
      perPage: json['perPage'] as int,
      maxPage: json['maxPage'] as int,
      currentPage: json['currentPage'] as int,
    );
  }
}