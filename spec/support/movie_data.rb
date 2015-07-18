module MovieData
  def shop_ids
    Array.new(7, 1)
  end

  def product_ids
    %w[az4056000816 azB000P5FHCQ azB000CQCOLA azB00014B10S azB0044BIQDO azB009K2N4FW azB009K2QJ0E]
  end

  def product_names
    [
      '陰陽道の本―日本史の闇を貫く秘儀・占術の系譜 (NEW SIGHT MOOK Books Esoterica 6)',
      '新豪血寺一族-煩悩解放-(DVD付)',
      '新・豪血寺一族-煩悩解放-',
      '新豪血寺一族 闘婚 NG 【NEOGEO】',
      'レッツゴー！陰陽師',
      '陰陽師　安倍　晴明風　  男性M    コスプレ衣装　 　完全オーダメイドも対応',
      '陰陽師  彰子風　  女性M    コスプレ衣装　 　完全オーダメイドも対応'
    ]
  end

  def product_image_urls
    %w[
      http://ecx.images-amazon.com/images/I/51H24893PSL._AA178_.jpg
      http://ecx.images-amazon.com/images/I/31GhQQVVoEL._AA178_.jpg
      http://ecx.images-amazon.com/images/I/31ZFo3xRGtL._AA178_.jpg
      http://ecx.images-amazon.com/images/I/51Akr-jxa2L._AA178_.jpg
      http://ecx.images-amazon.com/images/I/61so4UfAVtL._AA178_.jpg
      http://ecx.images-amazon.com/images/I/41RGc7k2rUL._AA178_.jpg
      http://ecx.images-amazon.com/images/I/41DecVejRuL._AA178_.jpg
    ]
  end

  def makers
    ['学研マーケティング', 'ゲーム・サントラ,矢部野彦磨&琴姫 With 坊主ダンサー,秋葉原三人娘,惑星ペンダギンのサダ吉とその仲間達,無一文隼人', 'エキサイト', 'プレイモア', 'Ｎｅ−Ｈｏ', 'LUGANO', 'LUGANO']
  end

  def buy_nums
    [12, 340, 28, 0, 0, 0, 0]
  end

  def clicked_nums
    [237, 22631, 43985, 1414, 225, 0, 0]
  end

  def clicked_at_this_movies
    [7, 1, 3, 2, 1, 0, 0]
  end

  def market_info
    [shop_ids, product_ids, product_names, product_image_urls, makers, buy_nums, clicked_nums, clicked_at_this_movies].transpose.map{ |info| {shop_id: info[0], product_id: info[1], product_name: info[2], product_image_url: info[3], maker: info[4], buy_num: info[5], clicked_num: info[6], clicked_at_this_movie: info[7]} }
  end
end