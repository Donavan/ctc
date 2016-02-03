class BasePage
  attr_accessor :doc

  def initialize(document)
    @doc = document
  end

  def elements(which, what, how = :css)
    if how == :css
      doc.css "#{which.to_s}.#{what.to_s}"
    else
      doc.xpath ".//#{which.to_s}#{what.to_s}"
    end
  end

  def element(which, what, how = :css)
    elements(which, what, how).first
  end

  def divs(what, how = :css)
    elements(:div, what, how)
  end

  def div(what, how = :css)
    divs(what, how).first
  end

  def text(which, what, how = :css)
    element(which, what, how).text.strip
  end

end