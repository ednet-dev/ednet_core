part of ednet_core;

String genEDNetWeb(Model model) {
  Domain domain = model.domain;

  var sc = ' \n';
  sc = '${sc}// web/${domain.codeLowerUnderscore}/${model.codeLowerUnderscore}/'
       '${domain.codeLowerUnderscore}_${model.codeLowerUnderscore}_web.dart \n';
  sc = '${sc} \n';

  sc = '${sc}import "dart:html"; \n';
  sc = '${sc} \n';
  sc = '${sc}import "package:ednet_default_app/ednet_default_app.dart"; \n';
  sc = '${sc}import "package:${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}/${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}.dart"; \n';
  sc = '${sc} \n';

  sc = '${sc}void initData(CoreRepository repository) { \n';
  sc = '${sc}   var ${domain.codeFirstLetterLower}Domain = '
       'repository.getDomainModels("${domain.code}"); \n';
  sc = '${sc}   var ${model.codeFirstLetterLower}Model = '
       '${domain.codeFirstLetterLower}Domain.'
       'getModelEntries("${model.code}"); \n';
  sc = '${sc}   ${model.codeFirstLetterLower}Model.init(); \n';
  sc = '${sc}   //${model.codeFirstLetterLower}Model.display(); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}void showData(CoreRepository repository) { \n';
  sc = '${sc}   var mainView = View(document, "main"); \n';
  sc = '${sc}   mainView.repo = repository; \n';
  sc = '${sc}   new RepoMainSection(mainView); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}void main() { \n';
  sc = '${sc}  var repository = CoreRepository(); \n';
  sc = '${sc}  initData(repository); \n';
  sc = '${sc}  showData(repository); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}
