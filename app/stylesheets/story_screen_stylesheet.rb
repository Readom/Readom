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

    st.view.collectionViewLayout.tap do |cl|
      cl.itemSize = [cell_size[:w], cell_size[:h]]
      #cl.scrollDirection = UICollectionViewScrollDirectionHorizontal
      #cl.headerReferenceSize = [cell_size[:w], cell_size[:h]]
      cl.minimumInteritemSpacing = @margin
      cl.minimumLineSpacing = @margin
      #cl.sectionInset = [0,0,0,0]
    end
  end

  def switch_list_btn(st)
    st.frame = {w: 24, h: 24, l: screen.bounds.origin.x + screen.bounds.size.width - 25, t: 25}
  end

  def refresh_btn(st)
    st.frame = {w: 24, h: 24, l: screen.bounds.origin.x + screen.bounds.size.width - 25, t: screen.bounds.origin.y + screen.bounds.size.height - 30}
  end
end
