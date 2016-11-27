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
    bg_image.gaussian_blur(radius: 5)
    bg_image.darken(brightness: -0.8, saturation: -0.2)
    bg_image.scale_to_fill(window.bounds.size, position: [:center, :left, :right, :top, :top_left, :top_right, :bottom_left, :bottom_right].sample)
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
