module StoryCellStylesheet
  def cell_size
    full_width = screen.bounds.size.width
    min_cell_width = 180
    min_cell_height = 84

    width = screen.bounds.size.width / 2 - 12
    if width < min_cell_width
      width = full_width - 12
    end

    height = 25375 / width
    if height < min_cell_height
      height = min_cell_height
    end

    {w: width, h: height}
  end

  def story_cell(st)
    st.frame = cell_size
    st.background_color = color(base: color.random, a: 0.65)

    # Style overall view here
  end

  def title(st)
    st.frame = {w: cell_size[:w] - 1, h: cell_size[:h] - 12, t: 1}
    st.background_color = color(base: color.white, a: 0.65)
    st.line_break_mode = NSLineBreakByWordWrapping
    st.number_of_lines = 0
  end

  def info(st)
    st.frame = {w: cell_size[:w] - 1, h: 10, t: cell_size[:h] - 11}
    st.background_color = color(base: color.white, a: 0.60)
    st.font = UIFont.fontWithName('Arial', size: 9)
    st.text_color = color(base: color.black, a: 0.75)
    st.line_break_mode = NSLineBreakByWordWrapping
    st.number_of_lines = 1
  end

end
