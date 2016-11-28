module StoryCellStylesheet
  def cell_margin
    @margin = ipad? ? {x: 9, y: 12} : {x: 4, y: 8}
  end

  def cell_size
    margin = cell_margin

    # [width + margin] * n + margin = full_width
    full_width = screen.bounds.size.width
    min_cell_width = 310
    min_cell_height = ipad? ? 175 : 115

    per_line = (full_width.to_i - margin[:x]) / (min_cell_width + margin[:x])

    width = (screen.bounds.size.width - margin[:x]) / per_line - margin[:x]
    if width < min_cell_width
      width = full_width - margin[:x]
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
    st.background_color = color(r: cr, g: cg, b: cb, a: 0.35)

    # Style overall view here
  end

  def title(st)
    # t: 1, l: 2, b: 15, r: 1,
    st.frame = {top: 1, left: 2, width: cell_size[:w] - 3, height: cell_size[:h] - 16}

    st.background_color = color(base: ([153]*3).uicolor, a: 0.15)
    st.font = UIFont.boldSystemFontOfSize 20
    st.text_color = color.white
    st.line_break_mode = NSLineBreakByWordWrapping
    st.number_of_lines = 0
  end

  def info(st)
    # t: -, l: 4, b: 1, r: 1  h: 14
    st.frame = {top: cell_size[:h] - 15, left: 4, width: cell_size[:w] - 5, height: 14}

    st.background_color = color(base: color.white, a: 0.35)
    st.font = UIFont.fontWithName('Arial', size: 12)
    st.text_color = [51, 51, 51].uicolor
    st.line_break_mode = NSLineBreakByWordWrapping
    st.number_of_lines = 1
  end

end
