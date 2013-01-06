class ListItem < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessor                :_destroy
  attr_reader     :word1_str, :word2_str
  attr_accessible :word1_str, :word2_str
  attr_accessible  :word1_id,  :word2_id
  attr_accessible     :word1,     :word2
  attr_accessible              :_destroy
  attr_accessible                  :list

  after_save                 :trim_words
  before_destroy          :release_words
  after_find          :populate_word_str

  belongs_to                       :list
  belongs_to :word1, class_name:  'Word'
  belongs_to :word2, class_name:  'Word'

  def word1_str= word
    #puts "word1_str= " + word

    ListItem.uncached { release_word Word.find( self.word1_id ) } if !self.word1_id.blank?
    self.word1_id =     process_word word, self.list.lang1_id

    @word1_str    = word
  end

  def word2_str= word
    #puts "word2_str= " + word

    ListItem.uncached { release_word Word.find( self.word2_id ) } if !self.word2_id.blank?
    self.word2_id =     process_word word, self.list.lang2_id

    @word2_str    = word
  end

  def trim_words
    #puts "trim_words"
    ListItem.uncached { Word.where( freq: 0 ).destroy_all }
  end

  def populate_word_str
    #puts "populate_word_str"
    @word1_str = self.word1.word.capitalize
    @word2_str = self.word2.word.capitalize

  end

  def release_word word
    #print "release_word "
    if !word.nil?

      #print "#{word.id} #{word.word} #{word.freq}\n"

      word.freq -= 1
      word.save
    #else
      #print "\n"
    end

  end

  def release_words
    #puts "release_words"
    release_word self.word1
    release_word self.word2

    self.word1 =   nil
    self.word2 =   nil

    self.save

    trim_words

    true
  end

  def process_word word, lang_id
    #print "process_word #{word}, #{lang_id}"
    ListItem.uncached do

      word_model = Word.where( :word => word.downcase.strip, :language_id => lang_id ).first

      if !word_model.nil?

        word_model.freq += 1
        word_model.save

      else

        word_model = Word.create( :word => word.downcase.strip, :language_id => lang_id )

      end

      #puts " \##{word_model.freq} => #{word_model.id}"

      return word_model.id
    end
  end

end
