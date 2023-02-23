part of ednet_core;

String genEDNetLibraryApp(Model model) {
  Domain domain = model.domain;

  var sc = ' \n';
  sc = '${sc}// lib/'
       '${domain.codeLowerUnderscore}_${model.codeLowerUnderscore}_app.dart \n';
  sc = '${sc} \n';

  sc = '${sc}${license} \n';
  sc = '${sc} \n';

  sc = '${sc}library ${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}_app; \n';
  sc = '${sc} \n';
  
  sc = '${sc}/* \n';
  sc = '${sc}import "dart:html"; \n';
  sc = '${sc}import "dart:math"; \n';
  sc = '${sc} \n';

  sc = '${sc}import "package:ednet_core/ednet_core.dart"; \n';
  sc = '${sc}import "package:ednet_default_app/ednet_default_app.dart"; \n';
  sc = '${sc} \n';
  sc = '${sc}import "package:${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}/${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}.dart"; \n';
  sc = '${sc}*/ \n';
  sc = '${sc} \n';

  return sc;
}


