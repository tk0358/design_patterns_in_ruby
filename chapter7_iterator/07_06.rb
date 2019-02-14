# 早口言葉から'p'で始まるすべての単語を検索する
s = 'Peter Piper picked a peck of pickled peppers'
s.scan(/[Pp]\w*/){|word| puts "This word is #{word}"}
