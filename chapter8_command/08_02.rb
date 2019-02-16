# コードブロック版のCommandパターン

class SlickButton
  attr_accessor :command

  def initialize(&block)
    @command = block
  end

  # ボタンの描画と管理のためのコード
  # コードを省略

  def on_button_push
    @command.call if @command
  end
end

new_button = SlickButton.new do
  # 新しい文書を作成
end