class StoryScreenStylesheet < ApplicationStylesheet

  include StoryCellStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb

    @margin = cell_margin

    set_view_background_image
  end

  def set_view_background_image
    images = ['Costa Rican Frog.jpg', 'Pensive Parakeet.jpg', 'Boston City Flow.jpg']
    bg_image = UIImage.imageNamed images.sample

    # scale
    window_size = [window.bounds.size.width, window.bounds.size.height].max + 20
    bg_size = [window_size + rand(window_size), 12888].min # size nor greater than 12888
    position = [:top_left, :top, :top_right, :left, :center, :right, :bottom_left, :bottom, :bottom_right].sample

    bg_image = bg_image.gaussian_blur(radius: 2).scale_to_fill([bg_size, bg_size], position: position)

    screen.view.backgroundColor = bg_image.uicolor
  end

  def collection_view(st)
    st.view.contentInset = [@margin[:y], 0, @margin[:y], 0]
    st.background_color = color(base: ([204]*3).uicolor, a: 0.80)

    st.view.collectionViewLayout.tap do |cl|
      cl.itemSize = [cell_size[:w], cell_size[:h]]
      #cl.scrollDirection = UICollectionViewScrollDirectionHorizontal
      #cl.headerReferenceSize = [cell_size[:w], cell_size[:h]]
      cl.minimumInteritemSpacing = @margin[:x]
      cl.minimumLineSpacing = @margin[:y]
      cl.sectionInset = [@margin[:y], @margin[:x], @margin[:y], @margin[:x]]
    end
  end

  def version_label(st)
    st.frame = {w: 36, h: 10, fl: 0, t: 20}

    st.font = UIFont.fontWithName('Arial', size: 9)
  end

  def switch_topic_btn(st)
    st.frame = {w: 28, h: 28, fl: 0, t: 35}
  end

  def refresh_btn(st)
    st.frame = {w: 28, h: 28, fl: 0, t: 80}
  end
end
