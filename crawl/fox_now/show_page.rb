require_relative '../base_page'
require_relative '../models'

class ShowPage < BasePage

  class ShowRow < BasePage

    class EpisodeInfo < BasePage
      def initialize(doc, show_id)
        super(doc)
        @show_id = show_id
      end
      def title
        text(:div, 'views-field-title')
      end

      def episode_no
        text(:div, 'views-field-field-episode-number')
      end

      def air_date
        text(:div, 'views-field-field-air-date').delete('Aired ')
      end

      def rating
        text(:div, 'views-field-field-rating')
      end

      def sub_rating
        text(:div, 'views-field-field-sub-rating')
      end

      def thumbnail
        element(:img, 'clip-img').attribute('src').value
      end

      def url
        element( 'a', "[contains(@href,'/watch/')]", :xpath).attribute('href').value
      end

      def to_model
        Episode.new to_h
      end

      def to_h
        {
          show_id: @show_id,
          title: title,
          episode_no: episode_no,
          air_date: air_date,
          rating: rating,
          sub_rating: sub_rating,
          thumbnail_url: thumbnail,
          url: "http://www.fox.com#{url}",
          source: :fox_now
        }
      end
    end # End of showinfo

    def title
      text(:h3, 'show-title')
    end

    def episode_elements
      divs('views-row')[0..-2]
    end

    def episodes
      results = [] unless block_given?
      episode_elements.each do |epi_element|
        show = EpisodeInfo.new(epi_element, title)
        # noinspection RubyScope
        results << show unless block_given?
        yield show if block_given?
      end
      results
    end

    def to_model
      eps = []
      episodes { |ep|
        begin
          eps << ep.to_model
        rescue
        end
      }

      Show.new({ title: title, episodes: eps })
    end

    def to_h
      eps = []
      episodes { |ep|
        begin
        eps << ep.to_model
        rescue
        end
      }

      {
        title: title,
        episodes: eps
      }
    end

  end  # end of showRow

  def shows_div
    @shows_div ||= div('view-content')
  end

  def show_rows
    @show_rows ||= divs('views-row')
  end

  def each_show
    each_row do |row|
      begin
        yield row.to_model
      rescue
        # TODO:
      end
    end
  end

  def each_row
    show_rows.each do |show_element|
      yield ShowRow.new(show_element)
    end
  end


  def shows
    res = []
    rows { |r|
      begin
        res << r.to_model
      rescue
      end

    }
    res
  end

  def rows
    results = [] unless block_given?
    show_rows.each do |show_element|
      row = ShowRow.new(show_element)
      # noinspection RubyScope
      results << row unless block_given?
      yield row if block_given?
    end
    results
  end

end