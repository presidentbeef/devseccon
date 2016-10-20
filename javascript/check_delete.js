var check_get_survey = function(ast) {
  if(ast.type == "CallExpression" &&
      ast.callee.type == "Identifier" &&
      ast.callee.name == "delete_survey" &&
      ast.arguments.length == 1) {

        console.log("delete_survey called without user_id at line ",
            ast.loc.start)
      }
}

var walk = function(ast) {
  if(Array.isArray(ast))
  {
    ast.forEach(walk);
  }
  else if(ast.type) {
    check_get_survey(ast)

      for (key in ast) {
        walk(ast[key])
      }
  }
}

var esprima = require('esprima');
walk(esprima.parse('delete_survey(survey_id)', { loc: true }))
