class locationn {
  final int id;
  final String type;
  final String title;

  locationn.fromJson(Map? json):
        id = json?['entity_id'] != null ? json!['entity_id'] as int : 0,
        type = json?['entity_type'] != null ? json!['entity_type'] as String : '',
        title = json?['title'] != null ? json!['title'] as String : '';
}