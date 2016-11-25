class StoryScreenStylesheet < ApplicationStylesheet

  include StoryCellStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb

    @margin = ipad? ? 6 : 4
  end

  def collection_view(st)
    st.view.contentInset = [@margin, @margin, @margin, @margin]
    st.background_color = color.white

    images = ['Costa Rican Frog.jpg', 'Pensive Parakeet.jpg', 'Boston City Flow.jpg']
    bg_image = UIImage.imageNamed images.sample
    bg_image.gaussian_blur(radius: 5)
    bg_image.darken(brightness: -0.8, saturation: -0.2)
    bg_image.scale_to_fill(screen.bounds.size, position: :center)
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
    st.frame = {w: 28, h: 28, l: screen.bounds.origin.x + screen.bounds.size.width - 30, t: 30}
  end

  def refresh_btn(st)
    st.frame = {w: 28, h: 28, l: screen.bounds.origin.x + screen.bounds.size.width - 30, t: 60}
  end
end
