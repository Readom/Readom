class StoryScreenStylesheet < ApplicationStylesheet

  include StoryCellStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb

    @margin = ipad? ? 6 : 4
  end

  def collection_view(st)
    st.view.contentInset = [@margin, 0, @margin, 0]
    st.background_color = [255, 153, 0].uicolor

    images = ['Costa Rican Frog.jpg', 'Pensive Parakeet.jpg', 'Boston City Flow.jpg']
    bg_image = UIImage.imageNamed images.sample

    # scale
    window_size = [window.bounds.size.width, window.bounds.size.height].max
    bg_size = [window_size + rand(window_size), 12888].min # size nor greater than 12888
    position = [:top_left, :top, :top_right, :left, :center, :right, :bottom_left, :bottom, :bottom_right].sample

    bg_image = bg_image.gaussian_blur(radius: 2).scale_to_fill([bg_size, bg_size], position: position)

    st.background_color = bg_image.uicolor

    st.view.collectionViewLayout.tap do |cl|
      cl.itemSize = [cell_size[:w], cell_size[:h]]
      #cl.scrollDirection = UICollectionViewScrollDirectionHorizontal
      #cl.headerReferenceSize = [cell_size[:w], cell_size[:h]]
      cl.minimumInteritemSpacing = @margin
      cl.minimumLineSpacing = @margin
      #cl.sectionInset = [0,0,0,0]
    end
  end

  def switch_topic_btn(st)
    st.frame = {w: 28, h: 28, fr: 0, t: 35}
  end

  def refresh_btn(st)
    st.frame = {w: 28, h: 28, fr: 0, t: 80}
  end

  def version_label(st)
    st.frame = {w: 36, h: 10, fr: 0, t: 20}

    st.font = UIFont.fontWithName('Arial', size: 9)
  end
end
