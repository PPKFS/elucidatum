import gleam/set.{type Set}
import state.{type State}

pub type Word {
  I6(word: String)
  StringLiteral(word: String)
  Word(word: String)
  Substitution(word: String)
  ParagraphBreak
}

pub type Whitespace {
  Newline
  Tab
  TabIndent(num_indents: Int)
  Space
  }

type VocabEntryKey = Int

pub type Token {
  Token
    ( word: Word
    , preceding_whitespace: Whitespace
    , vocabulary_entry: VocabEntryKey
    )
}

type LexerState {
  LexerState
  ( divide_strings: Bool
  , allow_i6_escapes: Bool
  , wait_for_dashes: Bool
  , break_at_slashes: Bool
  , punctuation: Set(String)
  , previous_character: String
  , in_literal_mode: Bool
  , most_significant_whitespace: String
  , consecutive_tabs: Int
  , empty_line_so_far: Bool
  , empty_word_so_far: Bool
  , comment_nesting_level: Int
  , soak_up_spaces_mode: Bool
  )
}

fn is_punctuation(punctuation_mark: String) -> State(Bool, LexerState) {
  use p <- state.gets(fn(s:LexerState){s.punctuation})
  state.return(set.contains(p, punctuation_mark))
}

pub fn is_whitespace(punctuation: String) -> Bool {
  case punctuation {
    " " | "\t" | "\n" -> True
    _ -> False
  }
}

pub fn lex(input: String) -> String {

}

fn feed_triplet(prev_char: String, current_char: String, next_char: String) -> State(Nil, LexerState) {
  state.modify(fn(s){LexerState(..s, previous_character: prev_char)})
    |> state.modify(fn(s){LexerState(..s, previous_character: prev_char)})
}