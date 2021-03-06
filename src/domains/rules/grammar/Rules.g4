grammar Rules;

// Parser rules

model:
  line*;

line: 
  (sectionLine | emptyLine | ruleDefinition | commentLine | emptyLine );


emptyLine:
  WS? EOL;

sectionLine:
  WS? (GIVEN | WHEN | THEN) ~EOL*;

ruleDefinition: 
    commentLine*
    ruleLine;        

commentLine:
  WS? commentText endOfLine;

commentText:
  ~(RULE | GIVEN | WHEN | THEN | WS | EOL)+ ~EOL*;

ruleLine:
  WS? RULE expression endOfLine;

expression:
  ( expressionText | VALUE_REFERENCE | CONSTANT_VALUE )+
;

expressionText:
  ~(EOL | VALUE_REFERENCE | CONSTANT_VALUE | COMMENT_SYMBOL )+
;

endOfLine:
  EOL | EOF;



// Lexer rules

GIVEN: 'Given:' | 'given:';
WHEN:  'When:' | 'when:';
THEN: 'Then:' | 'then:';
RULE: 'Rule:' | 'rule:';

VALUE_REFERENCE: '<value>';
CONSTANT_VALUE: '"value"';
COMMENT_SYMBOL: '#';

fragment POLISH_LETTER:
  [\u0104\u0105\u0106\u0107\u0118\u0119\u0141\u0142\u0143\u0144\u00D3\u00F3\u015A\u015B\u0179\u017A\u017B\u017C];
  
fragment ENG_LETTER:
  [a-zA-Z];

fragment SPECIAL_CHARACTER:
  [!?;:,._];

fragment NUMBER: 
  [0-9]+;

WORD: ( ENG_LETTER | POLISH_LETTER | NUMBER )+;


WS: [ \t]+;

EOL: [\r\n]+;


UNKNOWN: .;