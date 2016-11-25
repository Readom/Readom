class StoryScreenStylesheet < ApplicationStylesheet

  include StoryCellStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb

    @margin = ipad? ? 12 : 8
  end

  def collection_view(st)
    st.view.contentInset = [@margin, @margin, @margin, @margin]
    st.background_color = color.white

    images = ['Costa Rican Frog.jpg', 'Pensive Parakeet.jpg', 'Boston City Flow.jpg']
    bg_image = UIImage.imageNamed images.sample
    bg_image.darken(brightness: -0.8, saturation: -0.2)
    bg_color = bg_image.uicolor
    st.background_color = bg_color

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
    st.frame = {w: 24, h: 24, l: screen.bounds.origin.x + screen.bounds.size.width - 25, t: 30}
  end

  def refresh_btn(st)
    st.frame = {w: 24, h: 24, l: screen.bounds.origin.x + screen.bounds.size.width - 25, t: 60}
  end
end
