module Rabel
  class Captcha
    def self.random_code(length=4)
      chars = ('b'..'z').to_a - ['l', 'o'] + ('2'..'9').to_a
      rand_chars = []
      length.times do
        rand_chars << chars[rand(chars.length)]
      end
      rand_chars.join
    end

    #def self.image(code)
    #  canvas = Magick::Image.new(40 * code.length, 40)
    #  draw = Magick::Draw.new
    #  draw.font_family = 'times'
    #  draw.pointsize = 20
    #  start_pos = 10
    #  code.each_char do |char|
    #    draw.annotate(canvas, 0, 0, start_pos, 22 + rand(10), char) {
    #      rotation = rand(10) > 5 ? 0.7 : -1.1
    #      self.font_weight = rand(10) > 5 ?  Magick::NormalWeight : Magick::BoldWeight
    #      self.fill = '#731f43'
    #      self.affine = Magick::AffineMatrix.new(1.7, 0.8, rotation, 1.7, rand(8), rand(5))
    #      self.text_antialias(true)
    #    }
    #    start_pos += 40
    #  end
    #  result_image = canvas.to_blob { self.format = 'gif' }
    #  canvas.destroy!
    #  result_image
    #end

    def self.image(code)
      width = 40 * code.length
      height = 40
      depth = 16
      map = 'gray'
      pixels = Array.new(width*height) {|i| 65535 }
      blob = pixels.pack("S*")
      format = 'gif'
      img = MiniMagick::Image.import_pixels(blob, width, height, depth, map, format)
      start_pos = 10
      code.each_char do |char|
        img.combine_options do |cmd|
            cmd.font('Times New Roman')
            cmd.fill('#731f43')
            cmd.pointsize("#{20 + rand(12)}")
            cmd.weight( (rand(10) > 5) ? '700' : '400')
            cmd.annotate("+#{start_pos}+#{22 + rand(10)}\" \"#{char}")
        end
        start_pos += 40
      end
      img.to_blob
    end

  end
end
