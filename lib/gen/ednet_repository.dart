part of ednet_core;

String genRepository(Repository repo, String library) {
  var sc = 'part of ${library}; \n';
  sc = '${sc} \n';
  sc = '${sc}// lib/destructive_repository.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class Repository extends Repository { \n';
  sc = '${sc} \n';
  sc = '${sc}  static const REPOSITORY = "Repository"; \n';
  sc = '${sc} \n';
  sc = '${sc}  Repository([String code=REPOSITORY]) : super(code) { \n';
  for (Domain domain in repo.domains) {
    sc = '${sc}    var domain = new Domain("${domain.code}"); \n';
    sc = '${sc}    domains.add(domain); \n';
    sc = '${sc}    add(new ${domain.code}Domain(domain)); \n';
    sc = '${sc} \n';
  }
  sc = '${sc}  } \n';
  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}
