module StoryCellStylesheet
  def cell_size
    margin = ipad? ? 6 : 4

    per_line = screen.bounds.size.width.to_i / 320

    full_width = screen.bounds.size.width
    min_cell_width = 310
    min_cell_height = ipad? ? 160 : 105

    width = screen.bounds.size.width / per_line - margin * 2
    if width < min_cell_width
      width = full_width - margin
    end

    height = 32550 / width
    if height < min_cell_height
      height = min_cell_height
    end

    {w: width, h: height}
  end

  def story_cell(st)
    st.frame = cell_size

    c = [255, 153, 0].uicolor
    cr, cg, cb = [c.red, c.green, c.blue].map do |v|
      n = 2
      255 - rand(255 * n + (1 - v) * 255) / (n + 1)
    end
    st.background_color = color(r: cr, g: cg, b: cb, a: 0.50)

    # Style overall view here
  end

  def title(st)
    # t: 1, l: 2, b: 11, r: 1,
    st.frame = {top: 1, left: 2, width: cell_size[:w] - 3, height: cell_size[:h] - 12}

    st.background_color = color(base: color.white, a: 0.45)
    st.line_break_mode = NSLineBreakByWordWrapping
    st.number_of_lines = 0
  end

  def info(st)
    # t: -, l: 4, b: 1, r: 1  h: 10
    st.frame = {top: cell_size[:h] - 11, left: 4, width: cell_size[:w] - 5, height: 10}
    st.background_color = color(base: color.white, a: 0.50)
    st.font = UIFont.fontWithName('Arial', size: 9)
    st.text_color = color(base: color.black, a: 0.75)
    st.line_break_mode = NSLineBreakByWordWrapping
    st.number_of_lines = 1
  end

end
