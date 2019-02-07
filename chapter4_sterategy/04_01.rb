# レポート作成プログラムから、HTMLフォーマッティングをするコード部分を
# それぞれのフォーマットクラス内に移動した
class Formatter
  def output_report( title, text )
    raise 'Abstract method called'
  end
end

class HTMLFormatter < Formatter
  def output_report( title, text )
    puts '<html>'
    puts '  <head>'
    puts "    <title>#{title}</title>"
    puts '  </head>'
    puts '  <body>'
    text.each do |line|
      puts "    <p>#{line}<p>"
    end
    puts '  </body>'
    puts '</html>'
  end
end

# 同様にプレーンテキスト用のフォーマットはこのようになる
class PlainTextFormatter < Formatter
  def output_report(title, text)
    puts "***** #{title} *****"
    text.each do |line|
      puts line
    end
  end
end

# 出力をフォーマットする詳細をReportクラスから完全にトリノ沿いてしまったので、
# クラスはとてもシンプルになった
class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(formatter)
    @title = '月次報告'
    @text = [ '順調', '最高の調子' ]
    @formatter = formatter
  end

  def output_report
    @formatter.output_report( @title, @text )
  end
end

# 新しいReportクラスの使い方はほんの少し複雑になった
# Reportクラスには適切なフォーマッティングオブジェクトを与えなくてはならない
report = Report.new(HTMLFormatter.new)
report.output_report

report.formatter = PlainTextFormatter.new
report.output_report
